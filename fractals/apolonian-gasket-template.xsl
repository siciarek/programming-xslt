<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/utils.xsl" />
    <xsl:include href="../lib/apolonius.xsl" />

    <xsl:template match="/">
        <xsl:apply-templates select="$apolonianGasket">
            <xsl:with-param name="stage" select="0" />
            <xsl:with-param name="size" select="512" />
            <xsl:with-param name="type" select="0" />
            <xsl:with-param name="color" select="'rgb(0, 128, 0)'" />
        </xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>

