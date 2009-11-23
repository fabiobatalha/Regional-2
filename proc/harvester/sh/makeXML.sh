echo Criando secondLevelForAlphabeticList.xml
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForAlphabeticList.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForAlphabeticList.xsl

echo Criando secondLevelForCollectionByAlphabeticList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForCollectionByAlphabeticList.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForCollectionByAlphabeticList.xsl

echo Criando secondLevelForCollectionByDate
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForCollectionByDate.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForCollectionByDate.xsl

echo Criando secondLevelForCollectionBySubject
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForCollectionBySubject.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForCollectionBySubject.xsl

echo Criando secondLevelForLastIssuesByAlphabeticList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForLastIssuesByAlphabeticList.xml $XML_HOME/new_issues.xml $XSL_HOME/secondLevelForLastIssuesByAlphabeticList.xsl $LAST_DATE_PARAM

echo Criando secondLevelForLastIssuesBySubject
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForLastIssuesBySubject.xml $XML_HOME/new_issues.xml $XSL_HOME/secondLevelForLastIssuesBySubject.xsl  $LAST_DATE_PARAM

echo Criando secondLevelForLastJournalsByAlphabeticList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForLastJournalsByAlphabeticList.xml $XML_HOME/new_titles.xml $XSL_HOME/secondLevelForLastJournalsByAlphabeticList.xsl  $LAST_DATE_PARAM

echo Criando secondLevelForLastJournalsByDate
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForLastJournalsByDate.xml $XML_HOME/new_titles.xml $XSL_HOME/secondLevelForLastJournalsByDate.xsl  $LAST_DATE_PARAM

echo Criando secondLevelForLastJournalsBySubject
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForLastJournalsBySubject.xml $XML_HOME/new_titles.xml $XSL_HOME/secondLevelForLastJournalsBySubject.xsl $LAST_DATE_PARAM

echo Criando secondLevelForPublishersByCollection
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForPublishersByCollection.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForPublishersByCollection.xsl $XHTML_LANG_PARAM

echo Criando secondLevelForPublishersByLetter
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForPublishersByLetter.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForPublishersByLetter.xsl

echo Criando secondLevelForSubjectByCollection
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForSubjectByCollection.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForSubjectByCollection.xsl

echo Criando secondLevelForSubjectByLetter
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/secondLevelForSubjectByLetter.xml $XML_HOME/get_titles.xml $XSL_HOME/secondLevelForSubjectByLetter.xsl

echo Criando collectionList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/collectionList.xml $XML_HOME/get_titles.xml $XSL_HOME/collectionList.xsl

echo Criando journalAlphabeticList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/journalAlphabeticList.xml $XML_HOME/get_titles.xml $XSL_HOME/journalAlphabeticList.xsl

echo Criando lastIssues
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/lastIssues.xml $XML_HOME/new_issues.xml $XSL_HOME/lastIssues.xsl $LAST_DATE_PARAM

echo Criando lastTitles
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/lastTitles.xml $XML_HOME/new_titles.xml $XSL_HOME/lastTitles.xsl $LAST_DATE_PARAM

echo Criando publisherAlphabeticList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/publisherAlphabeticList.xml $XML_HOME/get_titles.xml $XSL_HOME/publisherAlphabeticList.xsl

echo Criando subjectList
$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/subjectList.xml $XML_HOME/get_titles.xml $XSL_HOME/subjectList.xsl

chmod -R 777 xml/*

echo Importanto o get_titles.xml para o mysql . . .

sed "s/'/''/g" -i $XML_HOME/get_titles.xml 

$JAVA_EXEC -jar $PROC/lib/saxon8.jar -o $XML_HOME/get_titles.sql $XML_HOME/get_titles.xml $XSL_HOME/get_titles2sql.xsl

$MYSQL/mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_DATABASE < $XML_HOME/get_titles.sql 
