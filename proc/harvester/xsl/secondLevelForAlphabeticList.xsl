<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>
	
	<xsl:include href="journalLink.xsl"/>
	<xsl:variable name="alphabet_file" select="'../xml/alphabet.xml'"/>
	<xsl:variable name="alphabet" select="document($alphabet_file)"/>
	<xsl:template match="/">
		<secondLevelForAlphabeticList>
			<xsl:apply-templates select="/collectionList/collection"/>
		</secondLevelForAlphabeticList>
	</xsl:template>
	<xsl:template match="collection">
		<journalList collection="{@name}" total="{count(wxis-modules/record[publicationStatus='C'])}">
			<xsl:apply-templates select="$alphabet//letter">
				<xsl:with-param name="records" select="wxis-modules/record[publicationStatus='C']"/>
			</xsl:apply-templates>
		</journalList>
	</xsl:template>
	<xsl:template match="letter">
		<xsl:param name="records"/>
		<xsl:variable name="letter" select="."/>
		<xsl:variable name="selectedRecords" select="$records[starts-with(translate(title,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$letter)]"/>
		<xsl:if test="count($selectedRecords) &gt; 0">
			<order by="{$letter}" total="{count($selectedRecords)}">
				<xsl:apply-templates select="$selectedRecords/title">
					<xsl:sort select="translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU')"/>
				</xsl:apply-templates>
			</order>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
