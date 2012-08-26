<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pentaflake="pentaflake"
    xmlns:pentaflakec="pentaflakec">

<!--     <xsl:include href="../common/math.xsl" /> -->

    <xsl:template name="pentagon">
        <xsl:param name="cx" />
        <xsl:param name="cy" />
        <xsl:param name="radius" />
        <xsl:param name="type" select="0" />

        <xsl:variable name="angle" select="72" />

        <xsl:variable name="ncy">
            <xsl:choose>
                <xsl:when test="$type = 1">
                    <xsl:value-of select="$cy + $radius" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$cy - $radius" />
                </xsl:otherwise>
            </xsl:choose>

        </xsl:variable>

<!--         <xsl:value-of select="concat('M', $cx, ',', $cy, ', ', $cx + 1, ',', $cy + 1, 'Z')" /> -->

        <xsl:variable name="first">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="0 * $angle" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />

                <xsl:with-param name="point_y" select="$ncy" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="second">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="1 * $angle" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />

                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ncy" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="third">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="2 * $angle" />
                <xsl:with-param name="base_x" select="$cx" />

                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ncy" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="fourth">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="3 * $angle" />

                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ncy" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="fifth">
            <xsl:call-template name="protate">

                <xsl:with-param name="angle" select="4 * $angle" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ncy" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="'M'" />

        <xsl:value-of select="$first" />
        <xsl:value-of select="' '" />

        <xsl:value-of select="$second" />
        <xsl:value-of select="' '" />

        <xsl:value-of select="$third" />
        <xsl:value-of select="' '" />

        <xsl:value-of select="$fourth" />

        <xsl:value-of select="' '" />

        <xsl:value-of select="$fifth" />
        <xsl:value-of select="' '" />

        <xsl:value-of select="'Z'" />

    </xsl:template>

    <pentaflakec:pentaflakec />
    <xsl:variable name="pentaflakec" select="document('')/*/pentaflakec:*[1]" />
    <xsl:template name="pentaflakec" match="*[namespace-uri()='pentaflakec']">

        <xsl:param name="stage" select="0" />

        <xsl:call-template name="pentaflake">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="center" select="1" />
        </xsl:call-template>

    </xsl:template>

    <pentaflake:pentaflake />
    <xsl:variable name="pentaflake" select="document('')/*/pentaflake:*[1]" />

    <xsl:template name="pentaflake" match="*[namespace-uri()='pentaflake']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="22 + 512 div 2" />
        <xsl:param name="radius" select="512 div 2" />
        <xsl:param name="center" select="0" />
        <xsl:param name="type" select="0" />

        <xsl:variable name="angle" select="72" />

        <xsl:variable name="gr">
            <xsl:variable name="sqrt_5">
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="num" select="5" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="(1 + $sqrt_5) div 2" />
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$stage = 0">

                <xsl:call-template name="pentagon">
                    <xsl:with-param name="cx" select="$cx" />
                    <xsl:with-param name="cy" select="$cy" />
                    <xsl:with-param name="radius" select="$radius" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nradius" select="$radius div (1 + $gr)" />

                <xsl:variable name="ncx" select="$cx" />

                <xsl:variable name="ncy">
                    <xsl:choose>
                        <xsl:when test="$type = 1 and $center = 1">
                            <xsl:value-of select="$cy + $nradius * $gr" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$cy - $nradius * $gr" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="first">

                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$ncx" />
                        <xsl:with-param name="point_y" select="$ncy" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="second">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="1 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$ncx" />
                        <xsl:with-param name="point_y" select="$ncy" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="third">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="2 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$ncx" />
                        <xsl:with-param name="point_y" select="$ncy" />
                    </xsl:call-template>

                </xsl:variable>

                <xsl:variable name="fourth">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="3 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$ncx" />
                        <xsl:with-param name="point_y" select="$ncy" />

                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="fifth">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="4 * $angle" />
                        <xsl:with-param name="base_x" select="$cx" />
                        <xsl:with-param name="base_y" select="$cy" />
                        <xsl:with-param name="point_x" select="$ncx" />

                        <xsl:with-param name="point_y" select="$ncy" />
                    </xsl:call-template>
                </xsl:variable>

<!-- CENTER: -->

                <xsl:if test="$center = 1">
                    <xsl:call-template name="pentaflake">
                        <xsl:with-param name="stage" select="$stage - 1" />
                        <xsl:with-param name="radius" select="$nradius" />
                        <xsl:with-param name="cx" select="$cx" />
                        <xsl:with-param name="cy" select="$cy" />
                        <xsl:with-param name="type" select="($type + 1) mod 2" />
                        <xsl:with-param name="center" select="$center" />
                    </xsl:call-template>
                </xsl:if>

<!-- OTHER: -->

                <xsl:call-template name="pentaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="cx" select="substring-before($first, ',')" />
                    <xsl:with-param name="cy" select="substring-after($first, ',')" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:call-template name="pentaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="cx" select="substring-before($second, ',')" />
                    <xsl:with-param name="cy" select="substring-after($second, ',')" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:call-template name="pentaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="cx" select="substring-before($third, ',')" />
                    <xsl:with-param name="cy" select="substring-after($third, ',')" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:call-template name="pentaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="cx" select="substring-before($fourth, ',')" />
                    <xsl:with-param name="cy" select="substring-after($fourth, ',')" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>

                <xsl:call-template name="pentaflake">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="radius" select="$nradius" />
                    <xsl:with-param name="cx" select="substring-before($fifth, ',')" />
                    <xsl:with-param name="cy" select="substring-after($fifth, ',')" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="center" select="$center" />
                </xsl:call-template>


            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
