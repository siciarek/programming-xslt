<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:factorial="factorial">

<factorial:factorial />
<xsl:variable name="factorial" select="document('')/*/factorial:*[1]" />
<xsl:template name="factorial" match="*[namespace-uri()='factorial']">

	<xsl:param name="n" />

	<xsl:choose>
		<xsl:when test="$n = 0">
			<xsl:copy-of select="1" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="result">
				<xsl:call-template name="factorial">
					<xsl:with-param name="n" select="$n - 1" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:copy-of select="$n * $result" />
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


</xsl:stylesheet>

