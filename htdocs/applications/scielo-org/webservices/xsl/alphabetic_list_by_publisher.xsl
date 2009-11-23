<?xml version="1.0" encoding="ISO-8859-1"?>	
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" version="1.0" media-type="text/html" />

	<xsl:variable name="DIR" select="/root//DIR" />
	<xsl:variable name="letter" select="/root/http-info/cgi/letter"/>
	<xsl:variable name="lang" select="/root/http-info//lang" />
	<xsl:variable name="texts" select="document(concat('../../xml/',$lang,'/bvs.xml'))/bvs/texts" />	

	<xsl:variable name="sorted">
		<xsl:apply-templates select="//secondLevelForPublishersByLetter/order" mode="sort">
			<xsl:sort select="publisher"/>
		</xsl:apply-templates>
	</xsl:variable>
	
	<xsl:template match="/">
		<div id="collection">
			<h3><span><xsl:value-of select="$texts/text[@id = 'alphabetic.publisher.title']"/></span></h3>
			<div id="breadCrumb">
			    <a href="{$DIR}/index.php?lang={$lang}">home</a>
				&gt; <xsl:value-of select="$texts/text[@id = 'alphabetic.home']"/>
			</div>
		   <div class="content">

			 <xsl:choose>
				<xsl:when test="$letter != ''">
				        <h3><xsl:value-of select="$letter"/><span class="lengthData"><strong><xsl:value-of select="count(//publisher[starts-with(name,$letter)])"/></strong> periodico(s)</span></h3>
					<xsl:apply-templates select="//publisher[starts-with(translate(name,'ÁÉÍÓÚ','AEIOU'),$letter)]">
						<xsl:sort select="name"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<h3>A<span class="lengthData"><strong><xsl:value-of select="count(//publisher[starts-with(name,'A')])"/></strong> periodico(s)</span></h3>
					<xsl:apply-templates select="//publisher[starts-with(name,'A')]">
						<xsl:sort select="name"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			 </xsl:choose>


		   </div>
		</div>

	</xsl:template>

	<xsl:template match="publisher">
		<div><xsl:value-of select="name"/><strong> (<xsl:value-of select="../../@collection"/>)</strong></div>
		<ul>
		<xsl:apply-templates select="JournalList"/>
		</ul>
	</xsl:template>

	<xsl:template match="JournalList">
		<xsl:apply-templates select="journal"/>
	</xsl:template>

	<xsl:template match="journal">
		<li><a href="{@uri}"><xsl:value-of select="."/></a></li>
	</xsl:template>

</xsl:stylesheet>
