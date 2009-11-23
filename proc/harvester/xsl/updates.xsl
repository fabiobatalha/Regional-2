<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes"/>
	<!--
parametro que faz o mult-lingüe . . . {pt,en,es}
-->
	<xsl:param name="lang"/>
	<xsl:param name="processDate"/>
        <xsl:param name="DIR"/>

	<xsl:variable name="subjects" select="document('../xml/commonSubjectList.xml')"/>	
	<xsl:variable name="lastIssues" select="document('../xml/lastIssues.xml')"/>
	<xsl:variable name="lastTitles" select="document('../xml/lastTitles.xml')"/>
	<xsl:variable name="labels" select="document('../xml/labels.xml')/root/labels[@lang = $lang]"/>
	<xsl:variable name="count_collections" select="count(//collection)"/>
	<xsl:template match="/">
		<ul>
		<div id="updates">
			<xsl:if test="count(//collection)&gt;0">
				<li><span class="lengthData"><xsl:value-of select="$labels/general/lastUpdate"/> - <xsl:value-of select="substring($processDate,7,2)"/>/<xsl:value-of select="$labels/general/date/months/month[@value=substring($processDate,5,2)]/@name"/>/<xsl:value-of select="substring($processDate,1,4)"/></span></li>
				<xsl:apply-templates select="$lastIssues" mode="totalIssues"/>
				<hr/>				
				<xsl:apply-templates select="$lastTitles" mode="totalTitles"/>
			</xsl:if>
<!--
			<ul>
				<xsl:apply-templates select="$subjects//subject" mode="subjectList"/>
			</ul>
			<hr/>
			<ul>
				<xsl:apply-templates select="//collection" mode="collectionList"/>
			</ul>
