#!/bin/bash
#
# chroot.sh - Chroot to a different environment while being able
# to access the internet and run X applications
# Written by: Ahmed S. Darwish under the license of your choice
#

if [ ! $UID -eq 0 ]; then
    echo "Sudoing..."
    exec sudo "$0" $*
fi

function query_yn()
{
    echo -n "$1: [y,n] "
    RES=""
    while [ "$RES" != "n" -a "$RES" != "y" ]; do
        read -s -n 1 RES
    done
    if [ "$RES" != "n" ]; then
        echo "yes"
        RES="yes"
    else
        echo "no"
        RES="no"
    fi
}

function query_options()
{
    echo "$1"
    RES=""
    select opt in $2; do
        if [ -z "$opt" ]; then
            echo "Invalid option, try again."
        else
            RES=$opt
            break
        fi
    done
}

function query_string()
{
    echo -n "$1: "
    if [ -n "$2" ]; then
        echo -n "[$2] "
    fi
    RES=""
    read RES
    if [ -z "$RES" ]; then
        RES=$2
    fi
}

function query_int()
{
    echo -n "$1: "
    if [ -n "$2" ]; then
        echo -n "[$2] "
    fi
    RES=""
    while [ -z "$RES" ]; do
        read RES
        if [ -z "$RES" ]; then
            RES=$2
        fi
        RES=`echo $RES | grep "^[0-9]*$"`
    done
}

query_options "Please select device type" "file disk"
if [ "$RES" == "file" ]; then
    MOUNT_OPTS="-o loop,offset=16384"
    query_string "File path" "hd.img"
    export CHROOT_DEV=$RES
    if [ -e "$CHROOT_DEV" ]; then
        query_yn "File already exists, replace it"
        if [ "$RES" == "yes" ]; then
            rm -f $CHROOT_DEV
        fi
    fi
    if [ ! -e "$CHROOT_DEV" ]; then
        query_int "Size of image (in MB)" 650
        echo "Creating image..."
        dd if=/dev/zero of=$CHROOT_DEV count=$RES bs=1M
    fi
else
    MOUNT_OPTS=""
    while [ -z "$CHROOT_DEV" ]; do
        query_string "Device path" "/dev/sda"
        if [ ! -e "$RES" ]; then
            echo "Error, $RES is not a valid device."
        else
            export CHROOT_DEV=$RES
        fi
    done
fi

query_string "Disk label" "FSL_ROOT"
export CHROOT_LABEL=$RES

query_yn "Partition and format $CHROOT_DEV"
if [ "$RES" == "yes" ]; then
    echo "Partitioning $CHROOT_DEV"
    parted $CHROOT_DEV "mklabel msdos mkpart primary ext2 0 -0 set 1 boot on mkfs 1 ext2"
    echo "Labelling $CHROOT_DEV to $CHROOT_LABEL"
    tune2fs -c 0 -i 0 $CHROOT_DEV -L $CHROOT_LABEL
fi

while [ -z "$CHROOT_ENV" ]; do
    query_string "Path to mount $CHROOT_DEV" "/media/image"
    DIR=$RES
    if [ ! -d "$DIR" ]; then
        query_yn "$RES does not exist, create it"
        if [ "$RES" == "yes" ]; then
            mkdir -p $DIR
        fi
    fi
    if [ -d "$DIR" ]; then
        export CHROOT_ENV=$DIR
    fi
done
mount $MOUNT_OPTS -t ext2 $CHROOT_DEV $CHROOT_ENV

query_yn "Boot strap system"
if [ "$RES" == "yes" ]; then
    debootstrap --arch i386 sid $CHROOT_ENV http://ftp.debian.org/debian --include=parted,debootstrap,grub
fi

query_yn "Install kernel on system"
if [ "$RES" == "yes" ]; then
    cat << EOF > $CHROOT_ENV/etc/kernel-img.conf
