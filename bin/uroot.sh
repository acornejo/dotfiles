#!/bin/bash
set -e

readonly folders='proc sys dev etc lib bin sbin home usr/lib usr/bin usr/sbin var/run var/log'
readonly busybox_version='1.26.1-defconfig-multiarch'
readonly busybox_arch=$(uname -p)
readonly busybox_url="http://busybox.net/downloads/binaries/${busybox_version}/busybox-${busybox_arch}"

download_busybox() {
  local out=$1
  if hash wget 2>/dev/null; then
    wget -q ${busybox_url} -O ${out}
  else
    curl ${busybox_url} -o ${out}
  fi
}

create_chroot() {
    for folder in ${folders}; do
        mkdir -p ${folder}
    done

    cat <<EOF > etc/hosts
127.0.0.1   localhost
::1         localhost ip6-localhost ip6-loopback
ff02::1     ip6-allnodes
ff02::2     ip6-allrouters
EOF

    cat <<EOF > etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

    cat <<EOF > etc/host.conf
order hosts,bind
multi on
EOF

    cat <<EOF > etc/nsswitch.conf
passwd:         compat
group:          compat
shadow:         compat
gshadow:        files

hosts:          files resolve [!UNAVAIL=return] dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
EOF

    # copy over local time
    if [ -e /etc/localtime ]; then
        cp /etc/localtime etc
    fi

    # create wtmp and utmp files
    touch var/log/wtmp
    touch var/run/utmp
    touch var/log/lastlog

    # download and install busybox
    download_busybox bin/busybox
    chmod 0755 bin/busybox
    bin/busybox unshare -mUiu -r  -p -f \
      bin/busybox chroot . /bin/busybox --install -s /bin
}

create_user() {
    local id=${1}
    local user=${2}

    if [ -z "$id" ]; then
        echo "User id not optional!"
        exit 1
    fi

    if [ -z "$user" ]; then
        echo "Username not optional!"
        exit 1
    fi

    if [ $id -eq 0 ] && [ "$user" != "root" ]; then
        echo "User id 0 must be root"
        exit 1
    fi

    if [ "$user" == "root" ] && [ $id -ne 0 ]; then
        echo "User root must have id 0"
        exit 1
    fi


    echo "${user}:x:${id}:${id}:${user}:/home/${user}:/bin/sh" >> etc/passwd
    echo "${user}:x:${id}:" >> etc/group
    echo "${user}:*:17269:0:99999:7:::" >> etc/shadow
    mkdir home/${user}
}

enter_chroot() {
    local mount="bin/busybox mount"
    local chroot="bin/busybox chroot"
    local unshare="bin/busybox unshare"
    local sh="bin/busybox sh"
    env -i USER=root SHELL=/bin/sh TERM=${TERM} HOME=/home/root \
        ${unshare} -r -pimfunU \
        ${sh} -c "${mount} --rbind /dev dev; ${mount} -t sysfs sys sys; ${mount} -t proc proc proc; exec ${chroot} . /bin/sh -l"
}

usage() {
    echo "Usage: $0"
    echo "  create {chroot_dir}"
    echo "  enter  {chroot_dir} [user]"
    echo
}

main() {
    local cmd=$1
    local chroot=$2
    case "${cmd}" in
        create)
            if [ -d "${chroot}" ]; then
                echo "Chroot directory ${chroot} already exists!"
                exit 1
            fi
            mkdir -p ${chroot} && cd ${chroot}
            create_chroot
            create_user 0 root
            ;;
        enter)
            if [ ! -d "${chroot}" ]; then
                echo "Chroot directory ${chroot} doesn't exist!"
                exit 1
            fi
            cd ${chroot}
            shift 2
            enter_chroot $*
            ;;
        help)
            usage
            ;;
        *)
            echo "Invalid command '${cmd}'"
            usage
            ;;
    esac
}

main $*
