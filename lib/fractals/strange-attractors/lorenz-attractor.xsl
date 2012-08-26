<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lorenz-attractor="lorenz-attractor"
    xmlns:lorenz="lorenz">

    <lorenz:lorenz />
    <xsl:variable name="lorenz" select="document('')/*/lorenz:*[1]" />
    <xsl:template name="lorenz" match="*[namespace-uri()='lorenz']">
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" />

        <xsl:variable name="sigma" select="10.0" />
        <xsl:variable name="b" select="8.0 div 3.0" />
        <xsl:variable name="r" select="28.0" />

        <xsl:variable name="newx" select="-$sigma * $x + $sigma * $y" />
        <xsl:variable name="newy" select="-$x * $z + $r * $x - $y" />
        <xsl:variable name="newz" select="$x * $y - $b * $z" />

        <xsl:variable name="nfrm" select="'0.########'" />
        <xsl:value-of select="concat(format-number($newx, $nfrm), ';', format-number($newy, $nfrm), ';', format-number($newz, $nfrm))" />

    </xsl:template>


    <lorenz-attractor:lorenz-attractor />
    <xsl:variable name="lorenz-attractor" select="document('')/*/lorenz-attractor:*[1]" />
    <xsl:template name="lorenz-attractor" match="*[namespace-uri()='lorenz-attractor']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="projection" select="x-z" />

        <xsl:variable name="x0" select="10" />
        <xsl:variable name="y0" select="20" />
        <xsl:variable name="z0" select="30" />

        <xsl:call-template name="do-attractor">
            <xsl:with-param name="n" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="function" select="$lorenz" />
            <xsl:with-param name="projection" select="$projection" />
            <xsl:with-param name="x" select="$x0" />
            <xsl:with-param name="y" select="$y0" />
            <xsl:with-param name="z" select="$z0" />
            <xsl:with-param name="xoffset" select="$size div 2" />
            <xsl:with-param name="yoffset">
                <xsl:if test="$projection = 'x-y'">
                    <xsl:value-of select="$size div 2" />
                </xsl:if>
                <xsl:if test="$projection != 'x-y'">
                    <xsl:value-of select="$size div 1" />
                </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="xdiv" select="50" />
            <xsl:with-param name="ydiv" select="55" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="do-attractor">
        <xsl:param name="n" />
        <xsl:param name="size" />
        <xsl:param name="function" />
        <xsl:param name="projection" select="x-z" />
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

            <xsl:variable name="pointx">
                <xsl:choose>
                    <xsl:when test="substring-before($projection, '-') = 'x'">
                        <xsl:value-of select="$newx" />
                    </xsl:when>
                    <xsl:when test="substring-before($projection, '-') = 'y'">
                        <xsl:value-of select="$newy" />
                    </xsl:when>
                    <xsl:when test="substring-before($projection, '-') = 'z'">
                        <xsl:value-of select="$newz" />
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="pointy">
                <xsl:choose>
                    <xsl:when test="substring-after($projection, '-') = 'x'">
                        <xsl:value-of select="$newx" />
                    </xsl:when>
                    <xsl:when test="substring-after($projection, '-') = 'y'">
                        <xsl:value-of select="$newy" />
                    </xsl:when>
                    <xsl:when test="substring-after($projection, '-') = 'z'">
                        <xsl:value-of select="$newz" />
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="px" select="format-number($pointx div $xtick + $xoffset, '0.##')" />
            <xsl:variable name="py" select="format-number(-1 * $pointy div $ytick + $yoffset, '0.##')" />

            <xsl:value-of select="concat($px, ',', $py, ' ')" />
            
<!--             <xsl:call-template name="draw-pixel"> -->
<!--                 <xsl:with-param name="x" select="$px" /> -->
<!--                 <xsl:with-param name="y" select="$py" /> -->
<!--             </xsl:call-template> -->

            <xsl:call-template name="do-attractor">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="function" select="$function" />
                <xsl:with-param name="projection" select="$projection" />
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