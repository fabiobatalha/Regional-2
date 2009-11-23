<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="title">
	<xsl:if test="normalize-space(../publicationStatus) = 'C'">
		<xsl:variable name="rep">
			<xsl:if test="../repository">&amp;rep=<xsl:value-of select="../repository"/>
			</xsl:if>
		</xsl:variable>

		<xsl:element name="journal">
			<xsl:attribute name="uri"><xsl:value-of select="../../../@uri"/>/scielo.php?script=sci_serial&amp;pid=<xsl:value-of select="../issn"/>&amp;nrm=iso<xsl:value-of select="$rep"/></xsl:attribute>
			<xsl:attribute name="status"><xsl:value-of select="../publicationStatus"/></xsl:attribute>
			<xsl:attribute name="date"><xsl:value-of select="../processDate"/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:if>
	</xsl:template>
</xsl:stylesheet>
