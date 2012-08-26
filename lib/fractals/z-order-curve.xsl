<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:z-order-curve="z-order-curve">

    <z-order-curve:z-order-curve />
    <xsl:variable name="z-order-curve" select="document('')/*/z-order-curve:*[1]" />
    <xsl:template name="z-order-curve" match="*[namespace-uri()='z-order-curve']">
		<xsl:param name="stage" select="0" />
		<xsl:param name="x1" select="0" />
		<xsl:param name="y1" select="0" />
		<xsl:param name="x2" select="512" />
		<xsl:param name="y2" select="512" />
		
		<xsl:variable name="delta" select="($x2 - $x1) div 2" />
		
		<xsl:choose>
			<xsl:when test="$stage = 0">
				<xsl:value-of select="concat($x1 + $delta, ',', $y1 + $delta, ' ')" />
			</xsl:when>
			
			<xsl:otherwise>
				
			
				<xsl:call-template name="z-order-curve">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + 0 * $delta" />
					<xsl:with-param name="y1" select="$y1 + 0 * $delta" />
					<xsl:with-param name="x2" select="$x1 + 1 * $delta" />
					<xsl:with-param name="y2" select="$y1 + 1 * $delta" />
				</xsl:call-template>

				<xsl:call-template name="z-order-curve">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + 1 * $delta" />
					<xsl:with-param name="y1" select="$y1 + 0 * $delta" />
					<xsl:with-param name="x2" select="$x1 + 2 * $delta" />
					<xsl:with-param name="y2" select="$y1 + 1 * $delta" />
				</xsl:call-template>

				<xsl:call-template name="z-order-curve">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + 0 * $delta" />
					<xsl:with-param name="y1" select="$y1 + 1 * $delta" />
					<xsl:with-param name="x2" select="$x1 + 1 * $delta" />
					<xsl:with-param name="y2" select="$y1 + 2 * $delta" />
				</xsl:call-template>

				<xsl:call-template name="z-order-curve">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x1" select="$x1 + 1 * $delta" />
					<xsl:with-param name="y1" select="$y1 + 1 * $delta" />
					<xsl:with-param name="x2" select="$x1 + 2 * $delta" />
					<xsl:with-param name="y2" select="$y1 + 2 * $delta" />
				</xsl:call-template>

			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

</xsl:stylesheet>
