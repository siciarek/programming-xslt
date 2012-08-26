<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fractal="fractal">

    <fractal:fractal />
    <xsl:variable name="fractal" select="document('')/*/fractal:*[1]" />
    <xsl:template name="fractal" match="*[namespace-uri()='fractal']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="angle" select="90" />

        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />

        <xsl:param name="size" select="0" />
        <xsl:param name="n" select="0" />

        <xsl:choose>
            <xsl:when test="$stage = 0">

            </xsl:when>

            <xsl:otherwise>

                <xsl:call-template name="fractal">
                    <xsl:with-param name="stage" select="$stage - 1" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>

<!--         <xsl:if test="$stage = 0"> -->
<!--             <xsl:call-template name="fractal"> -->
<!--                 <xsl:with-param name="stage" select="$stage - 1" /> -->
<!--             </xsl:call-template> -->
<!--         </xsl:if> -->

    </xsl:template>

</xsl:stylesheet>