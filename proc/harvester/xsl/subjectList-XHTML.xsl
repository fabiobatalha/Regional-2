<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

<xsl:param name="lang"/>
<xsl:param name="DIR"/>

<xsl:variable name="labels" select="/root/labels[@lang = $lang]" />
<xsl:variable name="subjectTranslated" select="$labels[@lang = $lang]/general/subjectListName" />
<xsl:variable name="subjectData" select="document('../xml/subjectList.xml')" />

<!--
Criando uma variavel com os assuntos ordenados em por ordem alfabética
-->
	<xsl:variable name="subjectsSorted">
		<subjectList>
		        <xsl:apply-templates select="$subjectTranslated/subject" mode="sortSubjects">
			        <xsl:sort select="title" order="ascending" data-type="text" />
		        </xsl:apply-templates>
		</subjectList>
	</xsl:variable>


	<xsl:template match="*" mode="sortSubjects">
		<xsl:variable name="subjectID">
			<xsl:value-of select="@name" />
		</xsl:variable>
		<subject>
			<name>
				<xsl:value-of select="title" />
			</name>
			<id>
				<xsl:value-of select="$subjectID" />
			</id>
			<total>
				<xsl:value-of select="$subjectData/subjectList/subject[normalize-space(name) = normalize-space($subjectID)]/total" />
			</total>
        	</subject>
	</xsl:template>

	<xsl:template match="subject[name = 'Others']" mode="list"/>

	<xsl:template match="subject[name != 'Others']" mode="list">
	<xsl:if test="total &gt; 0">
		<li>
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="concat($DIR,'/applications/scielo-org/php/secondLevel.php?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter&amp;subject=',normalize-space(id))"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="title">
					<xsl:value-of select="concat(./total,' ')" />
					<xsl:value-of select="$labels/general/journals" />
			</xsl:attribute>
	
			<xsl:value-of select="name" />

		</xsl:element>
		</li>
	</xsl:if>
	</xsl:template>	

        <xsl:template match="a">
                <xsl:copy-of select="$subjectsSorted" />
        </xsl:template>

	<xsl:template match="/">
		<xsl:element name="li">
			<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter">
				<strong>
					<xsl:value-of select="$labels/subjectList/title" />  - <xsl:value-of select="$labels/general/all"/> <!--xsl:value-of select="sum($subjectData//subject/total)"/-->
				</strong>
			</a>
			<ul id="subjects">
				<xsl:apply-templates select="$subjectsSorted/subjectList" mode="list" ></xsl:apply-templates>
				<xsl:if test="$subjectsSorted/subjectList/subject[name='Others']/total &gt; 0">
					<li>
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="concat($DIR,'/applications/scielo-org/php/secondLevel.php?xml=secondLevelForSubjectByLetter&amp;xsl=secondLevelForSubjectByLetter&amp;subject=Others')"></xsl:value-of>
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="concat($subjectsSorted/subjectList/subject[name='Others']/total,' ')" />
								<xsl:value-of select="$labels/general/journals" />
							</xsl:attribute>
							Others
						</xsl:element>
					</li>
				</xsl:if>
			</ul>
		</xsl:element>	
	</xsl:template>

</xsl:stylesheet>
