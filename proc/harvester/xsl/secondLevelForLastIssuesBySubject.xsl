<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>

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
		<secondLevelForLastIssuesBySubject>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForLastIssuesBySubject>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:variable name="name" select="@name" />
		<xsl:variable name="collectionFromXML" select="."/>
                <xsl:variable name="recordsPublicationStatusC" select="wxis-modules/record"/>
                <xsl:variable name="maxDate" select="substring(translate(translate($recordsPublicationStatusC[1]/updateDate - 7,'.',''),'E','0'),1,8)"/>

		<xsl:variable name="total">
		<xsl:choose>
			<xsl:when test="$processDate &lt; $maxDate">
				<xsl:value-of select="count(wxis-modules/record[(normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)])"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="count(wxis-modules/record[normalize-space(updateDate) &gt;= $maxDate])"/>
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
		<xsl:choose>
			<xsl:when test="$processDate &lt; $maxDate">
				<xsl:if test="count($collectionFromXML//record[(subject = $subject) and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)]) &gt; 0">
					<xsl:element name="order">
						<xsl:attribute name="by"><xsl:value-of select="$subject"/></xsl:attribute>
						<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[subject = $subject and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)])"/></xsl:attribute>
						<xsl:apply-templates select="$collectionFromXML//record[subject = $subject and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)]" mode="getTitle"/>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="count($collectionFromXML//record[(subject = $subject) and normalize-space(updateDate) &gt;= $maxDate]) &gt; 0">
					<xsl:element name="order">
						<xsl:attribute name="by"><xsl:value-of select="$subject"/></xsl:attribute>
						<xsl:attribute name="total"><xsl:value-of select="count($collectionFromXML//record[subject = $subject and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)])"/></xsl:attribute>
						<xsl:apply-templates select="$collectionFromXML//record[subject = $subject and normalize-space(updateDate) &gt;= $maxDate]" mode="getTitle"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="record" mode="getTitle">
		<xsl:element name="journal">
			<xsl:choose>
				<xsl:when test="pid">
		                      <xsl:attribute name="uri"><xsl:value-of select="../../@uri"/>/scielo.php?script=sci_issuetoc&amp;pid=<xsl:value-of select="pid"/>&amp;nrm=iso</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
		                      <xsl:attribute name="uri"><xsl:value-of select="../../@uri"/>/scielo.php?script=sci_issuetoc&amp;pid=<xsl:value-of select="concat(issn,pubYear,format-number(numero,'0000'))"/>&amp;nrm=iso</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="date">
				<xsl:value-of select="updateDate" />
			</xsl:attribute>
                        <xsl:value-of select="title"/> <xsl:if test="normalize-space(volume) != 's/v'"> v.<xsl:value-of select="volume"/> </xsl:if> <xsl:if test="normalize-space(numero) != ''" > n.<xsl:value-of select="numero"/></xsl:if> <xsl:if test="normalize-space(suplemento) != ''" > suppl.<xsl:value-of select="suplemento"/></xsl:if>

		</xsl:element>
	</xsl:template>

	<!-- TEMPLATES PARA GERAR LISTA ORDENADA E DISTINTA DE subject -->

	<xsl:template match="record" mode="getSubjectDoList">
		<record>
			<subject>
				<xsl:value-of select="subject"/>
			</subject>
			<updateDate>
				<xsl:value-of select="updateDate" />
			</updateDate>
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
			<updateDate>
				<xsl:value-of select="updateDate"/>
			</updateDate>
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
