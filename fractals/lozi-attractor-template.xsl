<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/strange-attractors/lozi-attractor.xsl" />

    <xsl:template match="/">
        
        <xsl:variable name="width" select="512" />
        <xsl:variable name="height" select="512" />

        <xsl:variable name="result">
            <xsl:call-template name="lozi-attractor">
                <xsl:with-param name="stage" select="19500" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="content">

            <xsl:variable name="x-axis" select="concat('M', 0, ',', $height div 2, ' ', 'L', $width, ',', $height div 2)" />
            <xsl:variable name="y-axis" select="concat('M', $width div 2, ',', 0, ' ', 'L', $width div 2, ',', $height)" />

            <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(200,200,200)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
                <xsl:attribute name="d">
                    <xsl:value-of select="concat($x-axis, $y-axis)" />
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(0, 0, 0)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                <xsl:attribute name="d">
                    <xsl:value-of select="$result" />
                </xsl:attribute>
            </xsl:element>
        </xsl:variable>

        <xsl:call-template name="image">
            <xsl:with-param name="type" select="'raw'" />
            <xsl:with-param name="content" select="$content" />
            <xsl:with-param name="frame" select="0" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

