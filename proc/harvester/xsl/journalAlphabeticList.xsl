<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" media-type="text/html" encoding="ISO-8859-1" omit-xml-declaration="no" indent="yes"/>

<xsl:template match="/">
        <xsl:variable name="A" select="count(//record[starts-with(title,'A') and publicationStatus='C'])"/>
        <xsl:variable name="B" select="count(//record[starts-with(title,'B') and publicationStatus='C'])"/>
        <xsl:variable name="C" select="count(//record[starts-with(title,'C') and publicationStatus='C'])"/>
        <xsl:variable name="D" select="count(//record[starts-with(title,'D') and publicationStatus='C'])"/>
        <xsl:variable name="E" select="count(//record[starts-with(title,'E') and publicationStatus='C'])"/>
        <xsl:variable name="F" select="count(//record[starts-with(title,'F') and publicationStatus='C'])"/>
        <xsl:variable name="G" select="count(//record[starts-with(title,'G') and publicationStatus='C'])"/>
        <xsl:variable name="H" select="count(//record[starts-with(title,'H') and publicationStatus='C'])"/>
        <xsl:variable name="I" select="count(//record[starts-with(title,'I') and publicationStatus='C'])"/>
        <xsl:variable name="J" select="count(//record[starts-with(title,'J') and publicationStatus='C'])"/>
        <xsl:variable name="K" select="count(//record[starts-with(title,'K') and publicationStatus='C'])"/>
        <xsl:variable name="L" select="count(//record[starts-with(title,'L') and publicationStatus='C'])"/>
        <xsl:variable name="M" select="count(//record[starts-with(title,'M') and publicationStatus='C'])"/>
        <xsl:variable name="N" select="count(//record[starts-with(title,'N') and publicationStatus='C'])"/>
        <xsl:variable name="O" select="count(//record[starts-with(title,'O') and publicationStatus='C'])"/>
        <xsl:variable name="P" select="count(//record[starts-with(title,'P') and publicationStatus='C'])"/>
        <xsl:variable name="Q" select="count(//record[starts-with(title,'Q') and publicationStatus='C'])"/>
        <xsl:variable name="R" select="count(//record[starts-with(title,'R') and publicationStatus='C'])"/>
        <xsl:variable name="S" select="count(//record[starts-with(title,'S') and publicationStatus='C'])"/>
        <xsl:variable name="T" select="count(//record[starts-with(title,'T') and publicationStatus='C'])"/>
        <xsl:variable name="U" select="count(//record[starts-with(title,'U') and publicationStatus='C'])"/>
        <xsl:variable name="V" select="count(//record[starts-with(title,'V') and publicationStatus='C'])"/>
        <xsl:variable name="W" select="count(//record[starts-with(title,'W') and publicationStatus='C'])"/>
        <xsl:variable name="X" select="count(//record[starts-with(title,'X') and publicationStatus='C'])"/>
        <xsl:variable name="Y" select="count(//record[starts-with(title,'Y') and publicationStatus='C'])"/>
        <xsl:variable name="Z" select="count(//record[starts-with(title,'Z') and publicationStatus='C'])"/>
	<journalAlphabeticList>
	<xsl:if test="$A &gt; 0">
		<alphabetic letter="A" total="{$A}" uri="" />
	</xsl:if>
	<xsl:if test="$B &gt; 0">
		<alphabetic letter="B" total="{$B}" uri="" />
	</xsl:if>
	<xsl:if test="$C &gt; 0">
		<alphabetic letter="C" total="{$C}" uri="" />
	</xsl:if>
	<xsl:if test="$D &gt; 0">
		<alphabetic letter="D" total="{$D}" uri="" />
	</xsl:if>
	<xsl:if test="$E &gt; 0">
		<alphabetic letter="E" total="{$E}" uri="" />
	</xsl:if>
	<xsl:if test="$F &gt; 0">
		<alphabetic letter="F" total="{$F}" uri="" />
	</xsl:if>
	<xsl:if test="$G &gt; 0">
		<alphabetic letter="G" total="{$G}" uri="" />
	</xsl:if>
	<xsl:if test="$H &gt; 0">
		<alphabetic letter="H" total="{$H}" uri="" />
	</xsl:if>
	<xsl:if test="$I &gt; 0">
		<alphabetic letter="I" total="{$I}" uri="" />
	</xsl:if>
	<xsl:if test="$J &gt; 0">
		<alphabetic letter="J" total="{$J}" uri="" />
	</xsl:if>
	<xsl:if test="$K &gt; 0">
		<alphabetic letter="K" total="{$K}" uri="" />
	</xsl:if>
	<xsl:if test="$L &gt; 0">
		<alphabetic letter="L" total="{$L}" uri="" />
	</xsl:if>
	<xsl:if test="$M &gt; 0">
		<alphabetic letter="M" total="{$M}" uri="" />
	</xsl:if>
	<xsl:if test="$N &gt; 0">
		<alphabetic letter="N" total="{$N}" uri="" />
	</xsl:if>
	<xsl:if test="$O &gt; 0">
		<alphabetic letter="O" total="{$O}" uri="" />
	</xsl:if>
	<xsl:if test="$P &gt; 0">
		<alphabetic letter="P" total="{$P}" uri="" />
	</xsl:if>
	<xsl:if test="$Q &gt; 0">
		<alphabetic letter="Q" total="{$Q}" uri="" />
	</xsl:if>
	<xsl:if test="$R &gt; 0">
		<alphabetic letter="R" total="{$R}" uri="" />
	</xsl:if>
	<xsl:if test="$S &gt; 0">
		<alphabetic letter="S" total="{$S}" uri="" />
	</xsl:if>
	<xsl:if test="$T &gt; 0">
		<alphabetic letter="T" total="{$T}" uri="" />
	</xsl:if>
	<xsl:if test="$U &gt; 0">
		<alphabetic letter="U" total="{$U}" uri="" />
	</xsl:if>
	<xsl:if test="$V &gt; 0">
		<alphabetic letter="V" total="{$V}" uri="" />
	</xsl:if>
	<xsl:if test="$W &gt; 0">
		<alphabetic letter="W" total="{$W}" uri="" />
	</xsl:if>
	<xsl:if test="$X &gt; 0">
		<alphabetic letter="X" total="{$X}" uri="" />
	</xsl:if>
	<xsl:if test="$Y &gt; 0">
		<alphabetic letter="Y" total="{$Y}" uri="" />
	</xsl:if>
	<xsl:if test="$Z &gt; 0">
		<alphabetic letter="Z" total="{$Z}" uri="" />
	</xsl:if>
	</journalAlphabeticList>
</xsl:template>


</xsl:stylesheet>