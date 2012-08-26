<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gehman-dendrite="gehman-dendrite">

    <gehman-dendrite:gehman-dendrite />
    <xsl:variable name="gehman-dendrite" select="document('')/*/gehman-dendrite:*[1]" />
    <xsl:template name="gehman-dendrite" match="*[namespace-uri()='gehman-dendrite']">

        <xsl:param name="stage" select="0" />
		<xsl:param name="x0" select="512 div 2" />
		<xsl:param name="y0" select="512 div 4" />
        <xsl:param name="size" select="512 div 4" />

        <xsl:variable name="xl" select="$x0 - $size" />
        <xsl:variable name="yl" select="$y0 + $size" />
 
		<xsl:variable name="xr" select="$x0 + $size" />
        <xsl:variable name="yr" select="$y0 + $size" />

		<xsl:value-of select="concat('M', $xl, ',', $yl, ' ')" />
		<xsl:value-of select="concat(' ', $x0, ',', $y0, ' ')" />
		<xsl:value-of select="concat('L', $xr, ',', $yr, ' ')" />
		
		<xsl:if test="$stage &gt; 0">
			<xsl:call-template name="gehman-dendrite">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$size div 2" />
				<xsl:with-param name="x0" select="$xl" />
				<xsl:with-param name="y0" select="$yl" />
			</xsl:call-template>
			<xsl:call-template name="gehman-dendrite">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$size div 2" />
				<xsl:with-param name="x0" select="$xr" />
				<xsl:with-param name="y0" select="$yr" />
			</xsl:call-template>
		</xsl:if>

    </xsl:template>

</xsl:stylesheet>