<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>

<xsl:param name="DIR"/>
<xsl:param name="lang"/>

<xsl:variable name="langs">
    <xsl:copy-of select="document('../xml/labels.xml')" />
</xsl:variable>

<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]" />

	<xsl:template match="/">
		<xsl:element name="li">
			<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticList">
			<strong>
				<xsl:value-of select="$labels/journalAlphabeticList/title" />
			</strong>
			</a>
			<ul id="subjects">
				<div class="letters"><xsl:apply-templates select="//journal"/></div>
			</ul>
		</xsl:element>	
	</xsl:template>

	<xsl:template match="journal">
		<li>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="@uri"/></xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</li>
	</xsl:template>

</xsl:stylesheet>
