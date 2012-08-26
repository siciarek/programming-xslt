<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:doPythagorasTree="doPythagorasTree"
    xmlns:pythagorasTree="pythagorasTree">

    <pythagorasTree:pythagorasTree />
    <xsl:variable name="pythagorasTree" select="document('')/*/pythagorasTree:*[1]" />
    <xsl:template name="pythagorasTree" match="*[namespace-uri()='pythagorasTree']">

        <xsl:param name="stage" select="12" />
        <xsl:param name="size" select="512 + 128" />
        <xsl:param name="type" select="1" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />


        <xsl:variable name="width" select="$size" />
        <xsl:variable name="height" select="$size - 100" />
        <xsl:variable name="base" select="$width div 7" />

        <xsl:variable name="x1" select="($width div 2) - ($base div 2)" />
        <xsl:variable name="y1" select="$height - $base" />

        <xsl:variable name="x2" select="($width div 2) + ($base div 2)" />
        <xsl:variable name="y2" select="$height - $base" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doPythagorasTree">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="color" select="$color" />
                <xsl:with-param name="x1" select="$x1" />
                <xsl:with-param name="y1" select="$y1" />
                <xsl:with-param name="x2" select="$x2" />
                <xsl:with-param name="y2" select="$y2" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>


    <doPythagorasTree:doPythagorasTree />
    <xsl:variable name="doPythagorasTree" select="document('')/*/doPythagorasTree:*[1]" />
    <xsl:template name="doPythagorasTree" match="*[namespace-uri()='doPythagorasTree']">

        <xsl:param name="stage" />
        <xsl:param name="type" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="color" />

        <xsl:variable name="point_1_prim">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="-90" />
                <xsl:with-param name="base_x" select="$x1" />
                <xsl:with-param name="base_y" select="$y1" />
                <xsl:with-param name="point_x" select="$x2" />
                <xsl:with-param name="point_y" select="$y2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="point_2_prim">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="90" />
                <xsl:with-param name="base_x" select="$x2" />
                <xsl:with-param name="base_y" select="$y2" />
                <xsl:with-param name="point_x" select="$x1" />
                <xsl:with-param name="point_y" select="$y1" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="x1_prim">
            <xsl:value-of select="substring-before($point_1_prim, ',')" />
        </xsl:variable>

        <xsl:variable name="y1_prim">
            <xsl:value-of select="substring-after($point_1_prim, ',')" />
        </xsl:variable>

        <xsl:variable name="x2_prim">
            <xsl:value-of select="substring-before($point_2_prim, ',')" />
        </xsl:variable>

        <xsl:variable name="y2_prim">
            <xsl:value-of select="substring-after($point_2_prim, ',')" />
        </xsl:variable>

        <xsl:variable name="top">

            <xsl:choose>
                <xsl:when test="$type = 1">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="90" />
                        <xsl:with-param name="base_x" select="$x1_prim + ($x2_prim - $x1_prim) div 2" />
                        <xsl:with-param name="base_y" select="$y1_prim + ($y2_prim - $y1_prim) div 2" />
                        <xsl:with-param name="point_x" select="$x1_prim" />
                        <xsl:with-param name="point_y" select="$y1_prim" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="-60" />
                        <xsl:with-param name="base_x" select="$x1_prim" />
                        <xsl:with-param name="base_y" select="$y1_prim" />
                        <xsl:with-param name="point_x" select="$x1_prim + ($x2_prim - $x1_prim) div 2" />
                        <xsl:with-param name="point_y" select="$y1_prim + ($y2_prim - $y1_prim) div 2" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <xsl:variable name="top_x">
            <xsl:value-of select="substring-before($top, ',')" />
        </xsl:variable>

        <xsl:variable name="top_y">
            <xsl:value-of select="substring-after($top, ',')" />
        </xsl:variable>

        <xsl:element name="polygon" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="fill">none</xsl:attribute>
            <xsl:attribute name="stroke-width">1</xsl:attribute>
            <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
            <xsl:attribute name="points">
                <xsl:value-of select="$x1" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y1" />
                <xsl:text> </xsl:text>
                
                <xsl:value-of select="$x2" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y2" />
                <xsl:text> </xsl:text>
                
                <xsl:value-of select="$x2_prim" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y2_prim" />
                <xsl:text> </xsl:text>

                <xsl:value-of select="$x1_prim" />
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y1_prim" />
                <xsl:text> </xsl:text>
            </xsl:attribute>
        </xsl:element>

        <xsl:if test="$stage &gt; 0">

            <xsl:call-template name="doPythagorasTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="color" select="$color" />
                <xsl:with-param name="x1" select="$x1_prim" />
                <xsl:with-param name="y1" select="$y1_prim" />
                <xsl:with-param name="x2" select="$top_x" />
                <xsl:with-param name="y2" select="$top_y" />
            </xsl:call-template>

            <xsl:call-template name="doPythagorasTree">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="color" select="$color" />
                <xsl:with-param name="x1" select="$top_x" />
                <xsl:with-param name="y1" select="$top_y" />
                <xsl:with-param name="x2" select="$x2_prim" />
                <xsl:with-param name="y2" select="$y2_prim" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
