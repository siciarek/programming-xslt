<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sincos="sincos" xmlns:sin="sin"
    xmlns:cos="cos" xmlns:abs="abs" xmlns:protate="protate" xmlns:runge-kutta="runge-kutta" xmlns:power="power" xmlns:rotatePath="rotatePath" xmlns:saw="saw" xmlns:sign="sign">

    <runge-kutta:runge-kutta />
    <xsl:variable name="runge-kutta" select="document('')/*/runge-kutta:*[1]" />
    <xsl:template name="runge-kutta" match="*[namespace-uri()='runge-kutta']">

        <xsl:param name="h" select="0.01" />
        <xsl:param name="function" />
        <xsl:param name="t" select="0" />
        <xsl:param name="x" select="0" />
        <xsl:param name="y" select="0" />
        <xsl:param name="z" select="0" />

        <xsl:variable name="d1">
            <xsl:apply-templates select="$function">
                <xsl:with-param name="x" select="$x" />
                <xsl:with-param name="y" select="$y" />
                <xsl:with-param name="z" select="$z" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="d1x" select="$h * substring-before($d1, ';')" />
        <xsl:variable name="d1_tail" select="substring-after($d1, ';')" />
        <xsl:variable name="d1y" select="$h * substring-before($d1_tail, ';')" />
        <xsl:variable name="d1z" select="$h * substring-after($d1_tail, ';')" />

        <xsl:variable name="d2">
            <xsl:apply-templates select="$function">
                <xsl:with-param name="x" select="$x + 0.5 * $d1x" />
                <xsl:with-param name="y" select="$y + 0.5 * $d1y" />
                <xsl:with-param name="z" select="$z + 0.5 * $d1z" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="d2x" select="$h * substring-before($d2, ';')" />
        <xsl:variable name="d2_tail" select="substring-after($d2, ';')" />
        <xsl:variable name="d2y" select="$h * substring-before($d2_tail, ';')" />
        <xsl:variable name="d2z" select="$h * substring-after($d2_tail, ';')" />


        <xsl:variable name="d3">
            <xsl:apply-templates select="$function">
                <xsl:with-param name="x" select="$x + 0.5 * $d2x" />
                <xsl:with-param name="y" select="$y + 0.5 * $d2y" />
                <xsl:with-param name="z" select="$z + 0.5 * $d2z" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="d3x" select="$h * substring-before($d3, ';')" />
        <xsl:variable name="d3_tail" select="substring-after($d3, ';')" />
        <xsl:variable name="d3y" select="$h * substring-before($d3_tail, ';')" />
        <xsl:variable name="d3z" select="$h * substring-after($d3_tail, ';')" />


        <xsl:variable name="d4">
            <xsl:apply-templates select="$function">
                <xsl:with-param name="x" select="$x + $d3x" />
                <xsl:with-param name="y" select="$y + $d3y" />
                <xsl:with-param name="z" select="$z + $d3z" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="d4x" select="$h * substring-before($d4, ';')" />
        <xsl:variable name="d4_tail" select="substring-after($d4, ';')" />
        <xsl:variable name="d4y" select="$h * substring-before($d4_tail, ';')" />
        <xsl:variable name="d4z" select="$h * substring-after($d4_tail, ';')" />

        <xsl:variable name="newx" select="$x + ($d1x + $d2x * 2 + $d3x * 2 + $d4x) div 6.0" />
        <xsl:variable name="newy" select="$y + ($d1y + $d2y * 2 + $d3y * 2 + $d4y) div 6.0" />
        <xsl:variable name="newz" select="$z + ($d1z + $d2z * 2 + $d3z * 2 + $d4z) div 6.0" />

        <xsl:variable name="nfrm" select="'0.########'" />
        <xsl:value-of select="concat(format-number($newx, $nfrm), ';', format-number($newy, $nfrm), ';', format-number($newz, $nfrm))" />

    </xsl:template>

    <sign:sign />
    <xsl:variable name="sign" select="document('')/*/sign:*[1]" />
    <xsl:template name="sign" match="*[namespace-uri()='sign']">
        <xsl:param name="value" />
        <xsl:choose>
            <xsl:when test="$value &lt; 0">
                <xsl:value-of select="-1" />
            </xsl:when>
            <xsl:when test="$value = 0">
                <xsl:value-of select="0" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <saw:saw />
    <xsl:variable name="saw" select="document('')/*/saw:*[1]" />
    <xsl:template name="saw" match="*[namespace-uri()='saw']">
        <xsl:param name="n" select="0" />
        <xsl:param name="x" />

        <xsl:variable name="distance">
            <xsl:call-template name="abs">
                <xsl:with-param name="value" select="$x - ceiling($x)" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$distance &lt;= 0.5">
            <xsl:value-of select="$x - ceiling($x)" />
        </xsl:if>

        <xsl:if test="$distance &gt; 0.5">
            <xsl:value-of select="ceiling($x - 1) - $x" />
        </xsl:if>

    </xsl:template>

    <xsl:template name="complex-sum">
        <xsl:param name="a" />
        <xsl:param name="b" />

        <xsl:variable name="a-real" select="substring-before($a, ',')" />
        <xsl:variable name="a-imaginary" select="substring-after($a, ',')" />

        <xsl:variable name="b-real" select="substring-before($b, ',')" />
        <xsl:variable name="b-imaginary" select="substring-after($b, ',')" />

        <xsl:value-of select="concat($a-real + $b-real, ',', $a-imaginary + $b-imaginary)" />

    </xsl:template>

    <xsl:template name="complex-square">
        <xsl:param name="n" />

        <xsl:variable name="n-real" select="substring-before($n, ',')" />
        <xsl:variable name="n-imaginary" select="substring-after($n, ',')" />

        <xsl:variable name="rsquare" select="$n-real * $n-real" />
        <xsl:variable name="isquare" select="$n-imaginary * $n-imaginary" />

        <xsl:variable name="r" select="$rsquare - $isquare" />
        <xsl:variable name="i" select="2 * $n-real * $n-imaginary" />

        <xsl:value-of select="concat($r, ',', $i)" />

    </xsl:template>

    <xsl:template name="complex-abs">
        <xsl:param name="n" />

        <xsl:variable name="n-real" select="substring-before($n, ',')" />
        <xsl:variable name="n-imaginary" select="substring-after($n, ',')" />

        <xsl:variable name="rsquare" select="$n-real * $n-real" />
        <xsl:variable name="isquare" select="$n-imaginary * $n-imaginary" />

        <xsl:call-template name="sqrt">
            <xsl:with-param name="num" select="($rsquare + $isquare)" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="matrix-determinant">
        <xsl:param name="a1" select="1" />
        <xsl:param name="b1" select="1" />
        <xsl:param name="a2" select="1" />
        <xsl:param name="b2" select="1" />

        <xsl:value-of select="$a1 * $b2 - $a2 * $b1" />

    </xsl:template>

    <xsl:template name="set-of-equations">
        <xsl:param name="a1" select="1" />
        <xsl:param name="b1" select="1" />
        <xsl:param name="c1" select="1" />

        <xsl:param name="a2" select="1" />
        <xsl:param name="b2" select="1" />
        <xsl:param name="c2" select="1" />

        <xsl:variable name="W">
            <xsl:call-template name="matrix-determinant">
                <xsl:with-param name="a1" select="$a1" />
                <xsl:with-param name="b1" select="$b1" />
                <xsl:with-param name="a2" select="$a2" />
                <xsl:with-param name="b2" select="$b2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="Wx">
            <xsl:call-template name="matrix-determinant">
                <xsl:with-param name="a1" select="$c1" />
                <xsl:with-param name="b1" select="$b1" />
                <xsl:with-param name="a2" select="$c2" />
                <xsl:with-param name="b2" select="$b2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="Wy">
            <xsl:call-template name="matrix-determinant">
                <xsl:with-param name="a1" select="$a1" />
                <xsl:with-param name="b1" select="$c1" />
                <xsl:with-param name="a2" select="$a2" />
                <xsl:with-param name="b2" select="$c2" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="x">
            <xsl:value-of select="$Wx div $W" />
        </xsl:variable>

        <xsl:variable name="y">
            <xsl:value-of select="$Wy div $W" />
        </xsl:variable>

        <xsl:value-of select="concat($x, ',', $y)" />

    </xsl:template>


    <xsl:template name="string-revert">
        <xsl:param name="string" select="'ABCDE'" />
        <xsl:param name="n" select="1" />

        <xsl:value-of select="substring($string, string-length($string) - $n + 1, 1)" />

        <xsl:if test="$n &lt; string-length($string)">
            <xsl:call-template name="string-revert">
                <xsl:with-param name="string" select="$string" />
                <xsl:with-param name="n" select="$n + 1" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="delete-element">
        <xsl:param name="element" select="0" />
        <xsl:param name="list" select="'0 1 2 3 4 5 6 7 8 9 '" />
        <xsl:param name="result" select="''" />

        <xsl:variable name="head" select="substring-before($list, ' ')" />
        <xsl:variable name="tail" select="substring-after($list, ' ')" />

        <xsl:choose>
            <xsl:when test="not($head)">
                <xsl:value-of select="$result" />
            </xsl:when>

            <xsl:otherwise>
                <xsl:variable name="res">
                    <xsl:choose>
                        <xsl:when test="$element = $head">
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($head, ' ')" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:call-template name="delete-element">
                    <xsl:with-param name="element" select="$element" />
                    <xsl:with-param name="list" select="$tail" />
                    <xsl:with-param name="result" select="concat($result, $res)" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    
    <!-- SOURCE: http://www.stylusstudio.com/xsllist/200108/post40740.html -->
    
