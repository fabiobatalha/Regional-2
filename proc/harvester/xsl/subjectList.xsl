<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:variable name="subject-list" select="document('../xml/commonSubjectList.xml')"/>

<xsl:template match="/">
	<xsl:variable name="subject-list-tree">
		<xsl:apply-templates select="$subject-list/subjectList/subject">
			<xsl:with-param name="wxis-modules" select="//wxis-modules"/>
		</xsl:apply-templates>
	</xsl:variable>
	<xsl:variable name="total">
		<xsl:value-of select="count(//wxis-modules//record[publicationStatus='C']/subject)"/>
	</xsl:variable>
	<xsl:variable name="matchTotal">
		<xsl:value-of select="sum($subject-list-tree/subject/total)"/>
	</xsl:variable>
	<subjectList>
		<xsl:copy-of select="$subject-list-tree"/>
		<subject uri="">
			<name>Others</name>
			<total><xsl:value-of select="$total - $matchTotal"/></total>
		</subject>
	</subjectList>
</xsl:template>

<xsl:template match="subject">
	<xsl:param name="wxis-modules"/>
	<xsl:variable name="subject-text" select="text()"/>
        <xsl:variable name="total" select="count($wxis-modules//record[subject=$subject-text and publicationStatus='C'])"/>
	<xsl:if test="$total &gt; 0">
	<subject uri="">
		<name><xsl:value-of select="text()"/></name>
	        <total><xsl:value-of select="$total"/></total>
	</subject>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
