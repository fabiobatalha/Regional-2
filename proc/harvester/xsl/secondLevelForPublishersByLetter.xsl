<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>
	<xsl:include href="journalLink.xsl"/>

	<xsl:param name="lang"/>
	<xsl:param name="PATH"/>
	<xsl:variable name="alphabet_file" select="'../xml/alphabet.xml'"/>
	<xsl:variable name="alphabet" select="document($alphabet_file)"/>

<xsl:template match="/">
  <secondLevelForPublishersByLetter>
	<xsl:apply-templates select="$alphabet//letter" mode="alphabet">
		<xsl:with-param name="collection" select="/collectionList/collection"/>
	</xsl:apply-templates>

   </secondLevelForPublishersByLetter>
</xsl:template>
<xsl:template match="letter" mode="alphabet">
	<xsl:param name="collection"/>
	<xsl:variable name="letter" select="."/>
	<xsl:variable name="total" select="count($collection//record[publicationStatus='C']/publisher[(substring(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter)])"/>

	<xsl:if test="$total &gt; 0">
		<xsl:element name="order">
			<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
			<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
			<xsl:apply-templates select="$collection">
	           <xsl:with-param name="LETTER" select="$letter"/>
		    </xsl:apply-templates>
		</xsl:element>
	</xsl:if>		
</xsl:template>
<xsl:template match="collection">
  <xsl:param name="LETTER"/>
  <xsl:variable name="total" select="count(wxis-modules/record[publicationStatus='C']/publisher[starts-with(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$LETTER)])"/>
  <publisherList collection="{@name}" total="{$total}">
	<xsl:apply-templates select="wxis-modules/record[publicationStatus='C']/publisher[not(.=preceding::publisher) and starts-with(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$LETTER)]">
		<xsl:sort select="publisher"/>
	</xsl:apply-templates>
  </publisherList>
</xsl:template>

<xsl:template match="publisher">
    <xsl:variable name="pub" select="." />
    <publisher uri="">
	<name><xsl:value-of select="." /></name>
	<journalList>
	    <xsl:apply-templates select="//title[../publisher=$pub  and ../publicationStatus='C']"/>
	</journalList>
    </publisher>
</xsl:template>

</xsl:stylesheet>
