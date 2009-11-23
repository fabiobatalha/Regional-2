<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>
	<xsl:include href="journalLink.xsl"/>

	<xsl:variable name="dateListSort">
		<xsl:apply-templates select="//record" mode="getDateDoList">
			<xsl:sort select="processDate" data-type="number" order="descending"/>
		</xsl:apply-templates>
	</xsl:variable>
	<xsl:variable name="dateListSorted">
		<!-- Distinct do elemento processDate -->
		<xsl:apply-templates select="$dateListSort//record" mode="getDateList"/>
	</xsl:variable>
	
	<xsl:variable name="maxDate">
		<xsl:value-of select="normalize-space($dateListSort//record[position() = 1]/processDate)" />
	</xsl:variable>
	
	<xsl:template match="/">
		<secondLevelForCollectionByDate>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForCollectionByDate>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:variable name="collectionFromXML" select="."/>
		<xsl:variable name="total" select="count(wxis-modules/record[publicationStatus = 'C'])"/>
		<journalList collection="{@name}" total="{$total}">
			<xsl:apply-templates select="$dateListSorted//record[processDate = $maxDate]" mode="getRecords">
				<xsl:with-param name="collectionFromXML" select="$collectionFromXML"/>
			</xsl:apply-templates>
		</journalList>	
	</xsl:template>
	
	<xsl:template match="record" mode="getRecords">
		<xsl:param name="collectionFromXML"/>
		<xsl:variable name="processDate" select="processDate"/>
		<xsl:if test="count($collectionFromXML//record[processDate = $processDate]) &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$processDate"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[processDate = $processDate])"/></xsl:attribute>
				<xsl:apply-templates select="$collectionFromXML//record[processDate = $processDate]" mode="getTitle"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="record" mode="getTitle">
		<xsl:apply-templates select="title"/>

	</xsl:template>

	<!-- TEMPLATES PARA GERAR LISTA ORDENADA E DISTINTA DE PROCESSDATE -->

	<xsl:template match="record" mode="getDateDoList">
		<record>
			<processDate>
				<xsl:value-of select="processDate"/>
			</processDate>
		</record>
	</xsl:template>

	<xsl:template match="record" mode="getDateList">
		<!-- Faz distinct -->
		<xsl:variable name="previous" select="normalize-space(preceding-sibling::record[position() = 1]/processDate)"/>
		<xsl:variable name="current" select="normalize-space(processDate)"/>
		<xsl:variable name="collection" select="processDate/@name"/>
		<xsl:if test="$current != $previous or not($previous)">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>

	<!--FIM TEMPLATES PARA GERAR LISTA ORDENADA E DISTINTA DE PROCESSDATE -->

</xsl:stylesheet>
<!--
<secondLevelForCollectionByDate>
	<journalList collection="Brazil" total="9999">
		<order by="XXXX" total="6666">
			<journal uri="">Acta Amazonica Brasil</journal> 
		</order>
	</journalList>
</secondLevelForCollectionByDate>
-->
<!--
<secondLevelForCollectionByDate>

<xsl:for-each select="collectionList">
	<xsl:apply-templates select="collection" />
</xsl:for-each>

</secondLevelForCollectionByDate>
</xsl:template>

<xsl:template match="collection">

<xsl:for-each select="record">
         <xsl:sort select="processDate" data-type="number" />
            <journalList name="{@name}" total="{count(.)}">
                    <xsl:copy-of select="	record"/>
           </journalList>
</xsl:for-each>

</xsl:template>
-->
