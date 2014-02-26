#!/bin/bash

# This script requieres CURL and bsdutils if you choose to log output (default)
# To run this command every 15 minutes you can use cron, however cron will write
# to syslog all commands executed, possible storing your password there.

# crontab -e
# PATH=place:path:here
# 0,15,30,45 * * * * updyn.sh user=USERNAME pass=PASSWORD host=HOSTNAME

cachefile=/tmp/updyn.cache
curlopt=-k
syslog=user.notice
retry=3
pause=3
verbose=0
agent=updyn.sh/0.2

############## end   configuration ##############

function parse_opts()
{
    while [ "$1" ]; do
        NAME=$(echo $1 | sed -e "s/\(.*\)=\(.*\)/\1/")
        VALUE=$(echo $1 | sed -e "s/\(.*\)=\(.*\)/\2/")
	if [ -n "$VALUE" ]; then
            eval $NAME=$VALUE
        fi
        shift 1
    done
}

function usage()
{
    echo "Usage: `basename $0` user={username} pass={password} host={hostname} [options]"
    echo "             ip={address}          default is public address"
    echo "             cachefile={file}      default is $cachefile"
    echo "             syslog={level}        default is $syslog"
    echo "             retry={num}           default is $retry"
    echo "             pause={num}           default is $pause"
    echo "             verbose={0|1}         default is $verbose"
    exit 1;
}

function log ()
{
    if [ -n "$syslog" ]; then
	    echo "$@" | logger -p "$syslog" -t $agent
    fi
    echo >&2 "$@"
}


parse_opts $*
if [ -z "$ip" ]; then
    ip=`curl ${curlopt} -s http://checkip.dyndns.org:8245 | awk '{print $6;}' | cut -f1 -d\<`
fi
if [ -z "$user" -o -z "$pass" -o -z "$host" ]; then
	echo "Missing mandatory parameter"
	usage
fi

log "Current IP Address is $ip."

cacheip=$(cat $cachefile 2>/dev/null)
if [ "x$ip" == "x$cacheip" ]; then
    log "Cache ($cachefile): up to date -- exiting."
    exit 0
fi

param="hostname=$host&system=dyndns&myip=$ip&wildcard=ON"

curl_verbose=-s
if [ "$verbose" -gt 0 ]; then
  curl_verbose=-v
fi

rc=''
while [ -z "$rc" -a $((retry--)) -gt 0 ]; do
  log curl $curl_verbose $curlopt -A "$agent" -u "$user:*******" 'https://members.dyndns.org/nic/update?'"$param"
  rc="$(curl $curl_verbose $curlopt -A "$agent" -u "$user:$pass" 'https://members.dyndns.org/nic/update?'"$param")"
  [ -z "$rc" ] && sleep $pause
done
[ -z "$rc" ] && rc="DynDNS connection timeout or CURL failed (use verbose)"

echo "$rc" | grep -q '^\(nochg\|good\)\b' ||
{
  log "Got unexpected result from curl: $rc"
  exit 1
}

log "Updating Cache file $cachefile"
rm $cachefile; echo $ip >$cachefile 2>/dev/null

exit 0

