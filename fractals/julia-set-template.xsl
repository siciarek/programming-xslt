<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/julia-mandelbrot-set.xsl" />

    <xsl:template match="/">

        <xsl:variable name="content">
            <xsl:call-template name="julia-mandelbrot-set">
                <xsl:with-param name="type" select="'julia'" />
                <xsl:with-param name="stage" select="20" />
                <xsl:with-param name="border" select="0" />
                <xsl:with-param name="cols" select="140" />
                <xsl:with-param name="rows" select="140" />

                <xsl:with-param name="c" select="'-1,0'" />
<!-- Dendrite:      -->
<!--                 <xsl:with-param name="c" select="'0,1'" /> -->
<!-- Douady rabbit: -->
<!--                 <xsl:with-param name="c" select="'−0,123,0.745'" /> -->
                
<!--                 <xsl:with-param name="c" select="'-1.125,0.25'" /> -->
            </xsl:call-template>


        </xsl:variable>

        <xsl:call-template name="image">
            <xsl:with-param name="type" select="'raw-path'" />
            <xsl:with-param name="content" select="$content" />
            <xsl:with-param name="shape-rendering" select="'crispEdges'" />
            <xsl:with-param name="stroke" select="'rgb(0, 0, 0)'" />
            <xsl:with-param name="stroke-width" select="1" />
            <xsl:with-param name="fill" select="'none'" />
            <xsl:with-param name="frame" select="0" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>


