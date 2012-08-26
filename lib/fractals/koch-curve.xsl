<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:koch-curve="koch-curve"
xmlns:kochSnowflake="kochSnowflake"
>
 
    <koch-curve:koch-curve />
    <xsl:variable name="koch-curve" select="document('')/*/koch-curve:*[1]" />
    <xsl:template name="koch-curve" match="*[namespace-uri()='koch-curve']">

        <xsl:param name="stage" select="1" />
        <xsl:param name="type" select="'triangular'" />
        <xsl:param name="color" select="'#000000'" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="angle">
            <xsl:choose>
                <xsl:when test="string($type) = 'quadratic'">
                    <xsl:value-of select="90" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="60" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="sin_a">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="$angle" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="offset" select="$sin_a * ($size div (180 div $angle))" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version"><xsl:value-of select="'1.1'" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>

            <xsl:element name="path">
                <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>

                <xsl:attribute name="d">
                    <xsl:text>M 0 </xsl:text><xsl:value-of select="$size div 2" /><xsl:text> L</xsl:text>
                    <xsl:call-template name="dokoch-curve">
                        <xsl:with-param name="x1" select="0" />
                        <xsl:with-param name="y1" select="$size div 2" />
                        <xsl:with-param name="x2" select="$size" />
                        <xsl:with-param name="y2" select="$size div 2" />
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="angle" select="$angle" />
                    </xsl:call-template>
                </xsl:attribute>

            </xsl:element>

        </xsl:element>
    </xsl:template>

    <kochSnowflake:kochSnowflake />
    <xsl:variable name="kochSnowflake" select="document('')/*/kochSnowflake:*[1]" />
    <xsl:template name="kochSnowflake" match="*[namespace-uri()='kochSnowflake']">

        <xsl:param name="stage" select="6" />
        <xsl:param name="type" select="'triangular'" />
        <xsl:param name="color" select="'rgb(0, 0, 0)'" />
        <xsl:param name="size" select="512" />

        <xsl:variable name="angle">
            <xsl:choose>
                <xsl:when test="string($type) = 'quadratic'">
                    <xsl:value-of select="90" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="60" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="sin_a">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="$angle" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="xoffset">
            <xsl:variable name="temp">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="3" />
                    <xsl:with-param name="exponent" select="$stage" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$stage &gt; 0">
                    <xsl:value-of select="$size div $temp" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0" />

                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:variable name="yoffset" select="$sin_a * ($size div (180 div $angle))" />
        <xsl:variable name="top_x" select="$size div 2" />
        <xsl:variable name="top_y" select="($sin_a * $size) + $yoffset" />

        <xsl:text>&#10;</xsl:text>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:text>&#10;</xsl:text>

            <xsl:element name="path">
                <xsl:attribute name="fill"><xsl:value-of select="'#EFEFFF'" /></xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>

                <xsl:attribute name="d">
                    
                    <xsl:value-of select="concat('M', 0, ' ', $yoffset)" />
                    <xsl:text> L</xsl:text>

                    <xsl:call-template name="dokoch-curve">
                        <xsl:with-param name="x1" select="0" />
                        <xsl:with-param name="y1" select="$yoffset" />
                        <xsl:with-param name="x2" select="$size" />
                        <xsl:with-param name="y2" select="$yoffset" />
                        <xsl:with-param name="stage" select="$stage" />
                        <xsl:with-param name="angle" select="$angle" />
                    </xsl:call-template>
                    
                    <xsl:choose>
                        <xsl:when test="string($type) = 'quadratic'">
                            <xsl:value-of select="concat('L', ($size), ' ', ($yoffset + $xoffset))" />
                            <xsl:call-template name="dokoch-curve">
                                <xsl:with-param name="x1" select="$size" />
                                <xsl:with-param name="y1" select="$yoffset + $xoffset" />
                                <xsl:with-param name="x2" select="0" />
                                <xsl:with-param name="y2" select="$yoffset + $xoffset" />
                                <xsl:with-param name="stage" select="$stage" />
                                <xsl:with-param name="angle" select="$angle" />
                            </xsl:call-template>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:call-template name="dokoch-curve">
                                <xsl:with-param name="x1" select="$size" />
                                <xsl:with-param name="y1" select="$yoffset" />
                                <xsl:with-param name="x2" select="$top_x" />
                                <xsl:with-param name="y2" select="$top_y" />
                                <xsl:with-param name="stage" select="$stage" />
                                <xsl:with-param name="angle" select="$angle" />
                            </xsl:call-template>
        
                            <xsl:call-template name="dokoch-curve">
                                <xsl:with-param name="x1" select="$top_x" />
                                <xsl:with-param name="y1" select="$top_y" />
                                <xsl:with-param name="x2" select="0" />
                                <xsl:with-param name="y2" select="$yoffset" />
                                <xsl:with-param name="stage" select="$stage" />
                                <xsl:with-param name="angle" select="$angle" />
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:text>Z</xsl:text>
                </xsl:attribute>

            </xsl:element>

            <xsl:text>&#10;</xsl:text>
        </xsl:element>
    </xsl:template>

    <xsl:template name="dokoch-curve">
        <xsl:param name="stage" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="angle" />

        <xsl:choose>

            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat(' ', $x2, ' ', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="sin_a">
                    <xsl:apply-templates select="$sin">
                        <xsl:with-param name="deg" select="$angle" />
                    </xsl:apply-templates>
                </xsl:variable>

                <xsl:variable name="delta_x" select="$x2 - $x1" />
                <xsl:variable name="delta_y" select="$y2 - $y1" />



                <xsl:variable name="start_x" select="$x1" />
                <xsl:variable name="start_y" select="$y1" />

                <xsl:variable name="left_x" select="$x1 + $delta_x div 3" />
                <xsl:variable name="left_y" select="$y1 + $delta_y div 3" />


                <xsl:variable name="right_x" select="$x1 + 2 * ($delta_x div 3)" />
                <xsl:variable name="right_y" select="$y1 + 2 * ($delta_y div 3)" />


                <xsl:variable name="end_x" select="$x2" />
                <xsl:variable name="end_y" select="$y2" />

                <xsl:call-template name="dokoch-curve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x1" select="$start_x" />
                    <xsl:with-param name="y1" select="$start_y" />
                    <xsl:with-param name="x2" select="$left_x" />
                    <xsl:with-param name="y2" select="$left_y" />
                    <xsl:with-param name="angle" select="$angle" />
                </xsl:call-template>


                <xsl:choose>
                
                <!-- QUADRATIC CURVE: -->

                    <xsl:when test="$angle = 90 or $angle = -90">

                        <xsl:variable name="left_top">
                            <xsl:call-template name="protate">
                                <xsl:with-param name="base_x" select="$left_x" />
                                <xsl:with-param name="base_y" select="$left_y" />
                                <xsl:with-param name="point_x" select="$right_x" />
                                <xsl:with-param name="point_y" select="$right_y" />
                                <xsl:with-param name="angle" select="-1 * $angle" />
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="left_top_x" select="substring-before($left_top, ',')" />
                        <xsl:variable name="left_top_y" select="substring-after($left_top, ',')" />

                        <xsl:variable name="right_top">
                            <xsl:call-template name="protate">
                                <xsl:with-param name="base_x" select="$right_x" />
                                <xsl:with-param name="base_y" select="$right_y" />
                                <xsl:with-param name="point_x" select="$left_x" />
                                <xsl:with-param name="point_y" select="$left_y" />
                                <xsl:with-param name="angle" select="1 * $angle" />
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="right_top_x" select="substring-before($right_top, ',')" />
                        <xsl:variable name="right_top_y" select="substring-after($right_top, ',')" />

                        <xsl:call-template name="dokoch-curve">
                            <xsl:with-param name="stage" select="$stage - 1" />
                            <xsl:with-param name="x1" select="$left_x" />
                            <xsl:with-param name="y1" select="$left_y" />
                            <xsl:with-param name="x2" select="$left_top_x" />
                            <xsl:with-param name="y2" select="$left_top_y" />
                            <xsl:with-param name="angle" select="$angle" />
                        </xsl:call-template>

                        <xsl:call-template name="dokoch-curve">
                            <xsl:with-param name="stage" select="$stage - 1" />
                            <xsl:with-param name="x1" select="$left_top_x" />
                            <xsl:with-param name="y1" select="$left_top_y" />
                            <xsl:with-param name="x2" select="$right_top_x" />
                            <xsl:with-param name="y2" select="$right_top_y" />
                            <xsl:with-param name="angle" select="$angle" />
                        </xsl:call-template>

                        <xsl:call-template name="dokoch-curve">
                            <xsl:with-param name="stage" select="$stage - 1" />
                            <xsl:with-param name="x1" select="$right_top_x" />
                            <xsl:with-param name="y1" select="$right_top_y" />
                            <xsl:with-param name="x2" select="$right_x" />
                            <xsl:with-param name="y2" select="$right_y" />
                            <xsl:with-param name="angle" select="$angle" />
                        </xsl:call-template>
                    </xsl:when>
                
                <!-- DEFAULT TRIANGULAR CURVE: -->

                    <xsl:otherwise>

                        <xsl:variable name="mid">
                            <xsl:call-template name="protate">
                                <xsl:with-param name="base_x" select="$right_x" />
                                <xsl:with-param name="base_y" select="$right_y" />
                                <xsl:with-param name="point_x" select="$left_x" />
                                <xsl:with-param name="point_y" select="$left_y" />
                                <xsl:with-param name="angle" select="$angle" />
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="mid_x" select="substring-before($mid, ',')" />
                        <xsl:variable name="mid_y" select="substring-after($mid, ',')" />

                        <xsl:call-template name="dokoch-curve">
                            <xsl:with-param name="stage" select="$stage - 1" />
                            <xsl:with-param name="x1" select="$left_x" />
                            <xsl:with-param name="y1" select="$left_y" />
                            <xsl:with-param name="x2" select="$mid_x" />
                            <xsl:with-param name="y2" select="$mid_y" />
                            <xsl:with-param name="angle" select="$angle" />
                        </xsl:call-template>

                        <xsl:call-template name="dokoch-curve">
                            <xsl:with-param name="stage" select="$stage - 1" />
                            <xsl:with-param name="x1" select="$mid_x" />
                            <xsl:with-param name="y1" select="$mid_y" />
                            <xsl:with-param name="x2" select="$right_x" />
                            <xsl:with-param name="y2" select="$right_y" />
                            <xsl:with-param name="angle" select="$angle" />
                        </xsl:call-template>
                    </xsl:otherwise>

                </xsl:choose>

                <xsl:call-template name="dokoch-curve">
                    <xsl:with-param name="x1" select="$right_x" />
                    <xsl:with-param name="y1" select="$right_y" />
                    <xsl:with-param name="x2" select="$end_x" />
                    <xsl:with-param name="y2" select="$end_y" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="angle" select="$angle" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>