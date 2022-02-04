#!/bin/bash
MES=`date +%m`
ANO=`date +%Y`
if [ $MES -eq 12 ]; then
ANO_PASTA=$(($ANO+1))
MES_ARQUIVO=01
else
ANO_PASTA=$ANO
MES_ARQUIVO=$(($MES+1))
fi
PASTA_TEMP=/var/www/tgnet/boletos/$ANO_PASTA/temp
PASTA_SEG=/var/www/tgnet/boletos/$ANO_PASTA/segunda-via
PASTA=/var/www/tgnet/boletos/$ANO_PASTA/
ARQUIVO=$PASTA$MES_ARQUIVO.pdf
GRUPO_A_CONVERTER=""
mkdir -p $PASTA
chmod 0777 $PASTA
mkdir -p $PASTA_TEMP
chmod 0777 $PASTA_TEMP
mkdir -p $PASTA_SEG
chmod 0777 $PASTA_SEG
cd $PASTA_TEMP
curl -s -u tgnetSys:senhaDoSys http://localhost/tgnet/eng/gera_boleto.php
for PDF in *.pdf;
do
GRUPO_A_CONVERTER=$GRUPO_A_CONVERTER' '$PDF
done
pdftk $GRUPO_A_CONVERTER cat output $ARQUIVO
for PDF2 in *.pdf;
do
rm $PDF2
done
rmdir $PASTA_TEMP
