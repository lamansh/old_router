#!/bin/sh 
/usr/sbin/pkg_info > /tmp/pkg_info
BACKUPFILE=backup-post-$(date +%m-%d-%Y).tar.gz
tar Pcfz /tmp/back-to-general/back/$BACKUPFILE --exclude /var/imap/socket --exclude /root/.cpan /root /etc /usr/local/etc /var/imap /usr/local/www /var/named /usr/src/sys/i386/conf/MYKERNEL /tmp/pkg_info /var/db/ports /var/db/openldap-data /usr/local/www/phpldapadmin/htdocs/ldif /usr/local/www/phpldapadmin/htdocs/tree.php > /tmp/back-to-general/tar_log

#milter-greylist
BACKUPFILE=backup-post-logs-$(date +%m-%d-%Y).tar.gz
tar Pcfz /tmp/back-to-general/back/$BACKUPFILE /var/milter-greylist/greylist.db  

#BAYES
BACKUPFILE=backup-post-bayes-$(date +%m-%d-%Y).tar.gz
tar Pcfz  /tmp/back-to-general/back/$BACKUPFILE /var/spool/MIMEDefang/.spamassassin  


/usr/local/bin/smbclient //192.168.0.60/BackupBSD/acid -A /tmp/back-to-general/backupbsd -l /tmp/back-to-general -c "prompt; lcd /tmp/back-to-general/back recurse; mput *; exit;"
cat /tmp/back-to-general/log.smbclient | mail -s "log post backup job" sharov@nchadvisors.kiev.ua
echo "" > /tmp/back-to-general/log.smbclient
rm /tmp/back-to-general/back/* 
