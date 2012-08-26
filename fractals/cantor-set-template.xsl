<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/fractals/cantor.xsl" />

    <xsl:template match="/">
        <xsl:apply-templates select="$cantorSet" />
    </xsl:template>

</xsl:stylesheet>

