<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>
	<xsl:include href="journalLink.xsl"/>

	<xsl:variable name="subjectListSort">
		<xsl:apply-templates select="//record" mode="getSubjectDoList">
			<xsl:sort select="subject"/>
		</xsl:apply-templates>
	</xsl:variable>
	<xsl:variable name="subjectListSorted">
		<!-- Distinct do elemento subject -->
		<xsl:apply-templates select="$subjectListSort//record" mode="getSubjectList"/>
	</xsl:variable>
	
	<xsl:template match="/">
		<secondLevelForCollectionBySubject>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForCollectionBySubject>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:variable name="collectionFromXML" select="."/>
		<xsl:variable name="total" select="count(wxis-modules/record[publicationStatus = 'C'])"/>
		<journalList collection="{@name}" total="{$total}">
			<xsl:apply-templates select="$subjectListSorted//record" mode="getRecords">
				<xsl:with-param name="collectionFromXML" select="$collectionFromXML"/>
			</xsl:apply-templates>
		</journalList>	
	</xsl:template>
	
	<xsl:template match="record" mode="getRecords">
		<xsl:param name="collectionFromXML"/>
		<xsl:variable name="subject" select="subject"/>
		<xsl:if test="count($collectionFromXML//record[subject = $subject]) &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$subject"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[subject = $subject and publicationStatus = 'C'])"/></xsl:attribute>
				<xsl:apply-templates select="$collectionFromXML//record[subject = $subject]" mode="getTitle"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="record" mode="getTitle">
					<xsl:apply-templates select="title"/>

	</xsl:template>

	<!-- TEMPLATES PARA GERAR LISTA ORDENADA E DISTINTA DE subject -->

	<xsl:template match="record" mode="getSubjectDoList">
		<record>
			<subject>
				<xsl:value-of select="subject"/>
			</subject>
		</record>
	</xsl:template>

	<xsl:template match="record" mode="getSubjectList">
		<!-- Faz distinct -->
		<xsl:variable name="previous" select="normalize-space(preceding-sibling::record[position() = 1]/subject)"/>
		<xsl:variable name="current" select="normalize-space(subject)"/>
		<xsl:variable name="collection" select="subject/@name"/>
		<xsl:if test="$current != $previous or not($previous)">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>

	<!--FIM TEMPLATES PARA GERAR LISTA ORDENADA E DISTINTA DE subject -->

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
         <xsl:sort select="subject" data-type="number" />
            <journalList name="{@name}" total="{count(.)}">
                    <xsl:copy-of select="	record"/>
           </journalList>
</xsl:for-each>

</xsl:template>
-->
