<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>
    <xsl:variable name="instance" select="//vars/instance"/>
    <xsl:variable name="instanceParam">
        <xsl:if test="//vars/instance != ''">
            <xsl:value-of select="concat('&amp;instance=',//vars/instance)"/>
        </xsl:if>
    </xsl:variable>

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
                        <xsl:apply-templates select="." mode="rightBox"/>
                    </div>
                </div>
                <div class="content">
                    <h3>
                        <span>
                            <xsl:value-of select="$texts/text[find='lastIssuesByCollection']/replace"/>
                            <xsl:apply-templates select="$instance[. != '']" mode="getInstance"/>
                        </span>
                    </h3>
                    <xsl:choose>
                        <xsl:when test="normalize-space($instance) != ''">
                            <xsl:apply-templates select="//journalList[@collection = normalize-space($instance)]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="//journalList"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <div style="clear: both;float: none;width: 100%;"/>
                </div>
            </div>
    </xsl:template>

    <xsl:template match="*" mode="getInstance">
     - <xsl:value-of select="."/>
    </xsl:template>


    <xsl:template match="journalList">
        <h3>
            <xsl:value-of select="@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='issues']/replace"/></span>
        </h3>
        <ul>
            <xsl:apply-templates select="order/journal"/>
        </ul>
    </xsl:template>

    <xsl:template match="journal">
        <li>
            <a href="{@uri}&amp;lng={$lang}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if><xsl:value-of select="."/> </a>
        </li>
    </xsl:template>

    <xsl:template match="letter">
      <xsl:param name="count"/>
      <xsl:variable name="letter" select="."/>
         <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList&amp;letter={.}" title=""><xsl:value-of select="."/></a>
        </xsl:if>
     </xsl:template>

    <xsl:template match="*" mode="getCollectionList">
        <li>
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByCollectionNotContexted&amp;instance={@collection}" title=""><xsl:value-of select="@collection"/></a>
        </li>
    </xsl:template>

    <xsl:template match="*" mode="rightBox">
        <div id="sortedBy">
            <ul>
                <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList" class="closed"><xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/></a>
                    <!--div id="letters" class="letters">
                        <xsl:apply-templates select="$alphabet">
                             <xsl:with-param name="count" select="//order"/>
                        </xsl:apply-templates>
                    </div-->
                </li>
                    <li>
                        <xsl:if test="normalize-space($instance) = ''">
                        <a href="#" class="closed"><xsl:value-of select="$texts/text[find='collection']/replace"/></a>
                            <div id="letters" class="letters">
                                <ul>
                                     <xsl:apply-templates select="//journalList" mode="getCollectionList"/>
                                </ul>
                            </div>
                        </xsl:if>
                    </li>
                <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesBySubject&amp;xsl=secondLevelForLastIssuesBySubject" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a></li>
                <!--li><a href="#" class="closed">publicador</a></li-->
            </ul>
        </div>
    </xsl:template>
</xsl:stylesheet>
