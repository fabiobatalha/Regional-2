<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1"/>
	<xsl:param name="lang" select="'pt'"/>
	<xsl:param name="collectionListFile"/>
        <xsl:param name="DIR"/>
	<xsl:variable name="network" select="document('../xml/network.xml')"/>
	<xsl:variable name="labels" select="document('../xml/labels.xml')/root/labels[@lang = $lang]"/>

	<xsl:template match="/">
		<DIV class="network">
			<UL>
				<xsl:apply-templates select="$network/networkPanel/language[@lang=$lang]/links/link"/>
				<xsl:apply-templates select="$labels/general/networkGroups/group" mode="all">
					<xsl:with-param name="rootXML" select="."/>
				</xsl:apply-templates>
			</UL>
		</DIV>
	</xsl:template>

	<xsl:template match="group" mode="all">
		<xsl:param name="rootXML"/>
		<xsl:variable name="groupName" select="@name"/>
		<LI><xsl:value-of select="." /></LI>
		<UL id="countries">
			<xsl:apply-templates select="$rootXML//collection[@grupo = $groupName]"/>
		</UL>
	</xsl:template>

	<xsl:template match="group[@name != 'developed']" mode="all">
		<xsl:param name="rootXML"/>
		<xsl:variable name="groupName" select="@name"/>
		<xsl:if test="(count($network/networkPanel/language[@lang=$lang]//project[name(parent::node()) = $groupName]) &gt; 0) or (count($rootXML//collection[@grupo = $groupName]) &gt; 0)">
			<LI><xsl:value-of select="$labels/general/networkGroups/group[@name=$groupName]" /></LI>
			<UL>
				<xsl:apply-templates select="$rootXML//collection[@grupo = $groupName]"/>
				<xsl:apply-templates select="$network/networkPanel/language[@lang=$lang]//project[name(parent::node()) = $groupName]"/>
			</UL>
		</xsl:if>
		
	</xsl:template>

	<xsl:template match="link">
		<LI>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</xsl:element>
		</LI>
	</xsl:template>
	
	<xsl:template match="collection">
		<xsl:variable name="name" select="name"/>
		<LI>
			<xsl:if test="@flagName != 'none'">
				<img src="{$DIR}/applications/scielo-org/image/common/flag/{@flagName}.jpg" alt=""/>
			</xsl:if>
				<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="concat(./@uri,'/?lang=',$lang)"/></xsl:attribute>
				<xsl:attribute name="title">

					<xsl:value-of select="concat(journalTotal/@current, ' ')"/>

					<xsl:choose>
						<xsl:when test="journalTotal/@current &gt; 1">
							<xsl:value-of select="$labels/general/journals" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$labels/general/journal" />
						</xsl:otherwise>
					</xsl:choose>

				</xsl:attribute>
					<xsl:value-of select="$labels/general/collections/collection[@name=$name]"/>
				</xsl:element>
		</LI>
	</xsl:template>

	<xsl:template match="project">
		<xsl:variable name="name" select="name"/>
		<LI>
			<xsl:if test="flagName != 'none'">
				<img src="{$DIR}/applications/scielo-org/image/common/flag/{flagName}.jpg" alt=""/>
			</xsl:if>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute>
				<xsl:value-of select="$labels/general/collections/collection[@name=$name]"/>
			</xsl:element>
		</LI>
	</xsl:template>
</xsl:stylesheet>
