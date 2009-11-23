<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:param name="LANG"/>
	<xsl:variable name="texts" select="document(concat($LANG,'/metaSearchInstancesTexts.xml'))//texts"/>
	<xsl:variable name="rules" select="document('metaSearchRules.xml')"/>
	<xsl:template match="/">
		<metaSearchInstances>
		<xsl:copy-of select="$rules//url_search"/>
			<xsl:apply-templates select="//instance"/>
		</metaSearchInstances>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*|text()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@name">
		<xsl:variable name="name" select="."/>
		<xsl:attribute name="name"><xsl:value-of select="$texts//text[@name=$name]/text()"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="@status">
	</xsl:template>
	<xsl:template match="instance/url">
	</xsl:template>
	<xsl:template match="instance">
		<instance>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*"/>
			<links>
				<xsl:apply-templates select="$rules//links/indexes/*[@status='on']">
					<xsl:with-param name="instance" select="."/>
					<xsl:with-param name="call" select="$rules//links/call"/>
				</xsl:apply-templates>
			</links>
		</instance>
	</xsl:template>
	<xsl:template match="links/indexes/*">
		<xsl:param name="instance"/>
		<xsl:param name="call"/>
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*|text()">
				<xsl:with-param name="instance" select="$instance"/>
				<xsl:with-param name="call" select="$call"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="links/indexes/*/text()">
		<xsl:param name="instance"/>
		<xsl:param name="call"/>
		<xsl:apply-templates select="$call">
			<xsl:with-param name="instance" select="$instance"/>
			<xsl:with-param name="index" select="."/>
		</xsl:apply-templates>
	</xsl:template>

	
	<xsl:template match="call">
		<xsl:param name="instance"/>
		<xsl:param name="index"/>
		<xsl:apply-templates select="text() | *">
			<xsl:with-param name="instance" select="$instance"/>
			<xsl:with-param name="index" select="$index"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="*/PARAM_BASE">
		<xsl:param name="instance"/>
		<xsl:param name="index"/>
		<xsl:value-of select="$instance/iahCode"/>
	</xsl:template>
	<xsl:template match="*/REPLACE_URL">
		<xsl:param name="instance"/>
		<xsl:param name="index"/>
		<xsl:value-of select="$instance/url"/>
	</xsl:template>
	<xsl:template match="*/PARAM_LANG">
		<xsl:param name="instance"/>
		<xsl:param name="index"/>
		<xsl:value-of select="$texts/@param_lang"/>
	</xsl:template>
	<xsl:template match="call/PARAM_INDEX">
		<xsl:param name="instance"/>
		<xsl:param name="index"/>
		<xsl:value-of select="$index"/>
	</xsl:template>
	<xsl:template match="*/PARAM_REP">
		<xsl:param name="instance"/>
		<xsl:param name="index"/><xsl:if test="$instance/iahCode!='library'">_param_limit=rep=<xsl:value-of select="concat('000',substring-after($instance/iahCode,'r'))"/></xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
