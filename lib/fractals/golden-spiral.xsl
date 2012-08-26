<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet id="stylesheet" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="xsl:stylesheet" />

    <xsl:template name="golden-spiral">

        <xsl:param name="stage" select="2" />
        <xsl:param name="size" select="512" />
        
        <xsl:variable name="gr">
            <xsl:variable name="sqrt_5">
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="num" select="5" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="(1 + $sqrt_5) div 2" />
        </xsl:variable>

        <xsl:variable name="width" select="$size * $gr" />
        <xsl:variable name="height" select="$size" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">

            <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>

            <xsl:call-template name="do-golden-spiral">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="gr" select="$gr" />
            </xsl:call-template>

        </xsl:element>

    </xsl:template>
    
    <xsl:template name="do-golden-spiral">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" />
        <xsl:param name="color" select="51" />
        <xsl:param name="gr" />

        <xsl:variable name="linecolor" select="'red'" />
        <xsl:variable name="linewidth" select="4" />
        <xsl:variable name="coloffset" select="20" />
        <xsl:variable name="nsize" select="$size div $gr div $gr div $gr div $gr" />
        <xsl:variable name="nx" select="$x + $size" />
        <xsl:variable name="ny" select="$y + $size div $gr" />

        <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="x"><xsl:value-of select="$x" /></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$y" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>
            <xsl:attribute name="fill"><xsl:value-of select="concat('rgb(', $color + 0 * $coloffset,',', $color + 0 * $coloffset,',', $color + 0 * $coloffset,')')" /></xsl:attribute>
        </xsl:element>
      
        <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
            <xsl:attribute name="stroke"><xsl:value-of select="$linecolor" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$linewidth" /></xsl:attribute>
            <xsl:attribute name="d"><xsl:value-of select="concat('M ', $x, ' ', $y + $size, 'a ', $size, ',', $size, ' 0 0,1 ',  $size, ',', -1 * $size)" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="x"><xsl:value-of select="$nx" /></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$y" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$size div $gr" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size div $gr" /></xsl:attribute>
            <xsl:attribute name="fill"><xsl:value-of select="concat('rgb(', $color + 1 * $coloffset,',', $color + 1 * $coloffset,',', $color + 1 * $coloffset,')')" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
            <xsl:attribute name="stroke"><xsl:value-of select="$linecolor" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$linewidth" /></xsl:attribute>
            <xsl:attribute name="d"><xsl:value-of select="concat('M ', $x + $size, ' ', $y, 'a ', $size div $gr, ',', $size div $gr, ' 0 0,1 ',  $size div $gr, ',', $size div $gr)" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="x"><xsl:value-of select="$x + $size + $nsize * $gr" /></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$ny" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$size div $gr div $gr" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$size div $gr div $gr" /></xsl:attribute>
            <xsl:attribute name="fill"><xsl:value-of select="concat('rgb(', $color + 2 * $coloffset,',', $color + 2 * $coloffset,',', $color + 2 * $coloffset,')')" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
            <xsl:attribute name="stroke"><xsl:value-of select="$linecolor" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$linewidth" /></xsl:attribute>
            <xsl:attribute name="d"><xsl:value-of select="concat('M ', $x + $size + $size div $gr, ' ', $y + $size div $gr, 'a ', $size div $gr div $gr, ',', $size div $gr div $gr, ' 0 0,1 ',  -1 * $size div $gr div $gr, ',', $size div $gr div $gr)" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="x"><xsl:value-of select="$nx" /></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$ny + $nsize" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$nsize * $gr" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$nsize * $gr" /></xsl:attribute>
            <xsl:attribute name="fill"><xsl:value-of select="concat('rgb(', $color + 3 * $coloffset,',', $color + 3 * $coloffset,',', $color + 3 * $coloffset,')')" /></xsl:attribute>
        </xsl:element>

        <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
            <xsl:attribute name="stroke"><xsl:value-of select="$linecolor" /></xsl:attribute>
            <xsl:attribute name="stroke-width"><xsl:value-of select="$linewidth" /></xsl:attribute>
            <xsl:attribute name="d"><xsl:value-of select="concat('M ', $x + $size, ' ', $ny + $nsize, 'a ', $size div $gr div $gr div $gr, ',', $size div $gr div $gr div $gr, ' 0 0,0 ',  $size div $gr div $gr div $gr, ',', $size div $gr div $gr div $gr)" /></xsl:attribute>
        </xsl:element>


        <xsl:if test="$stage &gt; 0">
            <xsl:call-template name="do-golden-spiral">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="x" select="$nx" />
                <xsl:with-param name="y" select="$ny" />
                <xsl:with-param name="gr" select="$gr" />
                <xsl:with-param name="size" select="$nsize" />
                <xsl:with-param name="color" select="$color + 4 * $coloffset" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>




</xsl:stylesheet>