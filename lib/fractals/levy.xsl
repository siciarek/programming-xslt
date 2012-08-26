<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:levyCCurve="levyCCurve">


    <levyCCurve:levyCCurve />
    <xsl:variable name="levyCCurve" select="document('')/*/levyCCurve:*[1]" />
    <xsl:template name="levyCCurve" match="*[namespace-uri()='levyCCurve']">

        <xsl:param name="stage" select="9" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="line_thickness" select="1" />

        <xsl:variable name="size">
             <xsl:choose>
                <xsl:when test="$stage &gt; 0">
                    <xsl:value-of select="100 div $stage" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="100" />
                </xsl:otherwise>
            </xsl:choose>      
        </xsl:variable>

        <xsl:variable name="start_y">
            <xsl:choose>
                <xsl:when test="$stage &lt; 5">
                    <xsl:value-of select="500" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$stage * 75" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="start_x">
            <xsl:choose>
                <xsl:when test="$stage = 0">
                    <xsl:value-of select="120" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="120 - $stage * 5" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="input" select="concat($start_x - $size, ',', $start_y, ' ', $start_x, ',', $start_y)" />

        <xsl:variable name="output1">
            <xsl:call-template name="doLevyCCurve">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="input" select="$input" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="handle">
            <xsl:call-template name="substring-last">
                <xsl:with-param name="path" select="$output1" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="handle_x" select="substring-before($handle, ',')" />
        <xsl:variable name="handle_y" select="substring-after($handle, ',')" />


        <xsl:variable name="output2" select="translate($output1, ' ', 'L')" />
        <xsl:variable name="output3" select="translate($output2, ',', ' ')" />
        <xsl:variable name="output4" select="concat('M', $output3)" />

        <xsl:variable name="d" select="$output4" />

        <xsl:processing-instruction name="xml-stylesheet">href="style.css" type="text/css"</xsl:processing-instruction>

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>


            <xsl:element name="path">
                <xsl:attribute name="fill">none</xsl:attribute>
                <xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
                <xsl:attribute name="stroke-width"><xsl:value-of select="$line_thickness" /></xsl:attribute>
                <xsl:attribute name="shape-rendering">default</xsl:attribute>

                <xsl:attribute name="d">
                    <xsl:value-of select="$d" />
                </xsl:attribute>
            </xsl:element>

        </xsl:element>
    </xsl:template>

    <xsl:template name="doLevyCCurve">

        <xsl:param name="stage" />
        <xsl:param name="input" />
        <xsl:param name="output" select="null" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">

                <xsl:variable name="base">
                    <xsl:call-template name="substring-last">
                        <xsl:with-param name="path" select="$input" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="base_x" select="substring-before($base, ',')" />
                <xsl:variable name="base_y" select="substring-after($base, ',')" />

                <xsl:variable name="rotated">
                    <xsl:call-template name="rotate-path">
                        <xsl:with-param name="base_x" select="$base_x" />
                        <xsl:with-param name="base_y" select="$base_y" />
                        <xsl:with-param name="path" select="$input" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="mirrored">
                    <xsl:call-template name="mirror-path">
                        <xsl:with-param name="path" select="$rotated" />
                        <xsl:with-param name="x" select="$base_x" />
                        <xsl:with-param name="y" select="$base_y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="in" select="concat($rotated, ' ', $mirrored)" />

                <xsl:call-template name="doLevyCCurve">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="input" select="$in" />
                </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$input" />
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>    
    
    <xsl:template name="rotate-path">

        <xsl:param name="path" />
        <xsl:param name="result" select="''" />
        <xsl:param name="base_x" />
        <xsl:param name="base_y" />
        <xsl:param name="angle" select="45" />


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
                        <xsl:with-param name="angle" select="$angle" />
                        <xsl:with-param name="base_x" select="$base_x" />
                        <xsl:with-param name="base_y" select="$base_y" />
                        <xsl:with-param name="point_x" select="$point_x" />
                        <xsl:with-param name="point_y" select="$point_y" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="res" select="concat($result, ' ', $rotated)" />

                <xsl:call-template name="rotate-path">
                    <xsl:with-param name="angle" select="$angle" />
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="result" select="$res" />
                    <xsl:with-param name="base_x" select="$base_x" />
                    <xsl:with-param name="base_y" select="$base_y" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space($result)" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="mirror-path">
        <xsl:param name="path" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="result" select="null" />

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
                <xsl:variable name="new_x" select="$point_x + 2 * ($x - $point_x)" />
                <xsl:variable name="new_y" select="$point_y + 2 * ($y - $point_y)" />

                <xsl:variable name="res" select="concat($new_x, ',', $point_y)" />
<!--                 <xsl:variable name="res" select="concat($point_x, ',', $new_y)" /> -->

                <xsl:call-template name="mirror-path">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="result" select="concat($res, ' ', $result)" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space($result)" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="substring-last">
        <xsl:param name="path" />
        <xsl:param name="result" select="''" />

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

                <xsl:call-template name="substring-last">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="result" select="$head" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="substring-without-last">
        <xsl:param name="path" />
        <xsl:param name="result" select="null" />

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

                <xsl:variable name="res">
                    <xsl:choose>
                        <xsl:when test="$tail">
                            <xsl:value-of select="concat($result, ' ', $head)" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$result" />
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:variable>
                <xsl:call-template name="substring-without-last">
                    <xsl:with-param name="path" select="$tail" />
                    <xsl:with-param name="result" select="$res" />
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space($result)" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>