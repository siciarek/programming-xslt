<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gray-code="gray-code">

<gray-code:gray-code />
<xsl:variable name="gray-code" select="document('')/*/gray-code:*[1]" />
<xsl:template name="gray-code" match="*[namespace-uri()='gray-code']">
        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="gray-code">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

                <xsl:call-template name="yarg-code">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
     <xsl:template name="yarg-code">
        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="gray-code">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>
 
                <xsl:call-template name="yarg-code">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>

