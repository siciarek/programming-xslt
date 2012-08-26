<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:star-fractal-2="star-fractal-2"
    xmlns:star-fractal-1="star-fractal-1">

    <star-fractal-1:star-fractal-1 />
    <xsl:variable name="star-fractal-1" select="document('')/*/star-fractal-1:*[1]" />
    <xsl:template name="star-fractal-1" match="*[namespace-uri()='star-fractal-1']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2 - 11" />
        <xsl:param name="radius" select="512 div 4.3" />
        <xsl:param name="type" select="1" />
        <xsl:param name="arm" select="-1" />


        <xsl:call-template name="pentagram">
            <xsl:with-param name="cx" select="$cx" />
            <xsl:with-param name="cy" select="$cy" />
            <xsl:with-param name="radius" select="$radius" />
            <xsl:with-param name="type" select="$type" />
        </xsl:call-template>

        <xsl:variable name="angle" select="72" />

        <xsl:choose>
            <xsl:when test="$stage = 0">
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nradius" select="$radius div 2.73" />
                <xsl:variable name="ntype" select="($type + 1) mod 2" />

                <xsl:variable name="ny">
                    <xsl:choose>
                        <xsl:when test="$type = 1">
                            <xsl:value-of select="$cy + ($radius + $nradius)" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$cy - ($radius + $nradius)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="p_1">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="1 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="2 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_4">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="3 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_5">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="4 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

<!-- CCCCCCCCCCC -->

                <xsl:if test="$arm != 0">
                    <xsl:call-template name="star-fractal-1">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="cx" select="substring-before($p_1,',')" />
                        <xsl:with-param name="cy" select="substring-after($p_1,',')" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="type" select="$ntype" />
                        <xsl:with-param name="arm" select="0" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$arm != 1">
                    <xsl:call-template name="star-fractal-1">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="cx" select="substring-before($p_2,',')" />
                        <xsl:with-param name="cy" select="substring-after($p_2,',')" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="type" select="$ntype" />
                        <xsl:with-param name="arm" select="1" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$arm != 2">
                    <xsl:call-template name="star-fractal-1">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="cx" select="substring-before($p_3,',')" />
                        <xsl:with-param name="cy" select="substring-after($p_3,',')" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="type" select="$ntype" />
                        <xsl:with-param name="arm" select="2" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$arm != 3">
                    <xsl:call-template name="star-fractal-1">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="cx" select="substring-before($p_4,',')" />
                        <xsl:with-param name="cy" select="substring-after($p_4,',')" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="type" select="$ntype" />
                        <xsl:with-param name="arm" select="3" />
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="$arm != 4">
                    <xsl:call-template name="star-fractal-1">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="cx" select="substring-before($p_5,',')" />
                        <xsl:with-param name="cy" select="substring-after($p_5,',')" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="type" select="$ntype" />
                        <xsl:with-param name="arm" select="4" />
                    </xsl:call-template>
                </xsl:if>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <star-fractal-2:star-fractal-2 />
    <xsl:variable name="star-fractal-2" select="document('')/*/star-fractal-2:*[1]" />
    <xsl:template name="star-fractal-2" match="*[namespace-uri()='star-fractal-2']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2 - 22" />
        <xsl:param name="radius" select="512 div 2" />
        <xsl:param name="arm" select="0" />
        <xsl:param name="rotation" select="0" />

        <xsl:call-template name="pentagram">
            <xsl:with-param name="cx" select="$cx" />
            <xsl:with-param name="cy" select="$cy" />
            <xsl:with-param name="radius" select="$radius" />
            <xsl:with-param name="rotation" select="0" />
            <xsl:with-param name="type" select="1" />
        </xsl:call-template>

        <xsl:variable name="angle" select="72" />

        <xsl:choose>
            <xsl:when test="$stage = 0">
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nradius" select="$radius div 2.73" />

                <xsl:variable name="ny" select="$cy + $radius - $nradius" />

                <xsl:variable name="p_1">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="1 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="2 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_4">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="3 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_5">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="4 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$cx" />
                        <xsl:with-param name="point_y" select="$ny" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="star-fractal-2">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="substring-before($p_1,',')" />
                    <xsl:with-param name="cy" select="substring-after($p_1,',')" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="arm" select="0" />
                </xsl:call-template>

                <xsl:call-template name="star-fractal-2">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="substring-before($p_2,',')" />
                    <xsl:with-param name="cy" select="substring-after($p_2,',')" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="arm" select="1" />
                </xsl:call-template>

                <xsl:call-template name="star-fractal-2">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="substring-before($p_3,',')" />
                    <xsl:with-param name="cy" select="substring-after($p_3,',')" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="arm" select="2" />
                </xsl:call-template>

                <xsl:call-template name="star-fractal-2">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="substring-before($p_4,',')" />
                    <xsl:with-param name="cy" select="substring-after($p_4,',')" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="arm" select="3" />
                </xsl:call-template>

                <xsl:call-template name="star-fractal-2">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="cx" select="substring-before($p_5,',')" />
                    <xsl:with-param name="cy" select="substring-after($p_5,',')" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="arm" select="4" />
                </xsl:call-template>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>