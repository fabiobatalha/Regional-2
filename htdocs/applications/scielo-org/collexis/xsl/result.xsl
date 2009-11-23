<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="1.0" indent="yes"/>

    <xsl:include href="common.xsl"/>
    <xsl:include href="navigationBar.xsl"/>

    <xsl:variable name="total" select="/MAIN/collexis/search/statistics/count"/>
    <xsl:variable name="count" select="/MAIN/define/DOCUMENTS_PER_PAGE"/>
    <xsl:variable name="collection" select="/MAIN/vars/collection"/>

    <xsl:variable name="from">
        <xsl:choose>
            <xsl:when test="/MAIN/vars/from != ''">
                <xsl:value-of select="/MAIN/vars/from"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="*" mode="content">
        <div id="group">
            <xsl:apply-templates select="." mode="center"/>
            <xsl:apply-templates select="." mode="right"/>
        </div>
    </xsl:template>

    <xsl:template match="*" mode="center">
        <div id="center">
            <form action="{$PATH_DATA}index.php" method="post" name="formMain">
                <input type="hidden" name="related_id" value="{/MAIN/vars/related_id}"/>
                <input type="hidden" name="from" value=""/>
                <xsl:apply-templates select="/MAIN/vars/child::*" mode="hidden"/>
                <xsl:apply-templates select="/MAIN/collexis"/>
            </form>
        </div>
    </xsl:template>

    <xsl:template match="collexis">
        <xsl:apply-templates select="error"/>
        <xsl:apply-templates select="search//recordlist"/>
    </xsl:template>

    <xsl:template match="error">
        <div id="error">
            <img src="{$PATH_IMAGE}/unavailable_icon.gif" border="0" align="middle"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="error/*">
        <xsl:value-of select="."/><br/>
    </xsl:template>

    <xsl:template match="recordlist">
        <xsl:variable name="collection" select="/MAIN/vars/collection"/>
        <xsl:variable name="collection-name" select="$config/collection-list/collection[name = $collection]/label"/>

        <div id="resultBlock">
            <xsl:choose>
                <xsl:when test="@count = 0">
                    <div id="noresult">
                        <img src="{$PATH_IMAGE}/unavailable_icon.gif" border="0" align="middle"/>
                        <xsl:value-of select="$texts/text[find = 'SEM_RESULTADO']/replace"/>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="lastOfPage" select="($from + $count) - 1"/>
                    <div id="total">

                        <xsl:value-of select="$texts/text[find = 'DOCUMENTOS']/replace"/>&#160;
                        <xsl:value-of select="$from"/> -
                        <xsl:choose>
                            <xsl:when test="$lastOfPage &gt;  $total">
                                <xsl:value-of select="$total"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$lastOfPage"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        &#160;<xsl:value-of select="$texts/text[find = 'DE']/replace"/>&#160;
                        <xsl:value-of select="$total"/>&#160;
                        <xsl:value-of select="$texts/text[find = 'RELEVANTES']/replace"/>
                    </div>

        <xsl:if test="$total &gt; 0">
            <xsl:apply-templates select="." mode="pages">
                <xsl:with-param name="total" select="$total"/>
                <xsl:with-param name="count" select="$count"/>
                <xsl:with-param name="from" select="$from"/>
            </xsl:apply-templates>
        </xsl:if>

                </xsl:otherwise>
            </xsl:choose>

        </div>

        <xsl:if test="$total &gt; 0">
            <xsl:apply-templates select="record"/>
            <div class="navigationBottom">
                <xsl:apply-templates select="." mode="pages">
                    <xsl:with-param name="total" select="$total"/>
                    <xsl:with-param name="count" select="$count"/>
                    <xsl:with-param name="from" select="$from"/>
                </xsl:apply-templates>
            </div>
        </xsl:if>

    </xsl:template>

    <xsl:template match="*" mode="right">
        <div id="right">
            <xsl:apply-templates select="//fingerprintlist[fingerprint/concept]"/>
            <xsl:apply-templates select="//cooccurrence[collexion//concept]"/>
        </div>
    </xsl:template>

    <xsl:template match="restrict">
        <xsl:choose>
            <xsl:when test="option">
                <xsl:value-of select="option[value = $collection]/text"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="fingerprintlist">

            <xsl:variable name="concept_list">
                <xsl:apply-templates select="fingerprint//concept" mode="list"/>
            </xsl:variable>

            <div id="resultBlock">
                <img src="{$PATH_IMAGE}/arrow.gif"/>
                <span id="title">
                    <xsl:value-of select="$texts/text[find = 'CONCEITOS']/replace"/>
                </span>
                <div id="text">
                    <xsl:value-of select="$texts/text[find = 'REFINE']/replace"/>
                </div>
            </div>
            <div id="conceptBox">
                <div id="text">
                    <xsl:copy-of select="$texts/text[find = 'CONCEITOS_INFO']/replace"/>
                </div>
                <div id="header">
                    <xsl:value-of select="$texts/text[find = 'GRAUS_DE_RELEVANCIA']/replace"/>
                    <span id="required_mark"> ! </span>
                </div>
                <form action="{$PATH_DATA}index.php" method="post" name="formFingerPrint">
                    <input type="hidden" name="task" value="search_by_fingerprint"/>
                    <input type="hidden" name="thesaurus" value="{/MAIN/vars/thesaurus}"/>
                    <input type="hidden" name="collection" value="{/MAIN/vars/collection}"/>
                    <input type="hidden" name="expression" value="{/MAIN/vars/expression}"/>
                    <input type="hidden" name="lang" value="{/MAIN/vars/lang}"/>
                    <input type="hidden" name="add_concept_id" value=""/>
                    <input type="hidden" name="add_concept_name" value=""/>
                    <input type="hidden" name="add_concept_thesaurus" value=""/>

                    <xsl:apply-templates select="fingerprint[concept]"/>

                    <div style="float: left; padding: 3px;">
                        <input type="submit" name="set" value=" {$texts/text[find = 'AJUSTAR_BOTAO']/replace} " class="set"/>
                    </div>
                </form>
            </div>

    </xsl:template>


    <xsl:template match="record">
        <xsl:variable name="partnerName" select="metainfo/partnerID"/>

        <div id="documentBox">
            <xsl:if test="position() mod 2 > 0">
                 <xsl:attribute name="style">background-color: #f4f2f0</xsl:attribute>
            </xsl:if>

            <div id="pos">
                <xsl:value-of select="($from + position())-1"/> / <xsl:value-of select="$total"/>
            </div>
            <div id="db">
                SciELO <xsl:value-of select="$texts/text[find = $partnerName]/replace"/>
            </div>

            <div id="line">
                <div id="document">
                    <xsl:apply-templates select="." mode="citation"/>
                    <xsl:apply-templates select="." mode="links"/>
                </div>
            </div>

        </div>

    </xsl:template>

        <xsl:template match="record2">
        <xsl:variable name="partnerName" select="metainfo/partnerID"/>

        <div id="documentBox">
            <xsl:if test="position() mod 2 > 0">
                 <xsl:attribute name="style">background-color: #f4f2f0</xsl:attribute>
            </xsl:if>

            <div id="pos">
                <xsl:value-of select="($from + position())-1"/> / <xsl:value-of select="$total"/>
            </div>
            <div id="db">
                <xsl:value-of select="$texts/text[find = $partnerName]/replace"/>
            </div>

            <div id="line">
                <div id="document">
                    <xsl:apply-templates select="." mode="citation"/>
                    <xsl:apply-templates select="." mode="links"/>
                </div>
            </div>

        </div>

    </xsl:template>


    <xsl:template match="fingerprint">

        <xsl:choose>
            <xsl:when test="@thesaurus = 'freetext'">
                <div id="thesaurus">
                    <xsl:value-of select="$texts/text[find = 'CONCEITOS_LIVRE']/replace"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="thesaurus">
                    <xsl:value-of select="$texts/text[find = 'CONCEITOS_TESAURO']/replace"/>
                </div>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:apply-templates select="concept">
                <xsl:sort select="concat(@rank,@required)" order="descending"/>
                <xsl:with-param name="thesaurus" select="@thesaurus"/>
        </xsl:apply-templates>

    </xsl:template>

    <xsl:template match="fingerprint/concept">
        <xsl:param name="thesaurus"/>

        <xsl:variable name="required">
            <xsl:choose>
                <xsl:when test="boolean(@required)">
                    <xsl:value-of select="@required"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>no</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <table with="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>

                <td width="2%">
                    <input type="checkbox" checked="1" name="concept_{$thesaurus}_{@id}" value="true"/>
                </td>
                <td width="50%">
                    <span class="required_{$required}">
                        <xsl:value-of select="name"/>
                    </span>
                </td>

            <td width="33%" nowrap="1">
                <input type="radio" name="rank_{@id}">
                    <xsl:choose>
                        <xsl:when test="@rank &lt; 0.3">
                            <xsl:attribute name="checked">1</xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="@rank"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="value">0.2</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </input>

                <input type="radio" name="rank_{@id}">
                    <xsl:choose>
                        <xsl:when test="@rank &gt;= 0.3 and @rank &lt; 0.8">
                            <xsl:attribute name="checked">1</xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="@rank"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="value">0.4</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </input>

                <input type="radio" name="rank_{@id}">
                    <xsl:choose>
                        <xsl:when test="@rank &gt;= 0.8 and $required != 'yes'">
                            <xsl:attribute name="checked">1</xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="@rank"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="value">1</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </input>

                <input type="radio" name="rank_{@id}" value="1.1">
                    <xsl:if test="$required = 'yes'">
                        <xsl:attribute name="checked">1</xsl:attribute>
                    </xsl:if>
                </input>

            </td>

            <td width="15%">
                <xsl:choose>
                    <xsl:when test="@rank = 0">
                        0%
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="format-number(@rank * 100,'#')"/>%
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            </tr>
        </table>
    </xsl:template>


    <xsl:template match="fingerprint/concept" mode="list">
        <xsl:value-of select="@id"/>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="cooccurrence">

        <xsl:variable name="add_concept_thesaurus" select="collexion/result/@thesaurus"/>
        <xsl:variable name="conceptList">
                <xsl:for-each select="collexion//concept">
                    <xsl:sort select="category" order="ascending"/>
                    <xsl:copy-of select="."/>
                 </xsl:for-each>
        </xsl:variable>

        <div id="{name()}">
            <xsl:copy-of select="$texts/text[find = 'ADICIONA_CONCEITO_MANUAL']/replace"/><br/>

            <form name="formAddConcept" style="margin-bottom: 10px;" method="POST">
                <input type="hidden" name="add_concept_thesaurus" value="{collexion/result/@thesaurus}"/>

                <input type="text" size="25" name="add_concept" class="concept"/>
                <input type="button" value="{$texts/text[find = 'ADICIONA_BOTAO']/replace}" class="set" onclick="javascript: add_concept_name();"/>
            </form>

            <xsl:copy-of select="$texts/text[find = 'ADICIONA_CONCEITO_PROPOSTO']/replace"/>
            <ul>
                <xsl:apply-templates select="collexion//concept" mode="group">
                    <xsl:with-param name="conceptList" select="collexion//concept" />
                        <!--xsl:sort select="." /-->
                </xsl:apply-templates>
            </ul>
        </div>

    </xsl:template>

    <xsl:template match="concept" mode="group">
        <xsl:param name="conceptList"/>

        <xsl:variable name="previous" select="position() - 1"/>
        <xsl:variable name="previousName" select="$conceptList/conceptList/concept[$previous]/category"/>

        <xsl:if test="$previous = 0 or $previousName != category">
            <li>
                <strong>
                    <xsl:value-of select="category"/>
                </strong>
            </li>
        </xsl:if>
        <blockquote>
            <a href="javascript: add_concept_id('{@id}');">
                <xsl:value-of select="name"/>
            </a>
        </blockquote>
    </xsl:template>

    <xsl:template match="record" mode="citation">
        <xsl:variable name="url" select="concat('http://',metainfo/partnerID,'/scielo.php?script=sci_arttext&amp;pid=',@id,'&amp;lng=en&amp;nrm=iso&amp;tlng=en')"/>

        <xsl:apply-templates select="metainfo/authors"/>

        <a href="{$url}" target="_blank">
            <span class="title"><xsl:value-of select="@title"/></span>
        </a>
        <xsl:apply-templates select="metainfo"/>
    </xsl:template>

    <xsl:template match="record" mode="links">
        <xsl:variable name="url" select="concat('http://',metainfo/partnerID,'/scielo.php?script=sci_arttext&amp;pid=',@id,'&amp;lng=en&amp;nrm=iso&amp;tlng=en')"/>
            <div id="links">
                <ul>
                    <xsl:if test="$url != ''">
                        <li>
                            <a href="{$url}" target="_blank">
                                <xsl:value-of select="$texts/text[find = 'TEXTO_COMPLETO']/replace"/>
                            </a>
                        </li>
                    </xsl:if>
                    <xsl:if test="metainfo/refDB != ''">
                        <li>
                            <a href="javascript:show_refDB('{metainfo/refDB}','{metainfo/refID}');" >
                                <xsl:value-of select="$texts/text[find = 'VER_REFERENCIA']/replace"/>
                            </a>
                        </li>
                    </xsl:if>
                    <li>
                        <a href="javascript:show_fingerprint('{@id}');">
                            <xsl:value-of select="$texts/text[find = 'LISTA_CONCEITOS']/replace"/>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:find_similar('{@id}');">
                            <xsl:value-of select="$texts/text[find = 'SIMILARES']/replace"/>
                        </a>
                    </li>
                </ul>
            </div>
    </xsl:template>

    <xsl:template match="metainfo">

            <xsl:value-of select="' '" />
            <i><xsl:apply-templates select="publishingInformation"/></i>

    </xsl:template>

    <xsl:template match="authors">

            <xsl:value-of select="concat(., ' ')"/>

    </xsl:template>


    <xsl:template match="issn">
        | issn: <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="publishingInformation">
        <xsl:value-of select="."/>
    </xsl:template>


    <xsl:template match="language">
        <xsl:variable name="lang">
            <xsl:call-template name="upper">
                <xsl:with-param name="str" select="."/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="translate">
            <xsl:value-of select="concat('IDIOMA_',$lang)"/>
        </xsl:variable>
        <xsl:value-of select="$texts/text[find = 'IDIOMA_DOCUMENTO']/replace"/>:
        <xsl:value-of select="$texts/text[find = $translate]/replace"/>
    </xsl:template>

</xsl:stylesheet>
