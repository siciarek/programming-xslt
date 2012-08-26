<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:haferman-carpet="haferman-carpet">

    <haferman-carpet:haferman-carpet />
    <xsl:variable name="haferman-carpet" select="document('')/*/haferman-carpet:*[1]" />
    <xsl:template name="haferman-carpet" match="*[namespace-uri()='haferman-carpet']">

        <xsl:param name="stage" select="1" />
        <xsl:param name="type" select="1" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="size" select="512" />
        <xsl:param name="color" select="'rgb(0,0,0)'" />


        <xsl:choose>
            <xsl:when test="$stage &gt; 0">

                <xsl:variable name="nsize" select="$size div 3" />

                <xsl:variable name="ntype">
                    <xsl:choose>
                        <xsl:when test="$type = 1">
                            <xsl:value-of select="0" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="1" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

<!-- TOP: -->

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$ntype" />
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="1" />
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$ntype" />
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

<!-- MID: -->

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="1" />
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$ntype" />
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="1" />
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

<!-- BOTTOM: -->

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$ntype" />
                   <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="1" />
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

                <xsl:call-template name="haferman-carpet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="type" select="$ntype" />
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />    
                    <xsl:with-param name="size" select="$nsize" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>

                <xsl:if test="$type = 1">
                    <xsl:value-of select="concat('M', $x, ',', $y)" />
                    <xsl:value-of select="concat('h', $size)" />
                    <xsl:value-of select="concat('v', $size)" />
                    <xsl:value-of select="concat('h', -$size)" />
                    <xsl:value-of select="'Z'" />
                </xsl:if>

            </xsl:otherwise>
        </xsl:choose>



    </xsl:template>


</xsl:stylesheet>