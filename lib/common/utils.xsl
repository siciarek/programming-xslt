<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:plot="plot" xmlns:psrgb="psrgb">

    <xsl:template name="logo-to-path">
        <xsl:param name="logo-path" select="''" />
		<xsl:param name="x" />
		<xsl:param name="y" />
		<xsl:param name="stack" select="''" />
		<xsl:param name="angle" select="0" />
        <xsl:param name="separator" select="' hideturtle '" />
		<xsl:param name="prev" select="''" />

        <xsl:variable name="head" select="substring-before($logo-path, $separator)" />
        <xsl:variable name="tail" select="substring-after($logo-path, $separator)" />

        <xsl:if test="$tail">

            <xsl:variable name="temp">
                <xsl:choose>
                    <xsl:when test="$head">
                        <xsl:value-of select="$head" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$logo-path" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="nangle">
                <xsl:choose>
                    <xsl:when test="starts-with($temp, 'rt')">
                        <xsl:value-of select="$angle + normalize-space(translate($temp, 'rt', ' '))" />
                    </xsl:when>
					<xsl:when test="starts-with($temp, 'restore')">
						<xsl:variable name="temphead" select="substring-before($stack, ';')" />
						<xsl:variable name="tempangle" select="substring-before($temphead, ',')" />
						<xsl:value-of select="$tempangle" />
					</xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$angle" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

			
			<xsl:variable name="nprev">
				<xsl:choose>
					<xsl:when test="starts-with($temp, 'pd fd')">
						<xsl:value-of select="'L'" />
					</xsl:when>
					<xsl:when test="starts-with($temp, 'pu fd')">
						<xsl:value-of select="'M'" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:variable name="npoint">
				<xsl:choose>
					<xsl:when test="starts-with($temp, 'pd fd')">

						<xsl:variable name="length" select="normalize-space(translate($temp, 'pd fd', ' '))" />

						<xsl:variable name="tpox">
							<xsl:call-template name="protate">
								<xsl:with-param name="angle" select="$nangle" />
								<xsl:with-param name="base_x" select="0" />
								<xsl:with-param name="base_y" select="0" />
								<xsl:with-param name="point_x" select="0" />
								<xsl:with-param name="point_y" select="-$length" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:value-of select="concat($x + substring-before($tpox, ','), ',', $y + substring-after($tpox, ','))" />
						
					</xsl:when>

					<xsl:when test="starts-with($temp, 'pu fd')">
						<xsl:variable name="length" select="normalize-space(translate($temp, 'pu fd', ' '))" />

						<xsl:variable name="tpoy">
							<xsl:call-template name="protate">
								<xsl:with-param name="angle" select="$nangle" />
								<xsl:with-param name="base_x" select="0" />
								<xsl:with-param name="base_y" select="0" />
								<xsl:with-param name="point_x" select="0" />
								<xsl:with-param name="point_y" select="-$length" />
							</xsl:call-template>
						</xsl:variable>
						
						<xsl:value-of select="concat($x + substring-before($tpoy, ','), ',', $y + substring-after($tpoy, ','))" />
						
					</xsl:when>

					<xsl:when test="starts-with($temp, 'restore')">
						<xsl:variable name="temphead" select="substring-before($stack, ';')" />
						
						<xsl:variable name="tempangle" select="substring-before($temphead, ',')" />
						<xsl:variable name="atail" select="substring-after($temphead, ',')" />
						<xsl:variable name="tempx" select="substring-before($atail, ',')" />
						<xsl:variable name="tempy" select="substring-after($atail, ',')" />
						<xsl:value-of select="concat($tempx, ',', $tempy)" />
					</xsl:when>

					<xsl:otherwise>
						<xsl:value-of select="concat($x, ',', $y)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:if test="starts-with($temp, 'pu fd') or starts-with($temp, 'restore')">
				<xsl:value-of select="'M'" />
			</xsl:if>
			
			<xsl:if test="starts-with($temp, 'pd fd')">
				<xsl:value-of select="''" />
			</xsl:if>
			
			<xsl:value-of select="concat($npoint, ' ')" />
			
			<xsl:if test="$nprev = 'L' and $prev = 'M'">
				<xsl:value-of select="'Z'" />
			</xsl:if>

			
			<!-- BRANCH OFF/RESTORE: -->

			<xsl:variable name="nstack">
				<xsl:choose>
					<xsl:when test="starts-with($temp, 'branchoff')">
						<xsl:value-of select="concat($angle, ',', $x, ',', $y, ';', $stack)" />
					</xsl:when>

					<xsl:when test="starts-with($temp, 'restore')">
						<xsl:value-of select="substring-after($stack, ';')" />
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:value-of select="$stack" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
            <xsl:call-template name="logo-to-path">
                <xsl:with-param name="logo-path" select="$tail" />
				<xsl:with-param name="x" select="substring-before($npoint, ',')" />
				<xsl:with-param name="y" select="substring-after($npoint, ',')" />
                <xsl:with-param name="stack" select="$nstack" />
                <xsl:with-param name="angle" select="$nangle" />
                <xsl:with-param name="separator" select="$separator" />
                <xsl:with-param name="prev" select="$nprev" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <xsl:template name="logo-to-offsets">
        <xsl:param name="logo-path" select="''" />
        <xsl:param name="angle" select="0" />
        <xsl:param name="separator" select="' pd '" />

        <xsl:variable name="head" select="substring-before($logo-path, $separator)" />
        <xsl:variable name="tail" select="substring-after($logo-path, $separator)" />

        <xsl:if test="$tail">

            <xsl:variable name="temp">
                <xsl:choose>
                    <xsl:when test="$head">
                        <xsl:value-of select="$head" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$logo-path" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="nangle">
                <xsl:choose>
                    <xsl:when test="starts-with($temp, 'rt')">
                        <xsl:value-of select="normalize-space(translate($temp, 'rt', ' '))" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:if test="starts-with($temp, 'fd')">
                <xsl:variable name="length" select="normalize-space(translate($temp, 'fd', ' '))" />

                <xsl:call-template name="protate">
                    <xsl:with-param name="angle" select="$angle" />
                    <xsl:with-param name="base_x" select="0" />
                    <xsl:with-param name="base_y" select="0" />
                    <xsl:with-param name="point_x" select="0" />
                    <xsl:with-param name="point_y" select="-$length" />
                </xsl:call-template>
                <xsl:value-of select="' '" />
            </xsl:if>

            <xsl:call-template name="logo-to-offsets">
                <xsl:with-param name="logo-path" select="$tail" />
                <xsl:with-param name="angle" select="$angle + $nangle" />
                <xsl:with-param name="separator" select="$separator" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <xsl:template name="draw-pixel">
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="radius" select="1" />

        <xsl:value-of select="concat('M',
        $x - $radius, ',', $y,
        'A', $radius, ',', $radius,
        ' 0 1,1 ',
        $x - $radius, ',', ($y - 0.001),
        'Z')" />
    </xsl:template>
    
    <xsl:template name="xdraw-pixel">
        <xsl:param name="x" />
        <xsl:param name="y" />

        <xsl:value-of select="concat('M',
        $x, ',', $y, ' ',
        $x + 1, ',', $y, ' ',
        $x + 1, ',', $y + 1, ' ',
        $x, ',', $y + 1,
        'Z')" />
    </xsl:template>

    <xsl:template name="pentagram">
        <xsl:param name="cx" select="512 div 2" />
        <xsl:param name="cy" select="512 div 2" />
        <xsl:param name="radius" select="512 div 4" />
        <xsl:param name="type" select="0" />
        <xsl:param name="rotation" select="0" />

        <xsl:variable name="angle" select="144" />

        <xsl:variable name="ny">
            <xsl:choose>
                <xsl:when test="$type = 1">
                    <xsl:value-of select="$cy + $radius" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$cy - $radius" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="p_1">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="0 * $angle + $rotation" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ny" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p_2">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="1 * $angle + $rotation" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ny" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p_3">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="2 * $angle + $rotation" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ny" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p_4">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="3 * $angle + $rotation" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ny" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="p_5">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="4 * $angle + $rotation" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$ny" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('M', $p_1)" />
        <xsl:value-of select="concat('L', $p_2)" />
        <xsl:value-of select="concat('L', $p_3)" />
        <xsl:value-of select="concat('L', $p_4)" />
        <xsl:value-of select="concat('L', $p_5)" />
        <xsl:value-of select="'Z'" />

    </xsl:template>

    <xsl:template name="cross">

        <xsl:param name="cx" />
        <xsl:param name="cy" />
        <xsl:param name="width" />
        <xsl:param name="height" />

        <xsl:value-of select="concat('M', $cx - ($height + $width div 2), ',',  $cy - $width div 2)" />

        <xsl:value-of select="concat('h', $height)" />
        <xsl:value-of select="concat('v', -$height)" />

        <xsl:value-of select="concat('h', $width)" />

        <xsl:value-of select="concat('v', $height)" />
        <xsl:value-of select="concat('h', $height)" />

        <xsl:value-of select="concat('v', $width)" />

        <xsl:value-of select="concat('h', -$height)" />
        <xsl:value-of select="concat('v', $height)" />

        <xsl:value-of select="concat('h', -$width)" />

        <xsl:value-of select="concat('v', -$height)" />
        <xsl:value-of select="concat('h', -$height)" />

        <xsl:value-of select="'Z'" />

    </xsl:template>

    <xsl:template name="polygon">
        <xsl:param name="sides" />
        <xsl:param name="cx" />
        <xsl:param name="cy" />
        <xsl:param name="radius" />
        <xsl:param name="n" select="0" />

        <xsl:variable name="angle" select="360 div $sides" />

        <xsl:if test="$n = 0">
            <xsl:value-of select="'M'" />
        </xsl:if>

        <xsl:call-template name="protate">
            <xsl:with-param name="angle" select="$angle * $n" />
            <xsl:with-param name="base_x" select="$cx" />
            <xsl:with-param name="base_y" select="$cy" />
            <xsl:with-param name="point_x" select="$cx" />
            <xsl:with-param name="point_y" select="$cy - $radius" />
        </xsl:call-template>

        <xsl:if test="$n = $sides - 1">
            <xsl:value-of select="'Z'" />
        </xsl:if>

        <xsl:if test="$n &lt; $sides - 1">
            <xsl:value-of select="' '" />

            <xsl:call-template name="polygon">
                <xsl:with-param name="n" select="$n + 1" />
                <xsl:with-param name="sides" select="$sides" />
                <xsl:with-param name="cx" select="$cx" />
                <xsl:with-param name="cy" select="$cy" />
                <xsl:with-param name="radius" select="$radius" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="star">
        <xsl:param name="points" />
        <xsl:param name="cx" />
        <xsl:param name="cy" />
        <xsl:param name="radius" />
        <xsl:param name="offset" select="0.35" />
        <xsl:param name="n" select="0" />

        <xsl:variable name="angle" select="360 div $points" />

        <xsl:if test="$n = 0">
            <xsl:value-of select="'M'" />
        </xsl:if>

        <xsl:variable name="o">
            <xsl:call-template name="protate">
                <xsl:with-param name="angle" select="$angle div 2" />
                <xsl:with-param name="base_x" select="$cx" />
                <xsl:with-param name="base_y" select="$cy" />
                <xsl:with-param name="point_x" select="$cx" />
                <xsl:with-param name="point_y" select="$cy - $radius * $offset" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="protate">
            <xsl:with-param name="angle" select="$angle * $n" />
            <xsl:with-param name="base_x" select="$cx" />
            <xsl:with-param name="base_y" select="$cy" />
            <xsl:with-param name="point_x" select="$cx" />
            <xsl:with-param name="point_y" select="$cy - $radius" />
        </xsl:call-template>

        <xsl:value-of select="' '" />

        <xsl:call-template name="protate">
            <xsl:with-param name="angle" select="$angle * $n" />
            <xsl:with-param name="base_x" select="$cx" />
            <xsl:with-param name="base_y" select="$cy" />
            <xsl:with-param name="point_x" select="substring-before($o, ',')" />
            <xsl:with-param name="point_y" select="substring-after($o, ',')" />
        </xsl:call-template>

        <xsl:if test="$n = $points - 1">
            <xsl:value-of select="'Z'" />
        </xsl:if>

        <xsl:if test="$n &lt; $points - 1">
            <xsl:value-of select="' '" />

            <xsl:call-template name="star">
                <xsl:with-param name="n" select="$n + 1" />
                <xsl:with-param name="points" select="$points" />
                <xsl:with-param name="cx" select="$cx" />
                <xsl:with-param name="cy" select="$cy" />
                <xsl:with-param name="radius" select="$radius" />
                <xsl:with-param name="offset" select="$offset" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="image">
        <xsl:param name="stage" select="0" />
        <xsl:param name="content" />
        <xsl:param name="type" select="'path'" />

        <xsl:param name="width" select="512" />
        <xsl:param name="height" select="512" />
        <xsl:param name="stroke" select="'none'" />
        <xsl:param name="fill" select="'rgb(0,0,0)'" />
        <xsl:param name="stroke-width" select="1" />
        <xsl:param name="shape-rendering" select="'default'" />
        <xsl:param name="frame" select="0" />

        <xsl:variable name="data">
            <xsl:choose>
                <xsl:when test="$type = 'raw' or $type = 'raw-polyline' or $type = 'raw-path'">
                    <xsl:copy-of select="$content" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$content">
                        <xsl:with-param name="stage" select="$stage" />
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version"><xsl:value-of select="'1.1'" /></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="'100%'" /></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="'100%'" /></xsl:attribute>
            <xsl:attribute name="viewBox"><xsl:value-of select="concat('0 0 ', $width, ' ', $height)" /></xsl:attribute>

            <xsl:if test="$frame = 1">
                <xsl:element name="rect" xmlns="http://www.w3.org/2000/svg">
                    <xsl:attribute name="stroke"><xsl:value-of select="'silver'" /></xsl:attribute>
                    <xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
                    <xsl:attribute name="x"><xsl:value-of select="0" /></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="0" /></xsl:attribute>
                    <xsl:attribute name="width"><xsl:value-of select="$width" /></xsl:attribute>
                    <xsl:attribute name="height"><xsl:value-of select="$height" /></xsl:attribute>
                </xsl:element>
            </xsl:if>

            <xsl:choose>
                <xsl:when test="$type = 'polyline' or $type = 'raw-polyline'">
                    <xsl:element name="polyline" xmlns="http://www.w3.org/2000/svg">
                        <xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
                        <xsl:attribute name="stroke"><xsl:value-of select="$stroke" /></xsl:attribute>
                        <xsl:attribute name="stroke-width"><xsl:value-of select="$stroke-width" /></xsl:attribute>
                        <xsl:attribute name="shape-rendering"><xsl:value-of select="$shape-rendering" /></xsl:attribute>
                        <xsl:attribute name="points">
                            <xsl:value-of select="$data" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="$type = 'path' or $type = 'raw-path'">
                    <xsl:element name="path" xmlns="http://www.w3.org/2000/svg">
                        <xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
                        <xsl:attribute name="fill-rule"><xsl:value-of select="'nonzero'" /></xsl:attribute>
                        <xsl:attribute name="stroke"><xsl:value-of select="$stroke" /></xsl:attribute>
                        <xsl:attribute name="stroke-width"><xsl:value-of select="$stroke-width" /></xsl:attribute>
                        <xsl:attribute name="shape-rendering"><xsl:value-of select="$shape-rendering" /></xsl:attribute>
                        <xsl:attribute name="d">
                            <xsl:value-of select="$data" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$data" />
                </xsl:otherwise>
            </xsl:choose>

        </xsl:element>
    </xsl:template>

    <xsl:template name="equation">
        <xsl:param name="equation" />
        <xsl:param name="result" select="0" />

        <xsl:choose>
            <xsl:when test="$equation">

                <xsl:variable name="operator" select="substring-before($equation, ' ')" />
                <xsl:variable name="tail" select="concat(normalize-space(substring-after($equation, ' ')), ' ')" />
                <xsl:variable name="number" select="normalize-space(substring-before($tail, ' '))" />
                <xsl:variable name="xtail" select="substring-after($tail, ' ')" />

