<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gosper-curve="gosper-curve">

    <gosper-curve:gosper-curve />
    <xsl:variable name="gosper-curve" select="document('')/*/gosper-curve:*[1]" />
    <xsl:template name="gosper-curve" match="*[namespace-uri()='gosper-curve']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="x0" select="$size" />
        <xsl:param name="y0" select="$size" />

        <xsl:variable name="width" select="512" />
        <xsl:variable name="height" select="512" />
        <xsl:variable name="stroke" select="'rgb(0, 0, 0)'" />
        <xsl:variable name="fill" select="'none'" />
        <xsl:variable name="stroke-width" select="1" />
        <xsl:variable name="shape-rendering" select="'default'" />

        <xsl:variable name="points">
            <xsl:call-template name="do-gosper-curve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version"><xsl:value-of select="'1.1'" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>

            <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                <xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$stroke" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="$stroke-width" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="$shape-rendering" /></xsl:attribute>
                <xsl:attribute name="points">
                    <xsl:value-of select="$points" />
                </xsl:attribute>
            </xsl:element>
        </xsl:element>

    </xsl:template>


    <xsl:template name="do-gosper-curve">

        <xsl:param name="stage" />
        <xsl:param name="size" select="512"/>
        <xsl:param name="x0" select="100" />
        <xsl:param name="y0" select="400" />
        <xsl:param name="color" select="'rgb(0, 0, 1)'" />

        <xsl:variable name="powstage">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="2.6457" />
                <xsl:with-param name="exponent" select="$stage + 1" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="step-size" select="$size div $powstage" />

        <xsl:variable name="d">
            <xsl:call-template name="gl">
                <xsl:with-param name="st" select="$stage" />
                <xsl:with-param name="ln" select="$step-size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="logo-path" select="concat(normalize-space($d), ' ')" />

        <xsl:variable name="normalized-logo-path">
            <xsl:call-template name="normalize-logo-path">
                <xsl:with-param name="path" select="$logo-path" />
                <xsl:with-param name="size" select="$step-size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="offsets">
            <xsl:call-template name="logo-path-to-offsets">
                <xsl:with-param name="path" select="concat(normalize-space(substring-after($normalized-logo-path, 'rt ')), ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="output">
            <xsl:call-template name="generate-curve">
                <xsl:with-param name="offsets" select="$offsets" />
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
            </xsl:call-template>
        </xsl:variable>

