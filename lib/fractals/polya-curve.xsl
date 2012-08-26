<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:polya-curve="polya-curve">

    <polya-curve:polya-curve />
    <xsl:variable name="polya-curve" select="document('')/*/polya-curve:*[1]" />
    <xsl:template name="polya-curve" match="*[namespace-uri()='polya-curve']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="type" select="0" />
		<xsl:param name="x1" select="0 + 52" />
		<xsl:param name="y1" select="512 - 52" />
		<xsl:param name="x2" select="512 - 52" />
		<xsl:param name="y2" select="512 - 52" />
		
		<xsl:if test="$stage = 0">
			<xsl:value-of select="concat($x1, ',', $y1, ' ')" />
			<xsl:value-of select="concat($x2, ',', $y2, ' ')" />
		</xsl:if>
		
		<xsl:if test="$stage &gt; 0">
			<xsl:variable name="xdelta" select="$x2 - $x1" />
			<xsl:variable name="ydelta" select="$y2 - $y1" />
			
			<xsl:variable name="top">
				<xsl:call-template name="protate">
					<xsl:with-param name="angle">
						<xsl:if test="$type = 0">
							<xsl:value-of select="-90" />
						</xsl:if>
						<xsl:if test="$type = 1">
							<xsl:value-of select="90" />
						</xsl:if>
					</xsl:with-param>
					<xsl:with-param name="base_x" select="$x1 + $xdelta div 2" />
					<xsl:with-param name="base_y" select="$y1 + $ydelta div 2" />
					<xsl:with-param name="point_x" select="$x2" />
					<xsl:with-param name="point_y" select="$y2" />
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:variable name="topx" select="substring-before($top, ',')" />
			<xsl:variable name="topy" select="substring-after($top, ',')" />

			<xsl:call-template name="polya-curve">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="($type + 1) mod 2" />
				<xsl:with-param name="x1" select="$topx" />
				<xsl:with-param name="y1" select="$topy" />
				<xsl:with-param name="x2" select="$x2" />
				<xsl:with-param name="y2" select="$y2" />
			</xsl:call-template>
			
			<xsl:call-template name="polya-curve">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="($type + 1) mod 2" />
				<xsl:with-param name="x1" select="$topx" />
				<xsl:with-param name="y1" select="$topy" />
				<xsl:with-param name="x2" select="$x1" />
				<xsl:with-param name="y2" select="$y1" />
			</xsl:call-template>

		</xsl:if>

    </xsl:template>

</xsl:stylesheet>