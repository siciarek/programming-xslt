<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vicsek="vicsek" xmlns:xvicsek="xvicsek">

    <xvicsek:xvicsek />
    <xsl:variable name="xvicsek" select="document('')/*/xvicsek:*[1]" />
    <xsl:template name="xvicsek" match="*[namespace-uri()='xvicsek']">
        <xsl:param name="stage" select="0" />

        <xsl:call-template name="vicsek">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="1" />
        </xsl:call-template>

    </xsl:template>

    <vicsek:vicsek />
    <xsl:variable name="vicsek" select="document('')/*/vicsek:*[1]" />
    <xsl:template name="vicsek" match="*[namespace-uri()='vicsek']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="0" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:value-of select="concat('M', $x, ',', $y)" />
                <xsl:value-of select="concat('L', $x + $size, ',', $y)" />
                <xsl:value-of select="concat('L', $x + $size, ',', $y + $size)" />
                <xsl:value-of select="concat('L', $x, ',', $y + $size)" />
                <xsl:value-of select="'Z'" />

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 3" />

                <!-- TOP ROW: -->
                <xsl:if test="$type = 1">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 0 * $nsize" />
                        <xsl:with-param name="y" select="$y + 0 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$type = 0">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 1 * $nsize" />
                        <xsl:with-param name="y" select="$y + 0 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$type = 1">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 2 * $nsize" />
                        <xsl:with-param name="y" select="$y + 0 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <!-- MID ROW: -->

                <xsl:if test="$type = 0">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 0 * $nsize" />
                        <xsl:with-param name="y" select="$y + 1 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:call-template name="vicsek">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:if test="$type = 0">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 2 * $nsize" />
                        <xsl:with-param name="y" select="$y + 1 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>
            
                <!-- BOTTOM ROW: -->

                <xsl:if test="$type = 1">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 0 * $nsize" />
                        <xsl:with-param name="y" select="$y + 2 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$type = 0">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 1 * $nsize" />
                        <xsl:with-param name="y" select="$y + 2 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$type = 1">
                    <xsl:call-template name="vicsek">
                        <xsl:with-param name="x" select="$x + 2 * $nsize" />
                        <xsl:with-param name="y" select="$y + 2 * $nsize" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="type" select="$type" />
                    </xsl:call-template>
                </xsl:if>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>