<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:devils-staircase="devils-staircase">

    <devils-staircase:devils-staircase />
    <xsl:variable name="devils-staircase" select="document('')/*/devils-staircase:*[1]" />
    <xsl:template name="devils-staircase" match="*[namespace-uri()='devils-staircase']">

        <xsl:param name="stage" select="0" />

        <xsl:param name="x1" select="0 + 52" />
        <xsl:param name="y1" select="512 - 52" />
        <xsl:param name="x2" select="512 - 52" />
        <xsl:param name="y2" select="0 + 52" />

		<xsl:choose>
		
			<xsl:when test="$stage = 0">
				<xsl:value-of select="concat($x1, ',', $y1, ' ')" />
				<xsl:value-of select="concat($x2, ',', $y2, ' ')" />
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:variable name="deltax" select="$x2 - $x1" />
				<xsl:variable name="deltay" select="$y1 - $y2" />

				<xsl:call-template name="devils-staircase">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1" />
					<xsl:with-param name="y1" select="$y1" />
					<xsl:with-param name="x2" select="$x1 + $deltax div 3" />
					<xsl:with-param name="y2" select="$y1 - $deltay div 2" />
				</xsl:call-template>
				<xsl:call-template name="devils-staircase">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + $deltax div 3" />
					<xsl:with-param name="y1" select="$y1 - $deltay div 2" />
					<xsl:with-param name="x2" select="$x1 + 2 * $deltax div 3" />
					<xsl:with-param name="y2" select="$y1 - $deltay div 2" />
				</xsl:call-template>
				<xsl:call-template name="devils-staircase">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + 2 * $deltax div 3" />
					<xsl:with-param name="y1" select="$y1 - $deltay div 2" />
					<xsl:with-param name="x2" select="$x2" />
					<xsl:with-param name="y2" select="$y2" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

    </xsl:template>


</xsl:stylesheet>