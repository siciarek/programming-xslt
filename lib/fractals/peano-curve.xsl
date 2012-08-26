<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:peano-curve="peano-curve">

    <peano-curve:peano-curve />
    <xsl:variable name="peano-curve" select="document('')/*/peano-curve:*[1]" />
    <xsl:template name="peano-curve" match="*[namespace-uri()='peano-curve']">

        <xsl:param name="stage" select="3" />
        <xsl:param name="size" select="512 - 2" />
        <xsl:param name="x0" select="1" />
        <xsl:param name="y0" select="512 - 1" />

        <xsl:variable name="nstage" select="2 * $stage" />

        <xsl:variable name="nsize">
            <xsl:variable name="temp">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="3" />
                    <xsl:with-param name="exponent" select="$stage" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$size div ($temp - 1)" />
        </xsl:variable>

        <xsl:variable name="logo-path">
            <xsl:call-template name="peano-curve-logo">
                <xsl:with-param name="stage" select="$nstage" />
                <xsl:with-param name="size" select="$nsize" />
            </xsl:call-template>
        </xsl:variable>


        <xsl:variable name="offsets">
            <xsl:call-template name="pc-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$logo-path" />
            </xsl:call-template>
        </xsl:variable>

       <xsl:variable name="output">
            <xsl:call-template name="generateCurve">
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
                <xsl:with-param name="offsets" select="concat($offsets, ' ')" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="normalize-space($output)" />

<!--         <xsl:variable name="output"> -->
<!--             <xsl:call-template name="generate-curve"> -->
<!--                 <xsl:with-param name="offsets" select="$offsets" /> -->
<!--                 <xsl:with-param name="x0" select="512" /> -->
<!--                 <xsl:with-param name="y0" select="512" /> -->
<!--             </xsl:call-template> -->
<!--         </xsl:variable> -->

<!--         <xsl:value-of select="$logo-path" /> -->
<!--         <xsl:value-of select="'&#10;'" /> -->
<!--         <xsl:value-of select="$offsets" /> -->

<!--         <xsl:value-of select="'hideturtle '" /> -->
<!--         <xsl:value-of select="normalize-space($normalized-logo-path)" /> -->

    </xsl:template>

    <xsl:template name="pc-logo-to-offsets">
        <xsl:param name="logo-path" select="''" />
        <xsl:param name="angle" select="0" />

        <xsl:variable name="head" select="substring-before($logo-path, ' pd ')" />
        <xsl:variable name="tail" select="substring-after($logo-path, ' pd ')" />

        <xsl:if test="$tail">

            <xsl:variable name="tmpmove">
                <xsl:choose>
                    <xsl:when test="$head">
                        <xsl:value-of select="$head" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$logo-path" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="move" select="normalize-space(translate(translate($tmpmove, 'rt', ' '), 'fd', ' '))" />
            <xsl:variable name="_angle" select="substring-before($move, ' ')" />
            <xsl:variable name="_length" select="substring-after($move, ' ')" />

            <xsl:variable name="nangle" select="$angle + $_angle" />

            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="$nangle" />
                <xsl:with-param name="base_x" select="0" />
                <xsl:with-param name="base_y" select="0" />
                <xsl:with-param name="point_x" select="0" />
                <xsl:with-param name="point_y" select="-$_length" />
            </xsl:call-template>

            <xsl:value-of select="' '" />

            <xsl:call-template name="pc-logo-to-offsets">
                <xsl:with-param name="logo-path" select="$tail" />
                <xsl:with-param name="angle" select="$nangle" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>


    <xsl:template name="peano-curve-logo">

        <xsl:param name="stage" select="2" />
        <xsl:param name="size" select="3" />
        <xsl:param name="parity" select="1" />

        <xsl:if test="$stage &gt;= 1">

            <xsl:value-of select="concat('rt ', $parity * 90, ' ')" />
            <xsl:value-of select="concat('fd ', 0, ' pd ')" />

            <xsl:call-template name="peano-curve-logo">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="parity" select="-$parity" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', 0, ' ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />

            <xsl:call-template name="peano-curve-logo">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="parity" select="$parity" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', 0, ' ')" />
            <xsl:value-of select="concat('fd ', $size, ' pd ')" />

            <xsl:call-template name="peano-curve-logo">
                <xsl:with-param name="stage" select="$stage - 1" />
                <xsl:with-param name="size" select="$size" />
                <xsl:with-param name="parity" select="-$parity" />
            </xsl:call-template>

            <xsl:value-of select="concat('rt ', -$parity * 90, ' ')" />
            <xsl:value-of select="concat('fd ', 0, ' pd ')" />

        </xsl:if>

    </xsl:template>
</xsl:stylesheet>