<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pascals-triangle="pascals-triangle">

    <pascals-triangle:pascals-triangle />
    <xsl:variable name="pascals-triangle" select="document('')/*/pascals-triangle:*[1]" />
    <xsl:template name="pascals-triangle" match="*[namespace-uri()='pascals-triangle']">

        <xsl:param name="n" select="9" />

        <xsl:if test="$n &gt; 0">
            <xsl:call-template name="pascals-triangle">
                <xsl:with-param name="n" select="$n - 1" />
            </xsl:call-template>
        </xsl:if>

        <xsl:call-template name="pascals-triangle-row">
            <xsl:with-param name="n" select="$n" />
        </xsl:call-template>

        <xsl:value-of select="'&#10;'" />

    </xsl:template>

    <xsl:template name="pascals-triangle-row">
        <xsl:param name="n" />
        <xsl:param name="k" select="0" />

        <xsl:call-template name="binomial-coefficient">
            <xsl:with-param name="n" select="$n" />
            <xsl:with-param name="k" select="$k" />
        </xsl:call-template>

        <xsl:value-of select="concat('', '&#09;')" />

        <xsl:if test="$k &lt; $n">
            <xsl:call-template name="pascals-triangle-row">
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="k" select="$k + 1" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>


</xsl:stylesheet>

