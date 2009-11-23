<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../xsl/secondLevelForLastJournalsByCollection.xsl"/>

<xsl:template match="*" mode="rightBox">
    <div id="sortedBy">
        <ul>
            <li>
                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByAlphabeticList" class="closed"><xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/></a>
                <!--div id="letters" class="letters" style="display: none;">
                <xsl:apply-templates select="$alphabet">
                <xsl:with-param name="count" select="//order"/>
                </xsl:apply-templates>
                </div-->
            </li>
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByCollection" class="closed"><xsl:value-of select="$texts/text[find='collection']/replace"/></a>
            <li>
                <div id="letters" class="letters">
                    <ul>
                        <xsl:apply-templates select="//journalList" mode="getCollectionList"/>
                    </ul>
                </div>
            </li>
            <li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsBySubject&amp;xsl=secondLevelForLastJournalsBySubject" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a></li>
            <!--li><a href="#" class="closed">publicador</a></li-->
        </ul>
    </div>
</xsl:template>
</xsl:stylesheet>