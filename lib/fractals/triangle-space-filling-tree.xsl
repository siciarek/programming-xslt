<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:triangle-space-filling-tree="triangle-space-filling-tree">

    <triangle-space-filling-tree:triangle-space-filling-tree />
    <xsl:variable name="triangle-space-filling-tree" select="document('')/*/triangle-space-filling-tree:*[1]" />
    <xsl:template name="triangle-space-filling-tree" match="*[namespace-uri()='triangle-space-filling-tree']">
        <xsl:param name="stage" />
        <xsl:param name="x" select="512 div 2" />
        <xsl:param name="y" select="512 div 2 + 52" />
        <xsl:param name="size" select="512 div 4" />
        <xsl:param name="rotation" select="0" />

				<xsl:variable name="v_1">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

				<xsl:variable name="v_2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="120 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="v_3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="240 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('L', $v_1, ' ')" />
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('L', $v_2, ' ')" />
                <xsl:value-of select="concat('M', $x, ',', $y, ' ')" />
                <xsl:value-of select="concat('L', $v_3, ' ')" />
            
			<xsl:if test="$stage &gt; 0" >
                
                <xsl:variable name="nsize" select="$size div 2" />
                <xsl:variable name="nrotation" select="$rotation mod 120" />
                
				<xsl:variable name="p_1">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="0 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

				<xsl:variable name="p_2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="120 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p_3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="240 + $rotation" />
                        <xsl:with-param name="base_x" select="$x" />
                        <xsl:with-param name="base_y" select="$y" />
                        <xsl:with-param name="point_x" select="$x" />
                        <xsl:with-param name="point_y" select="$y - $size" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="triangle-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="rotation" select="$nrotation + 60" />
                </xsl:call-template>

                <xsl:call-template name="triangle-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="substring-before($p_1, ',')" />
                    <xsl:with-param name="y" select="substring-after($p_1, ',')" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="rotation" select="$nrotation" />
                </xsl:call-template>

                <xsl:call-template name="triangle-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="substring-before($p_2, ',')" />
                    <xsl:with-param name="y" select="substring-after($p_2, ',')" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="rotation" select="$nrotation" />
                </xsl:call-template>
            
                <xsl:call-template name="triangle-space-filling-tree">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="substring-before($p_3, ',')" />
                    <xsl:with-param name="y" select="substring-after($p_3, ',')" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="rotation" select="$nrotation" />
                </xsl:call-template>
            
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>