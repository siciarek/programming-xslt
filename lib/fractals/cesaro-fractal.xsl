<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cesaro-fractal="cesaro-fractal" xmlns:cesaro-fractal-koch="cesaro-fractal-koch">

    <xsl:template name="draw-side">
        <xsl:param name="stage" />
        <xsl:param name="offset" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />

        <xsl:choose>
            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('L', $x2, ',', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="xsize">
                    <xsl:value-of select="($x2 - $x1) div 2" />
                </xsl:variable>

                <xsl:variable name="ysize">
                    <xsl:value-of select="($y2 - $y1) div 2" />
                </xsl:variable>

                <xsl:variable name="m">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="90" />
                        <xsl:with-param name="base_x" select="$x1 + $xsize" />
                        <xsl:with-param name="base_y" select="$y1 + $ysize" />
                        <xsl:with-param name="point_x" select="$x1 + $xsize * $offset" />
                        <xsl:with-param name="point_y" select="$y1 + $ysize * $offset" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="mx" select="substring-before($m, ',')" />
                <xsl:variable name="my" select="substring-after($m, ',')" />

                <xsl:call-template name="draw-side">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="offset" select="$offset" />
                    <xsl:with-param name="x1" select="$x1" />
                    <xsl:with-param name="y1" select="$y1" />
                    <xsl:with-param name="x2" select="$x1 + $xsize * (1 - $offset)" />
                    <xsl:with-param name="y2" select="$y1 + $ysize * (1 - $offset)" />
                </xsl:call-template>

                <xsl:call-template name="draw-side">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="offset" select="$offset" />
                    <xsl:with-param name="x1" select="$x1 + $xsize * (1 - $offset)" />
                    <xsl:with-param name="y1" select="$y1 + $ysize * (1 - $offset)" />
                    <xsl:with-param name="x2" select="$mx" />
                    <xsl:with-param name="y2" select="$my" />
                </xsl:call-template>

                <xsl:call-template name="draw-side">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="offset" select="$offset" />
                    <xsl:with-param name="x1" select="$mx" />
                    <xsl:with-param name="y1" select="$my" />
                    <xsl:with-param name="x2" select="$x2 - $xsize * (1 - $offset)" />
                    <xsl:with-param name="y2" select="$y2 - $ysize * (1 - $offset)" />
                </xsl:call-template>

                <xsl:call-template name="draw-side">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="offset" select="$offset" />
                    <xsl:with-param name="x1" select="$x2 - $xsize * (1 - $offset)" />
                    <xsl:with-param name="y1" select="$y2 - $ysize * (1 - $offset)" />
                    <xsl:with-param name="x2" select="$x2" />
                    <xsl:with-param name="y2" select="$y2" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <cesaro-fractal-koch:cesaro-fractal-koch />
    <xsl:variable name="cesaro-fractal-koch" select="document('')/*/cesaro-fractal-koch:*[1]" />
    <xsl:template name="cesaro-fractal-koch" match="*[namespace-uri()='cesaro-fractal-koch']">
        <xsl:param name="stage" select="0" />
        <xsl:call-template name="cesaro-fractal">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="offset" select="0.333333" />
        </xsl:call-template>
    </xsl:template>

    <cesaro-fractal:cesaro-fractal />
    <xsl:variable name="cesaro-fractal" select="document('')/*/cesaro-fractal:*[1]" />
    <xsl:template name="cesaro-fractal" match="*[namespace-uri()='cesaro-fractal']">
        <xsl:param name="stage" select="0" />
        <xsl:param name="offset" select="0.03" />

        <xsl:param name="x1" select="1" />
        <xsl:param name="y1" select="512 - 1" />
        <xsl:param name="x2" select="512 - 1" />
        <xsl:param name="y2" select="512 - 1" />
        <xsl:param name="size" select="512 - 2 * 1" />

        <xsl:value-of select="concat('M', $x1, ',', $y1)" />

        <xsl:call-template name="draw-side">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="offset" select="$offset" />
            <xsl:with-param name="x1" select="$x1" />
            <xsl:with-param name="y1" select="$y1" />
            <xsl:with-param name="x2" select="$x1 + $size" />
            <xsl:with-param name="y2" select="$y1" />
        </xsl:call-template>

        <xsl:call-template name="draw-side">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="offset" select="$offset" />
            <xsl:with-param name="x1" select="$x2" />
            <xsl:with-param name="y1" select="$y2" />
            <xsl:with-param name="x2" select="$x2" />
            <xsl:with-param name="y2" select="$y2 - $size" />
        </xsl:call-template>

        <xsl:call-template name="draw-side">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="offset" select="$offset" />
            <xsl:with-param name="x1" select="$x2" />
            <xsl:with-param name="y1" select="$y2 - $size" />
            <xsl:with-param name="x2" select="$x1" />
            <xsl:with-param name="y2" select="$y2 - $size" />
        </xsl:call-template>

        <xsl:call-template name="draw-side">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="offset" select="$offset" />
            <xsl:with-param name="x1" select="$x1" />
            <xsl:with-param name="y1" select="$y2 - $size" />
            <xsl:with-param name="x2" select="$x1" />
            <xsl:with-param name="y2" select="$y1" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>
