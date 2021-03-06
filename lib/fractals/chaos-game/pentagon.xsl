<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:chaos-game-pentagon="chaos-game-pentagon">

    <chaos-game-pentagon:chaos-game-pentagon />
    <xsl:variable name="chaos-game-pentagon" select="document('')/*/chaos-game-pentagon:*[1]" />
    <xsl:template name="chaos-game-pentagon" match="*[namespace-uri()='chaos-game-pentagon']">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="width" select="512" />
        <xsl:param name="height" select="512" />
        <xsl:param name="angle" select="72" />
        <xsl:param name="seed" />

        <xsl:variable name="bx" select="$width div 2" />
        <xsl:variable name="by" select="$width div 2 + 22" />

        <xsl:variable name="size" select="$width div 2" />

        <xsl:variable name="v1">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="0 * $angle" />
                <xsl:with-param name="base_x" select="$bx" />
                <xsl:with-param name="base_y" select="$by" />
                <xsl:with-param name="point_x" select="$bx" />
                <xsl:with-param name="point_y" select="$by - $size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="v2">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="1 * $angle" />
                <xsl:with-param name="base_x" select="$bx" />
                <xsl:with-param name="base_y" select="$by" />
                <xsl:with-param name="point_x" select="$bx" />
                <xsl:with-param name="point_y" select="$by - $size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="v3">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="2 * $angle" />
                <xsl:with-param name="base_x" select="$bx" />
                <xsl:with-param name="base_y" select="$by" />
                <xsl:with-param name="point_x" select="$bx" />
                <xsl:with-param name="point_y" select="$by - $size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="v4">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="3 * $angle" />
                <xsl:with-param name="base_x" select="$bx" />
                <xsl:with-param name="base_y" select="$by" />
                <xsl:with-param name="point_x" select="$bx" />
                <xsl:with-param name="point_y" select="$by - $size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="v5">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="4 * $angle" />
                <xsl:with-param name="base_x" select="$bx" />
                <xsl:with-param name="base_y" select="$by" />
                <xsl:with-param name="point_x" select="$bx" />
                <xsl:with-param name="point_y" select="$by - $size" />
            </xsl:call-template>
        </xsl:variable>


        <xsl:variable name="gr">
            <xsl:variable name="sqrt_5">
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="num" select="5" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="(1 + $sqrt_5) div 2" />
        </xsl:variable>


        <xsl:call-template name="do-chaos-game-pentagon">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="seed" select="$seed" />

			<xsl:with-param name="sides" select="5" />
            <xsl:with-param name="a" select="$gr div (1 + $gr)" />

            <xsl:with-param name="x" select="$x" />
            <xsl:with-param name="y" select="$y" />

            <xsl:with-param name="x1" select="substring-before($v1, ',')" />
            <xsl:with-param name="y1" select="substring-after($v1, ',')" />

            <xsl:with-param name="x2" select="substring-before($v2, ',')" />
            <xsl:with-param name="y2" select="substring-after($v2, ',')" />

            <xsl:with-param name="x3" select="substring-before($v3, ',')" />
            <xsl:with-param name="y3" select="substring-after($v3, ',')" />

            <xsl:with-param name="x4" select="substring-before($v4, ',')" />
            <xsl:with-param name="y4" select="substring-after($v4, ',')" />

            <xsl:with-param name="x5" select="substring-before($v5, ',')" />
            <xsl:with-param name="y5" select="substring-after($v5, ',')" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="do-chaos-game-pentagon">

        <xsl:param name="stage" />
        <xsl:param name="sides" />
        <xsl:param name="a" />

<!-- iterated point: -->

        <xsl:param name="x" />
        <xsl:param name="y" />
		
<!-- base pentagon vertices -->

        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="x3" />
        <xsl:param name="y3" />

        <xsl:param name="x4" />
        <xsl:param name="y4" />
        <xsl:param name="x5" />
        <xsl:param name="y5" />

        <xsl:param name="seed" />

        <xsl:variable name="rand" select="substring-before($seed, ' ')" />
        <xsl:variable name="tail" select="substring-after($seed, ' ')" />

        <xsl:variable name="vx">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 1.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$x1" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 2.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$x2" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 3.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$x3" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 4.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$x4" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$x5" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="vy">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 1.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$y1" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 2.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$y2" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 3.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$y3" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 4.0 * (1.0 div 5.0)">
                    <xsl:value-of select="$y4" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$y5" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <xsl:variable name="nx" select="$x + ($vx - $x) * $a" />
        <xsl:variable name="ny" select="$y + ($vy - $y) * $a" />

        <xsl:variable name="pixel_x" select="round($nx)" />
        <xsl:variable name="pixel_y" select="round($ny)" />

        <xsl:call-template name="draw-pixel">
            <xsl:with-param name="x" select="$pixel_x" />
            <xsl:with-param name="y" select="$pixel_y" />
        </xsl:call-template>

        <xsl:if test="$stage &gt; 0 and $tail">
            <xsl:call-template name="do-chaos-game-pentagon">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="seed" select="$tail" />

                <xsl:with-param name="sides" select="$sides" />
                <xsl:with-param name="a" select="$a" />

                <xsl:with-param name="x" select="$nx" />
                <xsl:with-param name="y" select="$ny" />

                <xsl:with-param name="x1" select="$x1" />
                <xsl:with-param name="y1" select="$y1" />

                <xsl:with-param name="x2" select="$x2" />
                <xsl:with-param name="y2" select="$y2" />

                <xsl:with-param name="x3" select="$x3" />
                <xsl:with-param name="y3" select="$y3" />

                <xsl:with-param name="x4" select="$x4" />
                <xsl:with-param name="y4" select="$y4" />

                <xsl:with-param name="x5" select="$x5" />
                <xsl:with-param name="y5" select="$y5" />

            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>