<!--                 <xsl:value-of select="concat('O:', $operator, '.&#10;')" /> -->
<!--                 <xsl:value-of select="concat('N:', $number, '.&#10;')" /> -->

                <xsl:variable name="res">
                    <xsl:choose>
                        <xsl:when test="string($operator) = '-'">
                            <xsl:value-of select="$result - $number" />
                        </xsl:when>
                        <xsl:when test="string($operator) = '+'">
                            <xsl:value-of select="$result + $number" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$result" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="equation">
                    <xsl:with-param name="equation" select="$xtail" />
                    <xsl:with-param name="result" select="$res" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="generate-array">
        <xsl:param name="n" />
        <xsl:param name="value" />
        <xsl:param name="separator" select="','" />


        <xsl:if test="$n - 1 &gt; 0">
            <xsl:call-template name="generate-array">
                <xsl:with-param name="n" select="$n - 1" />
                <xsl:with-param name="value" select="$value" />
                <xsl:with-param name="separator" select="$separator" />
            </xsl:call-template>
        </xsl:if>

        <xsl:variable name="val">
            <xsl:choose>
                <xsl:when test="string($value) = ''">
                    <xsl:value-of select="$n - 1" />
                </xsl:when>

                <xsl:otherwise>
                    <xsl:value-of select="$value" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="concat($val, $separator)" />

    </xsl:template>

    <xsl:template name="repeat">
        <xsl:param name="string" select="'&#10;'" />
        <xsl:param name="times" select="1" />
        <xsl:param name="i" select="0" />

        <xsl:if test="$i &lt; $times">
            <xsl:copy-of select="$string" />
        </xsl:if>

        <xsl:if test="$i &lt; $times">
            <xsl:call-template name="repeat">
                <xsl:with-param name="string" select="$string" />
                <xsl:with-param name="times" select="$times" />
                <xsl:with-param name="i" select="$i + 1" />
            </xsl:call-template>
        </xsl:if>
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

    <xsl:template name="generateCurve">
        <xsl:param name="offsets" />
        <xsl:param name="x0" />
        <xsl:param name="y0" />

        <xsl:if test="$offsets">


            <xsl:variable name="offset" select="substring-before($offsets, ' ')" />
            <xsl:variable name="tail" select="substring-after($offsets, ' ')" />

            <xsl:variable name="xoffset" select="substring-before($offset, ',')" />
            <xsl:variable name="yoffset" select="substring-after($offset, ',')" />

            <xsl:variable name="newx" select="$x0 + $xoffset" />
            <xsl:variable name="newy" select="$y0 + $yoffset" />


            <xsl:call-template name="plot">
                <xsl:with-param name="x" select="$x0" />
                <xsl:with-param name="y" select="$y0" />
            </xsl:call-template>

            <xsl:call-template name="generateCurve">
                <xsl:with-param name="offsets" select="$tail" />
                <xsl:with-param name="x0" select="$newx" />
                <xsl:with-param name="y0" select="$newy" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <plot:plot />
    <xsl:variable name="plot" select="document('')/*/plot:*[1]" />
    <xsl:template name="plot" match="*[namespace-uri()='plot']">

        <xsl:param name="x" />
        <xsl:param name="y" />

        <xsl:value-of select="concat(' ', $x, ',', $y)" />

    </xsl:template>

    <psrgb:psrgb />
    <xsl:variable name="psrgb" select="document('')/*/psrgb:*[1]" />
    <xsl:template name="psrgb" match="*[namespace-uri()='psrgb']">

        <xsl:param name="color" />

        <xsl:variable name="temp" select="substring-after($color, '(')" />
        <xsl:variable name="rgbcolor" select="normalize-space(substring-before($temp, ')'))" />
        <xsl:variable name="tail" select="normalize-space(substring-after($rgbcolor, ','))" />

        <xsl:variable name="R" select="normalize-space(substring-before($rgbcolor, ','))" />
        <xsl:variable name="G" select="normalize-space(substring-before($tail, ','))" />
        <xsl:variable name="B" select="normalize-space(substring-after($tail, ','))" />

        <xsl:value-of select="concat($R div 255, ' ', $G div 255, ' ', $B div 255)" />

    </xsl:template>


</xsl:stylesheet>
