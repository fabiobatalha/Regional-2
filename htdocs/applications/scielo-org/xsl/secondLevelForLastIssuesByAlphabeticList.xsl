<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>

    <xsl:variable name="letter" select="//vars/letter"/>
    <xsl:variable name="instance" select="//vars/instance"/>
    <xsl:variable name="instanceParam">
        <xsl:if test="//vars/instance != ''">
            <xsl:value-of select="concat('&amp;instance=',//vars/instance)"/>
        </xsl:if>
    </xsl:variable>
    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>

    <xsl:template match="/">
            <div class="middle">
                <div id="breadCrumb">
                    <a href="{$DIR}/index.php?lang={$lang}">home</a>&gt; <xsl:value-of select="$texts/text[find='issues']/replace"/>
                </div>
                <div class="serviceColumn">
                    <div class="webServices">
                        <h3>
                            <span><xsl:value-of select="$texts/text[find='previewBy']/replace"/></span>
                        </h3>

                        <div id="sortedBy">
                            <ul>
                                <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList{$instanceParam}" class="closed"><xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/></a>
                                <div id="letters" class="letters">
                                    <xsl:choose>
                                        <xsl:when test="normalize-space($instance) != ''">
                                            <xsl:apply-templates select="$alphabet">
                                                <xsl:with-param name="count" select="//journalList[@collection = $instance]/order"/>
                                            </xsl:apply-templates>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates select="$alphabet">
                                                <xsl:with-param name="count" select="//order"/>
                                            </xsl:apply-templates>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                                </li>
                                <xsl:if test="$scielo_portal='yes'">
                                <xsl:if test="normalize-space($instance) = ''">
                                    <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByCollection{$instanceParam}" class="closed"><xsl:value-of select="$texts/text[find='collection']/replace"/></a></li>
                                </xsl:if>
                                </xsl:if>
                                <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesBySubject&amp;xsl=secondLevelForLastIssuesBySubject{$instanceParam}" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a></li>
                                <!--li><a href="#" class="closed">publicador</a></li-->
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="content">
                    <h3>
                        <span>
                            <xsl:value-of select="$texts/text[find='lastIssuesByAlphabetic']/replace"/>
                            <xsl:apply-templates select="$instance[. != '']" mode="getInstance"/>
                        </span>
                    </h3>
                        <xsl:choose>
                            <xsl:when test="normalize-space($letter) != ''">
                                <xsl:apply-templates select="." mode="getInstanceValue">
                                    <xsl:with-param name="fullXML" select="."/>
                                    <xsl:with-param name="letter" select="$letter"/>
                                </xsl:apply-templates>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="$alphabet" mode="getContent">
                                    <xsl:with-param name="fullXML" select="."/>
                                </xsl:apply-templates>
                            </xsl:otherwise>
                        </xsl:choose>
                    <div style="clear: both;float: none;width: 100%;"/>
                </div>
            </div>
    </xsl:template>

    <xsl:template match="*" mode="getInstance">
     - <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="*" mode="getInstanceValue">
        <xsl:param name="fullXML"/>
        <xsl:param name="letter"/>
        <xsl:choose>
            <xsl:when test="normalize-space($instance) != ''">
                <xsl:apply-templates select="$fullXML//journalList[@collection = normalize-space($instance)]/order[@by=$letter]">
                    <xsl:with-param name="total" select="sum($fullXML//journalList[@collection=normalize-space($instance)]/order[@by=$letter]/@total)"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$fullXML//order[@by=$letter]">
                    <xsl:with-param name="total" select="sum($fullXML//journalList/order[@by=$letter]/@total)"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="letter" mode="getContent">
        <xsl:param name="fullXML"/>
        <xsl:variable name="letter" select="."/>
        <xsl:choose>
            <xsl:when test="normalize-space($instance) != ''">
                <xsl:apply-templates select="$fullXML//journalList[@collection = normalize-space($instance)]/order[@by=$letter]">
                    <xsl:with-param name="total" select="sum($fullXML//journalList[@collection=normalize-space($instance)]/order[@by=$letter]/@total)"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$fullXML//order[@by=$letter]">
                    <xsl:with-param name="total" select="sum($fullXML//journalList/order[@by=$letter]/@total)"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
     </xsl:template>

    <xsl:template match="order">
        <xsl:param name="total"/>
        <xsl:if test="position() = 1">
        <h3>
            <xsl:value-of select="@by"/> <span class="lengthData"><strong> <xsl:value-of select="$total"/> </strong>&#160;<xsl:value-of select="$texts/text[find='issues']/replace"/></span>
        </h3>
        </xsl:if>
        <ul>
            <xsl:apply-templates select="journal"/>
        </ul>
    </xsl:template>

    <xsl:template match="journal">
        <li>
            <a href="{@uri}&amp;lng={$lang}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if><xsl:value-of select="."/> </a>
            <xsl:if test="$scielo_portal='yes'"><span class="collectionName"> [<xsl:value-of select="../../@collection"/>]</span></xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="letter">
      <xsl:param name="count"/>
      <xsl:variable name="letter" select="."/>
         <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList&amp;letter={.}{$instanceParam}" title=""><xsl:value-of select="."/></a>&#160;
        </xsl:if>
     </xsl:template>
</xsl:stylesheet>
