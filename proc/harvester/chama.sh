#declare -x LANG="en_US.ISO-8859-1"
. conf.sh

$JAVA_HOME/bin/java -Dfile.encoding=ISO-8859-1 -cp .:scieloOrgHarvester.jar:lib/commons-codec.jar:lib/commons-httpclient.jar:lib/commons-logging.jar org.bireme.scieloorgharvester.scieloOrgHarvester

cp -f lastProcessDate.txt processDate.txt

echo Generating XML Files
sh/makeXML.sh

echo Generating XHTML Files
sh/makeXHTML.sh pt
sh/makeXHTML.sh es
sh/makeXHTML.sh en

cp -f xml/*.xml $HTDOCS/applications/scielo-org/webservices/xml
cp -rf html/en/*.html $HTDOCS/applications/scielo-org/html/en
cp -rf html/pt/*.html $HTDOCS/applications/scielo-org/html/pt
cp -rf html/es/*.html $HTDOCS/applications/scielo-org/html/es

date +%Y%M%d > lastProcessDate.txt
