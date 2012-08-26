<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:duffing-map="duffing-map"
    xmlns:duffing-system="duffing-system"
>
 
    <duffing-system:duffing-system />
    <xsl:variable name="duffing-system" select="document('')/*/duffing-system:*[1]" />
    <xsl:template name="duffing-system" match="*[namespace-uri()='duffing-system']">
        <xsl:param name="x" />
        <xsl:param name="y" />

        <xsl:variable name="a" select="2.75" />
        <xsl:variable name="b" select="0.2" />
        
        <xsl:variable name="ycube">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="$y" />
                <xsl:with-param name="exponent" select="3" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="newx" select="$y" />
        <xsl:variable name="newy" select="-$b * $x - $a * $y - $ycube" />

        <xsl:value-of select="concat($newx, ',', $newy)" />

    </xsl:template>


    <duffing-map:duffing-map />
    <xsl:variable name="duffing-map" select="document('')/*/duffing-map:*[1]" />
    <xsl:template name="duffing-map" match="*[namespace-uri()='duffing-map']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="x0" select="0.1" />
        <xsl:variable name="y0" select="0.1" />

        <xsl:call-template name="strange-attractor">
            <xsl:with-param name="n" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="function" select="$duffing-system" />
            <xsl:with-param name="x" select="$x0" />
            <xsl:with-param name="y" select="$y0" />
            <xsl:with-param name="xoffset" select="$size div 2" />
            <xsl:with-param name="yoffset" select="$size div 2" />
            <xsl:with-param name="xdiv" select="1" />
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

            <xsl:value-of select="$newpoint" />
            <xsl:value-of select="'            '" />
            

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