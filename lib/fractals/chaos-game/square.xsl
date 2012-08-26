<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:chaos-game-square="chaos-game-square">

    <chaos-game-square:chaos-game-square />
    <xsl:variable name="chaos-game-square" select="document('')/*/chaos-game-square:*[1]" />
    <xsl:template name="chaos-game-square" match="*[namespace-uri()='chaos-game-square']">

        <xsl:param name="stage" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="width" select="512" />
        <xsl:param name="height" select="512" />
        <xsl:param name="seed" />

        <xsl:call-template name="do-chaos-game-square">
            <xsl:with-param name="stage" select="$stage" />
            <xsl:with-param name="seed" select="$seed" />
			<xsl:with-param name="sides" select="4" />
			<xsl:with-param name="a" select="2 div 3" />

            <xsl:with-param name="x" select="$x" />
            <xsl:with-param name="y" select="$y" />

            <xsl:with-param name="x1" select="0" />
            <xsl:with-param name="y1" select="0" />

            <xsl:with-param name="x2" select="$width" />
            <xsl:with-param name="y2" select="0" />

            <xsl:with-param name="x3" select="$width" />
            <xsl:with-param name="y3" select="$height" />

            <xsl:with-param name="x4" select="0" />
            <xsl:with-param name="y4" select="$height" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="do-chaos-game-square">

		<xsl:param name="stage" />
        <xsl:param name="sides" />
        <xsl:param name="a" />

<!-- iterated point: -->

        <xsl:param name="x" />
        <xsl:param name="y" />

<!-- base square vertices -->

        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="x3" />
        <xsl:param name="y3" />
        <xsl:param name="x4" />
        <xsl:param name="y4" />

        <xsl:param name="seed" />

        <xsl:variable name="rand" select="substring-before($seed, ' ')" />
        <xsl:variable name="tail" select="substring-after($seed, ' ')" />

        <xsl:variable name="vx">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 1 * (1 div $sides)">
                    <xsl:value-of select="$x1" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 2 * (1 div $sides)">
                    <xsl:value-of select="$x2" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 3 * (1 div $sides)">
                    <xsl:value-of select="$x3" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$x4" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="vy">
            <xsl:choose>
                <xsl:when test="$rand &lt;= 1 * (1 div $sides)">
                    <xsl:value-of select="$y1" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 2 * (1 div $sides)">
                    <xsl:value-of select="$y2" />
                </xsl:when>
                <xsl:when test="$rand &lt;= 3 * (1 div $sides)">
                    <xsl:value-of select="$y3" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$y4" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="nx" select="$x + ($vx - $x) * $a" />
        <xsl:variable name="ny" select="$y + ($vy - $y) * $a" />

        <xsl:variable name="pixel_x" select="round($nx)" />
        <xsl:variable name="pixel_y" select="round($ny)" />

        <xsl:call-template name="draw-pixel">
            <xsl:with-param name="x" select="$pixel_x" />
            <xsl:with-param name="y" select="$pixel_y" />
        </xsl:call-template>

        <xsl:if test="$stage &gt; 0 and $tail">
            <xsl:call-template name="do-chaos-game-square">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="seed" select="$tail" />
                <xsl:with-param name="sides" select="$sides" />
                <xsl:with-param name="a" select="$a" />

                <xsl:with-param name="x" select="$nx" />
                <xsl:with-param name="y" select="$ny" />

                <xsl:with-param name="x1" select="$x1" />
                <xsl:with-param name="y1" select="$y1" />

                <xsl:with-param name="x2" select="$x2" />
                <xsl:with-param name="y2" select="$y2" />

                <xsl:with-param name="x3" select="$x3" />
                <xsl:with-param name="y3" select="$y3" />

                <xsl:with-param name="x4" select="$x4" />
                <xsl:with-param name="y4" select="$y4" />

            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>