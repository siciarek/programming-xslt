<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:minkowski-island="minkowski-island"
>

    <minkowski-island:minkowski-island />
    <xsl:variable name="minkowski-island" select="document('')/*/minkowski-island:*[1]" />
    <xsl:template name="minkowski-island" match="*[namespace-uri()='minkowski-island']">

        <xsl:param name="stage" select="3" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0, 0, 1)'" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>

            <xsl:call-template name="dominkowski-island">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x" select="0" />
                <xsl:with-param name="y" select="0" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <xsl:template name="dominkowski-island">
        <xsl:param name="stage" select="0" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="size" />
        <xsl:param name="color" />
        <xsl:param name="line_thickness" select="1" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:element name="polygon" xmlns="http://www.w3.org/2000/svg">
                    <xsl:attribute name="fill">none</xsl:attribute>
                    <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                    <xsl:attribute name="stroke-width"><xsl:value-of select="$line_thickness" /></xsl:attribute>
                    <xsl:attribute name="shape-rendering"><xsl:value-of select="'default'" /></xsl:attribute>
                    <xsl:attribute name="points">

                        <xsl:value-of select="$x + $size div 2" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y" />
                        <xsl:text> </xsl:text>
 
                        <xsl:value-of select="$x + $size" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y + $size div 2" />
                        <xsl:text> </xsl:text>
  
                        <xsl:value-of select="$x + $size div 2" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y + $size" />
                        <xsl:text> </xsl:text>

                        <xsl:value-of select="$x" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y + $size div 2" />
                        <xsl:text> </xsl:text>
  
                    </xsl:attribute>
                </xsl:element>

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 3" />

                <!-- TOP ROW: -->

                 <xsl:call-template name="dominkowski-island">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                </xsl:call-template>

                <!-- MID ROW: -->

                <xsl:call-template name="dominkowski-island">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                </xsl:call-template>
 
                <xsl:call-template name="dominkowski-island">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                </xsl:call-template>

                <xsl:call-template name="dominkowski-island">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                </xsl:call-template>

                <!-- BOTTOM ROW: -->

                <xsl:call-template name="dominkowski-island">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                </xsl:call-template>
 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>