<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hexaflake="hexaflake" xmlns:hexaflakec="hexaflakec">

    <hexaflakec:hexaflakec />
    <xsl:variable name="hexaflakec" select="document('')/*/hexaflakec:*[1]" />
    <xsl:template name="hexaflakec" match="*[namespace-uri()='hexaflakec']">
        <xsl:param name="stage" select="3" />
        
        <xsl:call-template name="hexaflake">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="center" select="1" />
        </xsl:call-template>
    </xsl:template>


    <hexaflake:hexaflake />
    <xsl:variable name="hexaflake" select="document('')/*/hexaflake:*[1]" />
    <xsl:template name="hexaflake" match="*[namespace-uri()='hexaflake']">
        <xsl:param name="stage" select="3" />
        <xsl:param name="size" select="512" />
        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2" />
        <xsl:param name="center" select="0" />

        <xsl:choose>
            <xsl:when test="$stage = 0">

                <xsl:variable name="first-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:variable name="second-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="60" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:variable name="third-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="120" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:variable name="fourth-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="180" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:variable name="fifth-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="240" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:variable name="sixth-point">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="300" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $size div 2" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:value-of select="concat('M', $first-point, $second-point, $third-point, $fourth-point, $fifth-point, $sixth-point, 'Z')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="nsize" select="$size div 3" />

                <!-- LEFT: -->

                <xsl:variable name="left-top">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="-60" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $nsize" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="substring-before($left-top, ',')" />
                    <xsl:with-param name="cy" select="substring-after($left-top, ',')" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:variable name="left-bottom">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="-120" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $nsize" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="substring-before($left-bottom, ',')" />
                    <xsl:with-param name="cy" select="substring-after($left-bottom, ',')" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <!-- MIDDLE: -->

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="$cx" />
                    <xsl:with-param name="cy" select="$cy - $nsize" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:if test="$center = 1">
                    <xsl:call-template name="hexaflake">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="size" select="$nsize" />
                        <xsl:with-param name="cx" select="$cx" />
                        <xsl:with-param name="cy" select="$cy" />
                        <xsl:with-param name="center" select="$center" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="$cx" />
                    <xsl:with-param name="cy" select="$cy + $nsize" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <!-- RIGHT: -->

                <xsl:variable name="right-top">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="60" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $nsize" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="substring-before($right-top, ',')" />
                    <xsl:with-param name="cy" select="substring-after($right-top, ',')" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:variable name="right-bottom">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="120" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$cy - $nsize" />
                    </xsl:call-template>
                    <xsl:value-of select="' '" />
                </xsl:variable>

                <xsl:call-template name="hexaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="cx" select="substring-before($right-bottom, ',')" />
                    <xsl:with-param name="cy" select="substring-after($right-bottom, ',')" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
