<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="journalLink.xsl"/>
	<xsl:variable name="alphabet_file" select="'../xml/alphabet.xml'"/>
	<xsl:variable name="alphabet" select="document($alphabet_file)"/>
	<xsl:variable name="subjectListSort">
		<xsl:apply-templates select="//record" mode="getSubjectDoList">
			<xsl:sort select="subject"/>
		</xsl:apply-templates>
	</xsl:variable>
	<xsl:variable name="subjectListSorted">
		<xsl:apply-templates select="$subjectListSort//record" mode="getSubjectList"/>
	</xsl:variable>
	<xsl:variable name="collection" select="//collectionList/collection"/>
	<xsl:template match="/">
		<secondLevelForSubjectByLetter>
			<xsl:apply-templates select="$alphabet//letter" mode="alphabet-subject">
				<!--xsl:with-param name="subjectList" select="$subjectListSorted//subject"/-->
			</xsl:apply-templates>
		</secondLevelForSubjectByLetter>
	</xsl:template>
	<xsl:template match="letter" mode="alphabet-subject">
		<!--xsl:param name="collectionName"/-->
		<xsl:variable name="letter" select="."/>
		
		<xsl:variable name="total" select="count($collection//subject[(substring(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter)   and ../publicationStatus='C'])"/>
		<xsl:if test="$total &gt; 0">
			<xsl:element name="subject-order">
				<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:apply-templates select="$subjectListSorted//subject[substring(translate(.,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1)=$letter]" mode="getTitle">
					<xsl:sort select="."/>
				</xsl:apply-templates>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="subject" mode="getTitle">
		<xsl:variable name="subject" select="."/>
		<xsl:element name="subject">
			<xsl:attribute name="uri"/>
			<xsl:attribute name="total"><xsl:value-of select="count($collection//record[subject=$subject  and publicationStatus='C'])"/></xsl:attribute>
			<xsl:element name="name">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:apply-templates select="$collection[.//record[subject=$subject  and publicationStatus='C']]" mode="journalList">
				<xsl:with-param name="subject" select="$subject"/>
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	<xsl:template match="collection" mode="journalList">
		<xsl:param name="subject"/>
		<xsl:variable name="collectionName" select="@name"/>
		<xsl:element name="collection">
			<xsl:attribute name="name"><xsl:value-of select="$collectionName"/></xsl:attribute>
			<xsl:attribute name="total"><xsl:value-of select="count(.//record[subject=$subject and publicationStatus='C'])"/></xsl:attribute>
			
			<xsl:element name="JournalList">
				<xsl:apply-templates select="$alphabet//letter" mode="alphabet">
					<xsl:with-param name="records" select=".//record[subject=$subject and publicationStatus='C']"/>
					
				</xsl:apply-templates>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="*" mode="alphabet">
		<xsl:param name="records"/>
		<!--xsl:param name="collectionName"/-->
		<xsl:variable name="letter" select="."/>
		<xsl:variable name="total" select="count($records[(substring(translate(title,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter)])"/>
		<xsl:if test="$total &gt; 0">
			<xsl:element name="order">
				<xsl:attribute name="by"><xsl:value-of select="$letter"/></xsl:attribute>
				<xsl:attribute name="total"><xsl:value-of select="$total"/></xsl:attribute>
				<xsl:apply-templates select="$records[(substring(translate(title,'ÁÉÍÓÚÂÊÎÔÛÄËÏÖÜÀÈÌÒÙ','AEIOUAEIOUAEIOUAEIOU'),1,1) = $letter)]" mode="getTitles"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="record" mode="getTitles">
		<xsl:apply-templates select="title"/>
	</xsl:template>
	<xsl:template match="record" mode="getSubjectDoList">
		<record>
			<subject collection="{../../@name}">
				<xsl:value-of select="subject"/>
			</subject>
		</record>
	</xsl:template>
	<xsl:template match="record" mode="getSubjectList">
		<!-- Faz distinct -->
		<xsl:variable name="previous" select="preceding-sibling::record[position() = 1]/subject"/>
		<xsl:variable name="current" select="subject"/>
		<xsl:variable name="collection" select="subject/@name"/>
		<xsl:if test="$current != $previous or not($previous)">
			<xsl:copy-of select="subject"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
<!--
<secondLevelForSubjectByCollection>
	<subjectList>
		<subject uri="">
			<name>Associação da Amazônia</name>
			<collection name="Brazil" total="9999">
				<journalList>
					<order by="A" total="9999">
						<journal uri="">Acta Amazonica Brasil</journal>
					</order>
				</journalList>
			</collection>
		</subject>
	</subjectList>
</secondLevelForSubjectByCollection>
-->
