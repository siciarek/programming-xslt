<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rossler-attractor="rossler-attractor"
    xmlns:rossler="rossler">

    <rossler:rossler />
    <xsl:variable name="rossler" select="document('')/*/rossler:*[1]" />
    <xsl:template name="rossler" match="*[namespace-uri()='rossler']">
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" />

        <xsl:variable name="a" select="0.2" />
        <xsl:variable name="b" select="0.2" />
        <xsl:variable name="c" select="5.7" />

        <xsl:variable name="newx" select="-1.0 * ($y + $z)" />
        <xsl:variable name="newy" select="$x + $a * $y" />
        <xsl:variable name="newz" select="$b + $z * ($x - $c)" />

        <xsl:variable name="nfrm" select="'0.########'" />
        <xsl:value-of select="concat(format-number($newx, $nfrm), ';', format-number($newy, $nfrm), ';', format-number($newz, $nfrm))" />

    </xsl:template>

    <rossler-attractor:rossler-attractor />
    <xsl:variable name="rossler-attractor" select="document('')/*/rossler-attractor:*[1]" />
    <xsl:template name="rossler-attractor" match="*[namespace-uri()='rossler-attractor']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="x0" select="0" />
        <xsl:variable name="y0" select="0" />
        <xsl:variable name="z0" select="0" />

        <xsl:call-template name="do-attractor">
            <xsl:with-param name="n" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="function" select="$rossler" />
            <xsl:with-param name="x" select="$x0" />
            <xsl:with-param name="y" select="$y0" />
            <xsl:with-param name="z" select="$z0" />
            <xsl:with-param name="xoffset" select="$size div 2" />
            <xsl:with-param name="yoffset" select="$size div 2" />
            <xsl:with-param name="xdiv" select="25" />
            <xsl:with-param name="ydiv" select="25" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="do-attractor">
        <xsl:param name="n" />
        <xsl:param name="size" />
        <xsl:param name="function" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" />
        <xsl:param name="xoffset" />
        <xsl:param name="yoffset" />
        <xsl:param name="xdiv" select="1" />
        <xsl:param name="ydiv" select="1" />


        <xsl:if test="$n &gt; 0">


            <xsl:variable name="newpoint">
                <xsl:call-template name="runge-kutta">
                    <xsl:with-param name="function" select="$function" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="z" select="$z" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="newx" select="substring-before($newpoint, ';')" />
            <xsl:variable name="xtail" select="substring-after($newpoint, ';')" />
            <xsl:variable name="newy" select="substring-before($xtail, ';')" />
            <xsl:variable name="newz" select="substring-after($xtail, ';')" />

            <xsl:variable name="xtick" select="$xdiv div $size" />
            <xsl:variable name="ytick" select="$ydiv div $size" />

            <xsl:call-template name="draw-pixel">
                <xsl:with-param name="x" select="format-number($newx div $xtick + $xoffset, '0.##')" />
                <xsl:with-param name="y" select="format-number(-1 * $newy div $ytick + $yoffset, '0.##')" />
            </xsl:call-template>

            <xsl:call-template name="do-attractor">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="function" select="$function" />
                <xsl:with-param name="x" select="$newx" />
                <xsl:with-param name="y" select="$newy" />
                <xsl:with-param name="z" select="$newz" />
                <xsl:with-param name="xoffset" select="$xoffset" />
                <xsl:with-param name="yoffset" select="$yoffset" />
                <xsl:with-param name="xdiv" select="$xdiv" />
                <xsl:with-param name="ydiv" select="$ydiv" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>