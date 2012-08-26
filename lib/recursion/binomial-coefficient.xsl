<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:binomial-coefficient="binomial-coefficient">

    <binomial-coefficient:binomial-coefficient />
    <xsl:variable name="binomial-coefficient" select="document('')/*/binomial-coefficient:*[1]" />
    <xsl:template name="binomial-coefficient" match="*[namespace-uri()='binomial-coefficient']">

        <xsl:param name="n" />
        <xsl:param name="k" />

        <xsl:variable name="n_f">
            <xsl:call-template name="factorial">
                <xsl:with-param name="n" select="$n" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="k_f">
            <xsl:call-template name="factorial">
                <xsl:with-param name="n" select="$k" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="n_k_f">
            <xsl:call-template name="factorial">
                <xsl:with-param name="n" select="$n - $k" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$n_f div ($k_f * $n_k_f)" />

    </xsl:template>

</xsl:stylesheet>