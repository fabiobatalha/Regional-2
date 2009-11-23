<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>
	<xsl:include href="journalLink.xsl"/>

	<xsl:param name="processDate"/>
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
		<secondLevelForLastJournalsBySubject>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForLastJournalsBySubject>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:variable name="name" select="@name" />
		<xsl:variable name="collectionFromXML" select="."/>

		<xsl:variable name="dateListSort">
			<xsl:apply-templates select="wxis-modules/record[publicationStatus = 'C']" mode="getDateDoList">
				<xsl:sort select="processDate" data-type="number" order="descending"/>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="maxDate">
			<xsl:value-of select="normalize-space($dateListSort//record[position() = 1]/processDate)" />
		</xsl:variable>
		<xsl:variable name="total">
		<xsl:choose>
			<xsl:when test="$processDate &lt; $maxDate">
				<xsl:value-of select="count(wxis-modules/record[(normalize-space(processDate) &lt;= normalize-space($maxDate)) and (normalize-space(processDate) &gt;= normalize-space($processDate)) and publicationStatus = 'C'])"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="count(wxis-modules/record[normalize-space(processDate) &gt;= normalize-space($maxDate) and publicationStatus = 'C'])"/>
			</xsl:otherwise>
		</xsl:choose>	
		</xsl:variable>
		<xsl:if test="$total &gt; 0">
			<journalList collection="{@name}" total="{$total}">
				<xsl:apply-templates select="$subjectListSorted//record" mode="getRecords">
					<xsl:with-param name="collectionFromXML" select="$collectionFromXML"/>
					<xsl:with-param name="maxDate" select="$maxDate"/>
				</xsl:apply-templates>
			</journalList>	
		</xsl:if>
	</xsl:template>

	<xsl:template match="record" mode="getRecords">
		<xsl:param name="collectionFromXML"/>
		<xsl:param name="maxDate"/>
		<xsl:variable name="subject" select="subject"/>
		<xsl:copy-of select="."/>
		<xsl:choose>
			<xsl:when test="$processDate &lt; $maxDate">
				<xsl:if test="count($collectionFromXML//record[subject = $subject and (normalize-space(processDate) &lt;= normalize-space($maxDate)) and (normalize-space(processDate) &gt;= normalize-space($processDate))]) &gt; 0">
					<xsl:element name="order">
						<xsl:attribute name="by"><xsl:value-of select="$subject"/></xsl:attribute>
						<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[subject = $subject and (normalize-space(processDate) &lt;= normalize-space($maxDate)) and (normalize-space(processDate) &gt;= normalize-space($processDate)) and publicationStatus = 'C'])"/></xsl:attribute>
						<xsl:apply-templates select="$collectionFromXML//record[subject = $subject and (normalize-space(processDate) &lt;= normalize-space($maxDate)) and (normalize-space(processDate) &gt;= normalize-space($processDate)) and publicationStatus = 'C']" mode="getTitle"/>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="count($collectionFromXML//record[subject = $subject and normalize-space(processDate) = normalize-space($maxDate)]) &gt; 0">
					<xsl:element name="order">
						<xsl:attribute name="by"><xsl:value-of select="$subject"/></xsl:attribute>
						<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[subject = $subject and (normalize-space(processDate) &lt;= normalize-space($maxDate)) and (normalize-space(processDate) &gt;= normalize-space($processDate)) and publicationStatus = 'C'])"/></xsl:attribute>
						<xsl:apply-templates select="$collectionFromXML//record[subject = $subject and normalize-space(processDate) &gt;= normalize-space($maxDate) and publicationStatus = 'C']" mode="getTitle"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
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
			<processDate>
				<xsl:value-of select="processDate" />
			</processDate>
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
	
	<xsl:template match="record" mode="getDateDoList">
		<record>
			<processDate>
				<xsl:value-of select="processDate"/>
			</processDate>
		</record>
	</xsl:template>	

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
