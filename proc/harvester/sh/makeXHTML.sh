#!/bin/bash
clear
if [ $# -eq 0 ];
then
   echo Especifique os idiomoas que serao gerados!
   echo Idiomas :
   echo "    pt";
   echo "    en";
   echo "    es";
   exit
fi  

while [ $# -ge 1 ]; do

	export HTML_DEST=../../htdocs/applications/scielo-org/html/$1
	export HTML_LOCAL=$PROC/html/$1
	export XHTML_LANG=$1
	export XHTML_LANG_PARAM="lang=$XHTML_LANG"
	export LAST_DATE_PARAM="processDate=`cat processDate.txt`"

	echo Language: $1
	
	echo 'Gerando a Coluna Periódicos'
	export FILE=$HTML_LOCAL/journalP1.html
	source $SH_HOME/makeJournalsColumnP1.sh

	echo 'Gerando a Coluna Periódicos'
	export FILE=$HTML_LOCAL/journalP2.html
	source $SH_HOME/makeJournalsColumnP2.sh
	
	echo 'Gerando a Coluna Periódicos'
	export FILE=$HTML_LOCAL/journalP3.html
	source $SH_HOME/makeJournalsColumnP3.sh
	
	echo 'Gerando a Coluna Periódicos'
	export FILE=$HTML_LOCAL/journalP4.html
	source $SH_HOME/makeJournalsColumnP4.sh			

	echo 'Gerando a Coluna Periódicos'
        export FILE=$HTML_LOCAL/journalP5.html
        source $SH_HOME/makeJournalsColumnP5.sh

	echo 'Gerando a Coluna Artigos'
        export FILE=$HTML_LOCAL/articles.html
        source $SH_HOME/makeLastArticles.sh

	echo 'Gerando a Coluna Atualizações'
    	export FILE=$HTML_LOCAL/updates.html
    	source $SH_HOME/makeUpdates.sh

	echo 'Gerando SciELO em Números'
	export FILE=$HTML_LOCAL/SciELO_in_numbers.html
	source $SH_HOME/makeSciELOInNumbers.sh
	
	echo 'Gerando Grupo Rede SciELO'
	export FILE=$HTML_LOCAL/SciELO_network.html
	source $SH_HOME/makeSciELONetwork.sh	
	
shift
done
