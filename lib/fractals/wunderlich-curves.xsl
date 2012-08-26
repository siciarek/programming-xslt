<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wunderlich-curve-1="wunderlich-curve-1">

    <wunderlich-curve-1:wunderlich-curve-1 />
    <xsl:variable name="wunderlich-curve-1" select="document('')/*/wunderlich-curve-1:*[1]" />
    <xsl:template name="wunderlich-curve-1" match="*[namespace-uri()='wunderlich-curve-1']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="type" select="0" />
		<xsl:param name="x" select="0 + 52" />
		<xsl:param name="y" select="512 - 52" />
		<xsl:param name="size" select="(512 - 2 * 52) div 2" />

        <xsl:variable name="nsize">
            <xsl:variable name="temp">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="3" />
                    <xsl:with-param name="exponent" select="$stage" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$size div ($temp - 1)" />
        </xsl:variable>
			
		<xsl:call-template name="do-wunderlich-curve-1">
			<xsl:with-param name="stage" select="$stage" />
			<xsl:with-param name="x" select="0 + 52" />
			<xsl:with-param name="y" select="512 - 52" />
			<xsl:with-param name="size" select="$nsize" />
		</xsl:call-template>

	</xsl:template>

    <xsl:template name="do-wunderlich-curve-1">

        <xsl:param name="stage" select="0" />
        <xsl:param name="type" select="0" />
		<xsl:param name="x" />
		<xsl:param name="y" />
		<xsl:param name="size" />
		
		<xsl:if test="$stage = 0 and $type = 0">
			<xsl:value-of select="concat($x + 0 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y - 0.5 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 0.5 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y - 1 * $size, ' ')" />
		</xsl:if>

		<xsl:if test="$stage = 0 and $type = 1">
			<xsl:value-of select="concat($x + 1 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0.5 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0.5 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 1 * $size, ' ')" />
		</xsl:if>
		
		<xsl:if test="$stage = 0 and $type = 2">
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0.5 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0.5 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 2 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y + 0 * $size, ' ')" />
		</xsl:if>

		<xsl:if test="$stage = 0 and $type = 3">
			<xsl:value-of select="concat($x + 1 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 1 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y - 0.5 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y - 0.5 * $size, ' ')" />
			<xsl:value-of select="concat($x + 1 * $size, ',', $y + 0 * $size, ' ')" />
			<xsl:value-of select="concat($x + 0 * $size, ',', $y + 0 * $size, ' ')" />
		</xsl:if>

		
		<xsl:if test="$stage &gt; 0">
			
			
<!-- LEFT: -->

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="0" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x" />
				<xsl:with-param name="y" select="$y" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="1" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x" />
				<xsl:with-param name="y" select="$y - 1.5 * $stage * $size" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="0" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x" />
				<xsl:with-param name="y" select="$y - 3 * $stage * $size" />
			</xsl:call-template>
	
<!-- MID: -->
<!--
			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="2" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 3 * $size" />
				<xsl:with-param name="y" select="$y - 6 * $size" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="3" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 3 * $size" />
				<xsl:with-param name="y" select="$y - 3 * $size" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="2" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 3 * $size" />
				<xsl:with-param name="y" select="$y" />
			</xsl:call-template>
-->

<!-- RIGHT: -->
<!--
			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="0" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 6 * $size" />
				<xsl:with-param name="y" select="$y" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="1" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 6 * $size" />
				<xsl:with-param name="y" select="$y - 3 * $size" />
			</xsl:call-template>

			<xsl:call-template name="do-wunderlich-curve-1">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="type" select="0" />
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="x" select="$x + 6 * $size" />
				<xsl:with-param name="y" select="$y - 6 * $size" />
			</xsl:call-template>
-->

		</xsl:if>

    </xsl:template>

</xsl:stylesheet>