<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sierpinskiTriangle="sierpinskiTriangle"
    xmlns:sierpinskiCarpet="sierpinskiCarpet" xmlns:sierpinskiCurve="sierpinskiCurve" xmlns:sierpinskiArrowheadCurve="sierpinskiArrowheadCurve">

    <sierpinskiArrowheadCurve:sierpinskiArrowheadCurve />
    <xsl:variable name="sierpinskiArrowheadCurve" select="document('')/*/sierpinskiArrowheadCurve:*[1]" />
    <xsl:template name="sierpinskiArrowheadCurve" match="*[namespace-uri()='sierpinskiArrowheadCurve']">

        <xsl:param name="stage" select="5" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:variable name="sin_60">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="60" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="d">

            <xsl:value-of select="'M'" />
            <xsl:call-template name="doSierpinskiArrowheadCurve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x1" select="0" />
                <xsl:with-param name="y1" select="$size * $sin_60" />
                <xsl:with-param name="x2" select="$size" />
                <xsl:with-param name="y2" select="$size * $sin_60" />
                <xsl:with-param name="h" select="$size" />
            </xsl:call-template>

        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:element name="path">
                <xsl:attribute name="fill">none</xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="2" /></xsl:attribute>
                <xsl:attribute name="shape-rendering">default</xsl:attribute>
                <xsl:attribute name="d">
                    <xsl:value-of select="normalize-space($d)" />
                </xsl:attribute>
            </xsl:element>

        </xsl:element>
    </xsl:template>

    <sierpinskiTriangle:sierpinskiTriangle />
    <xsl:variable name="sierpinskiTriangle" select="document('')/*/sierpinskiTriangle:*[1]" />
    <xsl:template name="sierpinskiTriangle" match="*[namespace-uri()='sierpinskiTriangle']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="size" select="512" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doSierpinskiTriangle">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x" select="0" />
                <xsl:with-param name="y" select="0" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="fill" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <sierpinskiCarpet:sierpinskiCarpet />
    <xsl:variable name="sierpinskiCarpet" select="document('')/*/sierpinskiCarpet:*[1]" />
    <xsl:template name="sierpinskiCarpet" match="*[namespace-uri()='sierpinskiCarpet']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="size" select="512" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doSierpinskiCarpet">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x" select="0" />
                <xsl:with-param name="y" select="0" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="fill" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <sierpinskiCurve:sierpinskiCurve />
    <xsl:variable name="sierpinskiCurve" select="document('')/*/sierpinskiCurve:*[1]" />
    <xsl:template name="sierpinskiCurve" match="*[namespace-uri()='sierpinskiCurve']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="0" />
        <xsl:param name="color" select="'rgb(0, 0, 1)'" />

        <xsl:variable name="d">

            <xsl:choose>
                <xsl:when test="$type = 0">
                    <xsl:call-template name="doSierpinskiCurveSet">
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="size" select="$size" />
                    </xsl:call-template>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:call-template name="doSierpinskiCurve">
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

        </xsl:element>

    </xsl:template>

    <xsl:template name="doSierpinskiCurve">
        <xsl:param name="stage" />
        <xsl:param name="size" />

        <xsl:value-of select="'M'" />

        <xsl:call-template name="sierpS">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="size" select="$size" />
        </xsl:call-template>

        <xsl:value-of select="'Z'" />

    </xsl:template>

    <xsl:template name="sierpS">
        <xsl:param name="stage" />
        <xsl:param name="size" />

        <xsl:variable name="powstage">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="2" />
                <xsl:with-param name="exponent" select="$stage" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="h" select="($size div 4) div $powstage" />
        <xsl:variable name="x0" select="2 * $h" />
        <xsl:variable name="y0" select="$h" />

        <xsl:variable name="temp_offsets">

            <xsl:call-template name="sierpA">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', $h, ' ')" />

            <xsl:call-template name="sierpB">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', $h, ' ')" />

            <xsl:call-template name="sierpC">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', -1 * $h, ' ')" />

            <xsl:call-template name="sierpD">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', -1 * $h, ' ')" />

        </xsl:variable>

        <xsl:variable name="offsets" select="normalize-space($temp_offsets)" />

        <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="offsets" select="$offsets" />
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
            </xsl:call-template>

        </xsl:variable>

        <xsl:value-of select="normalize-space($output)" />

    </xsl:template>

    <xsl:template name="sierpA">

        <xsl:param name="stage" />
        <xsl:param name="h" />

        <xsl:if test="$stage &gt; 0">
            <xsl:call-template name="sierpA">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', $h, ' ')" />

            <xsl:call-template name="sierpB">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(2 * $h, ',', 0, ' ')" />

            <xsl:call-template name="sierpD">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', -1 * $h, ' ')" />

            <xsl:call-template name="sierpA">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>


    <xsl:template name="sierpB">

        <xsl:param name="stage" />
        <xsl:param name="h" />

        <xsl:if test="$stage &gt; 0">
            <xsl:call-template name="sierpB">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', $h, ' ')" />

            <xsl:call-template name="sierpC">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(0, ',', 2 * $h, ' ')" />

            <xsl:call-template name="sierpA">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', $h, ' ')" />

            <xsl:call-template name="sierpB">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>



    <xsl:template name="sierpC">

        <xsl:param name="stage" />
        <xsl:param name="h" />

        <xsl:if test="$stage &gt; 0">
            <xsl:call-template name="sierpC">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', -1 * $h, ' ')" />

            <xsl:call-template name="sierpD">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-2 * $h, ',', 0, ' ')" />

            <xsl:call-template name="sierpB">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', $h, ' ')" />

            <xsl:call-template name="sierpC">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>


    <xsl:template name="sierpD">

        <xsl:param name="stage" />
        <xsl:param name="h" />

        <xsl:if test="$stage &gt; 0">
            <xsl:call-template name="sierpD">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat($h, ',', -1 * $h, ' ')" />

            <xsl:call-template name="sierpA">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(0, ',', -2 * $h, ' ')" />

            <xsl:call-template name="sierpC">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

            <xsl:value-of select="concat(-1 * $h, ',', -1 * $h, ' ')" />

            <xsl:call-template name="sierpD">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="h" select="$h" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>




