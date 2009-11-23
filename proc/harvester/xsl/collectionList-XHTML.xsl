<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>

<xsl:param name="lang"/>
<xsl:param name="DIR"/>

<xsl:variable name="langs">
    <xsl:copy-of select="document('../xml/labels.xml')" />
</xsl:variable>

<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]" />

	<xsl:template match="/">
		<xsl:element name="li">
			<xsl:value-of select="$labels/collectionList/title" /><br />
			<xsl:apply-templates mode="list"></xsl:apply-templates>
		</xsl:element>	
	</xsl:template>

	<xsl:template match="collection" mode="list">
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="./@uri"></xsl:value-of>
			</xsl:attribute>
			<xsl:value-of select="./name"></xsl:value-of>
		</xsl:element>
		<xsl:value-of select="' - '" />
		<xsl:element name="strong">
			<xsl:value-of select="./journalTotal" />
		</xsl:element>
		<xsl:value-of select="' - '" />
		<xsl:value-of select="$labels/general/journals" />
		<br />
	</xsl:template>		
		
</xsl:stylesheet>
