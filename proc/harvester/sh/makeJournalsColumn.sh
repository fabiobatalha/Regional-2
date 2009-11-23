echo '<div class="journals"><ul>' > $FILE

#Gera o form para a pesquisa
echo "|----Gerando o Form de Consulta"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/journalSearchBox.xml $XSL_HOME/journalSearchBox.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE

#Gera o HTML para a lista alfabetica de periódicos
echo "|----Gerando HTML para a lista de Periodicos"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/journalAlphabeticList.xml $XSL_HOME/journalAlphabeticList-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE

#excluido em 13-jun-2006 
#Gera o HTML para a lista de coleções
#echo "|----Gerando HTML para a lista de Coleções"
#$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/collectionList.xml $XSL_HOME/collectionList-XHTML.xsl $XHTML_LANG_PARAM >> $FILE

#Gera o HTML para a lista de assuntos
echo "|----Gerando HTML para a lista de Assuntos"
#$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/subjectList.xml $XSL_HOME/subjectList-XHTML.xsl $XHTML_LANG_PARAM >> $FILE
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/labels.xml $XSL_HOME/subjectList-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE

#Gera o HTML para a lista alfabetica de publicadores
echo "|----Gerando HTML para a lista de Publicadores"
$JAVA_EXEC -jar $SAXON_JAR $XML_HOME/publisherAlphabeticList.xml $XSL_HOME/publisherAlphabeticList-XHTML.xsl $XHTML_LANG_PARAM $APP_START_DIR >> $FILE

echo '</ul></div>' >> $FILE
