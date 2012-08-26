<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:penrose_tiling="penrose_tiling">

    <xsl:include href="/lib/common/math.xsl" />
    <xsl:include href="/lib/common/utils.xsl" />

<!--

	File        : penrose-tiling.xsl
	Procedure   : penrose_tiling
	Created by  : Jacek Siciarek <siciarek@gmail.com>
	Created at  : 2012-03-26 21:17:34+00:00

	Description : Pentagonal Curve (Penrose tiling)

-->

	<penrose_tiling:penrose_tiling />
	<xsl:variable name="penrose_tiling" select="document('')/*/penrose_tiling:*[1]" />
	<xsl:template name="penrose_tiling" match="*[namespace-uri()='penrose_tiling']">

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
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />

	<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />

	<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />

	<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />

	<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

		<xsl:value-of select="concat('restore', ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
		<xsl:value-of select="concat('branchoff', ' hideturtle ')" />

	<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

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

	<xsl:template name="penrose_tiling6">
		
		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		

		<xsl:if test="$depth = 0">
				<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />

		</xsl:if>
		

		<xsl:if test="$depth &gt; 0">		
		<xsl:call-template name="penrose_tiling8">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling9">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling8">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling6">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('restore', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		</xsl:if>

	</xsl:template>

	<xsl:template name="penrose_tiling7">
		
		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		

		<xsl:if test="$depth = 0">
				<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />

		</xsl:if>
		

		<xsl:if test="$depth &gt; 0">					<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling8">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling9">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling6">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('restore', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		</xsl:if>

	</xsl:template>

	<xsl:template name="penrose_tiling8">
		
		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		

		<xsl:if test="$depth = 0">
				<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />

		</xsl:if>
		

		<xsl:if test="$depth &gt; 0">					<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling6">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling8">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling9">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('restore', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		</xsl:if>

	</xsl:template>

	<xsl:template name="penrose_tiling9">
		
		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		

		<xsl:if test="$depth = 0">
				<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />

		</xsl:if>
		

		<xsl:if test="$depth &gt; 0">					<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling8">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling6">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('branchoff', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling9">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  $angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>

			<xsl:value-of select="concat('restore', ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />
			<xsl:value-of select="concat('rt ',  -$angle, ' hideturtle ')" />

		<xsl:call-template name="penrose_tiling7">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		<xsl:call-template name="penrose_tiling1">
			<xsl:with-param name="depth" select="$depth - 1" />
			<xsl:with-param name="angle" select="$angle" />
			<xsl:with-param name="size" select="$size" />
		</xsl:call-template>


		</xsl:if>

	</xsl:template>

	<xsl:template name="penrose_tiling1">
		
		<xsl:param name="depth" />
		<xsl:param name="angle" />
		<xsl:param name="size" />
		

		<xsl:if test="$depth = 0">
				<xsl:value-of select="concat('pd fd ', $size, ' hideturtle ')" />

		</xsl:if>
		

		<xsl:if test="$depth &gt; 0">				
		</xsl:if>

	</xsl:template>


    <xsl:template match="/">

		<xsl:variable name="color" select="'rgb(0, 0, 255)'" />
	
		<xsl:variable name="content">
             <xsl:call-template name="penrose_tiling">
                 <xsl:with-param name="depth" select="4" />
                 <xsl:with-param name="angle" select="36" />
                 <xsl:with-param name="size" select="16" />
                 <xsl:with-param name="xoffset" select="0" />
                 <xsl:with-param name="yoffset" select="0" />
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
             <xsl:with-param name="frame" select="0" />
         </xsl:call-template>

	 </xsl:template>

</xsl:stylesheet>

