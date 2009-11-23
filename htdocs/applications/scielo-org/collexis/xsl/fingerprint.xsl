<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" indent="yes"/>
	<xsl:include href="common.xsl"/>


	<xsl:template match="*" mode="body">
		<body>
			<link rel="stylesheet" href="css/screen.css" type="text/css"/>	
			<div id="layoutSize">
				<xsl:apply-templates select="/MAIN//record"/>				
			</div>
			<!--
			<textarea cols="140" rows="20">
				<xsl:copy-of select="."/>
			</textarea>
			-->
		</body>
	</xsl:template>	
		
	<xsl:template match="record">
		<div id="fingerprintBox">
			<xsl:apply-templates select="@title"/>
			<ul>
				<xsl:apply-templates select="fingerprintlist/fingerprint[@thesaurus != 'freetext']"/>		
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="@title">
		<div class="title">
			<xsl:value-of select="."/>
		</div>	
	</xsl:template>
	
	<xsl:template match="concept">
		<xsl:variable name="rank">
			<xsl:choose>
				<xsl:when test="@rank != 1">
					<xsl:value-of select="substring-before(@rank * 100,'.')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'100'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		<table cellspacing="0" cellpading="0">
			<tr>
				<td>
					<div id="line">
						<img src="{$PATH_IMAGE}/fpline.gif" border="0" height="8" width="{format-number(@rank * 100,'#')}"/>
					</div>
				</td>
				<td>
					<div id="rank">
						<xsl:value-of select="format-number(@rank * 100,'#')"/>
						<!--xsl:value-of select="$rank"/-->
					</div>
				</td>
				<td>
					<div id="name">
						<xsl:value-of select="name"/>		
					</div>		
				</td>
			</tr>
		</table>	
	</xsl:template>
	
</xsl:stylesheet>
