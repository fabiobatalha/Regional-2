<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="isPortal" select="//vars//portal"/>
    <xsl:variable name="collectionNamePresentation"><xsl:if test="$scielo_portal='yes' or $isPortal='yes'">yes</xsl:if></xsl:variable>

    <xsl:template match="journal">
        <xsl:if test="@status = 'C'">
            <li>
                <a href="{@uri}&amp;lng={$lang}">
                    <xsl:if test="$collectionNamePresentation='yes'">
                        <xsl:attribute name="target">_blank</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </a>
                <xsl:if test="$collectionNamePresentation='yes'">
                    <span class="collectionName">[<xsl:apply-templates select="." mode="NamePresentation"/>]</span>
                </xsl:if>
            </li>
        </xsl:if>
    </xsl:template>
    <xsl:template match="journal[../@by]" mode="NamePresentation"><!-- c--><xsl:variable name="by" select="../@by"/><xsl:value-of select="$subjectList//subject[name = $by]/translate"/></xsl:template>
    <xsl:template match="journal[../../@collection]" mode="NamePresentation"><!-- a--><xsl:value-of select="../../@collection"/></xsl:template>
    <xsl:template match="journal[../../../@name]" mode="NamePresentation"><!-- b--><xsl:value-of select="../../../@name"/></xsl:template>
        <xsl:template match="journal" mode="NamePresentation"><xsl:copy-of select="../../node()"/></xsl:template>

</xsl:stylesheet>
