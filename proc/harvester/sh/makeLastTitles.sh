echo "|----Gerando HTML para a caixa �ltimos T�tulos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/lastTitles.xml $XSL_HOME/lastTitles.xsl $XHTML_LANG_PARAM $APP_START_DIR > $FILE
