<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:binary-search="binary-search">

<binary-search:binary-search />
<xsl:variable name="binary-search" select="document('')/*/binary-search:*[1]" />
<xsl:template name="binary-search" match="*[namespace-uri()='binary-search']">

        <xsl:param name="key" />
        <xsl:param name="a" />

        <xsl:variable name="count">
            <xsl:call-template name="list-count">
                <xsl:with-param name="a" select="$a" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$count &gt; 1">

                <xsl:variable name="divided-list">
                    <xsl:call-template name="list-divide-in-two">
                        <xsl:with-param name="a" select="$a" />
                        <xsl:with-param name="count" select="$count" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="left" select="substring-before($divided-list, ';')" />
                <xsl:variable name="right" select="substring-after($divided-list, ';')" />

                <xsl:variable name="left-first">
                    <xsl:call-template name="list-first">
                        <xsl:with-param name="a" select="$left" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="left-last">
                    <xsl:call-template name="list-last">
                        <xsl:with-param name="a" select="$left" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="right-first">
                    <xsl:call-template name="list-first">
                        <xsl:with-param name="a" select="$right" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="right-last">
                    <xsl:call-template name="list-last">
                        <xsl:with-param name="a" select="$right" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="newa">
                    <xsl:choose>
                        <xsl:when test="$key &gt;= $left-first and $key &lt;= $left-last">
                            <xsl:value-of select="$left" />
                        </xsl:when>
                        <xsl:when test="$key &gt;= $right-first and $key &lt;= $right-last">
                            <xsl:value-of select="$right" />
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:call-template name="binary-search">
                    <xsl:with-param name="key" select="$key" />
                    <xsl:with-param name="a" select="$newa" />
                </xsl:call-template>

            </xsl:when>
            <xsl:when test="$count = 1">
                <xsl:choose>
                    <xsl:when test="$key = $a">
                        <xsl:value-of select="1" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>

