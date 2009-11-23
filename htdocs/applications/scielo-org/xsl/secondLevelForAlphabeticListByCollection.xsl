<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="collection" select="//vars/collection"/>
    <xsl:variable name="texts" select="document(concat($PATH,'/xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="alphabet" select="document(concat($PATH,'/webservices/xml/alphabet.xml'))//letter"/>


    <xsl:template match="/">
            <div class="middle">
                <div id="breadCrumb">
                    <a href="{DIR}/index.php?lang={$lang}"><xsl:value-of select="$texts/text[find='home']/replace"/> </a>
                    &gt; <xsl:value-of select="$texts/text[find='journalsByAlphabeticByCollection']/replace"/>
                </div>
                <div class="serviceColumn">
                    <div class="webServices">
                        <h3>
                            <span>
                                <xsl:value-of select="$texts/text[find='previewBy']/replace"/>
                            </span>
                        </h3>
                        <div id="">
                            <ul>
                                <li>
                                    <a class="closed" href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticList" title=""><xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/></a>
                                </li>
                                <li>
                                    <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticListByCollection" class="closed">
                                        <xsl:value-of select="$texts/text[find='collection']/replace"/>
                                    </a>
                                        <div id="collections" class="letters">
                                        <ul>
                                             <xsl:apply-templates select="//journalList" mode="collections"/>
                                        </ul>
                                        </div>
                                </li>
                                <li>                            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForAlphabeticListBySubject" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a></li>
                                <!--li><a href="#" class="closed">publicador</a></li-->
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <h3>
                        <span>
                            <xsl:value-of select="$texts/text[find='journalsByAlphabeticByCollection']/replace"/>
                            <xsl:if test="$collection = ''">
                                - <xsl:value-of select="concat(count(//journal),' ',$texts/text[find='journals']/replace)" />
                            </xsl:if>
                        </span>
                    </h3>
                    <xsl:apply-templates select="//journalList"/>
                    <div style="clear: both;float: none;width: 100%;"/>
                </div>
            </div>
    </xsl:template>

    <xsl:template match="journalList">

    <xsl:if test="$collection !=''">
        <xsl:if test="@collection = $collection">
            <h3>
                <xsl:value-of select="@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/></span>
            </h3>
            <ul>
                <xsl:apply-templates select="order//journal"/>
            </ul>
        </xsl:if>
    </xsl:if>

    <xsl:if test="$collection =''">
        <h3>
            <xsl:value-of select="@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/></span>
        </h3>
        <ul>
            <xsl:apply-templates select="order//journal"/>
        </ul>
    </xsl:if>

    </xsl:template>

    <xsl:template match="journal">
        <li>
            <a href="{@uri}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if><xsl:value-of select="."/> </a> <!-- <span class="collectionName"> [<xsl:value-of select="../../@collection"/>]</span> -->
        </li>
    </xsl:template>

    <xsl:template match="journalList" mode="collections">
            <li>
                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticListByCollection&amp;collection={@collection}" title="{@collection}"><xsl:value-of select="@collection"/></a>
            </li>
     </xsl:template>

</xsl:stylesheet>
