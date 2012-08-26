<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/fractals/minkowski-island.xsl" />

    <xsl:template match="/">
        <xsl:apply-templates select="$minkowski-island">
            <xsl:with-param name="stage" select="3" />
            <xsl:with-param name="size" select="512" />
            <xsl:with-param name="color" select="'rgb(0, 0, 1)'" />
        </xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>

