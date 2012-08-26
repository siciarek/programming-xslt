<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:turtleTree="turtleTree"
    xmlns:threeBranchesTree="threeBranchesTree">


    <xsl:template name="threeBranchesTree">
        <xsl:param name="stage" select="8" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:variable name="path">
            <xsl:call-template name="goThreeBranchesTree">
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="x" select="$size div 2" />
                <xsl:with-param name="y" select="$size" />
                <xsl:with-param name="a" select="90" />
                <xsl:with-param name="branchRadius" select="$size div 3.5" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>

            <xsl:copy-of select="$path" />
        </xsl:element>

    </xsl:template>

    <xsl:template name="goThreeBranchesTree">
        <xsl:param name="n" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="a" />
        <xsl:param name="branchRadius" />
        <xsl:param name="color" />

        <xsl:variable name="bendAngle" select="15" />
        <xsl:variable name="branchAngle" select="37" />
        <xsl:variable name="branchRatio" select="0.65" />

        <xsl:if test="$n &gt; 0">

            <xsl:variable name="sin_a">
                <xsl:call-template name="sin">
                    <xsl:with-param name="deg" select="$a" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="cos_a">
                <xsl:call-template name="cos">
                    <xsl:with-param name="deg" select="$a" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="cx" select="$x + $cos_a * $branchRadius" />
            <xsl:variable name="cy" select="$y - $sin_a * $branchRadius" />

            <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="$n div 3" /></xsl:attribute>
                <xsl:attribute name="d"><xsl:value-of select="concat('M', $x, ',', $y, ' ', $cx, ',', $cy, 'Z')" /></xsl:attribute>
            </xsl:element>

            <xsl:call-template name="goThreeBranchesTree">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="x" select="$cx" />
                <xsl:with-param name="y" select="$cy" />
                <xsl:with-param name="a" select="$a + $bendAngle - $branchAngle" />
                <xsl:with-param name="branchRadius" select="$branchRadius * $branchRatio" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

            <xsl:call-template name="goThreeBranchesTree">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="x" select="$cx" />
                <xsl:with-param name="y" select="$cy" />
                <xsl:with-param name="a" select="$a + $bendAngle + $branchAngle" />
                <xsl:with-param name="branchRadius" select="$branchRadius * $branchRatio" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

            <xsl:call-template name="goThreeBranchesTree">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="x" select="$cx" />
                <xsl:with-param name="y" select="$cy" />
                <xsl:with-param name="a" select="$a + $bendAngle" />
                <xsl:with-param name="branchRadius" select="$branchRadius * (1 - $branchRatio)" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:if>
    </xsl:template>

    <turtleTree:turtleTree />
    <xsl:variable name="turtleTree" select="document('')/*/turtleTree:*[1]" />
    <xsl:template name="turtleTree" match="*[namespace-uri()='turtleTree']">

        <xsl:param name="stage" select="8" />
        <xsl:param name="angle" select="90" />
        <xsl:param name="line_thickness" select="1" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doTurtleTree">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x1" select="$size div 2" />
                <xsl:with-param name="y1" select="$size" />
                <xsl:with-param name="x2" select="$size div 2" />
                <xsl:with-param name="y2" select="$size - 0.4 * $size" />
                <xsl:with-param name="angle" select="$angle" />
                <xsl:with-param name="line_thickness" select="$line_thickness" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <xsl:template name="doTurtleTree">

        <xsl:param name="stage" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="line_thickness" />
        <xsl:param name="angle" />
        <xsl:param name="color" />

        <xsl:element name="line" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$line_thickness" /></xsl:attribute>
            <xsl:attribute name="shape-rendering">default</xsl:attribute>
            <xsl:attribute name="x1"><xsl:value-of select="$x1" /></xsl:attribute>
            <xsl:attribute name="y1"><xsl:value-of select="$y1" /></xsl:attribute>
            <xsl:attribute name="x2"><xsl:value-of select="$x2" /></xsl:attribute>
            <xsl:attribute name="y2"><xsl:value-of select="$y2" /></xsl:attribute>
        </xsl:element>

        <xsl:if test="$stage &gt; 0">

            <xsl:variable name="xangle" select="180 - $angle div 2" />
            <xsl:variable name="factor" select="0.6" />

            <xsl:variable name="mid_x" select="$x2 - $factor * ($x2 - $x1)" />
            <xsl:variable name="mid_y" select="$y2 - $factor * ($y2 - $y1)" />

            <xsl:variable name="left">
                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="$xangle" />
                    <xsl:with-param name="base_x" select="$x2" />
                    <xsl:with-param name="base_y" select="$y2" />
                    <xsl:with-param name="point_x" select="$mid_x" />
                    <xsl:with-param name="point_y" select="$mid_y" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="left_x">
                <xsl:value-of select="substring-before($left, ',')" />
            </xsl:variable>

            <xsl:variable name="left_y">
                <xsl:value-of select="substring-after($left, ',')" />
            </xsl:variable>


            <xsl:variable name="right">
                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="-1 * $xangle" />
                    <xsl:with-param name="base_x" select="$x2" />
                    <xsl:with-param name="base_y" select="$y2" />
                    <xsl:with-param name="point_x" select="$mid_x" />
                    <xsl:with-param name="point_y" select="$mid_y" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="right_x">
                <xsl:value-of select="substring-before($right, ',')" />
            </xsl:variable>

            <xsl:variable name="right_y">
                <xsl:value-of select="substring-after($right, ',')" />
            </xsl:variable>

            <xsl:call-template name="doTurtleTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$x2" />
                <xsl:with-param name="y1" select="$y2" />
                <xsl:with-param name="x2" select="$left_x" />
                <xsl:with-param name="y2" select="$left_y" />
                <xsl:with-param name="line_thickness" select="$line_thickness" />
                <xsl:with-param name="angle" select="$angle" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

            <xsl:call-template name="doTurtleTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$x2" />
                <xsl:with-param name="y1" select="$y2" />
                <xsl:with-param name="x2" select="$right_x" />
                <xsl:with-param name="y2" select="$right_y" />
                <xsl:with-param name="line_thickness" select="$line_thickness" />
                <xsl:with-param name="angle" select="$angle" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>


</xsl:stylesheet>