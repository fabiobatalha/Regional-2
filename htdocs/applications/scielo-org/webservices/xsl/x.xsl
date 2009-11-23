<?xml version="1.0" encoding="iso-8859-1"?>
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" />

	<xsl:template match="/">
	
	<div class="indicators">
						<ul>
							<li><strong><xsl:value-of select="sum(//collection/indicators/journalTotal)"/></strong> </li>
							<li><strong><xsl:value-of select="sum(//collection/indicators/issueTotal)"/></strong> Fascículos</li>
							<li><strong><xsl:value-of select="sum(//collection/indicators/articleTotal)"/></strong> Artigos</li>

							<li><strong><xsl:value-of select="sum(//collection/indicators/citationTotal)"/></strong> Referências</li>
						</ul>
					</div>
	</xsl:template>
	
</xsl:stylesheet>