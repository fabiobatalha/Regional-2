<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:template match="/">
	<collectionList>
	<xsl:for-each select="/collectionList/collection">
	        <xsl:variable name="namec" select="@name"/>
		<collection uri="{@uri}" flagName="{@flagName}" grupo="{@grupo}">
			<xsl:apply-templates select="indicators">
				<xsl:with-param name="namec" select="$namec"/>
			</xsl:apply-templates>
		</collection>
	</xsl:for-each>
	</collectionList>
</xsl:template>

<xsl:template match="indicators">
	<xsl:param name="namec"/>
	<xsl:variable name="currentTotal" select="count(../wxis-modules/record[publicationStatus = 'C'])"/>
	<name><xsl:value-of select="$namec"/></name> 
	<journalTotal current="{$currentTotal}"><xsl:value-of select="journalTotal"/></journalTotal>
	<articleTotal><xsl:value-of select="articleTotal"/></articleTotal>
	<issueTotal><xsl:value-of select="issueTotal"/></issueTotal>
	<citationTotal><xsl:value-of select="citationTotal"/></citationTotal>
</xsl:template>
</xsl:stylesheet>
