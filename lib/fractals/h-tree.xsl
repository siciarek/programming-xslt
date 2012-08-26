<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:doHTree="doHTree" xmlns:hTree="hTree">

    <hTree:hTree />
    <xsl:variable name="hTree" select="document('')/*/hTree:*[1]" />
    <xsl:template name="hTree" match="*[namespace-uri()='hTree']">

        <xsl:param name="stage" select="6" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doHTree">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x1" select="$size div 3" />
                <xsl:with-param name="y1" select="$size div 2" />
                <xsl:with-param name="x2" select="$size" />
                <xsl:with-param name="y2" select="$size div 2" />
                <xsl:with-param name="line_thickness" select="$stage div 2 + 1" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <doHTree:doHTree />
    <xsl:variable name="doHTree" select="document('')/*/doHTree:*[1]" />
    <xsl:template name="doHTree" match="*[namespace-uri()='doHTree']">

        <xsl:param name="stage" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="line_thickness" />
        <xsl:param name="color" />
        
        <xsl:element name="line" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$line_thickness" /></xsl:attribute>
            <xsl:attribute name="shape-rendering">optimizeSpeed</xsl:attribute>
            <xsl:attribute name="x1"><xsl:value-of select="$x1" /></xsl:attribute>
            <xsl:attribute name="y1"><xsl:value-of select="$y1" /></xsl:attribute>
            <xsl:attribute name="x2"><xsl:value-of select="$x2" /></xsl:attribute>
            <xsl:attribute name="y2"><xsl:value-of select="$y2" /></xsl:attribute>
        </xsl:element>

        <xsl:if test="$stage &gt; 0">
            
            <xsl:variable name="lt" select="$stage div 2 + 0.5" />
            <xsl:variable name="factor" select="0.35" />
            
            <xsl:variable name="left_x1" select="$x1 - ($y2 - $y1) * $factor" />
            <xsl:variable name="left_y1" select="$y1 - ($x2 - $x1) * $factor" />
            <xsl:variable name="left_x2" select="$x1 + ($y2 - $y1) * $factor" />
            <xsl:variable name="left_y2" select="$y1 + ($x2 - $x1) * $factor" />
                                                                      
            <xsl:variable name="right_x1" select="$x1 - ($y1 - $y2) * $factor" />
            <xsl:variable name="right_y1" select="$y1 - ($x1 - $x2) * $factor" />
            <xsl:variable name="right_x2" select="$x1 + ($y1 - $y2) * $factor" />
            <xsl:variable name="right_y2" select="$y1 + ($x1 - $x2) * $factor" />

            <xsl:call-template name="doHTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$right_x1" />
                <xsl:with-param name="y1" select="$right_y1" />
                <xsl:with-param name="x2" select="$right_x2" />
                <xsl:with-param name="y2" select="$right_y2" />
                <xsl:with-param name="line_thickness" select="$lt" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>        

            <xsl:call-template name="doHTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$left_x1" />
                <xsl:with-param name="y1" select="$left_y1" />
                <xsl:with-param name="x2" select="$left_x2" />
                <xsl:with-param name="y2" select="$left_y2" />
                <xsl:with-param name="line_thickness" select="$lt" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>        

            <xsl:call-template name="doHTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$right_x1 + ($x2 - $x1)" />
                <xsl:with-param name="y1" select="$right_y1" />
                <xsl:with-param name="x2" select="$right_x2 + ($x2 - $x1)" />
                <xsl:with-param name="y2" select="$right_y2" />
                <xsl:with-param name="line_thickness" select="$lt" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>        

            <xsl:call-template name="doHTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x1" select="$left_x1 + ($x2 - $x1)" />
                <xsl:with-param name="y1" select="$left_y1" />
                <xsl:with-param name="x2" select="$left_x2 + ($x2 - $x1)" />
                <xsl:with-param name="y2" select="$left_y2" />
                <xsl:with-param name="line_thickness" select="$lt" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>        

        </xsl:if>
        
    </xsl:template>

</xsl:stylesheet>