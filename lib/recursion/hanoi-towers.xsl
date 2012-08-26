<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hanoi-towers="hanoi-towers">

<hanoi-towers:hanoi-towers />
<xsl:variable name="hanoi-towers" select="document('')/*/hanoi-towers:*[1]" />
<xsl:template name="hanoi-towers" match="*[namespace-uri()='hanoi-towers']">

        <xsl:param name="n" select="7" />
        <xsl:param name="from" select="1" />
        <xsl:param name="to" select="2" />
        <xsl:param name="spare" select="3" />

        <xsl:if test="$n &gt; 1">
            <xsl:call-template name="hanoi-towers">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="from" select="$from" />
                <xsl:with-param name="to" select="$spare" />
                <xsl:with-param name="spare" select="$to" />
            </xsl:call-template>
        </xsl:if>

        <xsl:copy-of select="concat($from, '-', $to, '&#10;')" />

        <xsl:if test="$n &gt; 1">
            <xsl:call-template name="hanoi-towers">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="from" select="$spare" />
                <xsl:with-param name="to" select="$to" />
                <xsl:with-param name="spare" select="$from" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>

