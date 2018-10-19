#!/bin/bash
# Simple script than alerting to email when disk is almost full 

print_usage() {
	echo "Usage: $0 <args>"
	echo "Possible arguments:"
	echo "  -t <THRESHOLD> -- treshold of disk usage (default 80)"
	echo "  -e <ADDRESS>   -- email address to sent alert msg"
	echo "  -c <CMD>       -- command to send email (default sendmail)"
	exit 0
}

THRESHOLD=90
EMAIL="mail@example.com"
CMD=sendmail

while getopts "h?e:t:c:" opt; do
    case "${opt}" in
    h|\?)
        print_usage
        ;;
    t)
        THRESHOLD=${OPTARG}
        ;;
    e)
        EMAIL=${OPTARG}
        ;;
	c)  
		CMD=${OPTARG}
		;;
    *)
        print_usage
        ;;
    esac
done

CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')

if [[ "$CURRENT" -gt "$THRESHOLD" ]] ; then
	TEXT="Subject: Disk Usage alert from $HOSTNAME\n\n"
	TEXT=$TEXT"Your root partition almost full\nUsed: $CURRENT%\n\n"
	TEXT=$TEXT"--\nSincerely,\n your df-monitor."
	echo -e $TEXT | sendmail $EMAIL
fi
