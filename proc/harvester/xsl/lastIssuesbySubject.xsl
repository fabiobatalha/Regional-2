<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:template match="/">
	<lastIssues>
		<xsl:apply-templates select="collectionList/collection" />
	</lastIssues>
</xsl:template>

<xsl:template match="collection">
<xsl:variable name="lastDate" select="wxis-modules/record[1]/updateDate" />
		<collection>
			<xsl:attribute name="uri">
				<xsl:value-of select="@uri"/>
			</xsl:attribute>

			<xsl:variable name="total">
				<xsl:value-of select="count(wxis-modules/record[updateDate = $lastDate])"/>
			</xsl:variable>

			<name><xsl:value-of select="@name"/></name>
			<processingDate><xsl:value-of select="wxis-modules/record[1]/updateDate"/></processingDate>
			<total><xsl:value-of select="$total"/></total>
		</collection>
</xsl:template>


</xsl:stylesheet>
