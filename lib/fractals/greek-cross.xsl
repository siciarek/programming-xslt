<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:greek-cross="greek-cross">

    <greek-cross:greek-cross />
    <xsl:variable name="greek-cross" select="document('')/*/greek-cross:*[1]" />
    <xsl:template name="greek-cross" match="*[namespace-uri()='greek-cross']">
		<xsl:param name="stage" select="0" />
		<xsl:param name="x0" select="512 div 2" />
		<xsl:param name="y0" select="512 div 2" />
		<xsl:param name="size" select="512 div 2" />
		
		
		<xsl:choose>
			<xsl:when test="$stage = 0">
				<xsl:value-of select="concat('M', $x0, ',', $y0)" />
                <xsl:value-of select="concat('L', $x0 + $size, ',', $y0)" />
                <xsl:value-of select="concat('L', $x0 - $size, ',', $y0, 'Z')" />
                <xsl:value-of select="concat('L', $x0, ',', $y0 + $size)" />
                <xsl:value-of select="concat('L', $x0, ',', $y0 - $size, 'Z')" />
			</xsl:when>
			
			<xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 2" />

				<xsl:call-template name="greek-cross">
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="x0" select="$x0" />
					<xsl:with-param name="y0" select="$y0 - $nsize" />
					<xsl:with-param name="size" select="$nsize" />
				</xsl:call-template>
 
                <xsl:call-template name="greek-cross">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x0" select="$x0" />
                    <xsl:with-param name="y0" select="$y0 + $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="greek-cross">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x0" select="$x0 + $nsize" />
                    <xsl:with-param name="y0" select="$y0" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="greek-cross">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x0" select="$x0 - $nsize" />
                    <xsl:with-param name="y0" select="$y0" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

</xsl:stylesheet>
