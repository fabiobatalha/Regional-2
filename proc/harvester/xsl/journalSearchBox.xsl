<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="yes" indent="yes"/>
<xsl:param name="lang"/>
<xsl:param name="DIR"/>

<xsl:variable name="langs">
    <xsl:copy-of select="document('../xml/labels.xml')" />
</xsl:variable>

<xsl:variable name="labels" select="$langs/root/labels[@lang = $lang]" />

<xsl:template match="/">
<li>
	<strong><xsl:value-of select="$labels/general/searchFormTitle" /></strong>
	  <form name="searchFormIssues" action="{$DIR}/applications/scielo-org{normalize-space(//action)}" method="post">
	    <input name="lang" value="{$lang}" type="hidden" />
	    <input name="group" value="" type="hidden" />
	    <div class="searchItens">
		<div class="label" style="padding: 0px; marging: 0px; font-size: 10px; font-weight: bold;"><xsl:value-of select="$labels//onemorewords" /></div>
                <input name="expression" class="expression" type="text" style="width: 150px; margin: 0p; padding: 0px;"/>
                <input value="pesquisar" name="submit" class="submit" type="submit" style="margin: 0px; padding: 0px;"/>
	    </div>
	  </form>
</li>
</xsl:template>


</xsl:stylesheet>
