<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="iso-8859-1" omit-xml-declaration="yes"/>
	<xsl:include href="journalLink.xsl"/>
	
	<xsl:variable name="alphabet" select="document('../xml/alphabet.xml')"/>

	<xsl:variable name="publisherListSort">
		<xsl:apply-templates select="//record[publicationStatus = 'C']" mode="getPublisherDoList">
			<xsl:sort select="publisher"/>
		</xsl:apply-templates>
	</xsl:variable>

	<xsl:variable name="publisherListSorted">
		<xsl:apply-templates select="$publisherListSort//record" mode="getPublisherList"/>
	</xsl:variable>
	
	<xsl:template match="/">
		<secondLevelForPublishersByCollection>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForPublishersByCollection>		
	</xsl:template>
	
	<xsl:template match="collection">
		<xsl:variable name="collectionName" select="@name"/>
		<xsl:element name="publisherList">
			<xsl:attribute name="collection"><xsl:value-of select="$collectionName"/></xsl:attribute>
			<xsl:attribute name="total"><xsl:value-of select="count(wxis-modules//record[publicationStatus = 'C'])"/></xsl:attribute>

			<xsl:apply-templates select="$alphabet//letter" mode="alphabet">
				<xsl:with-param name="collection" select="."/>
				<xsl:with-param name="collectionName" select="$collectionName"/>				
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="*" mode="alphabet">
		<xsl:param name="collection"/>
		<xsl:param name="collectionName"/>		
		<xsl:variable name="letter" select="."/>
		<xsl:variable name="total" select="count($publisherListSorted//publisher[(substring(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter) and (@collection = $collectionName)])"/>

		<xsl:if test="$total &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>


				<xsl:apply-templates select="$publisherListSorted//publisher[substring(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter and (@collection = $collectionName)]" mode="getTitle">
					<xsl:with-param name="collection" select="$collection"/>				
					<xsl:sort select="title"/>
				</xsl:apply-templates>	
			</xsl:element>
		</xsl:if>			
	</xsl:template>
	
	<xsl:template match="publisher" mode="getTitle">
		<xsl:param name="collection"/>
		<xsl:variable name="publisher" select="."/>
		<xsl:element name="publisher">
			<xsl:attribute name="uri"></xsl:attribute>
			<xsl:element name="name">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:element name="JournalList">
				<xsl:apply-templates select="$collection//record[normalize-space(publisher) = $publisher]" mode="getTitles"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="record" mode="getTitles">
		<xsl:apply-templates select="title"/>

	</xsl:template>

	<xsl:template match="record" mode="getPublisherDoList">
		<record>
			<publisher collection="{../../@name}"><xsl:value-of select="normalize-space(publisher)"/></publisher>
		</record>
	</xsl:template>	
	
	<xsl:template match="record" mode="getPublisherList"> <!-- Faz distinct -->
		<xsl:variable name="previous" select="preceding-sibling::record[position() = 1]/publisher"/>
		<xsl:variable name="current" select="publisher"/>
		<xsl:if test="concat($current/@collection,$current) != concat($previous/@collection,$previous) or not($previous)">
			<xsl:copy-of select="publisher"/>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>

<!--
	<secondLevelForPublishersByCollection>
		<publisherList collection="Brazil" total="9999">
			<order by="A" total="9999">
				<publisher uri="">Acta Amazonica Brasil</publisher>
			</order>
		</publisherList>
	</secondLevelForPublishersByCollection>
-->
