<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/fractals/koch-curve.xsl" />

    <xsl:template match="/">

        <xsl:call-template name="koch-curve">
            <xsl:with-param name="stage" select="4" />
            <xsl:with-param name="type" select="'triangular'" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

