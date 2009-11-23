<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="no" omit-xml-declaration="yes" encoding="iso-8859-1"/>

    <xsl:variable name="base-path" select="/root/define/DATABASE_PATH"/>
    <xsl:param name="xml-path" select="concat(/root/define/DATABASE_PATH,'xml/')"/>
    <xsl:param name="default-base-path" select="/root/define/DEFAULT_DATA_PATH"/>

    <xsl:variable name="subportas-xml" select="document(concat($default-base-path,'xml/subportals.xml'))"/>

    <xsl:param name="portal" select="''"/>
    <xsl:variable name="portal_param">
        <xsl:choose>
            <xsl:when test="$portal != ''">
                <xsl:value-of select="concat('&amp;portal=',$portal)" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="xml2html" select="'../php/xmlRoot.php'"/>
    <xsl:variable name="cgi" select="/root/http-info/cgi"/>
    <xsl:variable name="lang" select="$cgi/lang"/>
    <xsl:variable name="location" select="'../'"/>
    <xsl:variable name="image-location" select="'../image/admin/common/'"/>

    <xsl:variable name="xsl-path" select="'xsl/adm/'"/>
    <xsl:variable name="doc-name" select="concat('xml/',$lang,'/bvs.xml')"/>
    <xsl:variable name="doc-xml" select="document(concat($xml-path,$lang,'/bvs.xml'))"/>
    <xsl:variable name="session" select="/root/http-info/session"/>
    <xsl:variable name="user-level" select="$session/auth_level"/>


    <xsl:template match="/">
        <xsl:apply-templates select="root/adm/page[@id = 'menu']" mode="html"/>
    </xsl:template>

    <xsl:template match="*" mode="html">
        <html>
            <xsl:apply-templates select="." mode="head"/>
            <xsl:apply-templates select="." mode="body"/>
        </html>
    </xsl:template>

    <xsl:template match="*" mode="head">
        <head>
            <xsl:apply-templates select="." mode="meta"/>
            <xsl:apply-templates select="." mode="title"/>
            <xsl:apply-templates select="." mode="style"/>
            <xsl:apply-templates select="." mode="script"/>
        </head>
    </xsl:template>

    <xsl:template match="*" mode="meta">
        <meta http-equiv="Expires" content="-1" />
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    </xsl:template>


    <xsl:template match="*" mode="title">
        <title>
            <xsl:apply-templates select="@title"/>
        </title>
    </xsl:template>

    <xsl:template match="*" mode="style">
        <link rel="stylesheet" href="{$location}{@css}" type="text/css"/>
    </xsl:template>

    <xsl:template match="*" mode="script">
        <script language="JavaScript" src="{$location}js/menu.js">/* menu.js */</script>
    </xsl:template>

    <xsl:template match="message">
        <xsl:value-of select="concat('msgArray[',position(),'] = ','&quot;',@text,'&quot;',';')"/>
    </xsl:template>

    <xsl:template match="*" mode="body">
        <body>
            <xsl:apply-templates select="." mode="form"/>
        </body>
    </xsl:template>

    <xsl:template match="*" mode="form">
        <form name="formPage" action="{$xml2html}" method="post" class="{$portal}">
            <xsl:apply-templates select="$cgi/*" mode="hidden"/>
            <input type="hidden" name="buffer" value=""/>
            <xsl:apply-templates/>
        </form>
        <!--
        <form name="formPreview" action="/preview.php" method="post" target="preview">
            <input type="hidden" name="lang" value="{$lang}"/>
        </form>
        -->
    </xsl:template>
    <xsl:template match="*" mode="hidden">
        <input type="hidden" name="{name()}" value="{.}"/>
    </xsl:template>
    <xsl:template match="identification">
        <span class="identification">
            <center>
                <xsl:apply-templates select="@title"/>
                <xsl:apply-templates select="$doc-xml/bvs/identification/item" mode="hyphened"/>
            </center>
        </span>
    </xsl:template>
    <xsl:template match="bar">
        <hr size="1" noshade=""/>
        <table width="100%" border="0" cellpadding="4" cellspacing="0" class="bar">
            <tr valign="top">
                <td align="left" valign="middle">
                    <xsl:apply-templates select="*[not(@align = 'right')]" mode="piped"/>
                </td>
                <td align="right" valign="middle">
                    <xsl:apply-templates select="*[@align = 'right']" mode="piped"/>
                </td>
            </tr>
            <xsl:call-template name="subportals"/>
        </table>
        <hr size="1" noshade=""/>
        <br/>
    </xsl:template>

    <xsl:template name="subportals">
            <xsl:if test="$subportas-xml//item">
                <tr>
                    <td align="left" valign="bottom" colspan="2" style="border-top: 1px solid #808080">
                        <xsl:value-of select="'Subportals: '"/>
                        <a target="_top">
                            <xsl:if test="$portal != ''">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat('../admin/admFrames.php?lang=',$lang)"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="'Home'"/>
                        </a>
                        <xsl:for-each select="$subportas-xml//item">
                            <xsl:value-of select="' | '"/>
                            <a target="_top">
                                <xsl:if test="$portal != @id">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat('../admin/admFrames.php?lang=',$lang,'&amp;portal=', @id)"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="target">_top</xsl:attribute>
                                <xsl:value-of select="."/>
                            </a>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:if>
    </xsl:template>

    <!-- Botoes da barra superior (Gravar, English, Espanhol, Sair) -->
    <xsl:template match="item[@href]">
        <a href="{@href}{$portal_param}">
            <xsl:choose>
                <xsl:when test="not(starts-with(@href,'javascript'))">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat(@href,$portal_param)"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_top</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <!-- Itentificador das Colunas (Primeira Coluna, Segunda Coluna ... ) -->
    <xsl:template match="item[not(@href) and not(@type)]">
        <xsl:apply-templates select="text()"/>
    </xsl:template>


    <!-- Componentes (Collection, portal) -->
    <xsl:template match="item[@type != '']">
        <a href="{$xml2html}?xml={$cgi/xml}&amp;xsl={$xsl-path}tree-collection.xsl&amp;lang={$lang}&amp;page={@type}&amp;id={@id}{$portal_param}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="item[@type = 'ticker']">
           <a href="../admin/edit-ticker.php?lang={$lang}&amp;page={text()}&amp;id={@id}{$portal_param}">
                <xsl:apply-templates select="text()"/>
           </a>
    </xsl:template>

    <xsl:template match="item[@type = 'rss-highlight']">
           <a href="../admin/edit-rss-highlight.php?lang={$lang}&amp;page={text()}&amp;id={@id}{$portal_param}">
                <xsl:apply-templates select="text()"/>
           </a>
    </xsl:template>

    <xsl:template match="item[@type = 'service']">
            <a href="../admin/service.php?lang={$lang}&amp;page={text()}&amp;id={@id}{$portal_param}">
                <xsl:apply-templates select="text()"/>
            </a>
    </xsl:template>

    <xsl:template match="item[@type = 'rss']">
        <a href="../admin/rss.php?lang={$lang}&amp;page={text()}&amp;id={@id}{$portal_param}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="item[@type = 'xhtml']">
        <a href="../admin/htmlarea.php?lang={$lang}&amp;page={text()}&amp;id={@id}{$portal_param}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="item[@page]">
        <a href="{$xml2html}?xml={$cgi/xml}&amp;xsl={$xsl-path}tree.xsl&amp;lang={$lang}&amp;page={@page}{$portal_param}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="item[@page and @xsl]">
        <a href="{$xml2html}?xml={$cgi/xml}&amp;xsl={$xsl-path}{@xsl}&amp;lang={$lang}&amp;page={@page}{$portal_param}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="item[@file and @adm]">
        <a href="{@adm}">
            <xsl:apply-templates select="text()"/>
        </a>
    </xsl:template>

    <xsl:template match="*" mode="piped">
        <xsl:if test="position() != 1">&#160;<b>|</b>&#160;</xsl:if>
        <xsl:apply-templates select="."/>
    </xsl:template>
    <xsl:template match="*" mode="hyphened">
        <xsl:if test="position() != 1">&#160;<b>-</b>&#160;</xsl:if>
        <xsl:apply-templates select="."/>
    </xsl:template>
    <xsl:template match="item" mode="lined">
        <xsl:apply-templates select="."/>
        <br/>
    </xsl:template>

    <xsl:template match="menu">
        <script language="JavaScript">
            parent.frameHidden.menuXSL = "<xsl:value-of select="$cgi/xsl"/>";
        </script>

        <table width="100%" cellpadding="0" cellspacing="8" class="menu">
            <colgroup width="35%"></colgroup>
            <colgroup width="45%"></colgroup>
            <colgroup width="20%"></colgroup>

            <tr valign="top">
                <xsl:apply-templates select="block[contains(@level,$user-level) or not(@level)] "/>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="block">
        <td>
            <table width="90%" cellpadding="4" cellspacing="2" class="block">
                <tr>
                    <td align="center" class="block-title">
                        <xsl:apply-templates select="@title"/>
                    </td>
                </tr>
                <tr>
                    <td class="block-body">
                        <ul>
                            <xsl:apply-templates mode="tree"/>
                        </ul>
                    </td>
                </tr>
            </table>
        </td>
    </xsl:template>
    <xsl:template match="item | attach" mode="tree">
        <li type="disc">
            <xsl:apply-templates select="."/>
            <xsl:if test="*">
                <ul>
                    <xsl:apply-templates select="*" mode="tree"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="line" mode="tree">
        <p/>
    </xsl:template>
    <xsl:template match="attach[@file and @adm]">
        <a href="javascript:attachW('{@adm}')">
            <xsl:apply-templates select="." mode="label"/>
        </a>
    </xsl:template>
    <xsl:template match="attach[(@type = 'calls' or @type = 'warnings') and @file and @adm]">
        <a href="{@adm}">
            <xsl:apply-templates select="." mode="label"/>
        </a>
    </xsl:template>
    <xsl:template match="attach[@file and not(@adm)]">
        <xsl:apply-templates select="." mode="label"/>
    </xsl:template>
    <xsl:template match="attach" mode="label">
        <xsl:apply-templates select="text()"/>
        <xsl:if test="normalize-space(text()) =''">
            <xsl:apply-templates select="@type"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="doc-list" mode="tree">
        <xsl:variable name="find-element" select="@element"/>

        <xsl:apply-templates select="$doc-xml/bvs/*[name() = $find-element]/*" mode="tree"/>
    </xsl:template>
</xsl:stylesheet>
