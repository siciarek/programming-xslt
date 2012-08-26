<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:power="power">

    <xsl:variable name="power" select="document('')/*/power:*[1]" />
    <xsl:template name="power" match="*[namespace-uri()='power']">

        <xsl:param name="base" />
        <xsl:param name="exponent" />
        <xsl:param name="result" select="1" />

        <xsl:choose>
            <xsl:when test="$exponent &gt; 0">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="$base" />
                    <xsl:with-param name="exponent" select="$exponent - 1" />
                    <xsl:with-param name="result" select="$result * $base" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>

