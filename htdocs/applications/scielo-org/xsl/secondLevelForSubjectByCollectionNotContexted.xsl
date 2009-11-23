<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../xsl/secondLevelForSubjectByCollection.xsl"/>

    <xsl:variable name="PATH" select="//vars/PATH"/>

    <xsl:template match="*" mode="rightBox">
            <div id="sortedBy">
                <ul>
                    <li>
                        <xsl:if test="string-length($subject) = 0">
                            <a href="?xml={$presentationType}&amp;xsl={$presentationType}" title="" class="closed">
                            <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                            </a>
                        </xsl:if>
                        <xsl:if test="string-length($subject) > 0">
                            <a href="?xml={$presentationType}&amp;xsl={$presentationType}&amp;subject={$subject}" title="" class="closed">
                            <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                            </a>
                        </xsl:if>
                    </li>
                    <li>
                        <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectByCollectionNotContexted&amp;subject={$subject}" class="closed">
                            <xsl:value-of select="$texts/text[find='collection']/replace"/>
                        </a>
                        <div id="letters" class="letters">
                            <ul>
                                 <xsl:apply-templates select="//journalList" mode="getCollectionList"/>
                            </ul>
                        </div>
                    </li>
                    <xsl:if test="string-length($subject) = 0">
                    <li>
                        <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubject&amp;subject={$subject}" class="closed">
                            <xsl:value-of select="$texts/text[find='subject']/replace"/>
                        </a>
                    </li>
                    </xsl:if>
                    <!--li><a href="#" class="closed">publicador</a></li-->
                </ul>
            </div>
    </xsl:template>

    <xsl:template match="*" mode="getContent">
            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='journal-by-subject']/replace"/>
                        <!--xsl:apply-templates select="$instance[. != '']" mode="getInstance"/-->
                        <xsl:if test="$subject!=''">
                            -
                            <xsl:variable name="translation" select="document(concat('../xml/',$lang,'/subjectList.xml'))//subject[name=$subject]/translate"/>
                            <xsl:if test="$translation='' or not($translation)">
                                <xsl:value-of select="$subject"/>
                            </xsl:if>
                            <xsl:value-of select="$translation"/>
                        </xsl:if>
                    </span>
                </h3>
                <xsl:choose>
                    <xsl:when test="$subject!=''">
                        <xsl:apply-templates select="//journalList/order[@by=$subject]" mode="selected">
                            <xsl:with-param name="subject" select="$subject"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//journalList" mode="ddd">
                            <xsl:sort select="@collection"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                <div style="clear: both;float: none;width: 100%;"/>
            </div>
    </xsl:template>

    <xsl:template match="journalList" mode="ddd">
        <h3>
            <xsl:value-of select="@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/></span>
        </h3>
        <ul>
            <xsl:apply-templates select="order/journal">
                <xsl:sort select="." />
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="order" mode="selected">
        <xsl:param name="subject"/>
        <h3>
            <xsl:value-of select="../@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/></span>
        </h3>
        <ul>
            <xsl:apply-templates select="journal">
                <xsl:sort select="." />
            </xsl:apply-templates>
        </ul>
    </xsl:template>

</xsl:stylesheet>
