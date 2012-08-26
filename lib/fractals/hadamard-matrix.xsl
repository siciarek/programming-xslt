<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet id="stylesheet" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- any xsl:import elements -->
    
    <xsl:output method="xml" media-type="application/svg" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="xsl:stylesheet" />

	<xsl:template name="hadamard-matrix">
		<xsl:param name="stage" select="1" />
		<xsl:param name="type" select="0" />
		<xsl:param name="x" select="0" />
		<xsl:param name="y" select="0" />
		<xsl:param name="size" select="512" />
		<xsl:param name="foreground" select="'#FFFFFF'" />
		<xsl:param name="background" select="'#000000'" />

		<xsl:variable name="nsize" select="$size div 2" />
	
		<xsl:choose>
			<xsl:when test="$stage &gt; 0">

				<xsl:variable name="fgc">
					<xsl:choose>
						<xsl:when test="$type = 1">
							<xsl:value-of select="1" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="0" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="bgc">
					<xsl:choose>
						<xsl:when test="$type = 1">
							<xsl:value-of select="0" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="1" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<xsl:call-template name="hadamard-matrix" >
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="type" select="$fgc" />
					<xsl:with-param name="x" select="$x" />
					<xsl:with-param name="y" select="$y" />
					<xsl:with-param name="size" select="$nsize" />
				</xsl:call-template>

				<xsl:call-template name="hadamard-matrix" >
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="type" select="$fgc" />
					<xsl:with-param name="x" select="$x + $nsize" />
					<xsl:with-param name="y" select="$y" />
					<xsl:with-param name="size" select="$nsize" />
				</xsl:call-template>

				<xsl:call-template name="hadamard-matrix" >
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="type" select="$fgc" />
					<xsl:with-param name="x" select="$x" />
					<xsl:with-param name="y" select="$y + $nsize" />
					<xsl:with-param name="size" select="$nsize" />
				</xsl:call-template>

				<xsl:call-template name="hadamard-matrix" >
					<xsl:with-param name="stage" select="$stage - 1" />
					<xsl:with-param name="type" select="$bgc" />
					<xsl:with-param name="x" select="$x + $nsize" />
					<xsl:with-param name="y" select="$y + $nsize" />
					<xsl:with-param name="size" select="$nsize" />
				</xsl:call-template>

			</xsl:when>
		
			<xsl:otherwise>
				

				<xsl:variable name="fill">
					<xsl:choose>
						<xsl:when test="$type = 1">
							<xsl:value-of select="$foreground" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$background" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:element name="rect" xmlns="http://www.w3.org/2000/svg" >
					<xsl:attribute name="shape-rendering"><xsl:value-of select="'crispEdges'" /></xsl:attribute>
					<xsl:attribute name="fill"><xsl:value-of select="$fill" /></xsl:attribute>
					<xsl:attribute name="x"><xsl:value-of select="$x" /></xsl:attribute>
					<xsl:attribute name="y"><xsl:value-of select="$y" /></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$size" /></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$size" /></xsl:attribute>
				</xsl:element>

			</xsl:otherwise>
		</xsl:choose>
		
	
	
	</xsl:template>

  
</xsl:stylesheet>