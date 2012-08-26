<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wirth-curve="wirth-curve">

    <wirth-curve:wirth-curve />
    <xsl:variable name="wirth-curve" select="document('')/*/wirth-curve:*[1]" />
    <xsl:template name="wirth-curve" match="*[namespace-uri()='wirth-curve']">

        <xsl:param name="stage" />
        <xsl:param name="x0" select="1" />
        <xsl:param name="y0" select="512" />
        <xsl:param name="size" select="512 - 2" />

        <xsl:variable name="side">
            <xsl:variable name="temp">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="2" />
                    <xsl:with-param name="exponent" select="$stage" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="3 * $temp - 1" />
        </xsl:variable>

        <xsl:variable name="nsize" select="format-number($size div $side, '0.##')" />

        <xsl:variable name="logo-path">
            <xsl:call-template name="wc-logo-path">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>

       <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0 - $nsize div 2 - 1" />
                <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="'M'" />
        <xsl:value-of select="normalize-space($output)" />
        <xsl:value-of select="'Z'" />

    </xsl:template>


    <xsl:template name="wc-logo-path">
        <xsl:param name="stage" />
        <xsl:param name="size" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="angle" select="45" />
        </xsl:call-template>

        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />
        <xsl:value-of select="concat('rt ', 90, ' pd ')" />
        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="angle" select="45" />
        </xsl:call-template>

        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />
        <xsl:value-of select="concat('rt ', 90, ' pd ')" />
        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="angle" select="45" />
        </xsl:call-template>

        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />
        <xsl:value-of select="concat('rt ', 90, ' pd ')" />
        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="angle" select="45" />
        </xsl:call-template>

        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />
        <xsl:value-of select="concat('rt ', 90, ' pd ')" />
        <xsl:value-of select="concat('fd ', $size div 2, ' pd ')" />

    </xsl:template>

    <xsl:template name="wi">
        <xsl:param name="st" />
        <xsl:param name="size" />
        <xsl:param name="angle" />

        <xsl:if test="$st = 0">
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />
        </xsl:if>

        <xsl:if test="$st &gt; 0">

            <xsl:value-of select="concat('rt ', $angle, ' pd ')" />

            <xsl:call-template name="iw">
                <xsl:with-param name="st" select="$st" />
                <xsl:with-param name="angle" select="-1 * $angle" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -1 * $angle, ' pd ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />
            <xsl:value-of select="concat('rt ', -1 * $angle, ' pd ')" />

            <xsl:call-template name="iw">
                <xsl:with-param name="st" select="$st" />
                <xsl:with-param name="angle" select="-1 * $angle" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', $angle, ' pd ')" />

        </xsl:if>

    </xsl:template>


    <xsl:template name="iw">
        <xsl:param name="st" />
        <xsl:param name="size" />
        <xsl:param name="angle" />

        <xsl:value-of select="concat('rt ', $angle, ' pd ')" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$st - 1" />
            <xsl:with-param name="angle" select="-1 * $angle" />
            <xsl:with-param name="size" select="$size" />
        </xsl:call-template>

        <xsl:value-of select="concat('fd ', format-number($size div 2, '0.##'), ' pd ')" />
        <xsl:value-of select="concat('rt ', -2 * $angle, ' pd ')" />
        <xsl:value-of select="concat('fd ', format-number($size div 2, '0.##'), ' pd ')" />

        <xsl:call-template name="wi">
            <xsl:with-param name="st" select="$st - 1" />
            <xsl:with-param name="angle" select="-1 * $angle" />
            <xsl:with-param name="size" select="$size" />
        </xsl:call-template>

        <xsl:value-of select="concat('rt ', $angle, ' pd ')" />

    </xsl:template>

</xsl:stylesheet>