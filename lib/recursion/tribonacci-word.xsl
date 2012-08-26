<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tribonacci-word="tribonacci-word">

    <tribonacci-word:tribonacci-word />
    <xsl:variable name="tribonacci-word" select="document('')/*/tribonacci-word:*[1]" />
    <xsl:template name="tribonacci-word" match="*[namespace-uri()='tribonacci-word']">

        <xsl:param name="n" />
        <xsl:param name="result" select="'1'" />

        <xsl:choose>
            <xsl:when test="$n = 0">
                <xsl:value-of select="$result" />
            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="tribonacci-word">
                    <xsl:with-param name="n" select="$n - 1" />
                    <xsl:with-param name="result">
                        <xsl:call-template name="tribonacci-map">
                            <xsl:with-param name="word" select="$result" />
                        </xsl:call-template>
                    </xsl:with-param>
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="tribonacci-map">
        <xsl:param name="word" />

        <xsl:variable name="head" select="substring($word, 1, 1)" />
        <xsl:variable name="tail" select="substring($word, 2)" />
        
        <xsl:choose>
            <xsl:when test="$head = 1">
                <xsl:value-of select="12" />
            </xsl:when>
            <xsl:when test="$head = 2">
                <xsl:value-of select="13" />
            </xsl:when>
            <xsl:when test="$head = 3">
                <xsl:value-of select="1" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''" />
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$tail">
            <xsl:call-template name="tribonacci-map">
                <xsl:with-param name="word" select="$tail" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>



