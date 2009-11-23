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
    <xsl:variable name="subjects" select="document(concat('./xml/',$lang,'/subjectList.xml'))"/>
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>
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
                    <div id="sortedBy">
                        <ul>
                            <li>
                                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByAlphabeticList{$instanceParam}" class="closed">
                                    <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                                </a>
                                <!--div id="letters" class="letters" style="display: none;">
                                <xsl:apply-templates select="$alphabet">
                                     <xsl:with-param name="count" select="//order"/>
                                   </xsl:apply-templates>
                            </div-->
                            </li>
                            <xsl:if test="$scielo_portal='yes'">
                                <xsl:if test="normalize-space($instance) = ''">
                                    <li>
                                        <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByCollection{$instanceParam}" class="closed">
                                            <xsl:value-of select="$texts/text[find='collection']/replace"/>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:if>
                            <li>
                                <a href="#" class="closed">
                                    <xsl:value-of select="$texts/text[find='subject']/replace"/>
                                </a>
                                <div id="letters" class="letters">
                                    <ul>
                                        <xsl:choose>
                                            <xsl:when test="$instance != ''">
                                                <xsl:apply-templates select="$subjects/subjectList/subject" mode="getSubjectList">
                                                    <xsl:with-param name="journalList" select="//journalList[@collection = $instance]"/>
                                                </xsl:apply-templates>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:apply-templates select="$subjects/subjectList/subject" mode="getSubjectList">
                                                    <xsl:with-param name="journalList" select="//journalList"/>
                                                </xsl:apply-templates>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </ul>
                                </div>
                            </li>
                            <!--li><a href="#" class="closed">publicador</a></li-->
                        </ul>
                    </div>
                </div>
            </div>
            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='lastJournalsBySubject']/replace"/>
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
        </xsl:if>
        <xsl:if test="count($journalList//order[@by = $subject]/journal)&gt;0">
        <ul>
            <xsl:apply-templates select="$journalList//order[@by = $subject]/journal">
                <xsl:sort select="." />
            </xsl:apply-templates>
        </ul>
        </xsl:if>
    </xsl:template>
    <xsl:template match="journal">
        <li>
            <a href="{@uri}&amp;lng={$lang}">
                <xsl:if test="$scielo_portal='yes'">
                    <xsl:attribute name="target">_blank</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </a>
            <xsl:if test="$scielo_portal='yes'">
                <span class="collectionName"> [<xsl:value-of select="../../@collection"/>]</span>
            </xsl:if>
        </li>
    </xsl:template>
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
            <xsl:choose>
                <xsl:when test="$instance != ''">
                    <xsl:value-of select="count($journalList[@collection = $instance]/order[@by = $name])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="count($journalList/order[@by = $name])"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="$count &gt; 0">
            <li>
                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsBySubject&amp;xsl=secondLevelForLastJournalsBySubject&amp;instance={$instanceParam}&amp;subject={name}" title="">
                    <xsl:value-of select="translate"/>
                </a>
                <br/>
            </li>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
