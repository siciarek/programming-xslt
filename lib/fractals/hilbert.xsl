<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hilbertCurve="hilbertCurve">

    <hilbertCurve:hilbertCurve />
    <xsl:variable name="hilbertCurve" select="document('')/*/hilbertCurve:*[1]" />
    <xsl:template name="hilbertCurve" match="*[namespace-uri()='hilbertCurve']">

        <xsl:param name="stage" select="5" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="0" />
        <xsl:param name="color" select="'rgb(0, 0, 1)'" />

        <xsl:variable name="d">

            <xsl:choose>
                <xsl:when test="$type = 0">
                    <xsl:call-template name="doHilbertCurveSet">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="size" select="$size" />
                    </xsl:call-template>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:call-template name="doHilbertCurve">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="size" select="$size" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:element name="path">
                <xsl:attribute name="fill">none</xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering">crispEdges</xsl:attribute>
                <xsl:attribute name="d">
                    <xsl:value-of select="$d" />
                </xsl:attribute>
            </xsl:element>

<!--
            <xsl:element name="rect">
                <xsl:attribute name="fill">none</xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="'rgb(230,230,230)'" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
                <xsl:attribute name="shape-rendering"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
                <xsl:attribute name="x"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
                <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
                <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>
            </xsl:element>

            <xsl:element name="circle">
                <xsl:attribute name="fill"><xsl:value-of select="'rgb(0, 128, 0)'" /></xsl:attribute>
                <xsl:attribute name="r"><xsl:value-of select="2" /></xsl:attribute>
                <xsl:attribute name="cx"><xsl:value-of select="$start_x" /></xsl:attribute>
                <xsl:attribute name="cy"><xsl:value-of select="$start_y" /></xsl:attribute>
            </xsl:element>
-->

        </xsl:element>
    </xsl:template>

    <xsl:template name="doHilbertCurve">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" />

        <xsl:variable name="powstage">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="2" />
                <xsl:with-param name="exponent" select="$stage + 1" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="path">
            <xsl:call-template name="A">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x" select="$size* (1 - 1 div ($powstage))" />
                <xsl:with-param name="y" select="$size* (1 - 1 div ($powstage))" />
                <xsl:with-param name="h" select="$size div 2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('M', normalize-space($path))" />

    </xsl:template>

    <xsl:template name="doHilbertCurveSet">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" />
        <xsl:param name="result" select="null" />

        <xsl:variable name="path">
            <xsl:call-template name="doHilbertCurve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">

                <xsl:call-template name="doHilbertCurveSet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="result" select="normalize-space(concat($result, ' ', $path))" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <xsl:template name="A">

        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="h" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">
                <xsl:call-template name="D">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="A">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="A">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="B">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="plot">
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="B">

        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="h" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">
                <xsl:call-template name="C">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="B">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="B">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="A">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="plot">
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="C">

        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="h" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">
                <xsl:call-template name="B">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="C">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="C">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="D">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="plot">
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="D">

        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="h" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">
                <xsl:call-template name="A">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="D">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="D">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
                <xsl:call-template name="C">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $h" />
                    <xsl:with-param name="y" select="$y - $h" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="plot">
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


</xsl:stylesheet>