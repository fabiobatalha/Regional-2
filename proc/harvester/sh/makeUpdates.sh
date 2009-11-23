echo "|----Gerando HTML para a caixa Últimos Periodicos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/collectionList.xml $XSL_HOME/updates.xsl $XHTML_LANG_PARAM $LAST_DATE_PARAM $APP_START_DIR > $FILE
