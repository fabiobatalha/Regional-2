export TEMP_FILE=/var/tmp/$$.@@@

echo "From: scielo@brm.bireme.br" > $TEMP_FILE
echo "To: $1" >> $TEMP_FILE
echo "Subject: Resultado " >> $TEMP_FILE
echo "Mime-Version: 1.0" >> $TEMP_FILE
echo "Content-type:text/html" >> $TEMP_FILE

cat $2 >> $TEMP_FILE

/usr/lib/sendmail -t -oi < $TEMP_FILE

rm $TEMP_FILE
