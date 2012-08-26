<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t-square-fractal="t-square-fractal">

    <t-square-fractal:t-square-fractal />
    <xsl:variable name="t-square-fractal" select="document('')/*/t-square-fractal:*[1]" />
    <xsl:template name="t-square-fractal" match="*[namespace-uri()='t-square-fractal']">

        <xsl:param name="stage" select="0" />

        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2" />
        <xsl:param name="size" select="512 div 2" />

        <xsl:variable name="nsize" select="$size div 2" />

        <xsl:value-of select="concat('M', $cx - $size div 2, ',',  $cy - $size div 2)" />
        <xsl:value-of select="concat('h', $size)" />
        <xsl:value-of select="concat('v', $size)" />
        <xsl:value-of select="concat('h', -$size)" />
        <xsl:value-of select="'Z'" />

        <xsl:if test="$stage &gt; 0">

            <xsl:call-template name="t-square-fractal">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="cx" select="$cx - $nsize" />
                <xsl:with-param name="cy" select="$cy - $nsize" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>

            <xsl:call-template name="t-square-fractal">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="cx" select="$cx - $nsize" />
                <xsl:with-param name="cy" select="$cy + $nsize" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>

            <xsl:call-template name="t-square-fractal">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="cx" select="$cx + $nsize" />
                <xsl:with-param name="cy" select="$cy - $nsize" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>

            <xsl:call-template name="t-square-fractal">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="cx" select="$cx + $nsize" />
                <xsl:with-param name="cy" select="$cy + $nsize" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
