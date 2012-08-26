<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:koch-quadratic-type-2-curve="koch-quadratic-type-2-curve">

    <koch-quadratic-type-2-curve:koch-quadratic-type-2-curve />
    <xsl:variable name="koch-quadratic-type-2-curve" select="document('')/*/koch-quadratic-type-2-curve:*[1]" />
    <xsl:template name="koch-quadratic-type-2-curve" match="*[namespace-uri()='koch-quadratic-type-2-curve']">
        <xsl:param name="stage" select="0" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="512 div 2" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="logo-path">
            <xsl:value-of select="'rt 90 '" />

            <xsl:call-template name="kqt2c-logo">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:value-of select="' pd '" />

        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="kqt2c-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="generateCurve">
            <xsl:with-param name="x0" select="$x" />
            <xsl:with-param name="y0" select="$y" />
            <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="kqt2c-logo-to-offsets">
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

            <xsl:call-template name="kqt2c-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$tail" />
                <xsl:with-param name="angle" select="$nangle" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="kqt2c-logo">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:choose>
            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('fd ', $size, ' pd ')" />
            </xsl:when>
            <xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 4" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt -90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt 90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt 90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt 0 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt -90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt -90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:value-of select="'rt 90 '" />

                <xsl:call-template name="kqt2c-logo">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
