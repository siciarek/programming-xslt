<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" media-type="text/plain" />
    
    <xsl:include href="../lib/recursion/ispalindrome.xsl" />

    <xsl:template match="/">
        <xsl:value-of select="concat('ispalindrome(', /args/*[1], '):&#10;&#10;')" />
        
        <xsl:call-template name="ispalindrome">
            <xsl:with-param name="phrase" select="/args/*[1]" />
        </xsl:call-template>

		<xsl:value-of select="'&#10;&#10;'" />
		
		<xsl:value-of select="concat('ispalindrome(', /args/*[2], '):&#10;&#10;')" />
        
        <xsl:call-template name="ispalindrome">
            <xsl:with-param name="phrase" select="/args/*[2]" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

