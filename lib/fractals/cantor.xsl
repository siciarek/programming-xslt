<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cantorSet="cantorSet">

    <cantorSet:cantorSet />
    <xsl:variable name="cantorSet" select="document('')/*/cantorSet:*[1]" />
    <xsl:template name="cantorSet" match="*[namespace-uri()='cantorSet']">

        <xsl:param name="stage" select="6" />
        <xsl:param name="size" select="256 * 3" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />

        <xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
            <xsl:attribute name="version">1.1</xsl:attribute>

            <xsl:call-template name="doCantorSet">
                <xsl:with-param name="stage" select="$stage" />
                <xsl:with-param name="x1" select="0" />
                <xsl:with-param name="y1" select="0" />
                <xsl:with-param name="x2" select="$size" />
                <xsl:with-param name="y2" select="0" />
                <xsl:with-param name="color" select="$color" />
            </xsl:call-template>

        </xsl:element>
    </xsl:template>

    <xsl:template name="doCantorSet">

        <xsl:param name="stage" />
        <xsl:param name="x1" />
        <xsl:param name="y1" />
        <xsl:param name="x2" />
        <xsl:param name="y2" />
        <xsl:param name="color" />
		
		<xsl:variable name="hoffset" select="48" />
		<xsl:variable name="voffset" select="($x2 - $x1) div 3" />
		
		<xsl:element name="line" xmlns="http://www.w3.org/2000/svg">
			<xsl:attribute name="stroke"><xsl:value-of select="$color" /></xsl:attribute>
			<xsl:attribute name="stroke-width"><xsl:value-of select="12" /></xsl:attribute>
			<xsl:attribute name="shape-rendering">crispEdges</xsl:attribute>
			<xsl:attribute name="x1"><xsl:value-of select="$x1" /></xsl:attribute>
			<xsl:attribute name="y1"><xsl:value-of select="$y1 + $hoffset" /></xsl:attribute>
			<xsl:attribute name="x2"><xsl:value-of select="$x2" /></xsl:attribute>
			<xsl:attribute name="y2"><xsl:value-of select="$y2 + $hoffset" /></xsl:attribute>
		</xsl:element>

		<xsl:if test="$stage &gt; 0">

			<xsl:call-template name="doCantorSet">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="x1" select="$x1" />
				<xsl:with-param name="y1" select="$y1 + $hoffset" />
				<xsl:with-param name="x2" select="$x1 + $voffset" />
				<xsl:with-param name="y2" select="$y2 + $hoffset" />
                <xsl:with-param name="color" select="$color" />
			</xsl:call-template>		

			<xsl:call-template name="doCantorSet">
				<xsl:with-param name="stage" select="$stage - 1" />
				<xsl:with-param name="x1" select="$x1 + 2 * $voffset" />
				<xsl:with-param name="y1" select="$y1 + $hoffset" />
				<xsl:with-param name="x2" select="$x2" />
				<xsl:with-param name="y2" select="$y2 + $hoffset" />
                <xsl:with-param name="color" select="$color" />
			</xsl:call-template>		

		</xsl:if>
		
    </xsl:template>

</xsl:stylesheet>