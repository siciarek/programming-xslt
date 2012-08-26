<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" media-type="text/html" omit-xml-declaration="yes" indent="yes" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/sierpinski-3d.xsl" />

    <xsl:template match="/">

        <xsl:apply-templates select="$sierpinskiSponge">
            <xsl:with-param name="stage" select="2" />
            <xsl:with-param name="color" select="'rgb(0, 128, 0)'" />
            <xsl:with-param name="size" select="4" />
            <xsl:with-param name="type" select="'xml'" />
        </xsl:apply-templates>

    </xsl:template>

</xsl:stylesheet>

