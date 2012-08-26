<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:grate="grate">

    <grate:grate />
    <xsl:variable name="grate" select="document('')/*/grate:*[1]" />
    <xsl:template name="grate" match="*[namespace-uri()='grate']">

        <xsl:param name="stage" />
        <xsl:param name="x0" select="52" />
        <xsl:param name="y0" select="512 - 52" />
        <xsl:param name="size" select="512 - 2 * 52" />


        <xsl:variable name="logo-path">
            <xsl:call-template name="one">
                <xsl:with-param name="n" select="$stage" />
                <xsl:with-param name="a" select="90" />
                <xsl:with-param name="w" select="$size" />
                <xsl:with-param name="h" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
                <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="normalize-space($output)" />

    </xsl:template>

    <xsl:template name="two">
        <xsl:param name="a" />
        <xsl:param name="c" />
        <xsl:param name="w" />

        <xsl:if test="$c &gt; 0">

            <xsl:value-of select="concat('rt ',  $a, ' pd ')" />
            <xsl:value-of select="concat('fd ',   1, ' pd ')" />
            <xsl:value-of select="concat('rt ',  $a, ' pd ')" />
            <xsl:value-of select="concat('fd ',  $w, ' pd ')" />
            <xsl:value-of select="concat('rt ', -$a, ' pd ')" />

            <xsl:if test="$c &gt; 1">
                <xsl:value-of select="concat('fd ',   1, ' pd ')" />
            </xsl:if>

            <xsl:value-of select="concat('rt ', -$a, ' pd ')" />
            <xsl:value-of select="concat('fd ',  $w, ' pd ')" />

            <xsl:call-template name="two">
                <xsl:with-param name="a" select="$a" />
                <xsl:with-param name="c" select="$c - 2" />
                <xsl:with-param name="w" select="$w" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <xsl:template name="one">
        <xsl:param name="n" />
        <xsl:param name="w" />
        <xsl:param name="h" />
        <xsl:param name="a" />

        <xsl:if test="$n = 0">
            <xsl:value-of select="concat('fd ', $w, ' pd ')" />

            <xsl:call-template name="two">
                <xsl:with-param name="a" select="$a" />
                <xsl:with-param name="c" select="$h" />
                <xsl:with-param name="w" select="$w" />
            </xsl:call-template>

        </xsl:if>

        <xsl:if test="$n &gt; 0">
            <xsl:value-of select="concat('rt ', $a, ' pd ')" />

            <xsl:call-template name="one">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="a" select="-$a" />
                <xsl:with-param name="w" select="$h div 4" />
                <xsl:with-param name="h" select="$w" />
            </xsl:call-template>

            <xsl:value-of select="concat('fd ', $h div 8, ' pd ')" />

            <xsl:call-template name="one">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="a" select="$a" />
                <xsl:with-param name="w" select="$h div 4" />
                <xsl:with-param name="h" select="$w" />
            </xsl:call-template>

            <xsl:value-of select="concat('fd ', $h div 8, ' pd ')" />

            <xsl:call-template name="one">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="a" select="-$a" />
                <xsl:with-param name="w" select="$h div 4" />
                <xsl:with-param name="h" select="$w" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -$a, ' pd ')" />
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>