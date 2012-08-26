<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:minkowski-sausage="minkowski-sausage">

    <minkowski-sausage:minkowski-sausage />
    <xsl:variable name="minkowski-sausage" select="document('')/*/minkowski-sausage:*[1]" />
    <xsl:template name="minkowski-sausage" match="*[namespace-uri()='minkowski-sausage']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:param name="type" select="'square'" />

        <xsl:variable name="p1x" select="$size div 4" />
        <xsl:variable name="p1y" select="$size div 4" />

        <xsl:variable name="p2x" select="$size - $size div 4" />
        <xsl:variable name="p2y" select="$size div 4" />

        <xsl:variable name="p3x" select="$size - $size div 4" />
        <xsl:variable name="p3y" select="$size - $size div 4" />

        <xsl:variable name="p4x" select="$size div 4" />
        <xsl:variable name="p4y" select="$size - $size div 4" />

        <xsl:call-template name="minkowski-sausage-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p1x" />
            <xsl:with-param name="y1" select="$p1y" />
            <xsl:with-param name="x2" select="$p2x" />
            <xsl:with-param name="y2" select="$p2y" />
        </xsl:call-template>

        <xsl:call-template name="minkowski-sausage-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p2x" />
            <xsl:with-param name="y1" select="$p2y" />
            <xsl:with-param name="x2" select="$p3x" />
            <xsl:with-param name="y2" select="$p3y" />
        </xsl:call-template>

        <xsl:call-template name="minkowski-sausage-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p3x" />
            <xsl:with-param name="y1" select="$p3y" />
            <xsl:with-param name="x2" select="$p4x" />
            <xsl:with-param name="y2" select="$p4y" />
        </xsl:call-template>

        <xsl:call-template name="minkowski-sausage-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p4x" />
            <xsl:with-param name="y1" select="$p4y" />
            <xsl:with-param name="x2" select="$p1x" />
            <xsl:with-param name="y2" select="$p1y" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="minkowski-sausage-square-motif">

        <xsl:param name="stage" />

        <xsl:param name="x1" />
        <xsl:param name="y1" />

        <xsl:param name="x2" />
        <xsl:param name="y2" />

        <xsl:param name="type" select="'square'" />

        <xsl:variable name="direction">
            <xsl:choose>
                <xsl:when test="$type = 'antisquare'">
                    <xsl:value-of select="-1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('M', $x1, ',', $y1)" />
                <xsl:value-of select="concat('L', $x2, ',', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="sqrt_5">
                    <xsl:call-template name="sqrt">
                        <xsl:with-param name="num" select="5" />
                    </xsl:call-template>
                </xsl:variable>
 
                <xsl:variable name="x-by-a" select="($x2 - $x1) * (1 div $sqrt_5)" />
                <xsl:variable name="y-by-a" select="($y2 - $y1) * (1 div $sqrt_5)" />

                <xsl:variable name="p1x" select="$x1" />
                <xsl:variable name="p1y" select="$y1" />

                <xsl:variable name="p2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="26" />
                        <xsl:with-param name="base_x" select="$p1x" />
                        <xsl:with-param name="base_y" select="$p1y" />
                        <xsl:with-param name="point_x" select="$p1x + $x-by-a" />
                        <xsl:with-param name="point_y" select="$p1y + $y-by-a" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p2x" select="substring-before($p2, ',')" />
                <xsl:variable name="p2y" select="substring-after($p2, ',')" />

                <xsl:variable name="p3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="90" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p1x" />
                        <xsl:with-param name="point_y" select="$p1y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p3x" select="substring-before($p3, ',')" />
                <xsl:variable name="p3y" select="substring-after($p3, ',')" />

                <xsl:variable name="p4x" select="$x2" />
                <xsl:variable name="p4y" select="$y2" />


                <xsl:call-template name="minkowski-sausage-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p1x" />
                    <xsl:with-param name="y1" select="$p1y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="minkowski-sausage-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p3x" />
                    <xsl:with-param name="y2" select="$p3y" />
                </xsl:call-template>

                <xsl:call-template name="minkowski-sausage-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p3x" />
                    <xsl:with-param name="y1" select="$p3y" />
                    <xsl:with-param name="x2" select="$p4x" />
                    <xsl:with-param name="y2" select="$p4y" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>