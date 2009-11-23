echo "|----Gerando HTML para a caixa Últimos Periodicos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/lastIssues.xml $XSL_HOME/lastIssues.xsl $XHTML_LANG_PARAM $APP_START_DIR > $FILE
