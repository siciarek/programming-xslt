<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ice-fractal-triangle="ice-fractal-triangle"
    xmlns:ice-fractal-antitriangle="ice-fractal-antitriangle" xmlns:ice-fractal-square="ice-fractal-square" xmlns:ice-fractal-antisquare="ice-fractal-antisquare">

    <ice-fractal-square:ice-fractal-square />
    <xsl:variable name="ice-fractal-square" select="document('')/*/ice-fractal-square:*[1]" />
    <xsl:template name="ice-fractal-square" match="*[namespace-uri()='ice-fractal-square']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:param name="type" select="'square'" />

        <xsl:variable name="p1x" select="$size div 4" />
        <xsl:variable name="p1y" select="$size div 4" />

        <xsl:variable name="p2x" select="$size - $size div 4" />
        <xsl:variable name="p2y" select="$size div 4" />

        <xsl:variable name="p3x" select="$size - $size div 4" />
        <xsl:variable name="p3y" select="$size - $size div 4" />

        <xsl:variable name="p4x" select="$size div 4" />
        <xsl:variable name="p4y" select="$size - $size div 4" />

        <xsl:call-template name="ice-fractal-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p1x" />
            <xsl:with-param name="y1" select="$p1y" />
            <xsl:with-param name="x2" select="$p2x" />
            <xsl:with-param name="y2" select="$p2y" />
        </xsl:call-template>

        <xsl:call-template name="ice-fractal-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p2x" />
            <xsl:with-param name="y1" select="$p2y" />
            <xsl:with-param name="x2" select="$p3x" />
            <xsl:with-param name="y2" select="$p3y" />
        </xsl:call-template>

        <xsl:call-template name="ice-fractal-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p3x" />
            <xsl:with-param name="y1" select="$p3y" />
            <xsl:with-param name="x2" select="$p4x" />
            <xsl:with-param name="y2" select="$p4y" />
        </xsl:call-template>

        <xsl:call-template name="ice-fractal-square-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p4x" />
            <xsl:with-param name="y1" select="$p4y" />
            <xsl:with-param name="x2" select="$p1x" />
            <xsl:with-param name="y2" select="$p1y" />
        </xsl:call-template>

    </xsl:template>

    <ice-fractal-antisquare:ice-fractal-antisquare />
    <xsl:variable name="ice-fractal-antisquare" select="document('')/*/ice-fractal-antisquare:*[1]" />
    <xsl:template name="ice-fractal-antisquare" match="*[namespace-uri()='ice-fractal-antisquare']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:param name="radius" select="512 div 3" />

        <xsl:call-template name="ice-fractal-square">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="radius" select="$radius" />
            <xsl:with-param name="type" select="'antisquare'" />
        </xsl:call-template>

    </xsl:template>


    <ice-fractal-antitriangle:ice-fractal-antitriangle />
    <xsl:variable name="ice-fractal-antitriangle" select="document('')/*/ice-fractal-antitriangle:*[1]" />
    <xsl:template name="ice-fractal-antitriangle" match="*[namespace-uri()='ice-fractal-antitriangle']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:param name="radius" select="512 div 3" />
        <xsl:param name="type" select="'triangle'" />

        <xsl:call-template name="ice-fractal-triangle">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="radius" select="$radius" />
            <xsl:with-param name="type" select="'antitriangle'" />
        </xsl:call-template>

    </xsl:template>

    <ice-fractal-triangle:ice-fractal-triangle />
    <xsl:variable name="ice-fractal-triangle" select="document('')/*/ice-fractal-triangle:*[1]" />
    <xsl:template name="ice-fractal-triangle" match="*[namespace-uri()='ice-fractal-triangle']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />

        <xsl:param name="radius" select="512 div 3" />
        <xsl:param name="type" select="'triangle'" />

        <xsl:variable name="cx" select="$size div 2" />
        <xsl:variable name="cy" select="$size div 2" />

        <xsl:variable name="p1">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="0 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p2">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="1 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p3">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="2 * 120" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p1x" select="substring-before($p1, ',')" />
        <xsl:variable name="p1y" select="substring-after($p1, ',')" />

        <xsl:variable name="p2x" select="substring-before($p2, ',')" />
        <xsl:variable name="p2y" select="substring-after($p2, ',')" />

        <xsl:variable name="p3x" select="substring-before($p3, ',')" />
        <xsl:variable name="p3y" select="substring-after($p3, ',')" />


        <xsl:call-template name="ice-fractal-triangle-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p1x" />
            <xsl:with-param name="y1" select="$p1y" />
            <xsl:with-param name="x2" select="$p2x" />
            <xsl:with-param name="y2" select="$p2y" />
        </xsl:call-template>

        <xsl:call-template name="ice-fractal-triangle-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p2x" />
            <xsl:with-param name="y1" select="$p2y" />
            <xsl:with-param name="x2" select="$p3x" />
            <xsl:with-param name="y2" select="$p3y" />
        </xsl:call-template>

        <xsl:call-template name="ice-fractal-triangle-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="type" select="$type" />
            <xsl:with-param name="x1" select="$p3x" />
            <xsl:with-param name="y1" select="$p3y" />
            <xsl:with-param name="x2" select="$p1x" />
            <xsl:with-param name="y2" select="$p1y" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="ice-fractal-triangle-motif">

        <xsl:param name="stage" />

        <xsl:param name="x1" />
        <xsl:param name="y1" />

        <xsl:param name="x2" />
        <xsl:param name="y2" />

        <xsl:param name="type" select="'triangle'" />

        <xsl:variable name="direction">
            <xsl:choose>
                <xsl:when test="$type = 'antitriangle'">
                    <xsl:value-of select="-1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('M', $x1, ',', $y1)" />
                <xsl:value-of select="concat('L', $x2, ',', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="x-by-2" select="($x2 - $x1) div 2" />
                <xsl:variable name="y-by-2" select="($y2 - $y1) div 2" />
                <xsl:variable name="x-by-6" select="$x-by-2 div 3" />
                <xsl:variable name="y-by-6" select="$y-by-2 div 3" />

                <xsl:variable name="p1x" select="$x1" />
                <xsl:variable name="p1y" select="$y1" />

                <xsl:variable name="p2x" select="$x1 + $x-by-2" />
                <xsl:variable name="p2y" select="$y1 + $y-by-2" />

                <xsl:variable name="p3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$direction * 60" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p2x - $x-by-6" />
                        <xsl:with-param name="point_y" select="$p2y - $y-by-6" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p3x" select="substring-before($p3, ',')" />
                <xsl:variable name="p3y" select="substring-after($p3, ',')" />

                <xsl:variable name="p4">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$direction * 120" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p2x - $x-by-6" />
                        <xsl:with-param name="point_y" select="$p2y - $y-by-6" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p4x" select="substring-before($p4, ',')" />
                <xsl:variable name="p4y" select="substring-after($p4, ',')" />

                <xsl:variable name="p5x" select="$x2" />
                <xsl:variable name="p5y" select="$y2" />

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p1x" />
                    <xsl:with-param name="y1" select="$p1y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p3x" />
                    <xsl:with-param name="y2" select="$p3y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p3x" />
                    <xsl:with-param name="y1" select="$p3y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p4x" />
                    <xsl:with-param name="y2" select="$p4y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p4x" />
                    <xsl:with-param name="y1" select="$p4y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-triangle-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p5x" />
                    <xsl:with-param name="y2" select="$p5y" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="ice-fractal-square-motif">

        <xsl:param name="stage" />

        <xsl:param name="x1" />
        <xsl:param name="y1" />

        <xsl:param name="x2" />
        <xsl:param name="y2" />

        <xsl:param name="type" select="'square'" />

        <xsl:variable name="direction">
            <xsl:choose>
                <xsl:when test="$type = 'antisquare'">
                    <xsl:value-of select="-1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('M', $x1, ',', $y1)" />
                <xsl:value-of select="concat('L', $x2, ',', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="x-by-2" select="($x2 - $x1) div 2" />
                <xsl:variable name="y-by-2" select="($y2 - $y1) div 2" />
                <xsl:variable name="x-by-4" select="$x-by-2 div 1.3" />
                <xsl:variable name="y-by-4" select="$y-by-2 div 1.3" />

                <xsl:variable name="p1x" select="$x1" />
                <xsl:variable name="p1y" select="$y1" />

                <xsl:variable name="p2x" select="$x1 + $x-by-2" />
                <xsl:variable name="p2y" select="$y1 + $y-by-2" />

                <xsl:variable name="p3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$direction * 90" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p2x - $x-by-4" />
                        <xsl:with-param name="point_y" select="$p2y - $y-by-4" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p3x" select="substring-before($p3, ',')" />
                <xsl:variable name="p3y" select="substring-after($p3, ',')" />

                <xsl:variable name="p4x" select="$x2" />
                <xsl:variable name="p4y" select="$y2" />


                <xsl:call-template name="ice-fractal-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p1x" />
                    <xsl:with-param name="y1" select="$p1y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p3x" />
                    <xsl:with-param name="y2" select="$p3y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p3x" />
                    <xsl:with-param name="y1" select="$p3y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="ice-fractal-square-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p4x" />
                    <xsl:with-param name="y2" select="$p4y" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>