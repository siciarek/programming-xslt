<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/fractals/golden-spiral.xsl" />

    <xsl:template match="/">
        <xsl:call-template name="golden-spiral" />
    </xsl:template>

</xsl:stylesheet>

