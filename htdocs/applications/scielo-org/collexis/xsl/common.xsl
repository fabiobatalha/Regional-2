<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" indent="yes"/>

	<xsl:variable name="MAIN" select="/MAIN"/>		
	<xsl:variable name="def" select="/MAIN/define"/>	
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/MAIN/vars/lang != ''">
				<xsl:value-of select="/MAIN/vars/lang"/>
			</xsl:when>
			<xsl:otherwise>	
				<xsl:value-of select="$def/DEFAULT_LANGUAGE"/>
			</xsl:otherwise>	
		</xsl:choose>	
	</xsl:variable>	
	
	<xsl:variable name="PATH_DATA" select="$def/PATH_DATA"/>
	<xsl:variable name="PATH_IMAGE" select="concat($def/PATH_DATA,'image/',$lang)"/>
	<xsl:variable name="PATH_XML"   select="concat('../xml/',$lang)"/>

	<xsl:variable name="config" select="document(concat($PATH_XML,'/config.xml'))/config"/>
	
	<xsl:variable name="home" select="not(boolean(/MAIN/collexis//result))"/>
	<xsl:variable name="BVS_URL" select="$def/BVS_URL"/>
	
	<xsl:variable name="query_string">
		<xsl:apply-templates select="/MAIN/vars/child::*" mode="cgi"/>
	</xsl:variable>	

	
	<xsl:variable name="texts" select="document(concat($PATH_XML,'/texts.xml'))/texts/labels"/>

	<xsl:template match="/">		
		<xsl:apply-templates select="." mode="body"/>
	</xsl:template>

	<xsl:template match="*" mode="html">	
		<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
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

	<xsl:template match="*" mode="title">
		<title><xsl:apply-templates select="$texts/text[find = 'TITLE']/replace"/></title>
	</xsl:template>
	
	<xsl:template match="*" mode="meta">
		<meta http-equiv="Content-Language" content="pt-BR"/>	
		<meta http-equiv="Expires" content="-1"/>
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
		<meta name="author" content="BIREME (http://www.bireme.br/)"/>		
	</xsl:template>


	<xsl:template match="*" mode="style">
		<link rel="stylesheet" href="{$def/BVS_URL}/applications/scielo-org/css/public/style-pt.css" type="text/css" media="screen"/>
		<link rel="stylesheet" href="{$PATH_DATA}css/screen.css" type="text/css"/>		
	</xsl:template>

	<xsl:template match="*" mode="script">
		<script language="javascript" src="{$PATH_DATA}js/functions.js"></script>
		<script language="javascript">
			var PATH_DATA = '<xsl:value-of select="$PATH_DATA"/>';
		</script>
	</xsl:template>

	<xsl:template match="*" mode="body">
		<body>
			<xsl:apply-templates select="." mode="content"/>
		</body>
	</xsl:template>

	
	<xsl:template match="*" mode="top">
		<div class="bar">
			<div id="otherVersions">			
					<xsl:choose>
						<xsl:when test="$lang = 'pt'">
							<span class="english">
								<a href="javascript:changeLang('en','{$home}')">english</a> 
							</span>	| 
							<span class="español">
								<a href="javascript:changeLang('es','{$home}')">español</a>
							</span>
						</xsl:when>
						<xsl:when test="$lang = 'en'">
							<span class="português">
								<a href="javascript:changeLang('pt','{$home}')">português</a>
							</span> | 
							<span class="español">
								<a href="javascript:changeLang('es','{$home}')">español</a>
							</span>
						</xsl:when>
						<xsl:when test="$lang = 'es'">
							<a href="javascript:changeLang('en','{$home}')">english</a> | <a href="javascript:changeLang('pt','{$home}')">português</a>
						</xsl:when>
					</xsl:choose>			
			</div>
			<div id="contact">
				<span>
					<a href="{$texts/text[find = 'FALE_CONOSCO']/href}">
						<xsl:value-of select="$texts/text[find = 'FALE_CONOSCO']/replace"/>
					</a>	
				</span>
			</div>
		</div>
		<div class="top">
			<div id="parent">
				<img src="{$PATH_IMAGE}/logobvs.gif" alt="{$texts/text[find = 'BVS_TITLE']/replace}" />
			</div>
			<div id="identification">
				<h1>
					<span><xsl:value-of select="$texts/text[find = 'BVS_TITLE']/replace"/></span>
				</h1>
			</div>
			<div id="institutionList">
				<ul>
					<li>
						<a href="http://www.paho.org/" target="_blank">
							<img src="{$PATH_IMAGE}/logoOpas.gif" alt="BIREME | OPAS | OMS" />
						</a>
					</li>
				</ul>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="bar">		

		<div class="searchResult">
			<div id="search">
				<h3>
					<span><xsl:value-of select="$texts/text[find = 'TITLE']/replace"/></span>
				</h3>		
				<div id="breadCrumb">
					<a href="{$BVS_URL}">home</a>			
					<xsl:choose>
						<xsl:when test="$home = 'true'">
							&#62;
							<xsl:value-of select="$texts/text[find = 'HOME']/replace"/>						
						</xsl:when>						
						<xsl:otherwise>
							&#62;
							<a href="javascript:homePage();">
								<xsl:value-of select="$texts/text[find = 'HOME']/replace"/>
							</a>																
							&#62;<xsl:value-of select="$texts/text[find = 'RESULTADO']/replace"/>
							<xsl:if test="/MAIN/vars/area != ''">
								&#62;<xsl:value-of select="/MAIN/vars/area"/>
							</xsl:if>							
						</xsl:otherwise>
					</xsl:choose>
				</div>				
			</div>
		</div>		
	</xsl:template>

	<xsl:template match="*" mode="form-search">	
		<div class="center">
			<div id="search">
				<form action="{$PATH_DATA}index.php" method="post" name="formMain">
					<input type="hidden" name="task" value="search" />
					<input type="hidden" name="lang" value="{$lang}" />
					<xsl:apply-templates select="$config/collection-list" />
					<xsl:value-of select="$texts/text[find = 'PESQUISAR_POR']/replace" />

					<textarea name="expression" rows="4" cols="80" class="xsearch">
						<xsl:value-of select="/MAIN/vars/expression" />
					</textarea>
					<xsl:if test="/MAIN/vars/task = 'search'">
						<div id="expression_required">
							<xsl:value-of select="$texts/text[find = 'INFORME_EXPRESSAO']/replace" />
						</div>
					</xsl:if>
					<div id="searchOption">
						<xsl:apply-templates select="$config/thesaurus-list" />
						<input type="submit" align="bottom" value="{$texts/text[find = 'PESQUISAR']/replace}" class="submit" />
					</div>
				</form>
				<xsl:if test="$texts/text[find = 'DICA_CONTEUDO']/replace">
					<div id="highlightBox">
						<div id="content">		
							<ul>
								<xsl:apply-templates select="$texts/text[find = 'DICA_CONTEUDO']/replace"/>
							</ul>				
						</div>
					</div>
				</xsl:if>					
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="thesaurus-list">	
		<xsl:value-of select="$texts/text[find = 'IDIOMA']/replace"/>
		
		<xsl:variable name="selectedValues">	
			<xsl:apply-templates select="$MAIN/vars/thesaurus" mode="selectedOption"/>		
		</xsl:variable>

			
			<xsl:value-of select="thesaurus-label"/>
			<select size="1" name="thesaurus">
				<xsl:apply-templates select="thesaurus" mode="option">
					<xsl:with-param name="selectedValues" select="$selectedValues"/>
				</xsl:apply-templates>				
			</select>			
		
		<xsl:apply-templates select="additional-thesaurus"/>
	</xsl:template>
	
	<xsl:template match="collection-list[count(collection) = 1]">	
		<input type="hidden" name="collection" value="{collection/name}"/>	
	</xsl:template>

	<xsl:template match="additional-thesaurus">	
		<input type="hidden" name="additional_thesaurus" value="{name}"/>	
	</xsl:template>

	
	<xsl:template match="collection-list">	
	
		<xsl:value-of select="$texts/text[find = 'FONTE']/replace"/>:
		<xsl:variable name="selectedValues">	
			<xsl:apply-templates select="$MAIN/vars//*[name() = 'collection']" mode="selectedOption"/>		
		</xsl:variable>
		<select size="1" name="collection">
			<xsl:apply-templates select="collection" mode="option">
				<xsl:with-param name="selectedValues" select="$selectedValues"/>
			</xsl:apply-templates>				
		</select>			
		
	</xsl:template>

	
	<xsl:template match="filter-list">	
		Filtro:		
		<xsl:variable name="selectedValues">	
			<xsl:apply-templates select="/MAIN/vars//*[name() = 'collection']" mode="selectedOption"/>		
		</xsl:variable>
		<xsl:value-of select="collection-label"/>

		<select size="1" name="collection">
			<xsl:apply-templates select="collection" mode="option">
				<xsl:with-param name="selectedValues" select="$selectedValues"/>
			</xsl:apply-templates>				
		</select>			
		
	</xsl:template>	
	<xsl:template match="*" mode="option">
		<xsl:param name="selectedValues"/>
		<xsl:variable name="currentValue" select="concat('#',name,'#')"/>
		
		<option value="{name}">			
			<xsl:if test="name != '' and contains( $selectedValues, $currentValue)">
				<xsl:attribute name="selected">1</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="label"/>			
		</option>
		
	</xsl:template>
	
	<xsl:template match="*" mode="selectedOption">
		<xsl:value-of select="concat('#',.,'#')"/>	
	</xsl:template>	
		
    <xsl:template match="*" mode="hidden">
	    <xsl:if test=". != ''">
			<input type="hidden" name="{name()}"  value="{.}"/>
		</xsl:if>
    </xsl:template>

	<xsl:template match="related_id | from" mode="hidden"/>
	
	<xsl:template match="*" mode="cgi">    
	    <xsl:if test=". != ''">
			<xsl:value-of select="concat('&amp;',name(),'=',.)"/>
		</xsl:if>	
	</xsl:template>
		
	<xsl:template match="vars/child::*"/>	
	
	<xsl:template match="task" mode="cgi"/>  

	<xsl:variable
		name="uppercase"
	    select="concat('ABCDEFGHIJKLMNOPQRSTUVWXYZ',
				   '&#193;','&#194;','&#195;','&#196;','&#197;',
				   '&#201;','&#202;','&#203;',
				   '&#204;','&#205;','&#206;','&#207;',
				   '&#210;','&#211;','&#212;','&#213;','&#214;',
				   '&#217;','&#218;','&#219;',
				   '&#199;')"/>


	<xsl:variable
		name="lowercase"    
		select="concat('abcdefghijklmnopqrstuvwxyz',
				   '&#225;','&#226;','&#227;','&#228;','&#229;',
				   '&#233;','&#234;','&#235;',
				   '&#236;','&#237;','&#238;','&#239;',
				   '&#242;','&#243;','&#244;','&#245;','&#246;',
				   '&#249;','&#250;','&#251;',
				   '&#231;')"/>

	<xsl:template name="lower">
		<xsl:param name="str"/>	
	    <xsl:value-of select="translate($str, $uppercase, $lowercase)"/>
	</xsl:template>

	<xsl:template name="upper">
		<xsl:param name="str"/>
	    <xsl:value-of select="translate($str, $lowercase, $uppercase)"/>
	</xsl:template>

</xsl:stylesheet>

