<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" version="1.0" indent="yes"/>
	<xsl:include href="common.xsl"/>

	<xsl:variable name="index">
		<xsl:apply-templates select="/MAIN/wxis-modules//Isis_Key" mode="index"/>	
	</xsl:variable>

	<xsl:template match="Isis_Key" mode="index">	
		<xsl:value-of select="concat('|',occ,'|')"/>
	</xsl:template>	

	<xsl:template match="*" mode="content">		
		<xsl:apply-templates select="." mode="center"/>
	</xsl:template>
	
	<xsl:template match="*" mode="left"/>

	<xsl:template match="*" mode="center">
		<xsl:apply-templates select="." mode="form-search"/>
	</xsl:template>
	
	<xsl:template match="replace/item">	
		<li>
			<xsl:value-of select="."/>
		</li>
	</xsl:template>

</xsl:stylesheet>