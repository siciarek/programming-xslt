<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" media-type="text/plain" />
    
    <xsl:include href="../lib/recursion/binary-set.xsl" />

    <xsl:template match="/">
        <xsl:value-of select="concat('binary-set(', /args/*[1], '):&#10;&#10;')" />
        
        <xsl:call-template name="binary-set">
            <xsl:with-param name="n" select="/args/*[1]" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

