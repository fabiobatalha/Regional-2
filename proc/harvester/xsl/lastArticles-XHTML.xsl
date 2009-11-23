<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>
	<xsl:param name="DIR"/>
	<xsl:param name="lang"/>
	<xsl:variable name="langs">
		<xsl:copy-of select="document('../xml/labels.xml')"/>
	</xsl:variable>
	<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]"/>
	<xsl:variable name="rep">
		<xsl:if test="count(//collection)=1 and count(//repository)&gt;0"><xsl:apply-templates select="//collection/@flagName"/></xsl:if>
	</xsl:variable>
	<xsl:template match="/">
		<!--div class="webServices">
			<h3>
				<span>
					<xsl:value-of select="$labels//articles"/>
				</span>
			</h3-->
			<div class="articles"><ul><xsl:apply-templates select=".//collection[1]"/></ul></div>
		<!--/div-->
	</xsl:template>
	<xsl:template match="collection">
		<xsl:element name="li">
			<div>
				<a href="{@uri}/scielo.php?script=sci_artlist&amp;lng={$lang}&amp;nrm=iso{$rep}">
					<xsl:value-of select="$labels//last-articles"/>
				</a>
			</div>
		</xsl:element>
	</xsl:template>
	<xsl:template match="@flagName[.='00']"/>
	<xsl:template match="@flagName[.!='00']">&amp;rep=<xsl:value-of select="."/></xsl:template>

</xsl:stylesheet>
