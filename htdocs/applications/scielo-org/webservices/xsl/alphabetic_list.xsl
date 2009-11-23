<?xml version="1.0" encoding="iso-8859-1"?>
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="iso-8859-1"/>

	<xsl:variable name="DIR" select="/root//DIR" />
	<xsl:variable name="letter" select="/root/http-info/cgi/param"/>
	<xsl:variable name="lang" select="/root/http-info//lang" />
	<xsl:variable name="texts" select="document(concat('file://../../xml/',$lang,'/bvs.xml'))/bvs/texts" />	

	<xsl:variable name="sorted">
		<xsl:apply-templates select="//collection/wxis-modules/record" mode="sort">
			<xsl:sort select="title"/>
		</xsl:apply-templates>
	</xsl:variable>
	
	<xsl:template match="/">
		<div id="collection">
			<h3><span><xsl:value-of select="$texts/text[@id = 'alphabetic.title']"/></span></h3>
			<div id="breadCrumb">
			    <a href="{$DIR}/index.php?lang={$lang}">home</a>
				&gt; <xsl:value-of select="$texts/text[@id = 'alphabetic.home']"/>
			</div>
		   <div class="content">
	  	     <ul>
			 	<xsl:choose>
					<xsl:when test="$letter != ''">
					   <xsl:apply-templates select="$sorted//record[translate(substring(title,1,1),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU') = $letter]" mode="single"/>				</xsl:when>
					<xsl:otherwise>
					   	  <xsl:apply-templates select="$sorted//record" mode="all"/>
					</xsl:otherwise>
			    </xsl:choose>
			</ul>
		   </div>
		</div>
	</xsl:template>
	
	<xsl:template match="record" mode="sort">
<!--		<xsl:copy-of select="."/> -->
			<record>
				<xsl:copy-of select="title"/>
				<xsl:copy-of select="processDate"/>
				<xsl:copy-of select="issn"/>
				<xsl:copy-of select="publisher"/>
				<xsl:copy-of select="subject"/>
				<xsl:copy-of select="publicationStatus"/>
				<xsl:copy-of select="processDate"/>
				<uri><xsl:value-of select="../../@uri" /></uri>
			</record>
	</xsl:template>	
	
	<xsl:template match="record" mode="all">		
		<xsl:variable name="previous" select="translate(normalize-space(preceding-sibling::record[position() = 1]/title),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU')"/>
		<xsl:variable name="current" select="translate(normalize-space(title),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU')"/>

		<xsl:if test="substring($current,1,1) != substring($previous,1,1)">
			<h3><xsl:value-of select="substring($current,1,1)"/></h3>
		</xsl:if>
		<li>
			<a href="{concat(uri,'/scielo.php?script=sci_serial&amp;pid=',issn,'&amp;lng=en&amp;nrm=iso')}" target="_blank"><xsl:value-of select="title"/></a>
<!--			<textarea cols="80" rows="10">
				<xsl:copy-of select="." />
			</textarea>
-->
		</li>
	</xsl:template>

	<xsl:template match="record" mode="single">
		<xsl:if test="position() = 1">
			<h3><xsl:value-of select="substring(title,1,1)"/></h3>
		</xsl:if>
		<li>
			<a href="{uri}" target="_blank"><xsl:value-of select="title"/></a>
		</li>
	</xsl:template>

</xsl:stylesheet>
