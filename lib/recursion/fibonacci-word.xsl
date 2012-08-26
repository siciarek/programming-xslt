<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fibonacci-word="fibonacci-word">

<fibonacci-word:fibonacci-word />
<xsl:variable name="fibonacci-word" select="document('')/*/fibonacci-word:*[1]" />
<xsl:template name="fibonacci-word" match="*[namespace-uri()='fibonacci-word']">

        <xsl:param name="n" select="5" />
        <xsl:param name="prev" select="'1'" />
        <xsl:param name="result" select="'0'" />

        <xsl:choose>
            <xsl:when test="$n = 0">

                <xsl:value-of select="$result" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="fibonacci-word">
                    <xsl:with-param name="n" select="$n - 1" />
                    <xsl:with-param name="prev" select="$result" />
                    <xsl:with-param name="result" select="concat($result, $prev)" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

