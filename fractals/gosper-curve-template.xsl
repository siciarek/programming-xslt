<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/gosper-curve.xsl" />

<!-- 
0 - 8
1 - 3
2 - 2
3 - 1.6
-->

    <xsl:template match="/">
        <xsl:call-template name="gosper-curve">
            <xsl:with-param name="stage" select="3" />
            <xsl:with-param name="size" select="400" />
            <xsl:with-param name="x0" select="512 - 46" />
            <xsl:with-param name="y0" select="512 - 512 div 1.6" />
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>

