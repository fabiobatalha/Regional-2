echo "|----Gerando HTML para a caixa Rede Scielo"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/collectionList.xml $XSL_HOME/network-XHTML.xsl $XHTML_LANG_PARAM $NETWORK_PARAM $APP_START_DIR > $FILE
