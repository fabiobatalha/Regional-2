<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="../xsl/article_output.xsl" />
    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>

    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="texts" select="document('../xml/texts.xml')/texts/language[@id = $lang]"/>

    <xsl:variable name="metaSearchInstances" select="document(concat('../xml/',$lang,'/metaSearchInstances.xml'))"/>

    <xsl:variable name="links" select="//ARTICLE"/>
    <xsl:variable name="total" select="count(//similarlist/similar/article)"/>
    <xsl:variable name="expression" select="//vars/expression"/>
    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="/php/index.php">
                    home
                </a>
                &gt; <xsl:value-of select="$texts/text[find='similarity_search']/replace"/>
            </div>
            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='similarity_search']/replace"/> - <xsl:value-of select="$expression"/> - <xsl:value-of select="$texts/text[find='results_founded']/replace"/>: <xsl:value-of select="concat(' ',$total)"/>
                    </span>
                </h3>
                <div class="articleList">
                    <xsl:choose>
                        <xsl:when test="$total &gt; 0">
                            <ul>
                                <xsl:apply-templates select="//similarlist/similar"/>
                            </ul>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$texts/text[find='doesnt_related']/replace"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                <div style="clear: both;float: none;width: 100%;"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="similar">
        <xsl:apply-templates select="article">
            <xsl:with-param name="s" select="@s"/>
            <xsl:with-param name="pos" select="position()"/>
        </xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>
