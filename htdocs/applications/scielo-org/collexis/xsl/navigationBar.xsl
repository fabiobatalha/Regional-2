<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="*" mode="pages">
		<xsl:param name="from"/>
		<xsl:param name="total"/>
		<xsl:param name="count"/>
				
		<xsl:variable name="page" select="ceiling($from div $count)"/>
		<xsl:variable name="last" select="ceiling($total div $count)"/>	
		<xsl:variable name="nPages" select="ceiling($total div $count)"/>	
		<xsl:variable name="pages" select="document('../xml/pages.xml')/pages" />


		<xsl:variable name="rangeSet" select="( (number($from) div number($count)) div number(count($pages/page)))"/>
                
		<xsl:variable name="range">
			<xsl:if test="$rangeSet &gt;= 1">
				<xsl:value-of select="substring-before( $rangeSet,'.' )"/>
			</xsl:if>	
		</xsl:variable>

		<xsl:if test="$last &gt; 1">
			<div id="navigationBar">
					<xsl:value-of select="$texts/text[find = 'IR_PARA_PAGINA']/replace"/>&#160;

					<xsl:apply-templates select="$pages/page[$range &gt;= 1 and position() = 1]" mode="backward-navigation-left">
						<xsl:with-param name="page" select="$page"/>
						<xsl:with-param name="count" select="$count"/>
						<xsl:with-param name="range" select="$range"/>
					</xsl:apply-templates>

					<xsl:apply-templates select="$pages/page[@number &lt;= $last]" mode="page">
						<xsl:with-param name="page" select="$page"/>
						<xsl:with-param name="count" select="$count"/>
						<xsl:with-param name="range" select="$range"/>
						<xsl:with-param name="last" select="$last"/>
					</xsl:apply-templates>
					
					<xsl:apply-templates select="$pages/page[position() = last()]" mode="foward-navigation-right">
						<xsl:with-param name="page" select="$page"/>
						<xsl:with-param name="count" select="$count"/>
						<xsl:with-param name="range" select="$range"/>
						<xsl:with-param name="last" select="$last"/>
					</xsl:apply-templates>

			</div>	
		</xsl:if>

	</xsl:template>


	<xsl:template match="page" mode="backward-navigation-left">
		<xsl:param name="page"/>
		<xsl:param name="count"/>
		<xsl:param name="range"/>	
		<xsl:variable name="current" select="concat($range,@number) -1"/>

		<xsl:apply-templates select="." mode="call-page">
			<xsl:with-param name="from" select="( $current * $count) + 1"/>
			<xsl:with-param name="image" select="'left.gif'"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="page" mode="foward-navigation-right">
		<xsl:param name="page"/>
		<xsl:param name="count"/>
		<xsl:param name="range"/>
		<xsl:param name="last"/>
		<xsl:variable name="current" select="concat($range,@number) + 1"/>		
	
		<xsl:if test="$current &lt; $last">	
			<xsl:apply-templates select="." mode="call-page">
				<xsl:with-param name="from" select="($current * $count) + 1"/>
				<xsl:with-param name="image" select="'right.gif'"/>
			</xsl:apply-templates>		
		</xsl:if>	
	</xsl:template>
	
	<xsl:template match="page" mode="page">
		<xsl:param name="page"/>
		<xsl:param name="count"/>
		<xsl:param name="range"/>
		<xsl:param name="last"/>

		<xsl:variable name="current" select="concat($range,@number)+1"/>
		<xsl:choose>
			<xsl:when test="$current = $page">				
				<xsl:apply-templates select="." mode="this-page">
					<xsl:with-param name="range" select="$range"/>
				</xsl:apply-templates>	
			</xsl:when>
			<xsl:when test="$current &lt;= $last">								
				<xsl:apply-templates select="." mode="call-page">
					<xsl:with-param name="from" select="(($current - 1) * $count) + 1"/>
					<xsl:with-param name="range" select="$range"/>
				</xsl:apply-templates>
			</xsl:when>	
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<xsl:template match="page" mode="this-page">
		<xsl:param name="range"/>
		<xsl:value-of select="concat($range,@number)+1"/>
	</xsl:template>

	<xsl:template match="page" mode="call-page">
		<xsl:param name="from"/>
		<xsl:param name="range"/>
		<xsl:param name="image"/>
		<a href="javascript:go_document('{$from}')" >
			<xsl:choose>
				<xsl:when test="$image != ''">
					<img src="{concat($PATH_IMAGE,'/',$image)}" border="0" align="absmiddle" valign="middle"/>
				</xsl:when>
				<xsl:otherwise>
					<strong><xsl:value-of select="concat($range,@number)+1"/></strong>
				</xsl:otherwise>
			</xsl:choose>						
		</a>
	</xsl:template>

</xsl:stylesheet>
