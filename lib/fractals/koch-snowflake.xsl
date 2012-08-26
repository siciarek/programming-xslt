<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:koch-snowflake="koch-snowflake"
    xmlns:koch-antisnowflake="koch-antisnowflake">

    <koch-antisnowflake:koch-antisnowflake />
    <xsl:variable name="koch-antisnowflake" select="document('')/*/koch-antisnowflake:*[1]" />
    <xsl:template name="koch-antisnowflake" match="*[namespace-uri()='koch-antisnowflake']">
        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:call-template name="koch-snowflake">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="type" select="'antisnowflake'" />
        </xsl:call-template>
    </xsl:template>

    <koch-snowflake:koch-snowflake />
    <xsl:variable name="koch-snowflake" select="document('')/*/koch-snowflake:*[1]" />
    <xsl:template name="koch-snowflake" match="*[namespace-uri()='koch-snowflake']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="'snowflake'" />

        <xsl:variable name="radius" select="512 div 2.5" />
        <xsl:variable name="cx" select="$size div 2" />
        <xsl:variable name="cy" select="$size div 2" />

        <xsl:variable name="p1">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="60 + 0 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p2">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="60 + 1 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p3">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="60 + 2 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p1x" select="substring-before($p1, ',')" />
        <xsl:variable name="p1y" select="substring-after($p1, ',')" />

        <xsl:variable name="p2x" select="substring-before($p2, ',')" />
        <xsl:variable name="p2y" select="substring-after($p2, ',')" />

        <xsl:variable name="p3x" select="substring-before($p3, ',')" />
        <xsl:variable name="p3y" select="substring-after($p3, ',')" />

        <xsl:variable name="yoffset">
            <xsl:choose>
                <xsl:when test="$type = 'snowflake'">
                    <xsl:value-of select="0" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="($size - $p2y) div 2" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="'M'" />

        <xsl:call-template name="koch-curve">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p1x" />
            <xsl:with-param name="y1" select="$p1y - $yoffset" />
            <xsl:with-param name="x2" select="$p2x" />
            <xsl:with-param name="y2" select="$p2y - $yoffset" />
        </xsl:call-template>

        <xsl:call-template name="koch-curve">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p2x" />
            <xsl:with-param name="y1" select="$p2y - $yoffset" />
            <xsl:with-param name="x2" select="$p3x" />
            <xsl:with-param name="y2" select="$p3y - $yoffset" />
        </xsl:call-template>

        <xsl:call-template name="koch-curve">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p3x" />
            <xsl:with-param name="y1" select="$p3y - $yoffset" />
            <xsl:with-param name="x2" select="$p1x" />
            <xsl:with-param name="y2" select="$p1y - $yoffset" />
        </xsl:call-template>

        <xsl:value-of select="'Z'" />

    </xsl:template>


    <xsl:template name="koch-curve">

        <xsl:param name="stage" />

        <xsl:param name="x1" />
        <xsl:param name="y1" />

        <xsl:param name="x2" />
        <xsl:param name="y2" />

        <xsl:param name="type" select="'snowflake'" />

        <xsl:variable name="direction">
            <xsl:choose>
                <xsl:when test="$type = 'antisnowflake'">
                    <xsl:value-of select="-1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat($x2, ',', $y2, ' ')" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="x-by-3" select="($x2 - $x1) div 3" />
                <xsl:variable name="y-by-3" select="($y2 - $y1) div 3" />

                <xsl:variable name="p1x" select="$x1" />
                <xsl:variable name="p1y" select="$y1" />

                <xsl:variable name="p2x" select="$p1x + $x-by-3" />
                <xsl:variable name="p2y" select="$p1y + $y-by-3" />

                <xsl:variable name="p3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$direction * 120" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p1x" />
                        <xsl:with-param name="point_y" select="$p1y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p3x" select="substring-before($p3, ',')" />
                <xsl:variable name="p3y" select="substring-after($p3, ',')" />

                <xsl:variable name="p4x" select="$p1x + 2 * $x-by-3" />
                <xsl:variable name="p4y" select="$p1y + 2 * $y-by-3" />

                <xsl:variable name="p5x" select="$x2" />
                <xsl:variable name="p5y" select="$y2" />


                <xsl:call-template name="koch-curve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p1x" />
                    <xsl:with-param name="y1" select="$p1y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="koch-curve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p3x" />
                    <xsl:with-param name="y2" select="$p3y" />
                </xsl:call-template>

                <xsl:call-template name="koch-curve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p3x" />
                    <xsl:with-param name="y1" select="$p3y" />
                    <xsl:with-param name="x2" select="$p4x" />
                    <xsl:with-param name="y2" select="$p4y" />
                </xsl:call-template>

                <xsl:call-template name="koch-curve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p4x" />
                    <xsl:with-param name="y1" select="$p4y" />
                    <xsl:with-param name="x2" select="$p5x" />
                    <xsl:with-param name="y2" select="$p5y" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>