<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" media-type="text/plain" />
    
    <xsl:include href="../lib/common/utils.xsl" />
    <xsl:include href="../lib/recursion/binary-search.xsl" />

    <xsl:template match="/">
        <xsl:value-of select="concat('binary-search(', /args/*[1], ',[', /args/*[2], ']):&#10;&#10;')" />
        
        <xsl:call-template name="binary-search">
            <xsl:with-param name="key" select="/args/*[1]" />
            <xsl:with-param name="a" select="/args/*[2]" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

