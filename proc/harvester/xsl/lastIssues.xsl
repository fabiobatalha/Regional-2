<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:param name="processDate"/>
<xsl:param name="DIR"/>

<xsl:template match="/">
	<lastIssues>
		<xsl:apply-templates select="collectionList/collection" />
	</lastIssues>
</xsl:template>

<xsl:template match="collection">
		<xsl:variable name="recordsPublicationStatusC" select="wxis-modules/record"/>
		<xsl:variable name="lastDate" select="substring(translate(translate($recordsPublicationStatusC[1]/updateDate - 7,'.',''),'E','0'),1,8)"/>
		<xsl:choose>
			<xsl:when test="$processDate &lt; $lastDate">
				<collection>
					<xsl:attribute name="uri">
						<xsl:value-of select="@uri"/>
					</xsl:attribute>
					<xsl:variable name="total">
						<xsl:value-of select="count($recordsPublicationStatusC[(updateDate &lt;= $lastDate) and (updateDate &gt;= $processDate)])"/>
					</xsl:variable>
					<name><xsl:value-of select="@name"/></name>
					<xsl:copy-of select="wxis-modules/record[(updateDate &lt;= $lastDate) and (updateDate &gt;= $processDate)]/subject"/>
					<lastDate><xsl:value-of select="$lastDate"/></lastDate>
					<processingDate><xsl:value-of select="$processDate"/></processingDate>
					<total><xsl:value-of select="$total"/></total>
				</collection>
			</xsl:when>
			<xsl:otherwise>
				<collection>
					<xsl:attribute name="uri">
						<xsl:value-of select="@uri"/>
					</xsl:attribute>
					<xsl:variable name="total">
						<xsl:value-of select="count($recordsPublicationStatusC[updateDate &gt;= $lastDate])"/>
					</xsl:variable>
					<name><xsl:value-of select="@name"/></name>
					<xsl:copy-of select="wxis-modules/record[updateDate &gt;= $lastDate]/subject"/>
					<lastDate><xsl:value-of select="$lastDate"/></lastDate>
					<processingDate><xsl:value-of select="$processDate"/></processingDate>
					<total><xsl:value-of select="$total"/></total>
				</collection>
			</xsl:otherwise>
		</xsl:choose>

</xsl:template>

<xsl:template match="subject">
	<subject><xsl:value-of select="."/></subject>
</xsl:template>

</xsl:stylesheet>
