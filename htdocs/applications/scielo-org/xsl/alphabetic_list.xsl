<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output version="1.0" media-type="text/html"/>
    <xsl:variable name="DIR" select="//vars/DIR"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="letter" select="//vars/letter"/>
    <xsl:variable name="collection" select="//vars/collection"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="scielo_portal" select="//vars/scielo-portal"/>
    <xsl:variable name="texts" select="document(concat('../xml/',$lang,'/second_level.xml'))/texts"/>
    <xsl:variable name="presentationType" select="'secondLevelForAlphabeticList'"/>
    <xsl:variable name="alphabet" select="document('../webservices/xml/alphabet.xml')//letter"/>
    <xsl:variable name="sites" select="//publisherList"/>
    <!--xsl:variable name="sorted">
        <xsl:apply-templates select="//secondLevelForPublishersByLetter/order" mode="sort">
            <xsl:sort select="publisher"/>
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="journalsSorted">
        <xsl:apply-templates select="//journal" mode="sort">
            <xsl:sort select="."/>
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="journalListNoRepetition">
        <xsl:apply-templates select="$journalsSorted" mode="norepetition"/>
    </xsl:variable-->
    <xsl:template match="/">
        <div class="middle">
            <div id="breadCrumb">
                <a href="{$DIR}/index.php?lang={$lang}">home</a>
                &gt; <xsl:value-of select="$texts/text[find='journalsByAlphabeticByPublisher']/replace"/>
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
                                <a href="?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list">
                                    <xsl:attribute name="class"><xsl:choose><xsl:when test="$collection = ''">opened</xsl:when><xsl:otherwise>closed</xsl:otherwise></xsl:choose></xsl:attribute>
                                    <xsl:value-of select="$texts/text[find='alphabeticSort']/replace"/>
                                </a>
                                <xsl:if test="$collection = ''">
                                    <div id="letters" class="letters">
                                        <xsl:apply-templates select="$alphabet" mode="link">
                                            <xsl:with-param name="count" select="//order"/>
                                        </xsl:apply-templates>
                                    </div>
                                </xsl:if>
                            </li>
                            <xsl:if test="$scielo_portal='yes'">
                                <li>
                                    <a href="?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list&amp;collection=*">
                                        <xsl:attribute name="class"><xsl:choose><xsl:when test="$collection = ''">closed</xsl:when><xsl:otherwise>opened</xsl:otherwise></xsl:choose></xsl:attribute>
                                        <xsl:value-of select="$texts/text[find='collection']/replace"/>
                                    </a>
                                    <xsl:if test="$collection != ''">
                                        <div id="collections" class="letters">
                                            <ul>
                                                <xsl:apply-templates select="//publisherList" mode="link"/>
                                            </ul>
                                        </div>
                                    </xsl:if>
                                </li>
                            </xsl:if>
                            <!--li><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsBySubject&amp;xsl=secondLevelForLastJournalsBySubject" class="closed">assunto</a></li-->
                            <!--li><a href="#" class="closed">publicador</a></li-->
                        </ul>
                    </div>
                </div>
            </div>
            <div class="content">
                <h3>
                    <span>
                        <xsl:value-of select="$texts/text[find='journalsByAlphabeticByPublisher']/replace"/>
                        <xsl:if test="$letter ='' ">
                             - <xsl:value-of select="concat(sum(.//publisherList/@total),' ',$texts/text[find='journals']/replace)"/>
                        </xsl:if>
                    </span>
                </h3>
                <xsl:choose>
                    <xsl:when test="string-length($collection) = 0">
                        <xsl:apply-templates select="$alphabet[.=$letter or (string-length($letter) = 0)]">
                            <xsl:with-param name="list" select="//publisherList"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//publisherList[($collection = '*') or @collection=$collection]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="letter" mode="link">
        <xsl:param name="count"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($count[@by=$letter]//journal) &gt; 0">
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list&amp;letter={.}" title="">
                <xsl:value-of select="."/>
            </a>&#160;
        </xsl:if>
    </xsl:template>
    <xsl:template match="publisherList" mode="link">
        <li>
            <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForPublishersByCollection&amp;xsl=alphabetic_list&amp;collection={@collection}" title="{@collection}">
                <xsl:value-of select="@collection"/>
            </a>
        </li>
    </xsl:template>
    <xsl:template match="publisherList">
        <h3>
            <xsl:value-of select="@collection"/>
            <span class="lengthData">
                <strong>
                    <xsl:value-of select="@total"/>
                </strong> periódico(s)</span>
        </h3>

            <xsl:apply-templates select="order/publisher"/>
    </xsl:template>
    <xsl:template match="letter">
        <xsl:param name="list"/>
        <xsl:variable name="letter" select="."/>
        <xsl:if test="count($list//publisher[starts-with(translate(normalize-space(name),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$letter)]//journal) &gt; 0">
            <h3>
                <xsl:value-of select="$letter"/>
                <span class="lengthData">
                    <strong>
                        <xsl:value-of select="count($list//publisher[starts-with(translate(normalize-space(name),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$letter)]//journal)"/>
                    </strong> periódico(s)</span>
            </h3>
            <xsl:apply-templates select="$list//publisher[starts-with(translate(normalize-space(name),'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),$letter)]">
                <xsl:sort select="name"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    <xsl:template match="publisher">
        <h5>
            <xsl:value-of select="name" disable-output-escaping="yes"/>
        </h5>
        <ul>
            <xsl:apply-templates select="JournalList"/>
        </ul>
    </xsl:template>
    <xsl:template match="JournalList">
        <xsl:apply-templates select="journal"/>
    </xsl:template>
    <xsl:template match="journal">
        <li>
            <a href="{@uri}">
                <xsl:if test="$scielo_portal='yes'">
                    <xsl:attribute name="target">_blank</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </a>
            <xsl:if test="$scielo_portal='yes'">
                <span class="collectionName">[<xsl:value-of select="../../../../@collection"/>]</span>
            </xsl:if>
        </li>
    </xsl:template>
    <!--xsl:template match="journal" mode="x">
        <xsl:variable name="j" select="."/>
        <journal collection="{$sites[.//journal=$j]/@collection}"><xsl:value-of select="."/></journal>
    </xsl:template>
    <xsl:template match="journal" mode="sort">
        <xsl:variable name="j" select="."/>
        <xsl:apply-templates select="$sites//journal[.=$j]" mode="x"/>

    </xsl:template>
    <xsl:template match="journal" mode="norepetition">
        <xsl:variable name="previous" select="preceding-sibling::journal[position() = 1]"/>
        <xsl:variable name="current" select="."/>
        <xsl:if test="concat($current/@collection,$current) != concat($previous/@collection,$previous) or not($previous)">
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template-->
</xsl:stylesheet>
