<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:square-space-filling-tree="square-space-filling-tree">

    <square-space-filling-tree:square-space-filling-tree />
    <xsl:variable name="square-space-filling-tree" select="document('')/*/square-space-filling-tree:*[1]" />
    <xsl:template name="square-space-filling-tree" match="*[namespace-uri()='square-space-filling-tree']">
        <xsl:param name="stage" />
        <xsl:param name="x" select="512 div 2" />
        <xsl:param name="y" select="512 div 2" />
        <xsl:param name="size" select="512 div 4" />

<!-- http://en.wikipedia.org/wiki/Space-filling_tree -->
        
        <xsl:choose>
            <xsl:when test="$stage = 0">
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('l', $size, ' ', $size, ' ')" />
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('l', $size, ' ', -$size, ' ')" />
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('l', -$size, ' ', -$size, ' ')" />
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('l', -$size, ' ', $size, ' ')" />
            </xsl:when>
            <xsl:otherwise>
                
                <xsl:variable name="nsize" select="$size div 2" />
                
                <xsl:call-template name="square-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="square-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + $size" />
                    <xsl:with-param name="y" select="$y + $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>
            
                <xsl:call-template name="square-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + $size" />
                    <xsl:with-param name="y" select="$y - $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>
            
                <xsl:call-template name="square-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $size" />
                    <xsl:with-param name="y" select="$y + $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>
            
                <xsl:call-template name="square-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x - $size" />
                    <xsl:with-param name="y" select="$y - $size" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>
            
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>