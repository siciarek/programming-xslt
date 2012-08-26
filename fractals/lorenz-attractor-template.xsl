<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/strange-attractors/lorenz-attractor.xsl" />

    <xsl:template match="/">
        
        <xsl:variable name="width" select="512" />
        <xsl:variable name="height" select="512" />

        <xsl:variable name="result">
            <xsl:call-template name="lorenz-attractor">
                <xsl:with-param name="stage" select="7000" />
                <xsl:with-param name="projection" select="'x-z'" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="content">

            <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(0, 0, 0)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                <xsl:attribute name="points">
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

