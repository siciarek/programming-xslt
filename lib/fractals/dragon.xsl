<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dragonCurve="dragonCurve">

    <dragonCurve:dragonCurve />
    <xsl:variable name="dragonCurve" select="document('')/*/dragonCurve:*[1]" />
    <xsl:template name="dragonCurve" match="*[namespace-uri()='dragonCurve']">

        <xsl:param name="stage" select="13" />
        <xsl:param name="start_x" select="200" />
        <xsl:param name="start_y" select="400" />
        <xsl:param name="size" select="3" />
        <xsl:param name="line_thickness" select="1" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:variable name="path" select="concat($start_x, ',', $start_y + $size, ' ', $start_x, ',', $start_y)" />

        <xsl:variable name="rotated">
            <xsl:call-template name="doDragonCurve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="path" select="$path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="moveto" select="translate(concat('M', substring-before($rotated, ' ')), ',', ' ')" />
        <xsl:variable name="lineto" select="translate(translate(substring-after($rotated, ' '), ' ', 'L'), ',', ' ')" />
        <xsl:variable name="d" select="concat($moveto, ' ', $lineto)" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:element name="path">
                <xsl:attribute name="fill">none</xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="$line_thickness" /></xsl:attribute>
                <xsl:attribute name="shape-rendering">crispEdges</xsl:attribute>

                <xsl:attribute name="d">
                    <xsl:value-of select="$d" />
                </xsl:attribute>
            </xsl:element>
        </xsl:element>

    </xsl:template>


    
    <xsl:template name="doDragonCurve">

        <xsl:param name="stage" />
        <xsl:param name="path" />

        <xsl:variable name="rotated">
            <xsl:call-template name="rotatePath">
                <xsl:with-param name="path" select="$path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage &gt; 0">

                <xsl:call-template name="doDragonCurve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="path" select="$rotated" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$path" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>



</xsl:stylesheet>