<!-- ================================================= -->


    <xsl:template name="doSierpinskiCurveSet">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" />
        <xsl:param name="result" select="null" />

        <xsl:variable name="path">
            <xsl:call-template name="doSierpinskiCurve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">

                <xsl:call-template name="doSierpinskiCurveSet">
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

    <xsl:template name="doSierpinskiArrowheadCurve">
    
        <xsl:param name="stage" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="h" />

        <xsl:variable name="sin_60">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="60" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$stage = 0">

                <xsl:value-of select="concat($x2, ',', $y2, ' ', $x1, ',', $y1, ' ')" />

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="B">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="base_x" select="$x1" />
                        <xsl:with-param name="base_y" select="$y1" />
                        <xsl:with-param name="point_x" select="$x2 - ($x2 - $x1) div 2" />
                        <xsl:with-param name="point_y" select="$y2 - ($y2 - $y1) div 2" />
                        <xsl:with-param name="angle" select="-60" />
                    </xsl:call-template>
                </xsl:variable>
                
                <xsl:variable name="C">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="base_x" select="$x2" />
                        <xsl:with-param name="base_y" select="$y2" />
                        <xsl:with-param name="point_x" select="$x2 - ($x2 - $x1) div 2" />
                        <xsl:with-param name="point_y" select="$y2 - ($y2 - $y1) div 2" />
                        <xsl:with-param name="angle" select="60" />
                    </xsl:call-template>
                </xsl:variable>
                
                <xsl:variable name="Bx" select="substring-before($B, ',')" />
                <xsl:variable name="By" select="substring-after($B, ',')" />

                <xsl:variable name="Cx" select="substring-before($C, ',')" />
                <xsl:variable name="Cy" select="substring-after($C, ',')" />

                <xsl:call-template name="doSierpinskiArrowheadCurve"> <!-- 1 -->
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x1" select="$Bx" />
                    <xsl:with-param name="y1" select="$By" />
                    <xsl:with-param name="x2" select="$x1" />
                    <xsl:with-param name="y2" select="$y1" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>

                <xsl:value-of select="'M'" />

                <xsl:call-template name="doSierpinskiArrowheadCurve"> <!-- 3 -->
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x1" select="$Bx" />
                    <xsl:with-param name="y1" select="$By" />
                    <xsl:with-param name="x2" select="$Cx" />
                    <xsl:with-param name="y2" select="$Cy" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>

                <xsl:value-of select="'M'" />
                
                <xsl:call-template name="doSierpinskiArrowheadCurve"> <!-- 2 -->
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x1" select="$x2" />
                    <xsl:with-param name="y1" select="$y2" />
                    <xsl:with-param name="x2" select="$Cx" />
                    <xsl:with-param name="y2" select="$Cy" />
                    <xsl:with-param name="h" select="$h div 2" />
                </xsl:call-template>

             </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template name="doSierpinskiTriangle">
        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="size" />
        <xsl:param name="fill" />
        <xsl:param name="regular" select="1" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:variable name="sin_60">
                    <xsl:apply-templates select="$sin">
                        <xsl:with-param name="deg" select="60" />
                    </xsl:apply-templates>
                </xsl:variable>

                <xsl:element name="polygon" xmlns="http://www.w3.org/2000/svg">
                    <xsl:attribute name="rendering-shape">crispEdges</xsl:attribute>
                    <xsl:attribute name="fill">
                        <xsl:value-of select="$fill" />
                    </xsl:attribute>
                    <xsl:attribute name="points">
                        <xsl:value-of select="$x + 0.5 * $size" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y" />
                        <xsl:text> </xsl:text>

                        <xsl:value-of select="$x" />
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$y + $size * $sin_60" />
                        <xsl:text> </xsl:text>
						
                        <xsl:value-of select="$x + $size" />
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$y + $size * $sin_60" />
                    </xsl:attribute>
                </xsl:element>

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="sin_60">
                    <xsl:apply-templates select="$sin">
                        <xsl:with-param name="deg" select="60" />
                    </xsl:apply-templates>
                </xsl:variable>

                <xsl:variable name="nsize" select="0.5 * $size" />

                <!-- LEFT: -->
                <xsl:call-template name="doSierpinskiTriangle">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize * $sin_60" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <!-- TOP: -->
                <xsl:call-template name="doSierpinskiTriangle">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 0.5 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize * $sin_60" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <!-- RIGHT: -->
                <xsl:call-template name="doSierpinskiTriangle">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize * $sin_60" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>


            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="doSierpinskiCarpet">
        <xsl:param name="stage" select="0" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="size" />
        <xsl:param name="fill" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
                    <xsl:attribute name="x"><xsl:value-of select="$x" /></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$y" /></xsl:attribute>
                    <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
                    <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>
                    <xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
                    <xsl:attribute name="shape-rendering"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
                </xsl:element>

            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 3" />

                <!-- TOP ROW: -->

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <!-- MID ROW: -->

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <!-- BOTTOM ROW: -->

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiCarpet">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="fill" select="$fill" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>