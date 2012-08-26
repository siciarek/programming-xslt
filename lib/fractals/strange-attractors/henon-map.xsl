<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:henon-map="henon-map" xmlns:henon="henon"
    xmlns:henon-attractor="henon-attractor" xmlns:quadratic-attractor="quadratic-attractor"
>

    <quadratic-attractor:quadratic-attractor />
    <xsl:variable name="quadratic-attractor" select="document('')/*/quadratic-attractor:*[1]" />
    <xsl:template name="quadratic-attractor" match="*[namespace-uri()='quadratic-attractor']">
        <xsl:param name="x" />
        <xsl:param name="y" />

        <xsl:param name="a" select="0" />
        <xsl:param name="b" select="0" />
        <xsl:param name="c" select="0" />
        <xsl:param name="d" select="0" />
        <xsl:param name="e" select="0" />
        <xsl:param name="f" select="0" />

        <xsl:param name="g" select="0" />
        <xsl:param name="h" select="0" />
        <xsl:param name="i" select="0" />
        <xsl:param name="j" select="0" />
        <xsl:param name="k" select="0" />
        <xsl:param name="l" select="0" />

        <xsl:variable name="xsquare">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="$x" />
                <xsl:with-param name="exponent" select="2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="ysquare">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="$y" />
                <xsl:with-param name="exponent" select="2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="newx" select="$a * $xsquare + $b * $x * $y + $c * $ysquare + $d * $x + $e * $y + $f" />
        <xsl:variable name="newy" select="$g * $xsquare + $h * $x * $y + $i * $ysquare + $j * $x + $k * $y + $l" />

        <xsl:value-of select="concat($newx, ',', $newy)" />
    </xsl:template>

    <henon-attractor:henon-attractor />
    <xsl:variable name="henon-attractor" select="document('')/*/henon-attractor:*[1]" />
    <xsl:template name="henon-attractor" match="*[namespace-uri()='henon-attractor']">
        <xsl:param name="x" />
        <xsl:param name="y" />

        <xsl:call-template name="quadratic-attractor">
            <xsl:with-param name="x" select="$x" />
            <xsl:with-param name="y" select="$y" />
            <xsl:with-param name="n" select="0" />

            <xsl:with-param name="a" select="-1.4" />
            <xsl:with-param name="b" select="0" />
            <xsl:with-param name="c" select="0" />
            <xsl:with-param name="d" select="0" />
            <xsl:with-param name="e" select="1" />
            <xsl:with-param name="f" select="1" />

            <xsl:with-param name="g" select="0" />
            <xsl:with-param name="h" select="0" />
            <xsl:with-param name="i" select="0" />
            <xsl:with-param name="j" select="0.3" />
            <xsl:with-param name="k" select="0" />
            <xsl:with-param name="l" select="0" />
        </xsl:call-template>

    </xsl:template>


    <henon-map:henon-map />
    <xsl:variable name="henon-map" select="document('')/*/henon-map:*[1]" />
    <xsl:template name="henon-map" match="*[namespace-uri()='henon-map']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="x0" select="0" />
        <xsl:variable name="y0" select="0" />

        <xsl:call-template name="strange-attractor">
            <xsl:with-param name="n" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="function" select="$henon-attractor" />
            <xsl:with-param name="x" select="$x0" />
            <xsl:with-param name="y" select="$y0" />
            <xsl:with-param name="xoffset" select="$size div 2" />
            <xsl:with-param name="yoffset" select="$size div 2" />
            <xsl:with-param name="xdiv" select="4" />
            <xsl:with-param name="ydiv" select="1" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="strange-attractor">
        <xsl:param name="n" />
        <xsl:param name="size" />
        <xsl:param name="function" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="xoffset" />
        <xsl:param name="yoffset" />
        <xsl:param name="xdiv" select="1" />
        <xsl:param name="ydiv" select="1" />


        <xsl:if test="$n &gt; 0">

            <xsl:variable name="xtick" select="$xdiv div $size" />
            <xsl:variable name="ytick" select="$ydiv div $size" />

            <xsl:variable name="newpoint">
                <xsl:apply-templates select="$function">
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="n" select="$n" />
                </xsl:apply-templates>
            </xsl:variable>


            <xsl:variable name="newx" select="substring-before($newpoint, ',')" />
            <xsl:variable name="newy" select="substring-after($newpoint, ',')" />

            <xsl:call-template name="draw-pixel">
                <xsl:with-param name="x" select="format-number($newx div $xtick + $xoffset, '0.##')" />
                <xsl:with-param name="y" select="format-number(-1 * $newy div $ytick + $yoffset, '0.##')" />
            </xsl:call-template>

            <xsl:call-template name="strange-attractor">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="function" select="$function" />
                <xsl:with-param name="x" select="$newx" />
                <xsl:with-param name="y" select="$newy" />
                <xsl:with-param name="xoffset" select="$xoffset" />
                <xsl:with-param name="yoffset" select="$yoffset" />
                <xsl:with-param name="xdiv" select="$xdiv" />
                <xsl:with-param name="ydiv" select="$ydiv" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>