<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>
    <xsl:variable name="lang" select="//vars/lang"/>
    <xsl:variable name="PATH" select="//vars/PATH"/>
    <xsl:variable name="texts" select="document('../xml/texts.xml')/texts/language[@id = $lang]"/>
    <xsl:variable name="metaSearchInstances" select="document(concat('../xml/',$lang,'/metaSearchInstances.xml'))"/>
    <xsl:variable name="links" select="//ARTICLE"/>
    <xsl:variable name="total" select="count(//citinglist/citing)"/>


    <xsl:template match="/">

    <div class="articleList">
        <xsl:apply-templates select="/root/scielo/article" />
        <xsl:choose>
            <xsl:when test="$total &gt; 0">
                <ul>
                    <xsl:apply-templates select="//citinglist/citing" mode="pre" />
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$texts/text[find='doesnt_cited']/replace"/>
            </xsl:otherwise>
        </xsl:choose>
    </div>
    </xsl:template>

    <xsl:template match="citing" mode="pre">
        <xsl:param name="article" />
        <xsl:apply-templates select="." >
            <xsl:with-param name="s" select="@s"/>
            <xsl:with-param name="pos" select="position()"/>
        </xsl:apply-templates>
    </xsl:template>

       <xsl:template match="article">
                <xsl:param name="s"/>
                <xsl:param name="pos"/>
                <xsl:variable name="country" select="concat(@country,@code)"/>
                <xsl:variable name="nameCountry" select="$texts/text[find=$country]/replace"/>
                <xsl:variable name="domainCountry" select="$texts/text[find=$country]/url"/>
                <xsl:variable name="url" select="concat($domainCountry,'/scielo.php?script=sci_arttext&amp;pid=',@pid,'&amp;nrm=iso&amp;lng=',$lang)"/>
                <xsl:variable name="service_log" select="/root/service_log"/>
                <h3>
                        <span>
                                <!--xsl:apply-templates select="." mode="old"><xsl:with-param name="url" select="$url"/></xsl:apply-templates-->
                                <xsl:apply-templates select="." mode="standardized-reference"><xsl:with-param name="domain" select="$domainCountry"/><xsl:with-param name="LANG" select="$lang"/><xsl:with-param name="log" select="$service_log"/></xsl:apply-templates>
                                <xsl:if test="$s != ''">
                                        <br/>
                                        <xsl:value-of select="$texts/text[find='similarity']/replace"/>
                                        <xsl:value-of select="$s"/>
                                </xsl:if>
                        </span>
                </h3>
        </xsl:template>


        <xsl:template match="citing">
                <xsl:param name="s"/>
                <xsl:param name="pos"/>
                <xsl:variable name="country" select="concat(@country,@code)"/>
                <xsl:variable name="nameCountry" select="$texts/text[find=$country]/replace"/>
                <xsl:variable name="domainCountry" select="$texts/text[find=$country]/url"/>
                <xsl:variable name="url" select="concat($domainCountry,'/scielo.php?script=sci_arttext&amp;pid=',@pid,'&amp;nrm=iso&amp;lng=',$lang)"/>
                <xsl:variable name="service_log" select="/root/service_log"/>
                <li>
                        <div>
                                <div class="articleHeader">
                                        <div class="count">
                                                <xsl:value-of select="$pos"/> / <xsl:value-of select="$total"/>
                                        </div>
                                </div>
                                <div style="clear: both; height: 1px; margin: 0px; padding: 0px;"/>
                                <!--xsl:apply-templates select="." mode="old"><xsl:with-param name="url" select="$url"/></xsl:apply-templates-->
                                <xsl:apply-templates select="." mode="standardized-reference"><xsl:with-param name="domain" select="$domainCountry"/><xsl:with-param name="LANG" select="$lang"/><xsl:with-param name="log" select="$service_log"/></xsl:apply-templates>
                                <xsl:if test="$s != ''">
                                        <br/>
                                        <xsl:value-of select="$texts/text[find='similarity']/replace"/>
                                        <xsl:value-of select="$s"/>
                                </xsl:if>
                                <br/>
                                <div class="count">
                    <br/>
                                      <xsl:value-of select="$texts/text[find='accessat']/replace"/>: <xsl:apply-templates select="collections/collection" />
                                </div>
                        </div>
			<div style="clear: both; height: 1px; margin: 0px; padding: 0px;"/>
                </li>
        </xsl:template>

    <xsl:template match="collection">
        <xsl:variable name="total" select="count(.)" />
        <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@url" disable-output-escaping="yes"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    SciELO <xsl:value-of select="@instance" />
        </a>

             <xsl:choose>
                 <xsl:when test="position() = $total"> </xsl:when>
                 <xsl:otherwise>, </xsl:otherwise>
         </xsl:choose>
    </xsl:template>

        <xsl:template match="author">
                <xsl:param name="total"/>
                <xsl:value-of select="."/>
                <xsl:choose>
                        <xsl:when test="position() = $total">. </xsl:when>
                        <xsl:otherwise>, </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="title">
                <b>
                        <xsl:value-of select="."/>
                </b>.
        </xsl:template>
        <xsl:template match="serial">
                <xsl:value-of select="."/> ,
        </xsl:template>
        <xsl:template match="year">
                <xsl:value-of select="."/>,
        </xsl:template>
        <xsl:template match="volume">
                vol.<xsl:value-of select="."/>,
        </xsl:template>
        <xsl:template match="number">
                no.<xsl:value-of select="."/>,
        </xsl:template>
        <xsl:template match="@pid" mode="issn">
                ISSN <xsl:value-of select="substring(.,2,9)"/>.
        </xsl:template>
        <xsl:template match="*" mode="old">
                <xsl:param name="url"/>
                <xsl:apply-templates select="authors/author">
                        <xsl:with-param name="total" select="count(authors/author)"/>
                </xsl:apply-templates>
                <xsl:element name="a">
                        <xsl:attribute name="target">_blank</xsl:attribute>
                        <xsl:choose>
                                <xsl:when test="titles/title[@lang=$lang] != '' ">
                                        <!--
                                                                        Se tem titulo com o idioma da interface corrente mostra o titulo e
                                                                        prepara a URL para a presentar a interface e texto nesse idioma
                                                                -->
                                        <xsl:attribute name="href"><xsl:value-of select="concat($url,'&amp;tlng=',$lang)"/></xsl:attribute>
                                        <xsl:if test="$service_log = 1 ">
                                                <xsl:attribute name="OnClick">callUpdateArticleLog('similares_em_scielo');</xsl:attribute>
                                        </xsl:if>
                                        <xsl:apply-templates select="titles/title[@lang=$lang]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                        <!--
                                                                Se nao tem titulo com o idioma da interface corrente mostra o primeiro titulo e
                                                                prepara a URL para a presentar a interface e texto com o idioma corrente e o texto
                                                                com o idioma do primeiro titulo
                                                        -->
                                        <xsl:attribute name="href"><xsl:value-of select="concat($url,'&amp;tlng=',titles/title[1]/@lang)"/></xsl:attribute>
                                        <xsl:if test="$service_log = 1 ">
                                                <xsl:attribute name="OnClick">callUpdateArticleLog('similares_em_scielo');</xsl:attribute>
                                        </xsl:if>
                                        <xsl:apply-templates select="titles/title[1]"/>
                                </xsl:otherwise>
                        </xsl:choose>
                </xsl:element>,
                    <xsl:apply-templates select="serial"/>
                <xsl:apply-templates select="year"/>
                <xsl:apply-templates select="volume"/>
                <xsl:apply-templates select="number"/>
                <xsl:apply-templates select="@pid" mode="issn"/>
        </xsl:template>

        <xsl:template match="*" mode="standardized-reference">
                <xsl:param name="log"/>
                <xsl:param name="LANG"/>
                <xsl:param name="domain"/>

        <xsl:variable name="TextLinkFlag">
            <xsl:choose>
                <xsl:when test="string-length(@pid) = 28">0</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

                <xsl:call-template name="PrintArticleReferenceElectronicISO">
                        <xsl:with-param name="log" select="$log"/>
                        <xsl:with-param name="FORMAT" select="'short'"/>
                        <xsl:with-param name="LANG" select="$LANG"/>
                        <xsl:with-param name="AUTHLINK" select="'1'"/>
                        <xsl:with-param name="TEXTLINK" select="$TextLinkFlag"/>
                        <xsl:with-param name="AUTHORS" select="authors"/>
                        <xsl:with-param name="ARTTITLE" select="titles/title[1]"/>
                        <xsl:with-param name="VOL" select="volume"/>
                        <xsl:with-param name="NUM" select="number"/>
                        <xsl:with-param name="SUPPL" select="suppl | supplement"/>
                        <!--xsl:with-param name="MONTH" select=""/-->
                        <xsl:with-param name="YEAR" select="year"/>
                        <!--xsl:with-param name="CURR_DATE" select="@CURR_DATE"/-->
                        <xsl:with-param name="PID" select="@pid"/>
                        <xsl:with-param name="ISSN" select="substring(@pid,2,9)"/>
                        <!--xsl:with-param name="FPAGE" select="@FPAGE"/>
                        <xsl:with-param name="LPAGE" select="@LPAGE"/-->
                        <xsl:with-param name="SHORTTITLE" select="serial"/>
                        <xsl:with-param name="domain" select="$domain"/>
                </xsl:call-template>
        </xsl:template>


        <xsl:template name="PrintArticleReferenceElectronicISO">
                <xsl:param name="domain" select="concat('http://',//CONTROLINFO/SCIELO_INFO/SERVER)"/>
                <xsl:param name="log"/>
                <xsl:param name="FORMAT"/>
                <xsl:param name="LANG"/>
                <xsl:param name="AUTHLINK">0</xsl:param>
                <xsl:param name="TEXTLINK">0</xsl:param>
                <xsl:param name="AUTHORS"/>
                <xsl:param name="ARTTITLE"/>
                <xsl:param name="VOL"/>
                <xsl:param name="NUM"/>
                <xsl:param name="SUPPL"/>
                <xsl:param name="MONTH"/>
                <xsl:param name="YEAR"/>
                <xsl:param name="CURR_DATE"/>
                <xsl:param name="PID"/>
                <xsl:param name="ISSN"/>
                <xsl:param name="FPAGE"/>
                <xsl:param name="LPAGE"/>
                <xsl:param name="SHORTTITLE" select="//TITLEGROUP/TITLE"/>
                <xsl:variable name="url">
                        <xsl:value-of select="$domain"/>/scielo.php?script=sci_arttext&amp;pid=<xsl:value-of select="$PID"/>&amp;lng=<xsl:value-of select="$LANG"/>&amp;nrm=iso</xsl:variable>
                <xsl:call-template name="PrintAuthorsISOElectronic">
                        <xsl:with-param name="AUTHORS" select="$AUTHORS"/>
                        <xsl:with-param name="LANG" select="$LANG"/>
                        <xsl:with-param name="AUTHLINK" select="$AUTHLINK"/>
                        <xsl:with-param name="iah">
                                <xsl:if test="not(//SERVER)">
                                        <xsl:value-of select="$domain"/>/cgi-bin/wxis.exe/iah/?IsisScript=iah/iah.xis</xsl:if>
                        </xsl:with-param>
                </xsl:call-template>
                <xsl:if test="$ARTTITLE != '' ">
                        <xsl:choose>
                                <xsl:when test="$TEXTLINK='1'">
                                        <A>
                                                <xsl:attribute name="href"><xsl:value-of select="$url"/></xsl:attribute>
                                                <xsl:if test="$log = 1 ">
                                                        <xsl:attribute name="OnClick">callUpdateArticleLog('similares_em_scielo');</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="concat(' ', $ARTTITLE)" disable-output-escaping="yes"/>
                                        </A>
                                </xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="concat(' ', $ARTTITLE)" disable-output-escaping="yes"/>
                                </xsl:otherwise>
                        </xsl:choose>
                        <!--font class="negrito"-->
                        <xsl:if test="substring($ARTTITLE,string-length($ARTTITLE)) != '.' ">.</xsl:if>
                        <!--/font-->
                </xsl:if>
                <!-- fixed_scielo_social_sciences_20051027 -->
                <xsl:call-template name="PrintTranslatorsISO">
                        <xsl:with-param name="TRANSLATORS" select="$AUTHORS//PERSON[@type='TR']"/>
                        <xsl:with-param name="LANG" select="$LANG"/>
                </xsl:call-template>
                <i>
                        <xsl:value-of select="concat(' ', $SHORTTITLE)" disable-output-escaping="yes"/>
                </i> [online].

                <xsl:if test="($NUM!='ahead' and $NUM!='review' and $NUM!='beforeprint') or $VOL">
                        <xsl:variable name="prevVOL">
                                <xsl:choose>
                                        <xsl:when test="$LANG='en' ">v. </xsl:when>
                                        <xsl:otherwise>vol. </xsl:otherwise>
                                </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="prevNUM">
                                <xsl:choose>
                                        <xsl:when test="$LANG='en' ">n. </xsl:when>
                                        <xsl:otherwise>no. </xsl:otherwise>
                                </xsl:choose>
                        </xsl:variable>
                        <xsl:value-of select="concat(' ', $YEAR)"/>,
                        <xsl:if test="$VOL">
                                <xsl:value-of select="concat(' ',$prevVOL, $VOL)"/>
                        </xsl:if>
                        <xsl:if test="$NUM">
                                <xsl:choose>
                                        <xsl:when test="$NUM='SE' or $NUM='se'">Selected Edition</xsl:when>
                                        <xsl:otherwise>
                                                <xsl:if test="$VOL">, </xsl:if>
                                                <xsl:value-of select="concat($prevNUM,$NUM)"/>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$SUPPL">,
                                <xsl:choose>
                                        <xsl:when test=" $LANG='en' "> suppl. </xsl:when>
                                        <xsl:otherwise> supl. </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="$SUPPL>0">
                                        <xsl:value-of select="$SUPPL"/>
                                </xsl:if>
                        </xsl:if>
                </xsl:if>
                <xsl:if test="$FORMAT!='short'">
                        <xsl:if test="$CURR_DATE">
                                <xsl:choose>
                                        <xsl:when test=" $LANG = 'en' "> [cited </xsl:when>
                                        <xsl:when test=" $LANG = 'pt' "> [citado </xsl:when>
                                        <xsl:when test=" $LANG = 'es' "> [citado </xsl:when>
                                </xsl:choose>
                                <xsl:value-of select="substring($CURR_DATE,1,4)"/>-<xsl:value-of select="substring($CURR_DATE,5,2)"/>-<xsl:value-of select="substring($CURR_DATE,7,2)"/>]</xsl:if>
                </xsl:if>
                <!-- fixed_scielo_social_sciences_20051027 -->
                <xsl:if test="$FPAGE!=0 and $LPAGE!=0 and $FPAGE!='' and $LPAGE!=''">
                        <xsl:value-of select="concat(', pp. ', $FPAGE, '-', $LPAGE)"/>
                </xsl:if>.
                <!--xsl:choose>
                        <xsl:when test=" $LANG = 'en' "> Available from World Wide Web: </xsl:when>
                        <xsl:when test=" $LANG = 'pt' "> Disponível na  World Wide Web: </xsl:when>
                        <xsl:when test=" $LANG = 'es' "> Disponible en la World Wide Web: </xsl:when>
                </xsl:choose-->
                <xsl:if test="$FORMAT!='short'">
                        <xsl:choose>
                                <xsl:when test=" $LANG = 'en' "> Available from: </xsl:when>
                                <xsl:when test=" $LANG = 'pt' "> Disponível em: </xsl:when>
                                <xsl:when test=" $LANG = 'es' "> Disponible en: </xsl:when>
                        </xsl:choose>

  &lt;<!--a>    <xsl:call-template name="AddScieloLink" >
         <xsl:with-param name="seq" select="$PID" />
         <xsl:with-param name="script">sci_arttext</xsl:with-param>
        </xsl:call-template-->
                        <xsl:value-of select="$url"/>
                        <!--/a-->&gt;.</xsl:if>
                <xsl:value-of select="concat(' ISSN ', $ISSN, '.')"/>
                <xsl:if test="$NUM='ahead'"> In press
                <xsl:choose>
                                <xsl:when test="//ARTICLE/@ahpdate=''">
                                        <xsl:value-of select="substring(//ARTICLE/@CURR_DATE,1,4)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="substring(//ARTICLE/@ahpdate,1,4)"/>
                                </xsl:otherwise>
                        </xsl:choose>.
                </xsl:if>
                <xsl:apply-templates select="@DOI" mode="ref"/>
        </xsl:template>
        <xsl:template name="PrintAuthorsISOElectronic">
                <xsl:param name="AUTHORS"/>
                <xsl:param name="LANG"/>
                <xsl:param name="AUTHLINK"/>
                <xsl:param name="iah"/>
                <xsl:variable name="count" select="count($AUTHORS//AUTHOR)"/>
                <xsl:variable name="MAX">
                        <xsl:choose>
                                <xsl:when test="$count &gt; 4">1</xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="$count"/>
                                </xsl:otherwise>
                        </xsl:choose>
                </xsl:variable>
                <xsl:apply-templates select="$AUTHORS//AUTHOR[position()&lt;=$MAX]" mode="AUTHOR_E">
                        <xsl:with-param name="LANG" select="$LANG"/>
                        <xsl:with-param name="AUTHLINK" select="$AUTHLINK"/>
                        <xsl:with-param name="etal">
                                <xsl:choose>
                                        <xsl:when test="$count &gt; 4"> et al</xsl:when>
                                        <xsl:otherwise/>
                                </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="iah" select="$iah"/>
                </xsl:apply-templates>
        </xsl:template>
        <xsl:template name="PrintTranslatorsISO">
                <xsl:param name="TRANSLATORS"/>
                <xsl:param name="LANG"/>
                <!-- fixed_scielo_social_sciences_20051027 -->
                <xsl:if test="$TRANSLATORS">
                        <xsl:choose>
                                <xsl:when test=" $LANG = 'en' "> Translated by </xsl:when>
                                <xsl:when test=" $LANG = 'pt' "> Traduzido por </xsl:when>
                                <xsl:when test=" $LANG = 'es' "> Traducido por </xsl:when>
                        </xsl:choose>
                        <xsl:apply-templates select="$TRANSLATORS" mode="FULLNAME"/>.
  </xsl:if>
        </xsl:template>
        <xsl:template match="AUTHOR" mode="CORP_ISO">
                <xsl:param name="LANG"/>
                <xsl:param name="MAX"/>
                <xsl:choose>
                        <xsl:when test=" position() = $MAX ">
                                <i> et al</i>. </xsl:when>
                        <xsl:when test=" position() > $MAX "/>
                        <xsl:otherwise>
                                <xsl:value-of select="normalize-space(UPP_ORGNAME)" disable-output-escaping="yes"/>
                                <xsl:if test="ORGNAME and ORGDIV">. </xsl:if>
                                <xsl:value-of select="normalize-space(ORGDIV)" disable-output-escaping="yes"/>
                                <xsl:choose>
                                        <xsl:when test=" position() = last() ">. </xsl:when>
                                        <xsl:when test=" position() = last() - 1 and last() != $MAX ">
                                                <xsl:choose>
                                                        <xsl:when test=" $LANG = 'en' "> and </xsl:when>
                                                        <xsl:when test=" $LANG = 'pt' "> e </xsl:when>
                                                        <xsl:when test=" $LANG = 'es' "> y </xsl:when>
                                                </xsl:choose>
                                        </xsl:when>
                                        <xsl:when test=" position() + 1 != $MAX ">, </xsl:when>
                                </xsl:choose>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="AUTHOR" mode="AUTHOR_E">
                <xsl:param name="LANG"/>
                <xsl:param name="AUTHLINK"/>
                <xsl:param name="NUM_CORP"/>
                <xsl:param name="etal"/>
                <xsl:param name="MAX"/>
                <xsl:param name="iah"/>
                <xsl:variable name="length" select="normalize-space(string-length(NAME))"/>
                <xsl:choose>
                        <xsl:when test="SURNAME">
                                <xsl:call-template name="CreateAuthor">
                                        <xsl:with-param name="SURNAME" select="UPP_SURNAME"/>
                                        <xsl:with-param name="NAME" select="NAME"/>
                                        <xsl:with-param name="SEPARATOR" select="', '"/>
                                        <xsl:with-param name="SEARCH">
                                                <xsl:if test=" $AUTHLINK = 1 ">
                                                        <xsl:value-of select="@SEARCH"/>
                                                </xsl:if>
                                        </xsl:with-param>
                                        <xsl:with-param name="iah" select="$iah"/>
                                        <xsl:with-param name="LANG" select="$LANG"/>
                                        <xsl:with-param name="NORM">iso</xsl:with-param>
                                </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:variable name="length" select="normalize-space(string-length(NAME))"/>
                                <xsl:value-of select="normalize-space(UPP_ORGNAME)" disable-output-escaping="yes"/>
                                <xsl:if test="ORGNAME and ORGDIV">. </xsl:if>
                                <xsl:value-of select="normalize-space(ORGDIV)" disable-output-escaping="yes"/>
                        </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                        <xsl:when test="position()=last()">
                                <xsl:value-of select="$etal"/>.</xsl:when>
                        <xsl:when test="position() + 1=last()">
                                <xsl:choose>
                                        <xsl:when test=" $LANG = 'en' "> and </xsl:when>
                                        <xsl:when test=" $LANG = 'pt' "> e </xsl:when>
                                        <xsl:when test=" $LANG = 'es' "> y </xsl:when>
                                </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>; </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <xsl:template name="CreateAuthor">
                <xsl:param name="SURNAME"/>
                <xsl:param name="NAME"/>
                <xsl:param name="SEARCH"/>
                <xsl:param name="LANG"/>
                <xsl:param name="NORM"/>
                <xsl:param name="SEPARATOR"/>
                <xsl:param name="FULLNAME"/>
                <xsl:param name="iah"/>
                <!--xsl:variable name="SERVER" select="//SERVER"/>
                <xsl:variable name="PATH_WXIS" select="//PATH_WXIS"/>
                <xsl:variable name="PATH_DATA_IAH" select="//PATH_DATA_IAH"/>
                <xsl:variable name="PATH_CGI_IAH" select="//PATH_CGI_IAH"/-->
                <xsl:variable name="LANG_IAH">
                        <xsl:choose>
                                <xsl:when test=" $LANG='en' ">i</xsl:when>
                                <xsl:when test=" $LANG='es' ">e</xsl:when>
                                <xsl:when test=" $LANG='pt' ">p</xsl:when>
                        </xsl:choose>
                </xsl:variable>
                <xsl:variable name="fullname">
                        <xsl:choose>
                                <xsl:when test="$FULLNAME!=''">
                                        <xsl:value-of select="$FULLNAME"/>
                                </xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="$SURNAME" disable-output-escaping="yes"/>
                                        <!-- Displays separator character and space -->
                                        <xsl:if test=" $NAME and $SURNAME ">
                                                <xsl:value-of select="concat($SEPARATOR, ' ')"/>
                                        </xsl:if>
                                        <xsl:value-of select="$NAME" disable-output-escaping="yes"/>
                                </xsl:otherwise>
                        </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                        <!-- if SEARCH expression is present prints the link -->
                        <xsl:when test=" $SEARCH != '' ">
                                <xsl:variable name="url">
                                        <xsl:choose>
                                                <xsl:when test="string-length($iah)&gt;0">
                                                        <xsl:value-of select="$iah"/>&amp;base=article^dlibrary&amp;format=iso.pft&amp;lang=<xsl:value-of select="$LANG_IAH"/>&amp;nextAction=lnk&amp;indexSearch=AU&amp;exprSearch=<xsl:value-of select="$SEARCH"/>
                                                </xsl:when>
                                                <xsl:otherwise>http://<xsl:value-of select="concat($SERVER,$PATH_WXIS,$PATH_DATA_IAH)"/>?IsisScript=<xsl:value-of select="$PATH_CGI_IAH"/>iah.xis&amp;base=article^dlibrary&amp;format=iso.pft&amp;lang=<xsl:value-of select="$LANG_IAH"/>&amp;nextAction=lnk&amp;indexSearch=AU&amp;exprSearch=<xsl:value-of select="$SEARCH"/>
                                                </xsl:otherwise>
                                        </xsl:choose>
                                </xsl:variable>
                                <a href="{$url}">
                                        <xsl:value-of select="$fullname" disable-output-escaping="yes"/>
                                </a>
                        </xsl:when>
                        <!-- Otherwise, prints only the author -->
                        <xsl:otherwise>
                                <xsl:value-of select="$fullname" disable-output-escaping="yes"/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>


</xsl:stylesheet>
