<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" media-type="text/plain" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        DELETE FROM journals;
        <xsl:apply-templates select="collectionList/collection" />
    </xsl:template>

    <xsl:template match="collection">
        <xsl:variable name="collection" select="@name" />
        <xsl:variable name="uri" select="@uri" />

        <xsl:apply-templates select=".//record[publicationStatus = 'C']">
            <xsl:with-param name="collection" select="$collection" />
            <xsl:with-param name="uri" select="$uri" />
          </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="record">
        <xsl:param name="collection" />
        <xsl:param name="uri" />
        INSERT INTO journals (issn,collection,collectionUrl,title,creationDate) VALUES ('<xsl:value-of select="issn" />','<xsl:value-of select="$collection" />','<xsl:value-of select="$uri" />','<xsl:value-of select="title" />','<xsl:value-of select="processDate" />');
    </xsl:template>
</xsl:stylesheet>
