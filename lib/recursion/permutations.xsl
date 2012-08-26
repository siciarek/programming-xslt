<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:permutations="permutations">

<permutations:permutations />
<xsl:variable name="permutations" select="document('')/*/permutations:*[1]" />
<xsl:template name="permutations" match="*[namespace-uri()='permutations']">

	<xsl:param name="n" />
	<xsl:param name="separator" select="'&#10;'" />
	
	<xsl:variable name="output">
		<xsl:call-template name="generate-permutations">
			<xsl:with-param name="n" select="$n" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:value-of select="translate($output, ',', $separator)" />

</xsl:template>

<xsl:template name="generate-permutations">
	<xsl:param name="n" />
	<xsl:param name="seq" select="'1,'" />
	<xsl:param name="i" select="2" />

	<xsl:choose>
		<xsl:when test="$i &lt;= $n">
			<xsl:variable name="res">
				<xsl:call-template name="sequence">
					<xsl:with-param name="seq" select="$seq" />
					<xsl:with-param name="elem" select="$i" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="generate-permutations">
				<xsl:with-param name="seq" select="$res" />
				<xsl:with-param name="i" select="$i + 1" />
				<xsl:with-param name="n" select="$n" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$seq" />
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>

<xsl:template name="sequence">
	<xsl:param name="seq" />
	<xsl:param name="elem" />
	<xsl:param name="result" />

	<xsl:choose>
		<xsl:when test="$seq">
			
			<xsl:variable name="odd" select="substring-before($seq, ',')" />
			<xsl:variable name="for-even" select="substring-after($seq, ',')" />
			<xsl:variable name="even" select="substring-before($for-even, ',')" />
			<xsl:variable name="tail" select="substring-after($for-even, ',')" />
			
			<xsl:variable name="processed-odd">
				<xsl:call-template name="do-insider">
					<xsl:with-param name="string"  select="$odd" />
					<xsl:with-param name="elem" select="$elem" />
					<xsl:with-param name="direction" select="'rtl'" />
				</xsl:call-template>
			</xsl:variable>

			<xsl:variable name="processed-even">
				<xsl:if test="$even">
					<xsl:call-template name="do-insider">
						<xsl:with-param name="string"  select="$even" />
						<xsl:with-param name="elem" select="$elem" />
						<xsl:with-param name="direction" select="'ltr'" />
					</xsl:call-template>
				</xsl:if>
			</xsl:variable>
			
			<xsl:call-template name="sequence">
				<xsl:with-param name="seq" select="$tail" />
				<xsl:with-param name="elem" select="$elem" />
				<xsl:with-param name="result" select="concat($result, $processed-odd, $processed-even)" />
			</xsl:call-template>
			
		</xsl:when>
		
		<xsl:otherwise>
			<xsl:value-of select="$result" />
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>
	
<xsl:template name="do-insider">
	<xsl:param name="string" select="''" />
	<xsl:param name="elem" select="''" />
	<xsl:param name="result" select="''" />
	<xsl:param name="n" select="0" />
	<xsl:param name="direction" select="''" />
	
	<xsl:if test="$n &lt;= string-length($string) + 1">

		<xsl:variable name="res">
			<xsl:choose>
				<xsl:when test="string($direction) = 'rtl'">
					<xsl:variable name="before" select="substring($string, 1, $n)" />
					<xsl:variable name="after" select="substring($string, $n + 1, string-length($string))" />
					<xsl:value-of select="concat($before, $elem, $after)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="before" select="substring($string, 1, string-length($string) - $n)" />
					<xsl:variable name="after" select="substring($string,  string-length($string) - $n + 1, string-length($string))" />
					<xsl:value-of select="concat($before, $elem, $after)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:call-template name="do-insider">
			<xsl:with-param name="n" select="$n + 1" />
			<xsl:with-param name="elem" select="$elem" />
			<xsl:with-param name="string" select="$string" />
			<xsl:with-param name="result" select="$res" />
			<xsl:with-param name="direction" select="$direction" />
		</xsl:call-template>

		<xsl:if test="$result">
			<xsl:value-of select="concat($result, ',')" />
		</xsl:if>

	</xsl:if>
	
</xsl:template>

</xsl:stylesheet>

