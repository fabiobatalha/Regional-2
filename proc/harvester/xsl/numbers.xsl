<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output indent="no" encoding="ISO-8859-1" omit-xml-declaration="yes"/>
	<xsl:param name="lang"/>
	<xsl:param name="DIR"/>
	<xsl:variable name="langs">
		<xsl:copy-of select="document('../xml/labels.xml')"/>
	</xsl:variable>
	<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]"/>
	<xsl:template match="/">
<!--
		<div class="webServices">
			<h3>
				<span>
					<xsl:value-of select="$labels//reports"/>
				</span>
			</h3>
-->
			<div class="reports">
				<ul>
					<li>
						<a href="{$DIR}/applications/scielo-org/php/siteUsage.php"><xsl:value-of select="$labels//usage"/></a>
					</li>
					<li>
						<a href="{$DIR}/applications/scielo-org/php/citations.php"><xsl:value-of select="$labels//citations"/></a>
					</li>
					<li>
						<a href="{$DIR}/applications/scielo-org/php/collaborator.php"><xsl:value-of select="$labels//co-authors"/></a>
					</li>
				</ul>
					<!--div class="indicators">
						<ul-->
				<ul id="indicators">
					<li>
						<!--xsl:call-template name="sum">
							<xsl:with-param name="value" select="sum(//collection/indicators/journalTotal[.!=''])"/>
						</xsl:call-template-->
						<xsl:call-template name="sum">
							<xsl:with-param name="value" select="count(//record[publicationStatus='C'])"/>
						</xsl:call-template>
						<xsl:value-of select="$labels//journals"/>
					</li>
					<li>
						<xsl:call-template name="sum">
							<xsl:with-param name="value" select="sum(//collection/indicators/issueTotal[.!=''])"/>
						</xsl:call-template>
						<xsl:value-of select="$labels//issues"/>
					</li>
					<li>
						<xsl:call-template name="sum">
							<xsl:with-param name="value" select="sum(//collection/indicators/articleTotal[.!=''])"/>
						</xsl:call-template>
						<xsl:value-of select="$labels//articles"/>
					</li>
					<li>
						<xsl:call-template name="sum">
							<xsl:with-param name="value" select="sum(//collection/indicators/citationTotal[.!=''])"/>
						</xsl:call-template>
						<xsl:value-of select="$labels//citations"/>
					</li>
				</ul>
			</div>
<!--
		</div>
-->
	</xsl:template>
	<xsl:template name="sum">
		<xsl:param name="value"/>
		<span class="lengthData">
			<strong>
				<xsl:choose>
					<xsl:when test="$value &gt; 0">
						<xsl:choose>
							<xsl:when test="$lang='en'">
								
								<xsl:value-of select="format-number($value, '#,###')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="translate(format-number($value, '#,###'),',','.')"/>
							</xsl:otherwise>
						</xsl:choose>
						<!--xsl:value-of select="format-number($value, '#,###')"/-->
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</strong>
		</span>&#160; 	</xsl:template>
</xsl:stylesheet>
