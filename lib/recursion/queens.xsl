<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:queens="queens">

    <queens:queens />
    <xsl:variable name="queens" select="document('')/*/queens:*[1]" />
    <xsl:template name="queens" match="*[namespace-uri()='queens']">

        <xsl:param name="n" />

<!-- 
        int N = Integer.parseInt(args[0]);
        int[] a         = new int[N];         // a[i] = row of queen in ith column
        boolean[] diag1 = new boolean[2*N];   // is ith top diagonal occupied?
        boolean[] diag2 = new boolean[2*N];   // is ith bottom diagonal occupied?
        for (int i = 0; i < N; i++)
            a[i] = i;
        enumerate(a, diag1, diag2, N);

'3,1,6,2,5,7,4,0,'

-->

        <xsl:variable name="a">
            <xsl:call-template name="generate-array">
                <xsl:with-param name="n" select="$n" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="diag1">
            <xsl:call-template name="generate-array">
                <xsl:with-param name="n" select="$n * 2" />
                <xsl:with-param name="value" select="0" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="diag2">
            <xsl:call-template name="generate-array">
                <xsl:with-param name="n" select="$n * 2" />
                <xsl:with-param name="value" select="0" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$a" />
        <xsl:value-of select="'&#10;'" />
        <xsl:value-of select="$diag1" />
        <xsl:value-of select="'&#10;'" />
        <xsl:value-of select="$diag2" />
        <xsl:value-of select="'&#10;'" />

        <xsl:call-template name="print-queens">
            <xsl:with-param name="a" select="$a" />
        </xsl:call-template>


<!--
	<xsl:choose>
		<xsl:when test="$n = 1">
			<xsl:copy-of select="1" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="result">
				<xsl:call-template name="queens">
					<xsl:with-param name="n" select="$n - 1" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:copy-of select="$n * $result" />
		</xsl:otherwise>
	</xsl:choose>
-->

    </xsl:template>

    <xsl:template name="print-queens">

        <xsl:param name="a" />

        <xsl:variable name="counta">
            <xsl:call-template name="list-count">
                <xsl:with-param name="a" select="$a" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="row">
            <xsl:value-of select="'Q,'" />
            <xsl:call-template name="repeat">
                <xsl:with-param name="string" select="'*,'" />
                <xsl:with-param name="times" select="$counta - 1" />
            </xsl:call-template>
        </xsl:variable>


        <xsl:call-template name="do-print-queens">
            <xsl:with-param name="a" select="$a" />
            <xsl:with-param name="row" select="$row" />
        </xsl:call-template>

    </xsl:template>


    <xsl:template name="do-print-queens">
        <xsl:param name="a" />
        <xsl:param name="row" />

        <xsl:choose>

            <xsl:when test="$a">
                <xsl:variable name="head" select="substring-before($a, ',')" />
                <xsl:variable name="tail" select="substring-after($a, ',')" />

                <xsl:variable name="temp-row">
                    <xsl:call-template name="swap">
                        <xsl:with-param name="a" select="$row" />
                        <xsl:with-param name="i" select="0" />
                        <xsl:with-param name="j" select="$head" />
                    </xsl:call-template>
                </xsl:variable>
        
                <xsl:value-of select="concat(translate($temp-row, ',', ' '), '&#10;')" />
 
                <xsl:call-template name="do-print-queens">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="row" select="$row" />
                </xsl:call-template>

            </xsl:when>

            <xsl:otherwise>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <xsl:template name="swap">

        <xsl:param name="a" />
        <xsl:param name="temp_a" />
        <xsl:param name="i" />
        <xsl:param name="j" />
        <xsl:param name="at_i" />
        <xsl:param name="at_j" />
        <xsl:param name="n" select="0" />

        <xsl:choose>
            <xsl:when test="$a">

                <xsl:variable name="head" select="substring-before($a, ',')" />
                <xsl:variable name="tail" select="substring-after($a, ',')" />

                <xsl:variable name="xtemp_a">
                    <xsl:if test="$n = 0">
                        <xsl:value-of select="$a" />
                    </xsl:if>
                    <xsl:if test="$n > 0">
                        <xsl:value-of select="$temp_a" />
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="xat_i">
                    <xsl:if test="$n = $i">
                        <xsl:value-of select="$head" />
                    </xsl:if>
                    <xsl:if test="string-length($at_i) &gt; 0">
                        <xsl:value-of select="$at_i" />
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="xat_j">
                    <xsl:if test="$n = $j">
                        <xsl:value-of select="$head" />
                    </xsl:if>
                    <xsl:if test="string-length($at_j) &gt; 0">
                        <xsl:value-of select="$at_j" />
                    </xsl:if>
                </xsl:variable>

                <xsl:call-template name="swap">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="temp_a" select="$xtemp_a" />
                    <xsl:with-param name="i" select="$i" />
                    <xsl:with-param name="j" select="$j" />
                    <xsl:with-param name="at_i" select="$xat_i" />
                    <xsl:with-param name="at_j" select="$xat_j" />
                    <xsl:with-param name="n" select="$n + 1" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="do-swap">
                    <xsl:with-param name="a" select="$temp_a" />
                    <xsl:with-param name="i" select="$i" />
                    <xsl:with-param name="j" select="$j" />
                    <xsl:with-param name="at_i" select="$at_i" />
                    <xsl:with-param name="at_j" select="$at_j" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="do-swap">

        <xsl:param name="a" />
        <xsl:param name="i" />
        <xsl:param name="j" />
        <xsl:param name="at_i" />
        <xsl:param name="at_j" />
        <xsl:param name="n" select="0" />
        <xsl:param name="result" />

        <xsl:choose>
            <xsl:when test="$a">
                <xsl:variable name="head" select="substring-before($a, ',')" />
                <xsl:variable name="tail" select="substring-after($a, ',')" />

                <xsl:variable name="res">
                    <xsl:choose>

                        <xsl:when test="$n = $i">
                            <xsl:value-of select="concat($result, $at_j, ',')" />
                        </xsl:when>

                        <xsl:when test="$n = $j">
                            <xsl:value-of select="concat($result, $at_i, ',')" />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:value-of select="concat($result, $head, ',')" />
                        </xsl:otherwise>

                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="do-swap">
                    <xsl:with-param name="a" select="$tail" />
                    <xsl:with-param name="i" select="$i" />
                    <xsl:with-param name="j" select="$j" />
                    <xsl:with-param name="at_i" select="$at_i" />
                    <xsl:with-param name="at_j" select="$at_j" />
                    <xsl:with-param name="n" select="$n + 1" />
                    <xsl:with-param name="result" select="$res" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>

