<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:binary-set="binary-set">

<binary-set:binary-set />
<xsl:variable name="binary-set" select="document('')/*/binary-set:*[1]" />
<xsl:template name="binary-set" match="*[namespace-uri()='binary-set']">

        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="binary-set">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

                <xsl:call-template name="binary-set">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

