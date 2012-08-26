<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:makuchowski-umbrella="makuchowski-umbrella">

    <makuchowski-umbrella:makuchowski-umbrella />
    <xsl:variable name="makuchowski-umbrella" select="document('')/*/makuchowski-umbrella:*[1]" />
    <xsl:template name="makuchowski-umbrella" match="*[namespace-uri()='makuchowski-umbrella']">

        <xsl:param name="stage" select="0" />
		<xsl:param name="x0" select="512 div 2" />
		<xsl:param name="y0" select="0" />
        <xsl:param name="size" select="512 div 2" />

        <xsl:variable name="xl" select="$x0 - $size" />
        <xsl:variable name="yl" select="$y0 + $size" />
 
		<xsl:variable name="xr" select="$x0 + $size" />
        <xsl:variable name="yr" select="$y0 + $size" />

		<xsl:value-of select="concat('M', $xl, ',', $yl, ' ')" />
		<xsl:value-of select="concat($x0, ',', $y0, ' ')" />
		<xsl:value-of select="concat($xr, ',', $yr, 'Z')" />
		<xsl:value-of select="concat('M', $xl + $size, ',', $yl, ' ')" />
		<xsl:value-of select="concat($xl + $size, ',', $yl + $size, ' ')" />
		
		<xsl:if test="$stage &gt; 0">
			<xsl:call-template name="makuchowski-umbrella">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$size div 2" />
				<xsl:with-param name="x0" select="$xl + $size div 2" />
				<xsl:with-param name="y0" select="$yl - $size div 2" />
			</xsl:call-template>
			<xsl:call-template name="makuchowski-umbrella">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$size div 2" />
				<xsl:with-param name="x0" select="$xr - $size div 2" />
				<xsl:with-param name="y0" select="$yr - $size div 2" />
			</xsl:call-template>
		</xsl:if>

    </xsl:template>

</xsl:stylesheet>