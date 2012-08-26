<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cantor-square-fractal="cantor-square-fractal">




    <cantor-square-fractal:cantor-square-fractal />
    <xsl:variable name="cantor-square-fractal" select="document('')/*/cantor-square-fractal:*[1]" />
    <xsl:template name="cantor-square-fractal" match="*[namespace-uri()='cantor-square-fractal']">

        <xsl:param name="stage" select="0" />

        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2" />
        <xsl:param name="size" select="512 div 3" />

        <xsl:call-template name="cross">
            <xsl:with-param name="cx" select="$cx" />
            <xsl:with-param name="cy" select="$cy" />
            <xsl:with-param name="width" select="$size" />
            <xsl:with-param name="height" select="$size" />
        </xsl:call-template>

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">

                <xsl:variable name="nsize" select="$size div 3" />

                <xsl:call-template name="cantor-square-fractal">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="$cx - $size" />
                    <xsl:with-param name="cy" select="$cy - $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="cantor-square-fractal">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="$cx + $size" />
                    <xsl:with-param name="cy" select="$cy - $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="cantor-square-fractal">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="$cx - $size" />
                    <xsl:with-param name="cy" select="$cy + $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="cantor-square-fractal">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="$cx + $size" />
                    <xsl:with-param name="cy" select="$cy + $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
 

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
