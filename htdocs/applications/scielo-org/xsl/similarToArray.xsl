<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<!--

Agente colocou o pt pois não usamos as traduões dos textos, usamos a penas o match entre o código
da instância e o domínio dela, que é o mesmo nos três idiomas. É para ficar assim!

-->
    <xsl:variable name="domains" select="document('../xml/texts.xml')/texts/language[@id = 'pt']" />
    <xsl:template match="/">
        <xsl:apply-templates select="//similarlist/similar"/>
    </xsl:template>

    <xsl:template match="similar">
        <xsl:variable select="article/@country" name="country" />
        <xsl:value-of select="article/@pid"/>|ITEM_SPLIT|
        <xsl:value-of select="article/year"/>|ITEM_SPLIT|
        <xsl:value-of select="@s"/>|ITEM_SPLIT|
        <xsl:value-of select="$domains/text[find = $country]/url"/>|ITEM_SPLIT|
        <TITLES><xsl:apply-templates select="article/titles/title"/></TITLES>|ITEM_SPLIT|
        <xsl:value-of select="article/serial"/>|ITEM_SPLIT|
        <xsl:value-of select="article/volume"/>|ITEM_SPLIT|
        <xsl:value-of select="article/number"/>|ITEM_SPLIT|
        <xsl:value-of select="article/year"/>|ITEM_SPLIT|
        <xsl:value-of select="article/suppl"/>|ITEM_SPLIT|
        <AUTHORS><AUTH_PERS><xsl:apply-templates select="article/authors/author"/></AUTH_PERS></AUTHORS>|ITEM_SPLIT|
        <xsl:value-of select="'keyword'"/>|ITEM_SPLIT|
        |SIMILAR_SPLIT|
    </xsl:template>

    <xsl:template match="title">
        <xsl:element name="TITLE">
            <xsl:attribute name="LANG"><xsl:value-of select="@lang"/></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="author">
        <xsl:element name="AUTHOR">
            <xsl:element name="NAME">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:element name="SURNAME"/> <!-- esta em branco devido a mudança feita no xml agora nome e sobre-nome estão no elemento author -->
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
