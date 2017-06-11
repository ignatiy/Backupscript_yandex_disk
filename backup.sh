#!/bin/bash
NST=filename-$(date +'%d-%b-%Y-%R')
OF=$NST.tar
OLD_IFS=$IFS
IFS=$'\n'
SRCD="/media/media/backup"
TGTD="/home/backups"
tar -cJf $TGTD$OF $SRCD
curl -T $TGTD$OF --user username:password https://webdav.yandex.ru/
STATUS=$?
IFS=$OLD_IFS
if [[ $STATUS != 0 ]]; then
  rm $TGTD$OF 
  echo "$(date +'%d-%b-%Y-%R%nBackup') $OF error" 
else
  echo "Backup complete!" 
  rm $TGTD$OF
fi
exit