-->
		</div>
		</ul>
	</xsl:template>
	
	<xsl:template match="subject" mode="subjectList">
		<xsl:variable name="subject" select="."/>
		<xsl:variable name="totalIssuesFound" select="count($lastIssues//subject[text() = $subject])"/>		
		<xsl:variable name="totalTitlesFound" select="count($lastTitles//subject[text() = $subject])"/>
		<xsl:if test="($totalIssuesFound + $totalTitlesFound) &gt; 0">
		<li>
			<strong><xsl:value-of select="$labels/general/subjectListName/subject[@name = $subject]"/></strong>
			<ul>
				<xsl:if test="$totalIssuesFound &gt; 0">
    	        <li>
	               <span class="lengthData">
            	      <strong><xsl:value-of select="$totalIssuesFound"/> </strong>
        	          <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesBySubject&amp;xsl=secondLevelForLastIssuesBySubject&amp;subject={$subject}">

								<xsl:choose>
									<xsl:when test="$totalIssuesFound &gt; 1">
										<xsl:value-of select="$labels/general/issues"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$labels/general/issue"/>
									</xsl:otherwise>
								</xsl:choose>					  

					  </a></span>
    	        </li>
				</xsl:if>
				<xsl:if test="$totalTitlesFound &gt; 0">								
		            <li>
            		   <span class="lengthData">
        		          <strong><xsl:value-of select="$totalTitlesFound"/> </strong>
    		              <a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsBySubject&amp;xsl=secondLevelForLastJournalsBySubject&amp;subject={$subject}">
						  
								<xsl:choose>
									<xsl:when test="$totalTitlesFound &gt; 1">
										<xsl:value-of select="$labels/general/journals"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$labels/general/journal"/>
									</xsl:otherwise>
								</xsl:choose>
						  
						  </a></span>
		            </li>		
				</xsl:if>
			</ul>			
		</li>
		</xsl:if>		
	</xsl:template>
	
	<xsl:template match="lastIssues" mode="totalIssues">
		<xsl:if test="sum(//total) &gt; 0">
			<span class="lengthData">
				<li><strong><xsl:value-of select="concat(sum(//total),' ')"/></strong>
					<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList">
						<xsl:choose>
							<xsl:when test="sum(//total) &gt; 1">
								<xsl:value-of select="$labels/general/issues"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$labels/general/issue"/>
							</xsl:otherwise>
						</xsl:choose>
					</a>
				</li>
				<li><span><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesBySubject&amp;xsl=secondLevelForLastIssuesBySubject"><xsl:value-of select="$labels/subjectList/title"/></a></span></li>
                                <li><span><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByCollection"><xsl:value-of select="$labels/collectionList/title"/></a></span></li>
			</span>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lastTitles" mode="totalTitles">
		<xsl:if test="sum(//total) &gt; 0">
			<span class="lengthData">
				<li><strong><xsl:value-of select="concat(sum(//total),' ')"/></strong>
					<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByAlphabeticList">
							<xsl:choose>
								<xsl:when test="sum(//total) &gt; 1">
									<xsl:value-of select="$labels/general/journals"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$labels/general/journal"/>
								</xsl:otherwise>
							</xsl:choose>
					</a>
				</li>
				<li><span><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsBySubject&amp;xsl=secondLevelForLastJournalsBySubject"><xsl:value-of select="$labels/subjectList/title"/></a></span></li>
				<li><span><a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByCollection"><xsl:value-of select="$labels/collectionList/title"/></a></span></li>
			</span>
		</xsl:if>
	</xsl:template>
	<xsl:template match="collection" mode="collectionList">
		<xsl:variable name="name" select="normalize-space(name)"/>
		<xsl:variable name="collectionLastIssues" select="$lastIssues/lastIssues/collection[normalize-space(name) = $name]"/>
		<xsl:variable name="collectionLastTitles" select="$lastTitles/lastTitles/collection[normalize-space(name) = $name]"/>
		<xsl:variable name="rangeIssue">
		 <xsl:choose>
			<xsl:when test="$collectionLastIssues/processingDate &gt; $collectionLastIssues/lastDate">
				<xsl:value-of select="$labels/general/issueFrom"/> <xsl:apply-templates select="$collectionLastIssues/lastDate" mode="date"/> <xsl:value-of select="$labels/general/issueTo"/> <xsl:apply-templates select="$collectionLastIssues/processingDate" mode="date"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$labels/general/issueFrom"/> <xsl:apply-templates select="$collectionLastIssues/processingDate" mode="date"/> <xsl:value-of select="$labels/general/issueTo"/> <xsl:apply-templates select="$collectionLastIssues/lastDate" mode="date"/>							
			</xsl:otherwise>
		 </xsl:choose>
		</xsl:variable>
		<xsl:variable name="rangeTitle">
		 <xsl:choose>
			<xsl:when test="$collectionLastTitles/processingDate &gt; $collectionLastTitles/lastDate">
				<xsl:value-of select="$labels/general/titleFrom"/><xsl:apply-templates select="$collectionLastTitles/lastDate" mode="date"/> <xsl:value-of select="$labels/general/titleTo"/> <xsl:apply-templates select="$collectionLastTitles/processingDate" mode="date"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$labels/general/titleFrom"/><xsl:apply-templates select="$collectionLastTitles/processingDate" mode="date"/> <xsl:value-of select="$labels/general/titleTo"/> <xsl:apply-templates select="$collectionLastTitles/lastDate" mode="date"/>							
			</xsl:otherwise>
		 </xsl:choose>
		</xsl:variable>
		<li>
			<xsl:if test="$count_collections&gt;0">
				<strong>
					<xsl:value-of select="$labels/general/collections/collection[@name=$name]"/>
				</strong>
			</xsl:if>
			<ul>
				<xsl:if test="$collectionLastIssues/total &gt; 0">
					<li>
						<span class="lengthData">
							<strong>
								<xsl:value-of select="concat($collectionLastIssues/total,' ')"/>
							</strong>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of select="concat($DIR,'/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastIssuesByAlphabeticList&amp;xsl=secondLevelForLastIssuesByAlphabeticList&amp;instance=',$name)"/></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$rangeIssue"/></xsl:attribute>
								<xsl:choose>
									<xsl:when test="$collectionLastIssues/total &gt; 1">
										<xsl:value-of select="$labels/general/issues"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$labels/general/issue"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</span>
					</li>
				</xsl:if>
				<xsl:if test="$collectionLastTitles/total &gt; 0">
					<li>
						<span class="lengthData">
							<strong>
								<xsl:value-of select="concat(' ',$collectionLastTitles/total,' ')"/>
							</strong>
							<a href="{$DIR}/applications/scielo-org/php/secondLevel.php?xml=secondLevelForLastJournalsByAlphabeticList&amp;xsl=secondLevelForLastJournalsByAlphabeticList&amp;instance={$name}" title="{$rangeTitle}">
								<xsl:choose>
									<xsl:when test="$collectionLastTitles/total &gt; 1">
										<xsl:value-of select="$labels/general/journals"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$labels/general/journal"/>
									</xsl:otherwise>
								</xsl:choose>
							</a>					
						</span>
					</li>
				</xsl:if>
			</ul>
		</li>
	</xsl:template>
	<!--
template que formata a data
-->
	<xsl:template match="processingDate | lastDate" mode="date">
		<xsl:variable name="dateFormat" select="$labels/general/date/format"/>
		<xsl:variable name="dateSeparator" select="$labels/general/date/separator"/>
		<xsl:variable name="dateMonths" select="$labels/general/date/months"/>
		<xsl:variable name="day" select="substring(.,7,2)"/>
		<xsl:variable name="month" select="substring(.,5,2)"/>
		<xsl:variable name="year" select="substring(.,1,4)"/>
		<xsl:choose>
			<xsl:when test="substring($dateFormat,1,1)='d'">
				<xsl:value-of select="$day"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,1,1)='m'">
				<xsl:value-of select="$dateMonths/month[@value=$month]/@name"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,1,1)='y'">
				<xsl:value-of select="$year"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$dateSeparator"/>
		<xsl:choose>
			<xsl:when test="substring($dateFormat,2,1)='d'">
				<xsl:value-of select="$day"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,2,1)='m'">
				<xsl:value-of select="$dateMonths/month[@value=$month]/@name"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,2,1)='y'">
				<xsl:value-of select="$year"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$dateSeparator"/>
		<xsl:choose>
			<xsl:when test="substring($dateFormat,3,1)='d'">
				<xsl:value-of select="$day"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,3,1)='m'">
				<xsl:value-of select="$dateMonths/month[@value=$month]/@name"/>
			</xsl:when>
			<xsl:when test="substring($dateFormat,3,1)='y'">
				<xsl:value-of select="$year"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