<!--         <xsl:value-of select="normalize-space($normalized-logo-path)" /> -->
<!--         <xsl:value-of select="'&#10;'" /> -->
<!--         <xsl:value-of select="$offsets" /> -->

        <xsl:value-of select="normalize-space($output)" />

    </xsl:template>

    <xsl:template name="generate-curve">
        <xsl:param name="offsets" />
        <xsl:param name="x0" />
        <xsl:param name="y0" />

        <xsl:call-template name="plot">
            <xsl:with-param name="x" select="$x0" />
            <xsl:with-param name="y" select="$y0" />
        </xsl:call-template>

        <xsl:if test="$offsets">

            <xsl:variable name="offset" select="substring-before($offsets, ' ')" />
            <xsl:variable name="tail" select="substring-after($offsets, ' ')" />

            <xsl:variable name="xoffset" select="substring-before($offset, ',')" />
            <xsl:variable name="yoffset" select="substring-after($offset, ',')" />

            <xsl:variable name="newx" select="$x0 + $xoffset" />
            <xsl:variable name="newy" select="$y0 + $yoffset" />

            <xsl:call-template name="generate-curve">
                <xsl:with-param name="offsets" select="$tail" />
                <xsl:with-param name="x0" select="$newx" />
                <xsl:with-param name="y0" select="$newy" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>


    <xsl:template name="logo-path-to-offsets">
        <xsl:param name="path" />
        <xsl:param name="angle" select="-90" />
        <xsl:param name="result" select="''" />

        <xsl:variable name="head" select="normalize-space(substring-before($path, 'rt '))" />
        <xsl:variable name="tail" select="substring-after($path, 'rt ')" />


        <xsl:choose>
            <xsl:when test="$tail">

                <xsl:variable name="nangle" select="normalize-space(substring-before($head, 'fd'))" />
                <xsl:variable name="distance" select="normalize-space(substring-after($head, 'fd'))" />

                <xsl:variable name="res">

                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="$angle + $nangle" />
                        <xsl:with-param name="base_x" select="0" />
                        <xsl:with-param name="base_y" select="0" />
                        <xsl:with-param name="point_x" select="$distance" />
                        <xsl:with-param name="point_y" select="0" />
                    </xsl:call-template>

                    <xsl:value-of select="' '" />

                    <xsl:if test="not(substring-before($tail, 'rt'))">
                        <xsl:variable name="last-nangle" select="normalize-space(substring-before($tail, 'fd'))" />
                        <xsl:variable name="last-distance" select="normalize-space(substring-after($tail, 'fd'))" />

                        <xsl:call-template name="protate">
                            <xsl:with-param name="angle" select="$angle + $nangle + $last-nangle" />
                            <xsl:with-param name="base_x" select="0" />
                            <xsl:with-param name="base_y" select="0" />
                            <xsl:with-param name="point_x" select="$last-distance" />
                            <xsl:with-param name="point_y" select="0" />
                        </xsl:call-template>

                        <xsl:value-of select="' '" />

                    </xsl:if>

                </xsl:variable>

                <xsl:call-template name="logo-path-to-offsets">
                    <xsl:with-param name="path" select="concat(normalize-space($tail), ' ')" />
                    <xsl:with-param name="angle" select="$angle + $nangle" />
                    <xsl:with-param name="result" select="concat($result, $res)" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template name="normalize-logo-path">
        <xsl:param name="path" />
        <xsl:param name="size" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$path">
                <xsl:variable name="head" select="substring-before($path, 'fd')" />
                <xsl:variable name="tail" select="substring-after($path, 'fd')" />

                <xsl:variable name="head-head" select="substring-before(normalize-space($head), ' ')" />
                <xsl:variable name="head-tail" select="substring-after(normalize-space($head), ' ')" />

                <xsl:variable name="tdistance">
                    <xsl:choose>

                        <xsl:when test="$tail and number($tail)">
                            <xsl:value-of select="$head-head" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="number(normalize-space($head-head))">
                                    <xsl:value-of select="$head-head" />
                                </xsl:when>
                                <xsl:otherwise>
                                </xsl:otherwise>
                            </xsl:choose>

                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="tangle">
                    <xsl:value-of select="translate(translate(translate($head-tail, 't', ''), 'r', '+'), 'l', '-')" />
                </xsl:variable>

                <xsl:variable name="distance">
                    <xsl:choose>
                        <xsl:when test="number(normalize-space($tdistance))">
                            <xsl:value-of select="$tdistance" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="0" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="nangle">
                    <xsl:if test="normalize-space($tangle)">
                        <xsl:call-template name="equation">
                            <xsl:with-param name="equation" select="normalize-space($tangle)" />
                        </xsl:call-template>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="res">

                    <xsl:if test="number($nangle)">
                        <xsl:value-of select="concat(' rt ', $nangle, ' ')" />
                    </xsl:if>

                    <xsl:choose>
                        <xsl:when test="number($distance)">
                            <xsl:value-of select="concat(' fd ' , $distance, ' ')" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="$result">
                                <xsl:value-of select="concat(' fd ' , $size, ' ')" />
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:variable>

                <xsl:call-template name="normalize-logo-path">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="result" select="concat($res, $result)" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(' rt 0 ', normalize-space($result))" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template name="rg">
        <xsl:param name="st" />
        <xsl:param name="ln" />

        <xsl:variable name="_ln" select="$ln div 1" />

        <xsl:choose>
            <xsl:when test="$st = 0">
                <xsl:value-of select="concat('fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('rt  60 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('rt 120 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('lt  60 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('lt 120 fd ', $_ln * 2, ' ')" />
                <xsl:value-of select="concat('lt  60 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('rt  60'             , ' ')" />
            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 60, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 120, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt ', 60, ' ')" />

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt ', 120, ' ')" />

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt ', 60, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 60, ' ')" />

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="gl">
        <xsl:param name="st" />
        <xsl:param name="ln" />

        <xsl:variable name="_ln" select="$ln div 1" />

        <xsl:choose>
            <xsl:when test="$st = 0">
                <xsl:value-of select="concat('lt  60 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('rt  60 fd ', $_ln * 2, ' ')" />
                <xsl:value-of select="concat('rt 120 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('rt  60 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('lt 120 fd ', $_ln * 1, ' ')" />
                <xsl:value-of select="concat('lt  60 fd ', $_ln * 1, ' ')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('lt ', 60, ' ')" />

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 60, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 120, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('rt ', 60, ' ')" />

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt ', 120, ' ')" />

                <xsl:call-template name="rg">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

                <xsl:value-of select="concat('lt ', 60, ' ')" />

                <xsl:call-template name="gl">
                    <xsl:with-param name="st" select="$st - 1" />
                    <xsl:with-param name="ln" select="$_ln" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>