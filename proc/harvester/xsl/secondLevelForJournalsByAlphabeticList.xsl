<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>

	<xsl:include href="journalLink.xsl"/>
	<xsl:variable name="alphabet_file" select="'../xml/alphabet.xml'"/>
	<xsl:variable name="alphabet" select="document($alphabet_file)"/>

	<xsl:template match="/">
		<secondLevelForLastJournalsByAlphabeticList>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForLastJournalsByAlphabeticList>
	</xsl:template>

	<xsl:template match="collection">
	<xsl:variable name="dateListSort">
		<xsl:apply-templates select="wxis-modules/record" mode="getDateDoList">
			<xsl:sort select="processDate" data-type="number" order="descending"/>
		</xsl:apply-templates>
	</xsl:variable>

	<xsl:variable name="maxDate">
		<xsl:value-of select="normalize-space($dateListSort//record[position() = 1]/processDate)" />
	</xsl:variable>

		<xsl:variable name="name" select="@name" />
		<xsl:variable name="collectionFromXML" select="."/>
		<xsl:variable name="total" select="count(wxis-modules/record[normalize-space(processDate) = normalize-space($maxDate)])"/>

		<xsl:if test="$total &gt; 0">
			<xsl:element name="journalList">
				<xsl:attribute name="collection"><xsl:value-of select="@name"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:apply-templates select="$alphabet//letter" mode="getRecordByLetters">
					<xsl:with-param name="maxDate" select="$maxDate"/>
					<xsl:with-param name="collectionFromXML" select="$collectionFromXML"/>
				</xsl:apply-templates>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="letter" mode="getRecordByLetters">
		<xsl:param name="maxDate" />
		<xsl:param name="collectionFromXML"/>
		<xsl:variable name="letter" select="."/>
		<xsl:variable name="total" select="count($collectionFromXML//record[substring(title,1,1) = $letter and publicationStatus = 'C' and normalize-space(processDate) = $maxDate])"/>
		<xsl:if test="$total &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:apply-templates select="$collectionFromXML//record[substring(title,1,1) = $letter and publicationStatus = 'C' and normalize-space(processDate) = $maxDate]" mode="getTitle"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="record" mode="getTitle">
		<xsl:apply-templates select="title"/>

	</xsl:template>

	<xsl:template match="record" mode="getDateDoList">
		<record>
			<processDate>
				<xsl:value-of select="processDate"/>
			</processDate>
		</record>
	</xsl:template>


</xsl:stylesheet>


<!--
<secondLevelForLastJournalsByAlphabeticList>
	<journalList collection="Brazil" total="9999">
		<order by="A" total="6666">
			<journal uri="">Acta Amazonica Brasil</journal> 
		</order>
	</journalList>
</secondLevelForLastJournalsByAlphabeticList>
-->
