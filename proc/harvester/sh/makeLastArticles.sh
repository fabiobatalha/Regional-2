echo "|----Gerando HTML para a ultimos artigos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/get_titles.xml $XSL_HOME/lastArticles-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR > $FILE
