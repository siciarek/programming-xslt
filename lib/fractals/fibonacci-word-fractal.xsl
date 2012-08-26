<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fibonacci-word-fractal="fibonacci-word-fractal">

    <fibonacci-word-fractal:fibonacci-word-fractal />
    <xsl:variable name="fibonacci-word-fractal" select="document('')/*/fibonacci-word-fractal:*[1]" />
    <xsl:template name="fibonacci-word-fractal" match="*[namespace-uri()='fibonacci-word-fractal']">
        <xsl:param name="stage" select="0" />
        <xsl:param name="angle" select="90" />

        <xsl:param name="x" select="88" />
        <xsl:param name="y" select="492" />

        <xsl:param name="size" select="2" />
        <xsl:param name="n" select="0" />


        <xsl:variable name="word">
            <xsl:call-template name="fibonacci-word">
                <xsl:with-param name="n" select="$stage" /> <!-- 21 -->
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="logo-path">

            <xsl:call-template name="fibonacci-word-fractal-logo">
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="word" select="$word" />
                <xsl:with-param name="angle" select="$angle" />
            </xsl:call-template>

            <xsl:value-of select="' pd '" />

        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="fibonacci-word-fractal-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>


        <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="x0" select="$x" />
                <xsl:with-param name="y0" select="$y" />
                <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="normalize-space($output)" />

    </xsl:template>

    <xsl:template name="fibonacci-word-fractal-logo-to-offsets">
        <xsl:param name="logo-path" select="''" />
        <xsl:param name="angle" select="0" />

        <xsl:variable name="head" select="substring-before($logo-path, ' pd ')" />
        <xsl:variable name="tail" select="substring-after($logo-path, ' pd ')" />

        <xsl:if test="$tail">

            <xsl:variable name="tmpmove">
                <xsl:choose>
                    <xsl:when test="$head">
                        <xsl:value-of select="$head" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$logo-path" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="move" select="normalize-space(translate(translate($tmpmove, 'rt', ' '), 'fd', ' '))" />
            <xsl:variable name="_angle" select="substring-before($move, ' ')" />
            <xsl:variable name="_length" select="substring-after($move, ' ')" />

            <xsl:variable name="nangle" select="$angle + $_angle" />

            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="$nangle" />
                <xsl:with-param name="base_x" select="0" />
                <xsl:with-param name="base_y" select="0" />
                <xsl:with-param name="point_x" select="0" />
                <xsl:with-param name="point_y" select="-$_length" />
            </xsl:call-template>

            <xsl:value-of select="' '" />

            <xsl:call-template name="fibonacci-word-fractal-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$tail" />
                <xsl:with-param name="angle" select="$nangle" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="fibonacci-word-fractal-logo">
        <xsl:param name="size" />
        <xsl:param name="angle" select="90"/>
        <xsl:param name="word" />
        <xsl:param name="n" select="0" />

        <xsl:if test="$word">
            <xsl:variable name="head" select="substring($word, 1, 1)" />
            <xsl:variable name="tail" select="substring($word, 2)" />

<!-- 
Take the nth digit of a Fibonacci word,
- draw a segment forward
- If the digit is "0" then :
. turn left if "n" is even
. turn right if "n" is odd
and iterate
 -->

            <xsl:variable name="rotation">
                <xsl:choose>
                    <xsl:when test="$n = 0">
                        <xsl:value-of select="$angle" />
                    </xsl:when>
                    <xsl:when test="$head = 0 and ($n mod 2) = 0">
                        <xsl:value-of select="-$angle" />
                    </xsl:when>
                    <xsl:when test="$head = 0 and ($n mod 2) = 1">
                        <xsl:value-of select="$angle" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:value-of select="concat('rt ', $rotation, ' ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />

            <xsl:call-template name="fibonacci-word-fractal-logo">
                <xsl:with-param name="angle" select="$angle" />
                <xsl:with-param name="word" select="$tail" />
                <xsl:with-param name="n" select="$n + 1" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>