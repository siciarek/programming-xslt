<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/fractals/hexaflake.xsl" />

    <xsl:template match="/">
        <xsl:call-template name="image">
            <xsl:with-param name="content" select="$hexaflake" />
            <xsl:with-param name="stage" select="3" />
            <xsl:with-param name="shape-rendering" select="'default'" />
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
