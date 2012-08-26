<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:root="root">

    <root:root />
    <xsl:variable name="root" select="document('')/*/root:*[1]" />
    <xsl:template name="root" match="*[namespace-uri()='root']">

        <xsl:param name="stage" select="0" />
		<xsl:param name="x0" select="52" />
		<xsl:param name="y0" select="52" />
        <xsl:param name="size" select="512 - 2 * 52" />

		<xsl:if test="$stage = 0">
			<xsl:value-of select="concat('M', $x0, ',', $y0, ' ')" />
			<xsl:value-of select="concat(' ', $x0 + $size, ',', $y0, ' ')" />
			<xsl:value-of select="concat('M', $x0 + $size div 2, ',', $y0, ' ')" />
			<xsl:value-of select="concat(' ', $x0 + $size div 2, ',', $y0 + $size, ' ')" />
		</xsl:if>
		
		<xsl:if test="$stage &gt; 0">
		
			<xsl:variable name="nsize" select="$size div 3" />

			<xsl:call-template name="root">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$nsize" />
				<xsl:with-param name="x0" select="$x0" />
				<xsl:with-param name="y0" select="$y0" />
			</xsl:call-template>

			
			<xsl:call-template name="root">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$nsize" />
				<xsl:with-param name="x0" select="$x0 + $nsize" />
				<xsl:with-param name="y0" select="$y0" />
			</xsl:call-template>

			<xsl:call-template name="root">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$nsize" />
				<xsl:with-param name="x0" select="$x0 + $nsize" />
				<xsl:with-param name="y0" select="$y0 + 1 * $nsize" />
			</xsl:call-template>

			<xsl:call-template name="root">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$nsize" />
				<xsl:with-param name="x0" select="$x0 + $nsize" />
				<xsl:with-param name="y0" select="$y0 + 2 * $nsize" />
			</xsl:call-template>

			
			<xsl:call-template name="root">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="size" select="$nsize" />
				<xsl:with-param name="x0" select="$x0 + 2 * $nsize" />
				<xsl:with-param name="y0" select="$y0" />
			</xsl:call-template>

			
			
		</xsl:if>

    </xsl:template>

</xsl:stylesheet>