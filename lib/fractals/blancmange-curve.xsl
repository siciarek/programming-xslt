<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:blancmange-curve="blancmange-curve">

    <xsl:template name="blanc">

        <xsl:param name="s" />
        <xsl:param name="n" select="0" />
        <xsl:param name="x" />
        <xsl:param name="result" select="0" />

        <xsl:choose>
            <xsl:when test="$n = 0">
                <xsl:value-of select="$result" />
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="two-to-n">
                    <xsl:call-template name="power">
                        <xsl:with-param name="base" select="2" />
                        <xsl:with-param name="exponent" select="$n - 1" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="s-result">
                    <xsl:apply-templates select="$s">
                        <xsl:with-param name="n" select="$n" />
                        <xsl:with-param name="x" select="$two-to-n * $x" />
                    </xsl:apply-templates>
                </xsl:variable>

                <xsl:call-template name="blanc">
                    <xsl:with-param name="n" select="$n - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="s" select="$s" />
                    <xsl:with-param name="result" select="$result + ($s-result div $two-to-n)" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <blancmange-curve:blancmange-curve />
    <xsl:variable name="blancmange-curve" select="document('')/*/blancmange-curve:*[1]" />
    <xsl:template name="blancmange-curve" match="*[namespace-uri()='blancmange-curve']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="size" select="512" />

        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="512" />

        <xsl:variable name="powstage">
            <xsl:call-template name="power">
                <xsl:with-param name="base" select="2" />
                <xsl:with-param name="exponent" select="$stage" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="do-blancmange-curve">
            <xsl:with-param name="n" select="$stage + 1" />
            <xsl:with-param name="stage" select="$powstage" />
            <xsl:with-param name="size" select="$size" />
            <xsl:with-param name="x" select="$x" />
            <xsl:with-param name="yoffset" select="$y" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="do-blancmange-curve">

        <xsl:param name="n" />
        <xsl:param name="stage" />
        <xsl:param name="size" />
        <xsl:param name="x" select="0" />
        <xsl:param name="yoffset" />

        <xsl:param name="blanc-result" select="''" />
        <xsl:param name="prev-blanc-result" select="''" />
        <xsl:param name="saw-result" select="''" />

        <xsl:variable name="blanc-tick" select="1 div $size" />
        <xsl:variable name="saw-tick" select="$stage div $size" />

        <xsl:variable name="saw-value">
            <xsl:call-template name="saw">
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="x" select="$x * $saw-tick" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="saw-y" select="$yoffset + $saw-value div $saw-tick" />

        <xsl:variable name="blanc-value">
            <xsl:call-template name="blanc">
                <xsl:with-param name="s" select="$saw" />
                <xsl:with-param name="n" select="$n" />
                <xsl:with-param name="x" select="$x * $blanc-tick" />
            </xsl:call-template>
        </xsl:variable>



        <xsl:variable name="prev-blanc-value">
            <xsl:call-template name="blanc">
                <xsl:with-param name="s" select="$saw" />
                <xsl:with-param name="n">
                    <xsl:choose>
                        <xsl:when test="$n = 1">
                            <xsl:value-of select="$n" />                        
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$n - 1" />                        
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="x" select="$x * $blanc-tick" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="blanc-y" select="$yoffset + $blanc-value div $blanc-tick" />
        <xsl:variable name="prev-blanc-y" select="$yoffset + $prev-blanc-value div $blanc-tick" />

        <xsl:variable name="blanc-point" select="concat($x, ',', $blanc-y)" />
        <xsl:variable name="prev-blanc-point" select="concat($x, ',', $prev-blanc-y)" />
        <xsl:variable name="saw-point" select="concat($x, ',', $saw-y)" />

        <xsl:variable name="nblanc-result" select="concat($blanc-result, ' ', $blanc-point)" />
        <xsl:variable name="nprev-blanc-result" select="concat($prev-blanc-result, ' ', $prev-blanc-point)" />
        <xsl:variable name="nsaw-result" select="concat($saw-result, ' ', $saw-point)" />

        <xsl:choose>
            <xsl:when test="$x &gt;= $size">
                <xsl:value-of select="concat(normalize-space($nblanc-result), ';', normalize-space($nsaw-result), ';', normalize-space($nprev-blanc-result), ';')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="do-blancmange-curve">
                    <xsl:with-param name="n" select="$n" />
                    <xsl:with-param name="stage" select="$stage" />
                    <xsl:with-param name="x" select="$x + 1" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="yoffset" select="$yoffset" />
                    <xsl:with-param name="blanc-result" select="$nblanc-result" />
                    <xsl:with-param name="prev-blanc-result" select="$nprev-blanc-result" />
                    <xsl:with-param name="saw-result" select="$nsaw-result" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>

</xsl:stylesheet>