<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="no" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

<xsl:param name="lang"/>
	<xsl:param name="DIR"/>
	
<xsl:variable name="langs">
    <xsl:copy-of select="document('../xml/labels.xml')" />
</xsl:variable>

<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]" />

	<xsl:template match="/">
		<xsl:element name="li">
		<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list">
                <strong>
			<xsl:value-of select="$labels/publisherAlphabeticList/title" /> - <xsl:value-of select="$labels/general/all"/> <!--xsl:value-of select="sum(//alphabetic/@total)"/-->
                </strong>
		</a>
		<div class="letters">
			<xsl:apply-templates mode="list"></xsl:apply-templates>
		</div>
		</xsl:element>	
	</xsl:template>


	<xsl:template match="alphabetic" mode="list">
		<xsl:element name="a">
			<xsl:attribute name="href"><xsl:value-of select="concat($DIR,'/applications/scielo-org/php/secondLevel.php?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list&amp;letter=',./@letter)"></xsl:value-of></xsl:attribute>
			<xsl:attribute name="title">
				<xsl:choose>
				  <xsl:when test="./@total = 1">
					<xsl:value-of select="concat(./@total,' ',$labels/general/journal)" />
				  </xsl:when>
				  <xsl:otherwise>
					<xsl:value-of select="concat(./@total,' ',$labels/general/journals)" />
				  </xsl:otherwise>
				</xsl:choose> 
			</xsl:attribute>
		<xsl:value-of select="./@letter"></xsl:value-of>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
