<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tree-c="tree-c">


    <tree-c:tree-c />
    <xsl:variable name="tree-c" select="document('')/*/tree-c:*[1]" />
    <xsl:template name="tree-c" match="*[namespace-uri()='tree-c']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="angle" select="24" />
        <xsl:param name="x1" select="512 div 2" />
        <xsl:param name="y1" select="512 - 512 * 0.1" />
        <xsl:param name="x2" select="512 div 2" />
        <xsl:param name="y2" select="512 * 0.5" />

        <xsl:value-of select="concat('M', $x1, ',', $y1)" />
        <xsl:value-of select="concat('L', $x2, ',', $y2)" />

        <xsl:if test="$stage &gt; 0">

            <xsl:variable name="x-div-2" select="($x2 - $x1) div 2" />
            <xsl:variable name="y-div-2" select="($y2 - $y1) div 2" />

            <xsl:variable name="b1">
                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="1 * $angle" />
                    <xsl:with-param name="base_x" select="$x1 + 1 * $x-div-2" />
                    <xsl:with-param name="base_y" select="$y1 + 1 * $y-div-2" />
                    <xsl:with-param name="point_x" select="$x1 + 2 * $x-div-2" />
                    <xsl:with-param name="point_y" select="$y1 + 2 * $y-div-2" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="b1x" select="substring-before($b1, ',')" />
            <xsl:variable name="b1y" select="substring-after($b1, ',')" />

            <xsl:variable name="b2">
                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="-1 * $angle" />
                    <xsl:with-param name="base_x" select="$x1 + 2 * $x-div-2" />
                    <xsl:with-param name="base_y" select="$y1 + 2 * $y-div-2" />
                    <xsl:with-param name="point_x" select="$x1 + 3 * $x-div-2" />
                    <xsl:with-param name="point_y" select="$y1 + 3 * $y-div-2" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="b2x" select="substring-before($b2, ',')" />
            <xsl:variable name="b2y" select="substring-after($b2, ',')" />

            <xsl:variable name="b3">
                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="1 * $angle" />
                    <xsl:with-param name="base_x" select="$x1 + 2 * $x-div-2" />
                    <xsl:with-param name="base_y" select="$y1 + 2 * $y-div-2" />
                    <xsl:with-param name="point_x" select="$x1 + 3 * $x-div-2" />
                    <xsl:with-param name="point_y" select="$y1 + 3 * $y-div-2" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="b3x" select="substring-before($b3, ',')" />
            <xsl:variable name="b3y" select="substring-after($b3, ',')" />

 <!-- BRANCHES: -->

            <xsl:call-template name="tree-c">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$x1 + 1 * $x-div-2" />
                <xsl:with-param name="y1" select="$y1 + 1 * $y-div-2" />
                <xsl:with-param name="x2" select="$b1x" />
                <xsl:with-param name="y2" select="$b1y" />
            </xsl:call-template>

            <xsl:call-template name="tree-c">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$x1 + 2 * $x-div-2" />
                <xsl:with-param name="y1" select="$y1 + 2 * $y-div-2" />
                <xsl:with-param name="x2" select="$b2x" />
                <xsl:with-param name="y2" select="$b2y" />
            </xsl:call-template>

            <xsl:call-template name="tree-c">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$x1 + 2 * $x-div-2" />
                <xsl:with-param name="y1" select="$y1 + 2 * $y-div-2" />
                <xsl:with-param name="x2" select="$b3x" />
                <xsl:with-param name="y2" select="$b3y" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>