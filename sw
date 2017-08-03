LUCKY=62.244.26.201  
GOLDEN=85.223.215.177     
if  (!( ping -c 13 ${LUCKY} | /usr/bin/grep '64 bytes' | >> /dev/null ))
    then
	if  ( ping -c 3 ${GOLDEN} | /usr/bin/grep '64 bytes' | >> /dev/null )
	then
	    if ( /usr/bin/netstat -nr | grep default | grep 85.223.215.177 | >> /dev/null) 
	    then 
		echo "it's allready golden"
		exit 1
	    else
		/sbin/ipfw add 00003 fwd 192.168.0.254 ip from 62.244.3.192/26{215-245} to not 192.168.0.0/24, 192.168.15.0/24,62.244.3.192/26 out
                /sbin/ipfw add 00004 fwd 192.168.0.254 ip from 192.168.0.0/24{2-140} to not 192.168.0.0/24, 192.168.15.0/24,62.244.3.192/26 out
		/sbin/route change default ${GOLDEN}
		echo "LUCKY NET down Golden uses" | mail -s "Warning!" sharov@nchadvisors.kiev.ua
	        echo "LUCKY NET down Golden uses" | mail -s "Warning!" acid@nchadvisors.kiev.ua
	    
	    echo "Route was changed at $(date '+%d-%m-%H:%M:%S')" >> /var/log/sw.log
	    fi
	fi
    else
echo "Lust run $(date '+%d-%m-%H:%M:%S')" > /var/log/sw.log
fi

