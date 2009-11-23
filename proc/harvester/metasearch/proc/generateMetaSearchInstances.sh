
#!/bin/bash
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

	mkdir -p metasearch/xml/$1
	export FILE=metasearch/xml/$1/metaSearchInstances.xml 

	echo Language: $1
	echo "|----Gerando metaSearchInstances $FILE"
	$JAVA_EXEC -jar $SAXON_JAR metasearch/metaSearchInstancesDefinitions.xml metasearch/proc/generateMetaSearchInstancesXML.xsl LANG=$1 > $FILE

shift
done

