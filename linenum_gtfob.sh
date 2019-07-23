#!/bin/bash
# Bash script to take in the linenum.sh output and send it through https://github.com/JamesConlan96/GTFOBLookup 
file="/home/test/linenum_out.txt"
startflag="false"
while read line
do [ -z "$line" ] && continue ;
    if [ "$startflag" == "true" ]; then
            if [ "$line" == '[-] NFS config details:' ];then
                    exit
            else
	           bins=$(echo $line|rev|cut -f1 -d' '| cut -f1 -d'/'|rev | sed -e "s/^files://")
        	   echo "$bins"
            	   python gtfoblookup.py all "$bins"
            fi
    elif [ "$line" == '[-] SUID files:' ]; then
            startflag="true"
            continue
    fi
done <"$file"
