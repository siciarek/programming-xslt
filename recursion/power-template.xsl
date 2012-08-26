<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" media-type="text/plain" />
    
    <xsl:include href="../lib/recursion/power.xsl" />

    <xsl:template match="/">
     
<!--         <xsl:variable name="args">    -->
<!--             <xsl:for-each select="/args/*"> -->
<!--                 <xsl:value-of select="concat(name(.), ' ')" /> -->
<!--             </xsl:for-each> -->
<!--         </xsl:variable> -->
        
<!--         <xsl:value-of select="translate(normalize-space($args), ' ', ',')" /> -->

        <xsl:value-of select="concat('power(', /args/*[1], ', ', /args/*[2], '):&#10;&#10;')" />
        
        <xsl:call-template name="power">
            <xsl:with-param name="base" select="/args/*[1]" />
            <xsl:with-param name="exponent" select="/args/*[2]" />
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>