<!--     <sqrt:sqrt /> -->
<!--     <xsl:variable name="sqrt" select="document('')/*/sqrt:*[1]" /> -->
<!--     <xsl:template name="sqrt" match="*[namespace-uri()='sqrt']"> -->
    <xsl:template name="sqrt">

        <xsl:param name="num" select="0" />      <!-- The number you want to find the square root of -->
        <xsl:param name="try" select="1" />      <!-- The current 'try'.  This is used internally. -->
        <xsl:param name="iter" select="50" />     <!-- The current iteration, checked against maxiter to limit loop count -->

        <!-- This template was written by Nate Austin using Sir Isaac Newton's method of finding roots -->

        <xsl:choose>
            <xsl:when test="$try * $try = $num or $iter = 0">
                <xsl:value-of select="$try" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="num" select="$num" />
                    <xsl:with-param name="try" select="$try - (($try * $try - $num) div (2 * $try))" />
                    <xsl:with-param name="iter" select="$iter - 1" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <power:power />
    <xsl:variable name="power" select="document('')/*/power:*[1]" />
    <xsl:template name="power" match="*[namespace-uri()='power']">

        <xsl:param name="base" />
        <xsl:param name="exponent" />
        <xsl:param name="result" select="1" />

        <xsl:choose>
            <xsl:when test="$exponent &gt; 0">
                <xsl:call-template name="power">
                    <xsl:with-param name="base" select="$base" />
                    <xsl:with-param name="exponent" select="$exponent - 1" />
                    <xsl:with-param name="result" select="$result * $base" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <protate:protate />
    <xsl:variable name="protate" select="document('')/*/protate:*[1]" />
    <xsl:template name="protate" match="*[namespace-uri()='protate']">

        <xsl:param name="angle" />
        <xsl:param name="base_x" />
        <xsl:param name="base_y" />
        <xsl:param name="point_x" />
        <xsl:param name="point_y" />

        <xsl:variable name="sin_a">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="$angle" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="cos_a">
            <xsl:apply-templates select="$cos">
                <xsl:with-param name="deg" select="$angle" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:variable name="temp_x" select="$point_x - $base_x" />
        <xsl:variable name="temp_y" select="$point_y - $base_y" />
        <xsl:variable name="rotated_x" select="$temp_x * $cos_a - $temp_y * $sin_a" />
        <xsl:variable name="rotated_y" select="$temp_x * $sin_a + $temp_y * $cos_a" />
        <xsl:variable name="target_x" select="$rotated_x + $base_x" />
        <xsl:variable name="target_y" select="$rotated_y + $base_y" />

        <xsl:value-of select="concat($target_x, ',', $target_y)" />

    </xsl:template>

    <!-- abs(value) -->

    <abs:abs />
    <xsl:variable name="abs" select="document('')/*/abs:*[1]" />
    <xsl:template name="abs" match="*[namespace-uri()='abs']">

        <xsl:param name="value" />

        <xsl:choose>
            <xsl:when test="$value &lt; 0">
                <xsl:value-of select="-1 * $value" />
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$value" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- TRIGONOMETRIC FUNCTIONS: -->

    <!-- sincos(deg) -->
    <!-- SOURCE: http://knol.google.com/k/frank-bruder/a-simple-approximation-of-sine-and/1elqhros39id2/3# -->
    <sincos:sincos />
    <xsl:variable name="sincos" select="document('')/*/sincos:*[1]" />
    <xsl:template name="sincos" match="*[namespace-uri()='sincos']">

        <!-- An angle in degrees -->
        <xsl:param name="deg" />

        <xsl:variable name="normdeg_" select="$deg mod 360" />
        <xsl:variable name="normdeg" select="$normdeg_ + 360 * ($normdeg_ &lt; 0)" />

        <xsl:variable name="quadrant" select="floor($normdeg div 90)" />
        <xsl:variable name="qangle" select="($normdeg div 90) mod 1" />

        <xsl:variable name="oangle">
            <xsl:choose>
                <xsl:when test="$qangle &gt; 0.5">
                    <xsl:value-of select="(-$qangle + 1) * 2" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$qangle * 2" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- x*(pi/8 + x*(-(3-\2)pi/4+3*(\2-1) + x*((5-2\2)pi/8-2*(\2-1)))); -->
        <xsl:variable name="v" select="((0.02434754920783877 * $oangle - 0.002833068533467875) * $oangle + 0.39269908169872414) * $oangle" />

        <xsl:variable name="a" select="2 * $v div ($v * $v + 1)" />
        <xsl:variable name="b" select="(-$v * $v + 1) div ($v * $v + 1)" />

        <xsl:variable name="abssin">
            <xsl:choose>
                <xsl:when test="($qangle &gt; 0.5) = (($quadrant mod 2) = 1)">
                    <xsl:value-of select="$a" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$b" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="abscos">
            <xsl:choose>
                <xsl:when test="($qangle &gt; 0.5) = (($quadrant mod 2) = 1)">
                    <xsl:value-of select="$b" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$a" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$quadrant &gt; 1">
                <xsl:value-of select="-$abssin" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$abssin" />
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>,</xsl:text>
        <xsl:choose>
            <xsl:when test="(($quadrant + 1) mod 4) &gt; 1">
                <xsl:value-of select="-$abscos" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$abscos" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- sin(deg) -->
    <sin:sin />
    <xsl:variable name="sin" select="document('')/*/sin:*[1]" />
    <xsl:template name="sin" match="*[namespace-uri()='sin']">

        <xsl:param name="deg" />

        <xsl:variable name="value">
            <xsl:call-template name="sincos">
                <xsl:with-param name="deg" select="$deg" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="substring-before($value, ',')" />

    </xsl:template>

    <cos:cos />
    <xsl:variable name="cos" select="document('')/*/cos:*[1]" />
    <xsl:template name="cos" match="*[namespace-uri()='cos']">

        <xsl:param name="deg" />

        <xsl:variable name="value">
            <xsl:call-template name="sincos">
                <xsl:with-param name="deg" select="$deg" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="substring-after($value, ',')" />

    </xsl:template>

    <xsl:template name="doRotatePath">

        <xsl:param name="path" />
        <xsl:param name="result" />
        <xsl:param name="base_x" />
        <xsl:param name="base_y" />

        <xsl:choose>
            <xsl:when test="$path">
                <xsl:variable name="npath">
                    <xsl:choose>
                        <xsl:when test="contains($path, ' ')">
                            <xsl:value-of select="normalize-space($path)" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($path), ' ')" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="head" select="substring-before($npath, ' ')" />
                <xsl:variable name="tail" select="substring-after($npath, ' ')" />

                <xsl:variable name="point_x" select="substring-before($head, ',')" />
                <xsl:variable name="point_y" select="substring-after($head, ',')" />

                <xsl:variable name="rotated">
                    <xsl:call-template name="protate">
                        <xsl:with-param name="angle" select="-90" />
                        <xsl:with-param name="base_x" select="$base_x" />
                        <xsl:with-param name="base_y" select="$base_y" />
                        <xsl:with-param name="point_x" select="$point_x" />
                        <xsl:with-param name="point_y" select="$point_y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="res" select="concat($rotated, ' ', $result)" />

                <xsl:call-template name="doRotatePath">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="result" select="$res" />
                    <xsl:with-param name="base_x" select="$base_x" />
                    <xsl:with-param name="base_y" select="$base_y" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <rotatePath:rotatePath />
    <xsl:variable name="rotatePath" select="document('')/*/rotatePath:*[1]" />
    <xsl:template name="rotatePath" match="*[namespace-uri()='rotatePath']">
        <xsl:param name="path" />

        <xsl:variable name="base" select="substring-before($path, ' ')" />
        <xsl:variable name="result" select="substring-after($path, ' ')" />

        <xsl:variable name="base_x" select="substring-before($base, ',')" />
        <xsl:variable name="base_y" select="substring-after($base, ',')" />

        <xsl:variable name="output">
            <xsl:call-template name="doRotatePath">
                <xsl:with-param name="base_x" select="$base_x" />
                <xsl:with-param name="base_y" select="$base_y" />
                <xsl:with-param name="path" select="$result" />
                <xsl:with-param name="result" select="$path" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$output" />

    </xsl:template>

</xsl:stylesheet>
