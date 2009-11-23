<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="instance" select="//vars/instance"/>
    <xsl:variable name="subject" select="//vars/subject"/>
    <xsl:variable name="presentationType" select="'secondLevelForSubjectByLetter'"/>
    <xsl:variable name="subjectList" select="document(concat('../xml/',$lang,'/subjectList.xml'))"/>
    <xsl:include href="../xsl/journalLinks.xsl"/>

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


    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="{$DIR}/index.php?lang={$lang}">
                    <xsl:value-of select="$texts/text[find='home']/replace"/>
                </a>&gt; <xsl:value-of select="$texts/text[find='journal-by-subject']/replace"/>
            </div>
            <div class="serviceColumn"><div class="webServices">
                <h3>
                    <span><xsl:value-of select="$texts/text[find='previewBy']/replace"/></span>
                </h3>
                <xsl:apply-templates select="." mode="rightBox"/>
            </div>
            </div>
            <xsl:apply-templates select="." mode="getContent"/>
        </div>
    </xsl:template>

    <xsl:template match="*" mode="getInstance">
     - <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="subject">
        <h3>
            <xsl:variable name="name" select="name"/>
            <xsl:variable name="translation" select="document(concat($PATH,'/xml/',$lang,'/subjectList.xml'))//subject[name=$name]/translate"/>
            <xsl:if test="$translation='' or not($translation)">
                <xsl:value-of select="$name"/>
            </xsl:if>
            <xsl:value-of select="$translation"/>
            <span class="lengthData">
                <strong>
                    <xsl:value-of select="count(.//journal)"/>
                </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
            </span>
        </h3>
        <ul>
            <xsl:apply-templates select=".//collection">
                <xsl:sort select="."/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="journalList">
        <h3>
            <xsl:value-of select="@collection"/> <span class="lengthData"><strong><xsl:value-of select="@total"/></strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/></span>
        </h3>
        <ul>
            <xsl:apply-templates select="order/journal"/>
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

    <xsl:template match="collection">
        <h3>
            <xsl:value-of select="@name"/>
            <span class="lengthData">
                <strong>
                    <xsl:value-of select="count(.//journal)"/>
                </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
            </span>
        </h3>
        <ul>
            <xsl:apply-templates select=".//journal">
                <xsl:sort select="."/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <!--xsl:template match="journal">
        <xsl:variable name="by" select="../@by"/>
        <li>
            <a href="{@uri}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if>
                <xsl:value-of select="."/>
            </a><span class="collectionName">[<xsl:value-of select="$subjectList//subject[name = $by]/translate"/>]</span>
        </li>
    </xsl:template-->

    <xsl:template match="letter">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml={$presentationType}&amp;xsl={$presentationType}&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*" mode="getCollectionList">
        <li>
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubjectByCollection&amp;instance={@collection}&amp;subject={$subject}" title=""><xsl:value-of select="@collection"/></a>
        </li>
    </xsl:template>

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
                            <xsl:variable name="translation" select="document(concat($PATH,'/xml/',$lang,'/subjectList.xml'))//subject[name=$subject]/translate"/>
                            <xsl:if test="$translation='' or not($translation)">
                                <xsl:value-of select="$subject"/>
                            </xsl:if>
                            <xsl:value-of select="$translation"/>
                        </xsl:if>
                    </span>
                </h3>
                <xsl:choose>
                    <xsl:when test="$subject!=''">
                        <xsl:apply-templates select=".//journalList[@collection = $instance]/order[@by=$subject]" mode="selected">
                            <xsl:with-param name="subject" select="$subject"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//journalList[@collection = $instance]">
                            <xsl:sort select="@collection"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                <div style="clear: both;float: none;width: 100%;"/>
            </div>
    </xsl:template>
</xsl:stylesheet>
