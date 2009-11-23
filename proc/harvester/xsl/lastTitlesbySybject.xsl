<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:variable name="subjectList" select="document('../xml/commonSubjectList.xml')"/>

<xsl:template match="/">
	<lastTitles>
		<xsl:apply-templates select="$subjectList//subject">
			<xsl:with-param name="newTitles" select="."/>
		</xsl:apply-templates>
	</lastTitles>
</xsl:template>

<xsl:template match="subject">
	<xsl:param name="newTitles"/>
	<xsl:variable name="subject" select="."/>
	<collection>
		<xsl:attribute name="uri">
			<xsl:value-of select="@uri"/>
		</xsl:attribute>
		<xsl:element name="name"><xsl:value-of select="$subject"/></xsl:element>
		<xsl:apply-templates select="$newTitles//collectionList">
			<xsl:with-param name="subject" select="$subject"/>
		</xsl:apply-templates>
	</collection>
</xsl:template>

<xsl:template match="collectionList">
		<xsl:param name="subject"/>
		<xsl:variable name="recordsPublicationStatusC">
			<xsl:apply-templates select="collection/wxis-modules/record[publicationStatus = 'C']" mode="sortProcessDate">
				<xsl:with-param name="subject" select="$subject"/>
				<xsl:sort select="processDate" order="descending"/>
			</xsl:apply-templates>
		</xsl:variable>

		<xsl:variable name="lastDate" select="$recordsPublicationStatusC/record[1]/processDate"/>		
		
		<xsl:variable name="total">
			<xsl:value-of select="count(collection/wxis-modules/record[processDate=$lastDate and publicationStatus ='C' and subject = $subject])"/>
		</xsl:variable>
		<processingDate><xsl:value-of select="$lastDate"/></processingDate>
		<total><xsl:value-of select="$total"/></total>
</xsl:template>

<xsl:template match="record" mode="sortProcessDate">
	<xsl:param name="subject"/>
	<xsl:variable name="subjects">
		<xsl:apply-templates select="subject" mode="getSubjects"/>
	</xsl:variable>
	<xsl:if test="contains($subjects,$subject)">
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>

<xsl:template match="subject" mode="getSubjects">
	<xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>
