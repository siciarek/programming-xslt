<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gosper-island="gosper-island">

    <gosper-island:gosper-island />
    <xsl:variable name="gosper-island" select="document('')/*/gosper-island:*[1]" />
    <xsl:template name="gosper-island" match="*[namespace-uri()='gosper-island']">

        <xsl:param name="stage" select="0" />
        <xsl:param name="size" select="512" />
		
		<xsl:variable name="stagesquare">
			<xsl:call-template name="power">
				<xsl:with-param name="base" select="3" />
				<xsl:with-param name="exponent" select="$stage" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="cx" select="$size div 2" />
		<xsl:variable name="cy" select="$size div 2" />
		<xsl:variable name="radius" select="$size div 3" />
		<xsl:variable name="offset" select="30" /> <!-- 0 -> 30, 1 -> 10, 2-> -->
		
		<xsl:variable name="p1">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="0 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p1x" select="substring-before($p1, ',')" />
		<xsl:variable name="p1y" select="substring-after($p1, ',')" />

		<xsl:variable name="p2">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="1 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p2x" select="substring-before($p2, ',')" />
		<xsl:variable name="p2y" select="substring-after($p2, ',')" />
		
		<xsl:variable name="p3">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="2 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p3x" select="substring-before($p3, ',')" />
		<xsl:variable name="p3y" select="substring-after($p3, ',')" />
		
		<xsl:variable name="p4">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="3 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p4x" select="substring-before($p4, ',')" />
		<xsl:variable name="p4y" select="substring-after($p4, ',')" />

		<xsl:variable name="p5">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="4 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p5x" select="substring-before($p5, ',')" />
		<xsl:variable name="p5y" select="substring-after($p5, ',')" />


		<xsl:variable name="p6">
			<xsl:call-template name="protate">
				<xsl:with-param name="angle" select="5 * 60 + $offset" />
				<xsl:with-param name="base_x" select="$cx" />
				<xsl:with-param name="base_y" select="$cy" />
				<xsl:with-param name="point_x" select="$cx" />
				<xsl:with-param name="point_y" select="$cy - $radius" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="p6x" select="substring-before($p6, ',')" />
		<xsl:variable name="p6y" select="substring-after($p6, ',')" />


		<xsl:value-of select="'M'" />


        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p1x" />
            <xsl:with-param name="y1" select="$p1y" />
            <xsl:with-param name="x2" select="$p2x" />
            <xsl:with-param name="y2" select="$p2y" />
        </xsl:call-template>

        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p2x" />
            <xsl:with-param name="y1" select="$p2y" />
            <xsl:with-param name="x2" select="$p3x" />
            <xsl:with-param name="y2" select="$p3y" />
        </xsl:call-template>

        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p3x" />
            <xsl:with-param name="y1" select="$p3y" />
            <xsl:with-param name="x2" select="$p4x" />
            <xsl:with-param name="y2" select="$p4y" />
        </xsl:call-template>

        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p4x" />
            <xsl:with-param name="y1" select="$p4y" />
            <xsl:with-param name="x2" select="$p5x" />
            <xsl:with-param name="y2" select="$p5y" />
        </xsl:call-template>

        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p5x" />
            <xsl:with-param name="y1" select="$p5y" />
            <xsl:with-param name="x2" select="$p6x" />
            <xsl:with-param name="y2" select="$p6y" />
        </xsl:call-template>

        <xsl:call-template name="gosper-island-motif">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="x1" select="$p6x" />
            <xsl:with-param name="y1" select="$p6y" />
            <xsl:with-param name="x2" select="$p1x" />
            <xsl:with-param name="y2" select="$p1y" />
        </xsl:call-template>

		<xsl:value-of select="'Z'" />
    </xsl:template>

    <xsl:template name="gosper-island-motif">

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
                <xsl:value-of select="concat(' ', $x2, ',', $y2)" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="sqrt_7">
                    <xsl:call-template name="sqrt">
                        <xsl:with-param name="num" select="7" />
                    </xsl:call-template>
                </xsl:variable>
 
                <xsl:variable name="x-by-a" select="($x2 - $x1) div $sqrt_7" />
                <xsl:variable name="y-by-a" select="($y2 - $y1) div $sqrt_7" />

                <xsl:variable name="p1x" select="$x1" />
                <xsl:variable name="p1y" select="$y1" />

                <xsl:variable name="p2">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="19.5" />
                        <xsl:with-param name="base_x" select="$p1x" />
                        <xsl:with-param name="base_y" select="$p1y" />
                        <xsl:with-param name="point_x" select="$p1x + $x-by-a" />
                        <xsl:with-param name="point_y" select="$p1y + $y-by-a" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p2x" select="substring-before($p2, ',')" />
                <xsl:variable name="p2y" select="substring-after($p2, ',')" />

                <xsl:variable name="p3">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="119.5" />
                        <xsl:with-param name="base_x" select="$p2x" />
                        <xsl:with-param name="base_y" select="$p2y" />
                        <xsl:with-param name="point_x" select="$p1x" />
                        <xsl:with-param name="point_y" select="$p1y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="p3x" select="substring-before($p3, ',')" />
                <xsl:variable name="p3y" select="substring-after($p3, ',')" />

                <xsl:variable name="p4x" select="$x2" />
                <xsl:variable name="p4y" select="$y2" />


                <xsl:call-template name="gosper-island-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p1x" />
                    <xsl:with-param name="y1" select="$p1y" />
                    <xsl:with-param name="x2" select="$p2x" />
                    <xsl:with-param name="y2" select="$p2y" />
                </xsl:call-template>

                <xsl:call-template name="gosper-island-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p2x" />
                    <xsl:with-param name="y1" select="$p2y" />
                    <xsl:with-param name="x2" select="$p3x" />
                    <xsl:with-param name="y2" select="$p3y" />
                </xsl:call-template>

                <xsl:call-template name="gosper-island-motif">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$type" />
                    <xsl:with-param name="x1" select="$p3x" />
                    <xsl:with-param name="y1" select="$p3y" />
                    <xsl:with-param name="x2" select="$p4x" />
                    <xsl:with-param name="y2" select="$p4y" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>