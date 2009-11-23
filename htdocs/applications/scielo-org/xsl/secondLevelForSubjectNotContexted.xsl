<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../xsl/secondLevelForSubject.xsl"/>

    <xsl:template match="*" mode="rightBox">
                <div id="sortedBy">
                    <ul>
                        <li>
                            <a href="?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter" title="" class="closed">
                                <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                            </a>
                        </li>
                        <xsl:if test="$scielo_portal='yes'">
                        <li>
                            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectByCollection&amp;collection=*" class="closed">
                                <xsl:value-of select="$texts/text[find='collection']/replace"/>
                            </a>
                        </li>
                        </xsl:if>
                        <li>
                            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubject" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a>
                            <div id="letters" class="letters">
                            <ul>
                                <xsl:apply-templates select="$subjects/subjectList/subject" mode="getSubjectList">
                                    <xsl:with-param name="journalList" select="//journalList"/>
                                </xsl:apply-templates>
                            </ul>
                            </div>
                        </li>
                        <!--li><a href="#" class="closed">publicador</a></li-->
                    </ul>
                </div>
    </xsl:template>
</xsl:stylesheet>