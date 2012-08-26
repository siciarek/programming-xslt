<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:template name="recursive-sum">
        <xsl:param name="n" select="0" />
        <xsl:param name="result" select="0" />

        <xsl:choose>
            <xsl:when test="$n = 0">
                <xsl:value-of select="$result" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="recursive-sum">
                    <xsl:with-param name="n" select="$n - 1" />
                    <xsl:with-param name="result" select="$result + $n" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="recursive-findmin">
        <xsl:param name="a" select="''" />
        <xsl:param name="min" select="''" />

        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="head" select="substring-before($a, ',')" />
                <xsl:variable name="tail" select="substring-after($a, ',')" />

                <xsl:variable name="h">
                    <xsl:choose>
                        <xsl:when test="string($head) = ''">
                            <xsl:value-of select="$a" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$head" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>


                <xsl:variable name="_min">
                    <xsl:choose>
                        <xsl:when test="string(number($min)) = 'NaN'">
                            <xsl:value-of select="$h" />
                        </xsl:when>
                        <xsl:when test="$h &lt;= $min">
                            <xsl:value-of select="$h" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$min" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="recursive-findmin">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="min" select="$_min" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$min" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="recursive-findsum">
        <xsl:param name="a" select="'1,1'" />
        <xsl:param name="sum" select="0" />


        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="head" select="substring-before($a, ',')" />
                <xsl:variable name="tail" select="substring-after($a, ',')" />

                <xsl:variable name="h">
                    <xsl:choose>
                        <xsl:when test="string($head) = ''">
                            <xsl:value-of select="$a" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$head" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="recursive-findsum">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="sum" select="$sum + $h" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$sum" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="recursive-ispalindrome">
        <xsl:param name="a" select="''" />

        <xsl:variable name="acount" select="string-length($a)" />
                        
        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="first" select="substring($a, 1, 1)" />
                <xsl:variable name="mid" select="substring($a, 2, $acount - 2)" />
                <xsl:variable name="last"  select="substring($a, $acount)" />
              
                <xsl:choose>
                    <xsl:when test="$first = $last">
                        <xsl:call-template name="recursive-ispalindrome">
                            <xsl:with-param name="a" select="$mid" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="recursive-binary-search">
        <xsl:param name="key" />
        <xsl:param name="a" />

        <xsl:variable name="count">
            <xsl:call-template name="list-count">
                <xsl:with-param name="a" select="$a" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$count &gt; 1">

                <xsl:variable name="divided-list">
                    <xsl:call-template name="list-divide-in-two">
                        <xsl:with-param name="a" select="$a" />
                        <xsl:with-param name="count" select="$count" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="left" select="substring-before($divided-list, ';')" />
                <xsl:variable name="right" select="substring-after($divided-list, ';')" />

                <xsl:variable name="left-first">
                    <xsl:call-template name="list-first">
                        <xsl:with-param name="a" select="$left" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="left-last">
                    <xsl:call-template name="list-last">
                        <xsl:with-param name="a" select="$left" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="right-first">
                    <xsl:call-template name="list-first">
                        <xsl:with-param name="a" select="$right" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="right-last">
                    <xsl:call-template name="list-last">
                        <xsl:with-param name="a" select="$right" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="newa">
                    <xsl:choose>
                        <xsl:when test="$key &gt;= $left-first and $key &lt;= $left-last">
                            <xsl:value-of select="$left" />
                        </xsl:when>
                        <xsl:when test="$key &gt;= $right-first and $key &lt;= $right-last">
                            <xsl:value-of select="$right" />
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="recursive-binary-search">
                    <xsl:with-param name="key" select="$key" />
                    <xsl:with-param name="a" select="$newa" />
                </xsl:call-template>

            </xsl:when>
            <xsl:when test="$count = 1">
                <xsl:choose>
                    <xsl:when test="$key = $a">
                        <xsl:value-of select="1" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="list-divide-in-two">
        <xsl:param name="a" />
        <xsl:param name="count" />
        <xsl:param name="inner-count" select="0" />
        <xsl:param name="left" select="''" />
        <xsl:param name="separator" select="','" />

        <xsl:choose>
            <xsl:when test="$a and $inner-count &lt; $count div 2">

                <xsl:variable name="na">
                    <xsl:choose>
                        <xsl:when test="contains($a, $separator)">
                            <xsl:value-of select="normalize-space($a)" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($a), $separator)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="head" select="substring-before($na, $separator)" />
                <xsl:variable name="tail" select="substring-after($na, $separator)" />

                <xsl:variable name="l">
                    <xsl:choose>
                        <xsl:when test="$left">
                            <xsl:value-of select="concat($left, $separator, $head)" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$head" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="list-divide-in-two">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="count" select="$count" />
                    <xsl:with-param name="inner-count" select="$inner-count + 1" />
                    <xsl:with-param name="left" select="$l" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($left,';',$a)" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="list-count">
        <xsl:param name="a" />
        <xsl:param name="count" select="0" />
        <xsl:param name="separator" select="','" />

        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="na">
                    <xsl:choose>
                        <xsl:when test="contains($a, $separator)">
                            <xsl:value-of select="normalize-space($a)" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($a), $separator)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="tail" select="substring-after($na, $separator)" />

                <xsl:call-template name="list-count">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="count" select="$count + 1" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$count" />
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>

    <xsl:template name="list-first">
        <xsl:param name="a" />
        <xsl:param name="result" select="''" />
        <xsl:param name="separator" select="','" />

        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="na">
                    <xsl:choose>
                        <xsl:when test="contains($a, $separator)">
                            <xsl:value-of select="normalize-space($a)" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($a), $separator)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="head" select="substring-before($na, $separator)" />
                <xsl:variable name="tail" select="substring-after($na, $separator)" />

                <xsl:value-of select="$head" />

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="list-last">
        <xsl:param name="a" />
        <xsl:param name="result" select="''" />
        <xsl:param name="separator" select="','" />

        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="na">
                    <xsl:choose>
                        <xsl:when test="contains($a, $separator)">
                            <xsl:value-of select="normalize-space($a)" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($a), $separator)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="head" select="substring-before($na, $separator)" />
                <xsl:variable name="tail" select="substring-after($na, $separator)" />

                <xsl:call-template name="list-last">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="result" select="$head" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template name="hanoiTowers">
        <xsl:param name="n" select="7" />
        <xsl:param name="from" select="1" />
        <xsl:param name="to" select="2" />
        <xsl:param name="spare" select="3" />

        <xsl:if test="$n &gt; 1">
            <xsl:call-template name="hanoiTowers">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="from" select="$from" />
                <xsl:with-param name="to" select="$spare" />
                <xsl:with-param name="spare" select="$to" />
            </xsl:call-template>
        </xsl:if>

        <xsl:copy-of select="concat($from, '-', $to, '&#10;')" />

        <xsl:if test="$n &gt; 1">
            <xsl:call-template name="hanoiTowers">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="from" select="$spare" />
                <xsl:with-param name="to" select="$to" />
                <xsl:with-param name="spare" select="$from" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="binarySet">
        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="binarySet">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

                <xsl:call-template name="binarySet">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="grayCode">
        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="grayCode">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

                <xsl:call-template name="yargCode">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
     <xsl:template name="yargCode">
        <xsl:param name="bits" select="8" />
        <xsl:param name="result" select="''" />

        <xsl:choose>
            <xsl:when test="$bits = 0">

                <xsl:value-of select="concat($result, '&#10;')" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="grayCode">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '1')" />
                </xsl:call-template>
 
                <xsl:call-template name="yargCode">
                    <xsl:with-param name="bits" select="$bits - 1" />
                    <xsl:with-param name="result" select="concat($result, '0')" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="fibonacciWord">
        <xsl:param name="n" select="5" />
        <xsl:param name="prev" select="'1'" />
        <xsl:param name="result" select="'0'" />

        <xsl:choose>
            <xsl:when test="$n = 0">

                <xsl:value-of select="$result" />

            </xsl:when>
            <xsl:otherwise>

                <xsl:call-template name="fibonacciWord">
                    <xsl:with-param name="n" select="$n - 1" />
                    <xsl:with-param name="prev" select="$result" />
                    <xsl:with-param name="result" select="concat($result, $prev)" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>