echo '<div class="journals"><ul>' > $FILE
#Gera o HTML para a lista alfabetica de periódicos
echo "|----Gerando HTML para a lista de Periodicos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/secondLevelForAlphabeticList.xml $XSL_HOME/journalAlphabeticListFull-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE
#Gera o HTML para a lista alfabetica de publicadores
echo "|----Gerando HTML para a lista de Publicadores"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/publisherAlphabeticList.xml $XSL_HOME/publisherAlphabeticList-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE
echo '</ul></div>' >> $FILE
