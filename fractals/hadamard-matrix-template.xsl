<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />
    <xsl:include href="../lib/fractals/hadamard-matrix.xsl" />

	
	<xsl:template match="/">
		
		<xsl:variable name="size" select="512" />
	
		<xsl:element name="svg" xmlns="http://www.w3.org/2000/svg">
			<xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>
			
			<xsl:call-template name="hadamard-matrix">
				<xsl:with-param name="stage" select="5" />
			</xsl:call-template>

        </xsl:element>

	</xsl:template>

</xsl:stylesheet>