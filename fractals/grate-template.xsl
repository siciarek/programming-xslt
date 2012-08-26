<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/grate.xsl" />

    <xsl:template match="/">

        <xsl:call-template name="image">
            <xsl:with-param name="type" select="'polyline'" />
            <xsl:with-param name="width" select="512" />
            <xsl:with-param name="height" select="512" />
            <xsl:with-param name="content" select="$grate" />
            <xsl:with-param name="stage" select="4" />
            <xsl:with-param name="shape-rendering" select="'crispEdges'" />
            <xsl:with-param name="stroke" select="'rgb(0, 0, 0)'" />
            <xsl:with-param name="stroke-width" select="2" />
            <xsl:with-param name="fill" select="'none'" />
            <xsl:with-param name="frame" select="0" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

