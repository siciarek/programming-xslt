<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:simple_branch="simple_branch">

    <xsl:include href="/lib/common/math.xsl" />
    <xsl:include href="/lib/common/utils.xsl" />

<!--

	File        : simple-branch.xsl
	Procedure   : simple_branch
	Created by  : Jacek Siciarek <siciarek@gmail.com>
	Created at  : 2012-03-26 20:13:48+00:00

	Description : Simple Branch

-->

	<simple_branch:simple_branch />
	<xsl:variable name="simple_branch" select="document('')/*/simple_branch:*[1]" />
	<xsl:template name="simple_branch" match="*[namespace-uri()='simple_branch']">

		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		<xsl:param name="xoffset" />
		<xsl:param name="yoffset" />
		<xsl:param name="width" select="512" />
		<xsl:param name="height" select="512" />
		
		<xsl:variable name="x0" select="$width div 2 - $xoffset" />
		<xsl:variable name="y0" select="$height div 2 + $yoffset" />
		
		<xsl:variable name="logo-path">
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />
		<xsl:value-of select="concat('restore', ' hideturtle ')" />

		</xsl:variable>

        <xsl:variable name="output">
            <xsl:call-template name="logo-to-path">
                <xsl:with-param name="logo-path" select="concat($logo-path, ' hideturtle')" />
                <xsl:with-param name="x" select="$x0" />
                <xsl:with-param name="y" select="$y0" />
			</xsl:call-template>
 		</xsl:variable>

        <xsl:value-of select="concat('M', $x0, ',', $y0, ' ')" />
		<xsl:value-of select="normalize-space($output)" />
		
	</xsl:template>


    <xsl:template match="/">

		<xsl:variable name="color" select="'rgb(0, 0, 255)'" />
	
		<xsl:variable name="content">
             <xsl:call-template name="simple_branch">
                 <xsl:with-param name="depth" select="1" />
                 <xsl:with-param name="angle" select="45" />
                 <xsl:with-param name="size" select="64" />
                 <xsl:with-param name="xoffset" select="0" />
                 <xsl:with-param name="yoffset" select="256" />
             </xsl:call-template>
         </xsl:variable>

         <xsl:call-template name="image">
             <xsl:with-param name="type" select="'raw-path'" />
             <xsl:with-param name="width" select="512" />
             <xsl:with-param name="height" select="512" />
             <xsl:with-param name="content" select="$content" />
             <xsl:with-param name="shape-rendering" select="'default'" />
             <xsl:with-param name="stroke" select="$color" />
             <xsl:with-param name="fill" select="'none'" />
             <xsl:with-param name="frame" select="1" />
         </xsl:call-template>

	 </xsl:template>

</xsl:stylesheet>

