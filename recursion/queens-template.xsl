<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" media-type="text/plain" />
    
    <xsl:include href="../lib/common/math.xsl" />
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/recursion/queens.xsl" />

    <xsl:template match="/">
        <xsl:value-of select="concat('queens(', /args/*[1], '):&#10;&#10;')" />
        
        <xsl:call-template name="queens">
            <xsl:with-param name="n" select="/args/*[1]" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

