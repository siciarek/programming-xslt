<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:apolonianGasket="apolonianGasket">

    <apolonianGasket:apolonianGasket />
    <xsl:variable name="apolonianGasket" select="document('')/*/apolonianGasket:*[1]" />
    <xsl:template name="apolonianGasket" match="*[namespace-uri()='apolonianGasket']">

        <xsl:param name="stage" select="5" />
        <xsl:param name="size" select="512" />
        <xsl:param name="type" select="0" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>
			<xsl:call-template name="doApolonianGasket">
				<xsl:with-param name="stage" select="$stage" />
				<xsl:with-param name="x" select="$size div 2" />
				<xsl:with-param name="y" select="$size div 2" />
				<xsl:with-param name="size" select="$size div 2" />
				<xsl:with-param name="color" select="$color" />
			</xsl:call-template>
        </xsl:element>
    </xsl:template>

    <xsl:template xmlns="http://www.w3.org/2000/svg" name="doApolonianGasket">

        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="size" />
        <xsl:param name="color" />

        <xsl:choose>
            <xsl:when test="$stage &gt; 0">
<!--
                <xsl:call-template name="doapolonianGasketSet">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="result" select="normalize-space(concat($result, ' ', $path))" />
                </xsl:call-template>
-->
            </xsl:when>

            <xsl:otherwise>
				<xsl:element name="circle">
					<xsl:attribute name="cx"><xsl:value-of select="$x" /></xsl:attribute>
					<xsl:attribute name="cy"><xsl:value-of select="$y" /></xsl:attribute>
					<xsl:attribute name="r"><xsl:value-of select="$size" /></xsl:attribute>
					<xsl:attribute name="fill"><xsl:value-of select="'none'" /></xsl:attribute>
					<xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
					<xsl:attribute name="stroke-width"><xsl:value-of select="1" /></xsl:attribute>
				</xsl:element>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

 

</xsl:stylesheet>