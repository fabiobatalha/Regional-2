echo "|----Gerando HTML para a caixa SciELO em números"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/get_titles.xml $XSL_HOME/numbers.xsl $XHTML_LANG_PARAM $APP_START_DIR > $FILE
