<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cross-fractal="cross-fractal">

    <cross-fractal:cross-fractal />
    <xsl:variable name="cross-fractal" select="document('')/*/cross-fractal:*[1]" />
    <xsl:template name="cross-fractal" match="*[namespace-uri()='cross-fractal']">

        <xsl:param name="stage" select="0" />

        <xsl:param name="x0" select="512 div 2" />
        <xsl:param name="y0" select="512 div 2" />
        <xsl:param name="size" select="48" />

        <xsl:variable name="logo-path">

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="x0" select="$x0 - $size div 2" />
                <xsl:with-param name="y0" select="$y0 - $size div 2" />
                <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="'M'" />
        <xsl:value-of select="normalize-space($output)" />
        <xsl:value-of select="'Z'" />

    </xsl:template>

    <xsl:template name="side">

        <xsl:param name="stage" />
        <xsl:param name="n" />
        <xsl:param name="size" />

        <xsl:if test="$stage = 0">

            <xsl:value-of select="concat('fd ', $size, ' pd ')" />
            <xsl:value-of select="concat('rt ', 90, ' pd ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />
            <xsl:value-of select="concat('rt ', 90, ' pd ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />

        </xsl:if>

        <xsl:if test="$stage &gt; 0">

            <xsl:variable name="sqrt_5">
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="num" select="5" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:value-of select="concat('fd ', ($n + 2) * ($size - ($size div $sqrt_5)) div 2, ' pd ')" />
            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="size" select="$size div $sqrt_5" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />
            <xsl:value-of select="concat('fd ',($size - ($size div $sqrt_5)) div 2, ' pd ')" />

            <xsl:value-of select="concat('rt ', 90, ' pd ')" />
            <xsl:value-of select="concat('fd ',($size - ($size div $sqrt_5)) div 2, ' pd ')" />

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="size" select="$size div $sqrt_5" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />
            <xsl:value-of select="concat('fd ',($size - ($size div $sqrt_5)) div 2, ' pd ')" />

            <xsl:value-of select="concat('rt ', 90, ' pd ')" />
            <xsl:value-of select="concat('fd ',($size - ($size div $sqrt_5)) div 2, ' pd ')" />

            <xsl:value-of select="concat('rt ', -90, ' pd ')" />

            <xsl:call-template name="side">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="size" select="$size div $sqrt_5" />
            </xsl:call-template>


            <xsl:value-of select="concat('rt ', -90, ' pd ')" />
            <xsl:value-of select="concat('fd ', ($n + 2) * ($size - ($size div $sqrt_5)) div 2, ' pd ')" />

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
