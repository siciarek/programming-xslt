<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:julia-mandelbrot-set="julia-mandelbrot-set">

    <julia-mandelbrot-set:julia-mandelbrot-set />
    <xsl:variable name="julia-mandelbrot-set" select="document('')/*/julia-mandelbrot-set:*[1]" />
    <xsl:template name="julia-mandelbrot-set" match="*[namespace-uri()='julia-mandelbrot-set']">

        <xsl:param name="c" select="'0,1'" />
        <xsl:param name="type" select="'julia'" />
        <xsl:param name="stage" select="50" />
        <xsl:param name="x0" select="512 div 2 - 80" />
        <xsl:param name="y0" select="512 div 2 - 60" />
        <xsl:param name="cols" select="160 div 1" />
        <xsl:param name="rows" select="120 div 1" />
        <xsl:param name="border" select="0" />
        <xsl:param name="pixel" select="1" />

        <xsl:variable name="col" select="$pixel mod $cols" />
        <xsl:variable name="row" select="$pixel div $cols" />


        <xsl:variable name="ctick">
            <xsl:choose>
                <xsl:when test="$type = 'mandelbrot'">
                    <xsl:value-of select="3.0 div $cols" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="4.0 div $cols" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="rtick">
            <xsl:choose>
                <xsl:when test="$type = 'mandelbrot'">
                    <xsl:value-of select="2.0 div $rows" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="4.0 div $rows" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="ip">
            <xsl:choose>
                <xsl:when test="$type = 'mandelbrot'">
                    <xsl:value-of select="((1.0 * $rows) div 2.0 - $row) * $rtick" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="((2.0 * $rows) div 4.0 - $row) * $rtick" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="rp">
            <xsl:choose>
                <xsl:when test="$type = 'mandelbrot'">
                    <xsl:value-of select="((-2.0 * $cols) div 3.0 + $col) * $ctick" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="((-2.0 * $cols) div 4.0 + $col) * $ctick" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="cn" select="concat(format-number($rp, '0.####'), ',', format-number($ip, '0.####'))" />

        <xsl:variable name="magnitude">
            <xsl:choose>
                <xsl:when test="$type = 'mandelbrot'">
                    <xsl:call-template name="get-iterations-number">
                        <xsl:with-param name="zX" select="'0,0'" />
                        <xsl:with-param name="zC" select="$cn" />
                        <xsl:with-param name="iterations" select="$stage" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="get-iterations-number">
                        <xsl:with-param name="zX" select="$cn" />
                        <xsl:with-param name="zC" select="$c" />
                        <xsl:with-param name="iterations" select="$stage" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="test">
            <xsl:choose>
                <xsl:when test="$border &gt; 0">
                    <xsl:value-of select="$magnitude &gt;= $stage - 2 * $border and $magnitude &lt;= $stage - 1 * $border" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$magnitude &gt;= $stage" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="string($test) = 'true'">
            <xsl:call-template name="draw-pixel">
                <xsl:with-param name="x" select="$x0 + $col" />
                <xsl:with-param name="y" select="$y0 + $row" />
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="$pixel &lt; $cols * $rows">
            <xsl:call-template name="julia-mandelbrot-set">
                <xsl:with-param name="pixel" select="$pixel + 1" />
                <xsl:with-param name="x0" select="$x0" />
                <xsl:with-param name="y0" select="$y0" />
                <xsl:with-param name="cols" select="$cols" />
                <xsl:with-param name="rows" select="$rows" />
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="border" select="$border" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="c" select="$c" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="get-iterations-number">
        <xsl:param name="zC" />
        <xsl:param name="zX" select="'0.0,0.0'" />
        <xsl:param name="iterations" select="50" />
        <xsl:param name="n" select="0" />

        <xsl:variable name="zX-abs">
            <xsl:call-template name="complex-abs">
                <xsl:with-param name="n" select="$zX" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$zX-abs &gt; 2 or $n &gt;= $iterations">
                <xsl:value-of select="$n" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="nzX">
                    <xsl:call-template name="complex-sum">
                        <xsl:with-param name="a">
                            <xsl:call-template name="complex-square">
                                <xsl:with-param name="n" select="$zX" />
                            </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="b" select="$zC" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="get-iterations-number">
                    <xsl:with-param name="zX" select="$nzX" />
                    <xsl:with-param name="zC" select="$zC" />
                    <xsl:with-param name="n" select="$n + 1" />
                    <xsl:with-param name="iterations" select="$iterations" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>
