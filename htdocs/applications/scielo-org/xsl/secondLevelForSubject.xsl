<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="instance" select="//vars/instance"/>
    <xsl:variable name="subject" select="//vars/subject"/>
    <xsl:variable name="instanceParam">
        <xsl:if test="//vars/instance != ''">
            <xsl:value-of select="concat('&amp;instance=',//vars/instance)"/>
        </xsl:if>
    </xsl:variable>
    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="subjectsChoosed">
        <xsl:choose>
            <xsl:when test="$subject != ''">
                <subjectList>
                    <xsl:copy-of select="document(concat('../xml/',$lang,'/subjectList.xml'))/subjectList/subject[name = $subject]"/>
                </subjectList>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="document(concat('../xml/',$lang,'/subjectList.xml'))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="subjects" select="document(concat('../xml/',$lang,'/subjectList.xml'))"/>
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>
    <xsl:include href="../xsl/journalLinks.xsl"/>
    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="{$DIR}/index.php?lang={$lang}">
                    <xsl:value-of select="$texts/text[find='home']/replace"/>
                </a>&gt; <xsl:value-of select="$texts/text[find='journal']/replace"/>
            </div>
            <div class="serviceColumn">
                <div class="webServices">
                    <h3>
                        <span>
                            <xsl:value-of select="$texts/text[find='previewBy']/replace"/>
                        </span>
                    </h3>
                    <xsl:apply-templates select="." mode="rightBox"/>
                </div>
            </div>
            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='journal-by-subject']/replace"/>
                        <xsl:apply-templates select="$instance[. != '']" mode="getInstance"/>
                    </span>
                </h3>
                <xsl:choose>
                    <xsl:when test="$instance != ''">
                        <xsl:apply-templates select="$subjectsChoosed/subjectList/subject">
                            <xsl:with-param name="journalList" select="//journalList[@collection = $instance]"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="$subjectsChoosed/subjectList/subject">
                            <xsl:with-param name="journalList" select="//journalList"/>
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
    <xsl:template match="subject">
        <xsl:param name="journalList"/>
        <xsl:variable name="subject" select="name"/>
        <xsl:variable name="total" select="count($journalList//order[@by = $subject]/journal)"/>
        <xsl:if test="$total &gt; 0">
            <h3>
                <xsl:value-of select="translate"/>
                <span class="lengthData">
                    <strong>
                        <xsl:value-of select="$total"/>
                    </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
                </span>
            </h3>
            <ul>
            <xsl:apply-templates select="$journalList//order[@by = $subject]/journal"/>
            </ul>
        </xsl:if>
    </xsl:template>
    <!--xsl:template match="journal">
        <li>
            <a href="{@uri}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if><xsl:value-of select="."/></a>
            <xsl:if test="$scielo_portal='yes'"><span class="collectionName"> [<xsl:value-of select="../../@collection"/>]</span></xsl:if>
        </li>
    </xsl:template-->
    <xsl:template match="letter">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByAlphabeticList&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>
        </xsl:if>
    </xsl:template>
    <xsl:template match="*" mode="getSubjectList">
        <xsl:param name="journalList"/>
        <xsl:variable name="name" select="name"/>
        <!--xsl:if test="position()!=1">,</xsl:if-->
        <xsl:variable name="count">
            <xsl:value-of select="count($journalList/order[@by = $name])"/>
        </xsl:variable>
        <xsl:if test="$count &gt; 0">
            <li>
                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectNotContexted&amp;subject={name}" title="">
                    <xsl:value-of select="translate"/>
                </a>
                <br/>
            </li>
        </xsl:if>
    </xsl:template>
    <xsl:template match="*" mode="rightBox">
        <div id="sortedBy">
            <ul>
                <li>
                    <xsl:if test="string-length($subject) = 0">
                        <a href="?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter" title="" class="closed">
                            <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                        </a>
                    </xsl:if>
                    <xsl:if test="string-length($subject) > 0">
                        <a href="?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter&amp;subject={$subject}" title="" class="closed">
                            <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                        </a>
                    </xsl:if>
                </li>
                <xsl:if test="$scielo_portal='yes'">
                    <li>
                        <xsl:if test="string-length($subject) = 0">
                            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectByCollectionNotContexted&amp;collection=*" class="closed">
                                <xsl:value-of select="$texts/text[find='collection']/replace"/>
                            </a>
                        </xsl:if>
                        <xsl:if test="string-length($subject) > 0">
                            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectByCollectionNotContexted&amp;subject={$subject}&amp;collection=*" class="closed">
                                <xsl:value-of select="$texts/text[find='collection']/replace"/>
                            </a>
                        </xsl:if>
                    </li>
                </xsl:if>
                <li>
                    <a href="#" class="closed">
                        <xsl:value-of select="$texts/text[find='subject']/replace"/>
                    </a>
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
