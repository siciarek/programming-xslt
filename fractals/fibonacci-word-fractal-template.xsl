<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/recursion/fibonacci-word.xsl" />
    <xsl:include href="../lib/fractals/fibonacci-word-fractal.xsl" />

    <xsl:template match="/">

        <xsl:variable name="content">
            <xsl:call-template name="fibonacci-word-fractal">
                <xsl:with-param name="stage" select="18" />
                <xsl:with-param name="x" select="24" />
                <xsl:with-param name="y" select="24" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="image">
           <xsl:with-param name="type" select="'raw-polyline'" />
            <xsl:with-param name="content" select="$content" />
            <xsl:with-param name="shape-rendering" select="'crispEdges'" />
            <xsl:with-param name="stroke" select="'rgb(0, 0, 0)'" />
            <xsl:with-param name="fill" select="'none'" />
            <xsl:with-param name="frame" select="0" />
        </xsl:call-template>

<!-- STAGE 21: -->

<!-- 
        <xsl:variable name="content">
            <xsl:call-template name="fibonacci-word-fractal">
                <xsl:with-param name="stage" select="21" />
                <xsl:with-param name="x" select="24" />
                <xsl:with-param name="y" select="900 - 3 * 24 + 4" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="image">
            <xsl:with-param name="width" select="1200" />
            <xsl:with-param name="height" select="900 - 2 * 24" />
            <xsl:with-param name="type" select="'raw-polyline'" />
            <xsl:with-param name="content" select="$content" />
            <xsl:with-param name="shape-rendering" select="'crispEdges'" />
            <xsl:with-param name="stroke" select="'rgb(0, 0, 0)'" />
            <xsl:with-param name="fill" select="'none'" />
            <xsl:with-param name="frame" select="0" />
        </xsl:call-template>
-->

    </xsl:template>

</xsl:stylesheet>
