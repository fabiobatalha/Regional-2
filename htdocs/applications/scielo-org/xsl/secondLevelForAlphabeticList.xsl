<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="letter" select="//vars/letter"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>

    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <!--Contém lista alfabetica-->
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>

    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="{$DIR}/index.php?lang={$lang}">
                    <xsl:value-of select="$texts/text[find='home']/replace"/>
                </a>&gt; <xsl:value-of select="$texts/text[find='journalsByAlphabetic']/replace"/>

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
    <!--
                                <a href="#" class="opened" onClick="expandRetract(this,'letters');return false">
    -->
                                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticList" class="opened" >
                                    <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                                </a>
                                <div id="letters" class="letters" >
                                    <xsl:apply-templates select="document('../webservices/xml/alphabet.xml')//letter">
                                        <xsl:with-param name="count" select="//order"/>
                                    </xsl:apply-templates>
                                </div>
                            </li>
                            <xsl:if test="$scielo_portal='yes'">
                            <li>
                                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticListByCollection" class="closed">
                                    <xsl:value-of select="$texts/text[find='collection']/replace"/>

                                </a>
                            </li>
                            </xsl:if>
                            <li>
                                <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForAlphabeticListBySubject" class="closed"><xsl:value-of select="$texts/text[find='subject']/replace"/></a>
                            </li>
                            <!--li><a href="#" class="closed">publicador</a></li-->
                        </ul>
                    </div>
                </div>
            </div>

            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='journalsByAlphabetic']/replace"/>
                        <xsl:if test="$letter ='' ">
                             - <xsl:value-of select="concat(count(//journal),' ',$texts/text[find='journals']/replace)" />
                        </xsl:if>
                    </span>
                </h3>

                <!--HERE-->
                <xsl:choose>
                    <xsl:when test="normalize-space($letter) != ''">

                        <!--xsl:apply-templates select="//order[@by=$letter]/journal">
                            <xsl:sort select="text()" data-type="text" order="ascending"/>
                        </xsl:apply-templates-->
                        <!--xsl:apply-templates select="//order[@by=$letter]"/-->

                        <xsl:apply-templates select="//order[@by=$letter]/journal">
                            <xsl:with-param name="totalJournal" select="count(//order[@by=$letter]/journal)"/>
                            <xsl:with-param name="letterBy" select="$letter"/>
                            <xsl:sort select="text()" data-type="text" order="ascending"/>
                        </xsl:apply-templates>

                    </xsl:when>

                    <xsl:otherwise>
                        <!--xsl:apply-templates select="$alphabet" mode="getContent">
                            <xsl:with-param name="fullXML" select="."/>
                        </xsl:apply-templates-->
                        <xsl:apply-templates select="$alphabet" mode="alljournals">
                            <xsl:with-param name="fullXML" select="."/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>

            </div>
            <div style="clear: both;float: none;width: 100%;"/>
        </div>
    </xsl:template>

    <xsl:template match="letter" mode="getContent">
        <xsl:param name="fullXML"/>
        <xsl:variable name="letter" select="."/>
        <xsl:apply-templates select="$fullXML//order[@by=$letter]"/>
    </xsl:template>

    <xsl:template match="letter" mode="alljournals">
        <xsl:param name="fullXML"/>
        <xsl:variable name="letter" select="."/>

        <xsl:if test="count($fullXML//order[@by=$letter]//journal)&gt;0">
        <h3>
                <xsl:value-of select="."/>
                <span class="lengthData">
                    <strong>
                        <xsl:value-of select="count($fullXML//order[@by=$letter]//journal)"/>
                    </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
                </span>
            </h3>
        <ul>
            <xsl:apply-templates select="$fullXML//order[@by=$letter]/journal">
                <xsl:sort select="." data-type="text" order="ascending"/>
            </xsl:apply-templates>
        </ul>
        </xsl:if>
    </xsl:template>

    <!--xsl:template match="order">
        <xsl:variable name="by" select="@by" />
        <xsl:if test="position() = 1">
            <h3>
                <xsl:value-of select="@by"/>
                <span class="lengthData">
                    <strong>
                        <xsl:value-of select="count(//order[@by=$by]//journal)"/>

                        <textarea cols="80" rows="20">
                            <xsl:copy-of select="." />
                        </textarea>

                    </strong>&#160;<xsl:value-of select="$texts/text[find='journals']/replace"/>
                </span>
            </h3>
        </xsl:if>
            <xsl:apply-templates select="journal">
                <xsl:sort select="."/>
            </xsl:apply-templates>

    </xsl:template-->

    <xsl:template match="journal">
        <xsl:param name="totalJournal"/>
        <xsl:param name="letterBy"/>
            <xsl:if test="position() = 1" >
                <xsl:if test="string-length($letterBy) != 0">
                    <h3>
                        <xsl:value-of select="$letterBy"/>
                        <span class="lengthData">
                        <strong>
                                <xsl:value-of select="$totalJournal"/>
                        </strong>
                            &#160;
                        <xsl:value-of select="$texts/text[find='journals']/replace"/>
                </span>
            </h3>
        </xsl:if>
    </xsl:if>
    <ul>
        <li>
            <a href="{@uri}&amp;lng={$lang}">
                <xsl:if test="$scielo_portal='yes'">
                    <xsl:attribute name="target">_blank</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </a>
            <xsl:if test="$scielo_portal='yes'"><span class="collectionName">[<xsl:value-of select="../../@collection"/>]</span></xsl:if>
        </li>
    </ul>
    </xsl:template>

    <xsl:template match="letter">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForAlphabeticList&amp;xsl=secondLevelForAlphabeticList&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
