<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/blancmange-curve.xsl" />

    <xsl:template match="/">

        <xsl:variable name="result">
            <xsl:call-template name="blancmange-curve">
                <xsl:with-param name="stage" select="3" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="content">
            
            <xsl:variable name="blanc-line" select="substring-before($result, ';')" />
            
            <xsl:variable name="tail1" select="substring-after($result, ';')" />
            <xsl:variable name="saw-line" select="substring-before($tail1, ';')" />
            
            <xsl:variable name="tail2" select="substring-after($tail1, ';')" />
            <xsl:variable name="prev-blanc-line" select="substring-before($tail2, ';')" />
        
            <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(180,180,180)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                <xsl:attribute name="points">
                    <xsl:value-of select="$prev-blanc-line" />
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(0, 0, 0)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                <xsl:attribute name="points">
                    <xsl:value-of select="$blanc-line" />
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(255, 0, 0)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                <xsl:attribute name="points">
                    <xsl:value-of select="$saw-line" />
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

