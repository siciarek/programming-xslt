<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:barnsley-fern="barnsley-fern">

    <barnsley-fern:barnsley-fern />
    <xsl:variable name="barnsley-fern" select="document('')/*/barnsley-fern:*[1]" />
    <xsl:template name="barnsley-fern" match="*[namespace-uri()='barnsley-fern']">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="width" />
        <xsl:param name="height" />
        <xsl:param name="seed" />

        <xsl:variable name="xoffset" select="round((2.1818 div (2.6556 + 2.1818)) * $width)" />
        <xsl:variable name="xscale" select="round(($width - $xoffset) div 2.6556)" />
        <xsl:variable name="yscale" select="round($height div 10)" />

        <xsl:variable name="rand" select="substring-before($seed, ' ')" />
        <xsl:variable name="tail" select="substring-after($seed, ' ')" />

        <xsl:variable name="point_x">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 0.01">
                    <xsl:value-of select="0 * $x + 0 * $y + 0" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 0.08">
                    <xsl:value-of select="0.2 * $x - 0.26 * $y + 0" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 0.15">
                    <xsl:value-of select="-0.15 * $x + 0.28 * $y + 0" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0.85 * $x + 0.04 * $y + 0" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="point_y">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 0.01">
                    <xsl:value-of select="0 * $x + 0.16 * $y + 0" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 0.08">
                    <xsl:value-of select="0.23 * $x + 0.22 * $y + 1.6" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 0.15">
                    <xsl:value-of select="0.26 * $x + 0.24 * $y + 0.44" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="-0.04 * $x + 0.85 * $y + 1.6" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="pixel_x" select="round($x * $xscale + $xoffset)" />
        <xsl:variable name="pixel_y" select="$height - round($y * $yscale)" />

        <xsl:call-template name="draw-pixel">
            <xsl:with-param name="x" select="$pixel_x" />
            <xsl:with-param name="y" select="$pixel_y" />
        </xsl:call-template>

        <xsl:if test="$stage &gt; 0 and $tail">
            <xsl:call-template name="barnsley-fern">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x" select="$point_x" />
                <xsl:with-param name="y" select="$point_y" />
                <xsl:with-param name="width" select="$width" />
                <xsl:with-param name="height" select="$height" />
                <xsl:with-param name="seed" select="$tail" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
