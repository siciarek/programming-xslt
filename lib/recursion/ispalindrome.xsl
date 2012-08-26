<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ispalindrome="ispalindrome">

<ispalindrome:ispalindrome />
<xsl:variable name="ispalindrome" select="document('')/*/ispalindrome:*[1]" />
<xsl:template name="ispalindrome" match="*[namespace-uri()='ispalindrome']">

        <xsl:param name="phrase" select="''" />

        <xsl:variable name="acount" select="string-length($phrase)" />
                        
        <xsl:choose>
            <xsl:when test="$phrase">

                <xsl:variable name="first" select="substring($phrase, 1, 1)" />
                <xsl:variable name="mid" select="substring($phrase, 2, $acount - 2)" />
                <xsl:variable name="last"  select="substring($phrase, $acount)" />
              
                <xsl:choose>
                    <xsl:when test="$first = $last">
                        <xsl:call-template name="ispalindrome">
                            <xsl:with-param name="phrase" select="$mid" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

