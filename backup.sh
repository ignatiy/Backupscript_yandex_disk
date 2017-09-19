#!/bin/bash
NST=filename-$(date +'%d-%b-%Y-%R') # задаем имя нашего файла с датой и временем
OF=$NST.tar # такой вид примет наш файл на выходе
OLD_IFS=$IFS # объявляем переменные
IFS=$'\n'
SRCD="/media/media/backup" # путь куда бекапить
TGTD="/home/backups" # путь что бекапить
tar -cJf $TGTD$OF $SRCD # задаем параметры архивирования
curl -T $TGTD$OF --user username:password https://webdav.yandex.ru/ # отправляем бекап на яндекс диск
STATUS=$? # проверяем статус бекапа
IFS=$OLD_IFS
if [[ $STATUS != 0 ]]; then # если ошибка то бекап не создаем и удаляем то что уже создано. при этом отправка на яндекс диск не осуществляется
  rm $TGTD$OF 
  echo "$(date +'%d-%b-%Y-%R%nBackup') $OF error" # выводим в терминал сообщение об ошибке
else # если всё хорошо бекапим, сохраняем на диск и удаляем локальный бекап
  echo "Backup complete!" # выводим в терминал сообщение об успешном выполнении задачи
  rm $TGTD$OF
fi
exit # выходим из программы