do_symlynks = yes
relative_links = yes
do_bootloader = no
do_bootfloppy = no
do_initrd = yes
link_in_boot = no
EOF
    LC_ALL=C chroot $CHROOT_ENV apt-get -y --force-yes install linux-image-686
fi

query_yn "Setup grub in system"
if [ "$RES" == "yes" ]; then
    mkdir -p $CHROOT_ENV/boot/grub
    LC_ALL=C chroot $CHROOT_ENV apt-get -y --force-yes install grub
    cat << EOF > $CHROOT_ENV/boot/grub/menu.lst
default 0
timeout 0
hiddenmenu
title Linux
root (hd0,0)
kernel /vmlinuz root=LABEL=$CHROOT_LABEL ro
initrd /initrd.img
EOF
    cp $CHROOT_ENV/usr/lib/grub/*/* $CHROOT_ENV/boot/grub
    cat << EOF | grub --device-map=/dev/null
device (hd0) $CHROOT_DEV
root (hd0,0)
setup (hd0)
quit
EOF
    if [ -e "$CHROOT_ENV/boot/grub/device.map" ]; then
        rm -f $CHROOT_ENV/boot/grub/device.map
    fi
fi

query_yn "Setup minimal configuration"
if [ "$RES" == "yes" ]; then
    echo "127.0.0.1 localhost" > $CHROOT_ENV/etc/hosts
    echo "livesystem" > $CHROOT_ENV/etc/hostname
    rm -f $CHROOT_ENV/etc/mtab && ln -s /proc/mounts $CHROOT_ENV/etc/mtab

    cat << EOF > $CHROOT_ENV/etc/fstab
LABEL=$CHROOT_LABEL / ext2 defaults,errors=remount-ro,noatime 0 1
#LABEL=HOME_FS /home  ext3 defaults,errors=remount-ro,noatime 0 2
#LABEL=SWAP_FS swap   swap pri=1 0 0
tmpfs /tmp tmpfs defaults,noatime 0 0
tmpfs /var/lock tmpfs defaults,noatime 0 0
tmpfs /var/log tmpfs defaults,noatime 0 0
tmpfs /var/run tmpfs defaults,noatime 0 0
tmpfs /var/tmp tmpfs defaults,noatime 0 0
EOF
    cat << EOF > $CHROOT_ENV/etc/network/interfaces
auto lo
iface lo inet loopback

autho eth0
EOF
fi

query_yn "Chroot into system"
if [ "$RES" == "yes" ]; then
    FAKE_MOUNTS="dev proc sys tmp"

    # Mount fake proc, tmp, etc.. on chrooted system
    for dir in $FAKE_MOUNTS; do
        mount --bind "/$dir/" "$CHROOT_ENV/$dir/"
    done

    if [ -n "$DISPLAY" ]; then
        xhost +
        cp ~/.Xauthority $CHROOT_ENV/root/
        cp ~/.ICEauthority $CHROOT_ENV/root/
    fi

    # Do the chroot and global variable modification in a subshell not to affect the host session
    (
        export TERM="xterm"
        export SHELL="/bin/bash"
        export USER="root"
        export USERNAME="root"
        export PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin"
        export PWD="/"
        # Have the illusion of a first shell level
        export SHLVL="1"
        export HOME="/root"
        export LOGNAME="root"
        export DISPLAY=$DISPLAY
        export XAUTHORITY="$HOME/.Xauthority"
        export COLORTERM="$TERM"

        LC_ALL=C chroot "$CHROOT_ENV" /bin/bash -i
    )

    if [ -n "$DISPLAY" ]; then
        rm -f $CHROOT_ENV/root/.Xauthority
        rm -f $CHROOT_ENV/root/.ICEauthority
    fi

    # Unmount fake proc, tmp, etc.. on chrooted system
    for dir in $FAKE_MOUNTS; do
        umount "$CHROOT_ENV/$dir"
    done
fi

umount $CHROOT_ENV
