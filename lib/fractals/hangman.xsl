<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hangman="hangman">

    <hangman:hangman />
    <xsl:variable name="hangman" select="document('')/*/hangman:*[1]" />
    <xsl:template name="hangman" match="*[namespace-uri()='hangman']">
        <xsl:param name="stage" select="1" />
        <xsl:param name="size" select="512 - 2 * 52" />
        <xsl:param name="x0" select="52" />
        <xsl:param name="y0" select="512 - 52" />

        <xsl:value-of select="concat('M', $x0, ',', $y0)" />

        <xsl:variable name="path">
            <xsl:call-template name="do-hangman">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="decode-path">
            <xsl:with-param name="path" select="$path" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="hstep">
        <xsl:param name="angle" />
        <xsl:param name="val" />

        <xsl:variable name="sign">
            <xsl:choose>
                <xsl:when test="$angle &lt; 0">
                    <xsl:value-of select="-1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="nangle" select="(($angle * $sign) mod 360)" />

        <xsl:choose>
            <xsl:when test="$nangle = 0">
                <xsl:value-of select="concat('h', -$val)" />
            </xsl:when>
            <xsl:when test="$nangle = 180">
                <xsl:value-of select="concat('h', 1 * $val)" />
            </xsl:when>
            <xsl:when test="$nangle = 90">
                <xsl:value-of select="concat('v', -1 * $sign * $val)" />
            </xsl:when>
            <xsl:when test="$nangle = 270">
                <xsl:value-of select="concat('v', -1 * $val)" />
            </xsl:when>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="decode-path">
        <xsl:param name="path" />
        <xsl:param name="angle" select="180" />

        <xsl:variable name="head" select="substring-before($path, ' ')" />
        <xsl:variable name="tail" select="substring-after($path, ' ')" />

        <xsl:if test="$head">

            <xsl:variable name="nangle">
                <xsl:choose>
                    <xsl:when test="contains($head, 'a')">
                        <xsl:value-of select="normalize-space(translate($head, 'a', ' '))" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="lineto">
                <xsl:choose>
                    <xsl:when test="contains($head, 'l')">
                        <xsl:variable name="val" select="normalize-space(translate($head, 'l', ' '))" />

                        <xsl:call-template name="hstep">
                            <xsl:with-param name="angle" select="$angle" />
                            <xsl:with-param name="val" select="format-number($val,'#.##')" />
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="''" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:value-of select="$lineto" />

            <xsl:call-template name="decode-path">
                <xsl:with-param name="path" select="$tail" />
                <xsl:with-param name="angle" select="$angle + $nangle" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <xsl:template name="do-hangman">

        <xsl:param name="stage" />
        <xsl:param name="size" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:value-of select="concat('l', $size , ' ')" />
                <xsl:value-of select="concat('a', -90, ' ')" />
                <xsl:value-of select="concat('l', $size, ' ')" />

                <xsl:value-of select="concat('l', -1 * $size, ' ')" />
                <xsl:value-of select="concat('a', 90, ' ')" />
                <xsl:value-of select="concat('l', -1 * $size, ' ')" />

            </xsl:when>

            <xsl:otherwise>
                <xsl:variable name="nsize" select="$size div 2" />

                <xsl:call-template name="do-hangman">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="concat('l', $nsize, ' ')" />

                <xsl:call-template name="do-hangman">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="concat('l', $nsize, ' ')" />
                <xsl:value-of select="concat('a', -90, ' ')" />
                <xsl:value-of select="concat('l', $nsize, ' ')" />

                <xsl:call-template name="do-hangman">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="concat('l', -1 * $nsize, ' ')" />
                <xsl:value-of select="concat('a', 90, ' ')" />
                <xsl:value-of select="concat('l', -1 * $nsize , ' ')" />
                <xsl:value-of select="concat('l', -1 * $nsize , ' ')" />

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
