<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="collection" select="//vars/collection"/>
    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="commonSubjectList" select="document('../xml/commonSubjectList.xml')"/>
    <xsl:variable name="presentationType" select="'secondLevelForSubjectByLetter'"/>
    <xsl:variable name="subject" select="//vars/subject"/>
    <xsl:variable name="letter" select="//vars/letter"/>

    <xsl:include href="../xsl/journalLinks.xsl"/>
    <xsl:variable name="collection-list">
        <xsl:apply-templates select="/root/secondLevelForSubjectByLetter/subject-order/subject/collection">
           <xsl:sort select="@name"/>
        </xsl:apply-templates>
    </xsl:variable>


<!--
<xsl:apply-templates select="collection/@name[not(collection/@name=preceding-sibling::collection)]"/>
<xsl:value-of select="collection/@name[not(collection/@name=preceding-sibling::collection)]"/> 
-->


        <xsl:template match="collection">
       <!--xsl:if test="position() = 1">
        <xsl:value-of select="@name"/>
       </xsl:if-->

        <!--xsl:value-of select="self::*[not(@name=preceding-sibling::*/@name)]"/-->

       <!--xsl:if test="preceding-sibling::node()/@name != @name">
        *<xsl:value-of select="preceding-sibling::node()/@name"/>
       </xsl:if-->

       <!--
           * <xsl:value-of select="@name"/>
       -->
    </xsl:template>

    <xsl:template match="letter">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml={$presentationType}&amp;xsl={$presentationType}&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="letter" mode="subject">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml={$presentationType}&amp;xsl={$presentationType}&amp;subject={$subject}&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="{$DIR}/index.php?lang={$lang}">
                    <xsl:value-of select="$texts/text[find='home']/replace"/>
                </a>&gt; <xsl:value-of select="$texts/text[find='journal-by-subject']/replace"/>
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
                            <xsl:if test="$collection = ''">
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
                                <div id="letters" class="letters">
                                    <xsl:if test="string-length($subject) = 0">
                                    <xsl:apply-templates select="document('../webservices/xml/alphabet.xml')//letter">
                                        <xsl:with-param name="count" select="//order"/>
                                    </xsl:apply-templates>
                                    </xsl:if>
                                    <xsl:if test="string-length($subject) > 0">
                                        <xsl:apply-templates select="document('../webservices/xml/alphabet.xml')//letter" mode="subject">
                                        <xsl:with-param name="count" select="//name[.=$subject]/../collection/JournalList/order"/>
                                    </xsl:apply-templates>
                                    </xsl:if>
                                </div>
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
                            </xsl:if>
                            <xsl:if test="$collection != ''">
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


                            <div id="collections" class="letters">
                            <ul>
                            <textarea rows="10" cols="40"><xsl:copy-of select="$collection-list"/></textarea>
                                <!-- <xsl:apply-templates select="$collection-list"/> -->
                            </ul>
                            </div>

                            </xsl:if>
                            <xsl:if test="string-length($subject) = 0">
                            <li>
                                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForCollectionBySubject&amp;xsl=secondLevelForSubject&amp;subject={$subject}" class="closed">
                                    <xsl:value-of select="$texts/text[find='subject']/replace"/>
                                </a>
                            </li>
                            </xsl:if>
                            <!--li><a href="#" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a></li-->
                            <!--li><a href="#" class="closed">publicador</a></li-->
                        </ul>
                    </div>
                </div>
            </div>
            <div class="content">
                <h3>
                    <span>
                    <!--
                        <xsl:value-of select="substring-before($texts/text[find='journalsBySubjectSortedByLetter']/replace,'REPLACE_SUBJECT')"/>
                        <xsl:value-of select="substring-after($texts/text[find='journalsBySubjectSortedByLetter']/replace,'REPLACE_SUBJECT')"/>
                    -->
                        <xsl:value-of select="$texts/text[find='journal-by-subject']/replace"/>
                        <xsl:if test="$letter!=''">
                                - <xsl:value-of select="$letter"/>
                        </xsl:if>
                        <xsl:if test="$subject !=''">
                                - <xsl:variable name="translation" select="document(concat('../xml/',$lang,'/subjectList.xml'))//subject[name=$subject]/translate"/>
                            <xsl:if test="$translation='' or not($translation)">
                                <xsl:value-of select="$subject"/>
                            </xsl:if>
                            <xsl:value-of select="$translation"/>
                        </xsl:if>
                    </span>
                </h3>
                <div class="content">
                    <!--span class="lengthData">
                        <strong>
                            <xsl:value-of select="count(//subject[name=$subject or $subject='']//order[@by=$letter or $letter='']//journal)"/>
                        </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
                    </span-->
                    <xsl:choose>
                        <xsl:when test="$subject = 'Others'">
                            <xsl:variable name="subjectsString">
                                <xsl:copy-of select="$commonSubjectList"/>
                            </xsl:variable>
                            <xsl:apply-templates select="//subject-order//subject[(contains($subjectsString,name) != 'true' ) and (.//order[$letter=@by or $letter=''])]">
                                <xsl:sort select="."/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="//subject-order//subject[(name=$subject or $subject='') and (.//order[$letter=@by or $letter=''])]">                                <xsl:sort select="."/>
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                <div style="clear: both;float: none;width: 100%;"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="subject">
        <h3>
            <xsl:variable name="name" select="name"/>
            <xsl:variable name="translation" select="document(concat('../xml/',$lang,'/subjectList.xml'))//subject[name=$name]/translate"/>
            <xsl:if test="$translation='' or not($translation)">
                <xsl:value-of select="$name"/>
            </xsl:if>
            <xsl:value-of select="$translation"/>
            <span class="lengthData">
                <strong>
                    <xsl:choose>
                        <xsl:when test="$letter!=''">
                            <xsl:value-of select="count(.//order[@by=$letter]//journal)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="count(.//collection//order//journal)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
            </span>
        </h3>
        <xsl:choose>
            <xsl:when test="$letter=''">
                <!--xsl:apply-templates select=".//order">
                    <xsl:sort select="."/>
                    <xsl:with-param name="journals" select=".//order//journal"/>
                </xsl:apply-templates-->
                <xsl:apply-templates select="document('../webservices/xml/alphabet.xml')//letter" mode="order">
                    <xsl:with-param name="order" select=".//order"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="ord" select=".//order[@by=$letter]"/>
                <xsl:apply-templates select="$ord[1]">
                    <xsl:sort select="."/>
                    <xsl:with-param name="journals" select=".//order[@by=$letter]//journal"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="letter" mode="order">
        <xsl:param name="order"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($order[@by=$letter]//journal) &gt; 0">
            <xsl:variable name="ord" select="$order[@by=$letter]"/>
            <xsl:apply-templates select="$ord[1]">
                <xsl:with-param name="journals" select="$order[@by=$letter]//journal"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    <xsl:template match="order">
        <xsl:param name="journals"/>
        <xsl:variable name="by" select="@by"/>

        <ul>
            <xsl:apply-templates select="$journals">
                <xsl:sort select="."/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>
    <!--xsl:template match="journal">
        <li>
            <a href="{@uri}"><xsl:if test="$scielo_portal='yes'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if>
                <xsl:value-of select="."/>
            </a>
            <xsl:if test="$scielo_portal='yes'"><span class="collectionName">[<xsl:value-of select="../../../@name"/>]</span></xsl:if>
        </li>
    </xsl:template-->
</xsl:stylesheet>
