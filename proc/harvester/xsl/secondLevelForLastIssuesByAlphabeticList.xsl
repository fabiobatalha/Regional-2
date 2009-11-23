<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>

	<xsl:param name="processDate"/>
	<xsl:variable name="alphabet_file" select="'../xml/alphabet.xml'"/>
	<xsl:variable name="alphabet" select="document($alphabet_file)"/>

	<xsl:template match="/">
		<secondLevelForLastIssuesByAlphabeticList>
			<xsl:apply-templates select="collectionList/collection"/>
		</secondLevelForLastIssuesByAlphabeticList>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:variable name="name" select="@name" />
		<xsl:variable name="collectionFromXML" select="."/>
                <xsl:variable name="recordsPublicationStatusC" select="wxis-modules/record"/>
                <xsl:variable name="maxDate" select="substring(translate(translate($recordsPublicationStatusC[1]/updateDate - 7,' ',''),'E','0'),1,8)"/>
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
			<xsl:element name="journalList">
				<xsl:attribute name="collection"><xsl:value-of select="@name"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:apply-templates select="$alphabet//letter" mode="getRecordByLetters">
					<xsl:with-param name="collectionFromXML" select="$collectionFromXML"/>
					<xsl:with-param name="maxDate" select="$maxDate"/>
				</xsl:apply-templates>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="letter" mode="getRecordByLetters">
		<xsl:param name="collectionFromXML"/>
		<xsl:param name="maxDate"/>
		<xsl:variable name="letter" select="."/>
		<xsl:variable name="total">
		<xsl:choose>
			<xsl:when test="$processDate &lt; $maxDate">
				<xsl:value-of select="count($collectionFromXML//record[substring(title,1,1) = $letter and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)])"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="count($collectionFromXML//record[substring(title,1,1) = $letter and normalize-space(updateDate) &gt;= $maxDate])"/>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
		<xsl:if test="$total &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$processDate &lt; $maxDate">
				<xsl:apply-templates select="$collectionFromXML//record[substring(title,1,1) = $letter and (normalize-space(updateDate) &lt;= $maxDate) and (normalize-space(updateDate) &gt;= $processDate)]" mode="getTitle"/>
					</xsl:when>
					<xsl:otherwise>
				<xsl:apply-templates select="$collectionFromXML//record[substring(title,1,1) = $letter and normalize-space(updateDate) &gt;= $maxDate]" mode="getTitle"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
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
	            <!--http://test.scielo.br/scielo.php?script=sci_issuetoc&    pid=0036-466520040004&lng=en&nrm=iso -->			
			<xsl:attribute name="date">
				<xsl:value-of select="updateDate" />
			</xsl:attribute>
			<xsl:value-of select="title"/> <xsl:if test="normalize-space(volume) != 's/v'"> v.<xsl:value-of select="volume"/> </xsl:if> <xsl:if test="normalize-space(numero) != ''" > n.<xsl:value-of select="numero"/></xsl:if> <xsl:if test="normalize-space(suplemento) != ''" > suppl.<xsl:value-of select="suplemento"/></xsl:if>
		</xsl:element>
	</xsl:template>

	<xsl:template match="record" mode="getDateDoList">
		<record>
			<updateDate>
				<xsl:value-of select="updateDate"/>
			</updateDate>
		</record>
	</xsl:template>
	
</xsl:stylesheet>
<!--
<secondLevelForLastIssuesByAlphabeticList>
	<journalList collection="Brazil" total="9999">
		<order by="A" total="6666">
			<journal vol="" num="" uri="">Acta Amazonica Brasil</journal> 
		</order>
	</journalList>
</secondLevelForLastIssuesByAlphabeticList>
-->
