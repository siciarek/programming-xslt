<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="w-angle">
        <xsl:param name="size" />
        <xsl:value-of select="concat('rt 90 fd ', $size, ' lt 90 fd ', $size, ' rt 90 ')" />
    </xsl:template>

    <xsl:template name="w-connect">
        <xsl:param name="stage" />
        <xsl:param name="size" />

        <xsl:choose>
            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('fd ', $size, ' ')" />
            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="w-connect">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>

                <xsl:call-template name="w-angle">
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>

                <xsl:call-template name="w-connect">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt 90 fd ', $size, ' lt 90 ')" />

                <xsl:call-template name="w-connect">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>

                <xsl:call-template name="w-angle">
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>

                <xsl:call-template name="w-connect">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="parse-logo-path">
        <xsl:param name="path" />
        <xsl:param name="size" />
        <xsl:param name="angle" select="0" />

        <xsl:choose>
            <xsl:when test="$path">
                <xsl:variable name="head" select="substring-before($path, concat('fd ', $size))" />
                <xsl:variable name="tail" select="substring-after($path, concat('fd ', $size))" />

                <xsl:variable name="rotation"
                    select="normalize-space(translate(translate(translate(translate($head, 't', ''), 'r', ''), 'l', '-'), ' ', ''))" />

                <xsl:if test="string($angle + $rotation) != 'NaN'">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$angle + $rotation" />
                        <xsl:with-param name="base_x" select="0" />
                        <xsl:with-param name="base_y" select="0" />
                        <xsl:with-param name="point_x" select="$size" />
                        <xsl:with-param name="point_y" select="0" />
                    </xsl:call-template>

                    <xsl:value-of select="' '" />
                </xsl:if>

                <xsl:call-template name="parse-logo-path">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="angle" select="($angle + $rotation) mod 360" />
                </xsl:call-template>

            </xsl:when>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="do-w-curve-set">

        <xsl:param name="stage" />
        <xsl:param name="_size" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$stage &gt;= 0">

                <xsl:variable name="res">
                    <xsl:call-template name="do-w-curve">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="_size" select="$_size" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="do-w-curve-set">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="_size" select="$_size" />
                    <xsl:with-param name="result" select="concat($res, ' ', $result)" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <xsl:template name="do-w-curve">

        <xsl:param name="stage" />
        <xsl:param name="_size" />

        <xsl:variable name="stagepow">
            <xsl:variable name="temp">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="2" />
                    <xsl:with-param name="exponent" select="$stage" />
                </xsl:call-template>
            </xsl:variable>

            <xsl:value-of select="$temp * 4" />
        </xsl:variable>

        <xsl:variable name="size" select="$_size div $stagepow" />
        <xsl:variable name="x0" select="$_size - $_size div $stagepow - $_size div ($stagepow * 2)" />
        <xsl:variable name="y0" select="$_size div ($stagepow * 2)" />

        <xsl:variable name="logo-path">
            <xsl:call-template name="w-angle">
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
            <xsl:call-template name="w-connect">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:call-template name="w-angle">
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
            <xsl:call-template name="w-connect">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:call-template name="w-angle">
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
            <xsl:call-template name="w-connect">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>

            <xsl:call-template name="w-angle">
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
            <xsl:call-template name="w-connect">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="parse-logo-path">
                <xsl:with-param name="path" select="$logo-path" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="offsets" select="$offsets" />
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('M', $output, 'Z')" />
    </xsl:template>

    <xsl:template name="w-curve">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="1" />

        <xsl:variable name="width" select="$size" />
        <xsl:variable name="height" select="$size" />
        <xsl:variable name="stroke" select="'rgb(0, 0, 0)'" />
        <xsl:variable name="fill" select="'none'" />
        <xsl:variable name="stroke-width" select="1" />
        <xsl:variable name="shape-rendering" select="'crispEdges'" />

        <xsl:variable name="d">
            <xsl:choose>
                <xsl:when test="$type = 0">
                    <xsl:call-template name="do-w-curve">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="_size" select="$size" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="do-w-curve-set">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="_size" select="$size" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version"><xsl:value-of select="'1.1'" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>

            <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$stroke" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="$stroke-width" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="$shape-rendering" /></xsl:attribute>
                <xsl:attribute name="d">
                    <xsl:value-of select="$d" />
                </xsl:attribute>
            </xsl:element>
        </xsl:element>

    </xsl:template>

</xsl:stylesheet>
