<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sierpinskiTetrahedron="sierpinskiTetrahedron"
    xmlns:sierpinskiPyramid="sierpinskiPyramid" xmlns:sierpinskiSponge="sierpinskiSponge">


    <sierpinskiTetrahedron:sierpinskiTetrahedron />
    <xsl:variable name="sierpinskiTetrahedron" select="document('')/*/sierpinskiTetrahedron:*[1]" />
    <xsl:template name="sierpinskiTetrahedron" match="*[namespace-uri()='sierpinskiTetrahedron']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="size" select="1" />
        <xsl:param name="type" select="'xml'" />

        <xsl:choose>
            <xsl:when test="$type = 'vrml'">

                <xsl:text>#VRML V2.0 utf8

Background { skyColor 1 1 1 }
  
Group {
  children [</xsl:text>

                <xsl:call-template name="doSierpinskiTetrahedron">
                    <xsl:with-param name="stage" select="$stage" />
                    <xsl:with-param name="x" select="0" />
                    <xsl:with-param name="y" select="0" />
                    <xsl:with-param name="z" select="0" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="'vrml'" />
                </xsl:call-template>


                <xsl:text>
    Viewpoint {
      description "basic"
      jump TRUE
      fieldOfView 0.88000000
      orientation -0.37865439 -0.58626306 0.71618187 2.19761825
      position -2.35851955 -0.44550714 -0.42314950
    }

  ]
}
</xsl:text>

            </xsl:when>

            <xsl:when test="$type = 'x3d'">

                <x3d>
                    <scene DEF="scene">

                        <background skyColor="1 1 1"></background>

                        <group>
                            <xsl:call-template name="doSierpinskiTetrahedron">
                                <xsl:with-param name="stage" select="$stage" />
                                <xsl:with-param name="x" select="0" />
                                <xsl:with-param name="y" select="0" />
                                <xsl:with-param name="z" select="0" />
                                <xsl:with-param name="size" select="$size" />
                                <xsl:with-param name="color" select="$color" />
                                <xsl:with-param name="type" select="'xml'" />
                            </xsl:call-template>
                            <viewpoint description="basic" jump="true" fieldOfView="0.88000000" orientation="-0.37865439 -0.58626306 0.71618187 2.19761825"
                                position="-2.35851955 -0.44550714 -0.42314950"></viewpoint>

                        </group>
                    </scene>
                </x3d>

            </xsl:when>

            <xsl:otherwise>

                <html>
                    <head>
                        <title>Sierpinski tetrahedron</title>
                        <meta http-equiv="Content-Type" content="text/html;charset=utf-8"></meta>
                        <script type="text/javascript" src="http://www.x3dom.org/x3dom/release/x3dom.js"></script>
                    </head>

                    <body style="margin:0">

                        <x3d id="fractal" showStat="false" showLog="false" x="0px" y="0px" width="800px" height="600px"
                            swfpath="http://www.x3dom.org/x3dom/release/x3dom.swf">
                            <scene DEF="scene">

                                <background skyColor="1 1 1"></background>

                                <group>
                                    <xsl:call-template name="doSierpinskiTetrahedron">
                                        <xsl:with-param name="stage" select="$stage" />
                                        <xsl:with-param name="x" select="0" />
                                        <xsl:with-param name="y" select="0" />
                                        <xsl:with-param name="z" select="0" />
                                        <xsl:with-param name="size" select="$size" />
                                        <xsl:with-param name="color" select="$color" />
                                        <xsl:with-param name="type" select="'xml'" />
                                    </xsl:call-template>
                                    <viewpoint description="basic" jump="true" fieldOfView="0.88000000"
                                        orientation="-0.37865439 -0.58626306 0.71618187 2.19761825" position="-2.35851955 -0.44550714 -0.42314950"></viewpoint>

                                </group>
                            </scene>
                        </x3d>
                    </body>
                </html>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>



    <xsl:template name="doSierpinskiTetrahedron">
        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" select="0" />
        <xsl:param name="size" />
        <xsl:param name="color" />
        <xsl:param name="type" select="'xml'" />

        <xsl:variable name="sin_60">
            <xsl:apply-templates select="$sin">
                <xsl:with-param name="deg" select="60" />
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:variable name="xcolor">
                    <xsl:call-template name="psrgb">
                        <xsl:with-param name="color" select="$color" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="Ax" select="$x" />
                <xsl:variable name="Ay" select="$y" />
                <xsl:variable name="Az" select="$z" />

                <xsl:variable name="Bx" select="$x + $size" />
                <xsl:variable name="By" select="$y" />
                <xsl:variable name="Bz" select="$z" />

                <xsl:variable name="Cx" select="$x + 0.5 * $size" />
                <xsl:variable name="Cy" select="$y + $size * $sin_60" />
                <xsl:variable name="Cz" select="$z" />

                <xsl:variable name="Dx" select="$x + 0.5 * $size * $sin_60" />
                <xsl:variable name="Dy" select="$y + 0.5 * $size * $sin_60" />
                <xsl:variable name="Dz" select="$z - $size * $sin_60" />


                <xsl:variable name="A" select="concat($Ax, ' ', $Ay, ' ', $Az)" />
                <xsl:variable name="B" select="concat($Bx, ' ', $By, ' ', $Bz)" />
                <xsl:variable name="C" select="concat($Cx, ' ', $Cy, ' ', $Cz)" />
                <xsl:variable name="D" select="concat($Dx, ' ', $Dy, ' ', $Dz)" />

                <xsl:variable name="point" select="concat($A, ' ', $B, ' ', $C, ' ', $D)" />

                <xsl:choose>
                    <xsl:when test="$type = 'vrml'">

                        <xsl:text>
    Shape{
      appearance Appearance { material Material { diffuseColor 0.5 0.5 0.5 emissiveColor 0 0 0.5 specularColor 0 0 1 shininess 1.0 transparency 0 } }
      geometry IndexedFaceSet {
        coordIndex [ 0, 1, 2, 0, -1,     0, 3, 1, -1,      1, 3, 2, -1,       2, 3, 0, -1 ]
        coord Coordinate { point [ </xsl:text>
                        <xsl:value-of select="$point" />
                        <xsl:text>] }
      }
    }</xsl:text>

                    </xsl:when>

                    <xsl:otherwise>

                        <shape>
                            <appearance>
                                <material diffuseColor="0.5 0.5 0.5" emissiveColor="0 0 0.5" specularColor="0 0 1" shininess="1.0"
                                    transparency="0" />
                            </appearance>
                            <indexedFaceSet coordIndex="0, 1, 2, 0, -1,     0, 3, 1, -1,      1, 3, 2, -1,       2, 3, 0, -1">
                                <xsl:element name="coordinate">
                                    <xsl:attribute name="point"><xsl:value-of select="$point" /></xsl:attribute>
                                </xsl:element>
                            </indexedFaceSet>
                        </shape>

                    </xsl:otherwise>

                </xsl:choose>

            </xsl:when>

            <xsl:otherwise>

                <xsl:call-template name="doSierpinskiTetrahedron">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiTetrahedron">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 0.5 * $size" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiTetrahedron">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 0.25 * $size" />
                    <xsl:with-param name="y" select="$y + $size * 0.5 * $sin_60" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiTetrahedron">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + 0.25 * $size * $sin_60" />
                    <xsl:with-param name="y" select="$y + 0.25 * $size * $sin_60" />
                    <xsl:with-param name="z" select="$z - $size * 0.5 * $sin_60" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <sierpinskiPyramid:sierpinskiPyramid />
    <xsl:variable name="sierpinskiPyramid" select="document('')/*/sierpinskiPyramid:*[1]" />
    <xsl:template name="sierpinskiPyramid" match="*[namespace-uri()='sierpinskiPyramid']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="size" select="1" />
        <xsl:param name="type" select="'xml'" />

        <xsl:choose>
            <xsl:when test="$type = 'vrml'">

                <xsl:text>#VRML V2.0 utf8

Background { skyColor 1 1 1 }

Group {
  children [</xsl:text>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage" />
                    <xsl:with-param name="x" select="0" />
                    <xsl:with-param name="y" select="0" />
                    <xsl:with-param name="z" select="0" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:text>

    Viewpoint { description "basic" fieldOfView 1 jump TRUE orientation -0.9 -0.3 0.3 1.7 position -2 8 -1.5 }
    PointLight { color 1 1 0.5 location 1.87758946 1.36161554 -2.20474148 }
    PointLight { color 1 1 0.5 location 7.05048847 5.36687326 -0.58721435 }

  ]
}
</xsl:text>

            </xsl:when>

            <xsl:otherwise>

                <html>
                    <head>
                        <title>Sierpinski Pyramid</title>
                        <meta http-equiv="Content-Type" content="text/html;charset=utf-8"></meta>
                        <script type="text/javascript" src="http://www.x3dom.org/x3dom/release/x3dom.js"></script>
                    </head>

                    <body style="margin:0">

                        <x3d id="fractal" showStat="false" showLog="false" x="0px" y="0px" width="800px" height="600px"
                            swfpath="http://www.x3dom.org/x3dom/release/x3dom.swf">
                            <scene DEF="scene">

                                <background skyColor="1 1 1"></background>

                                <group>
                                    <xsl:call-template name="doSierpinskiPyramid">
                                        <xsl:with-param name="stage" select="$stage" />
                                        <xsl:with-param name="x" select="0" />
                                        <xsl:with-param name="y" select="0" />
                                        <xsl:with-param name="z" select="0" />
                                        <xsl:with-param name="size" select="$size" />
                                        <xsl:with-param name="color" select="$color" />
                                        <xsl:with-param name="type" select="'xml'" />
                                    </xsl:call-template>
                                    <ViewPoint description="basic" jump="true" fieldOfView="1" orientation="-0.9 -0.3 0.3 1.7"
                                        position="-2 8 -1.5"></ViewPoint>

                                    <PointLight color="1 1 0.44000000" location="1.87758946 1.36161554 -2.20474148">
                                    </PointLight>
                                    <PointLight color="1 1 0.44000000" location="7.05048847 5.36687326 -0.58721435">
                                    </PointLight>
                                </group>
                            </scene>
                        </x3d>
                    </body>
                </html>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="doSierpinskiPyramid">
        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" select="0" />
        <xsl:param name="size" />
        <xsl:param name="color" />
        <xsl:param name="type" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:variable name="xcolor">
                    <xsl:call-template name="psrgb">
                        <xsl:with-param name="color" select="$color" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="Ax" select="$x" />
                <xsl:variable name="Ay" select="$y" />
                <xsl:variable name="Az" select="$z" />

                <xsl:variable name="Bx" select="$x + $size" />
                <xsl:variable name="By" select="$y" />
                <xsl:variable name="Bz" select="$z" />

                <xsl:variable name="Cx" select="$x + $size" />
                <xsl:variable name="Cy" select="$y + $size" />
                <xsl:variable name="Cz" select="$z" />

                <xsl:variable name="Dx" select="$x" />
                <xsl:variable name="Dy" select="$y + $size" />
                <xsl:variable name="Dz" select="$z" />

                <xsl:variable name="Ex" select="$x + 0.5 * $size" />
                <xsl:variable name="Ey" select="$y + 0.5 * $size" />
                <xsl:variable name="Ez" select="$z - $size" />


                <xsl:variable name="A" select="concat($Ax, ' ', $Ay, ' ', $Az)" />
                <xsl:variable name="B" select="concat($Bx, ' ', $By, ' ', $Bz)" />
                <xsl:variable name="C" select="concat($Cx, ' ', $Cy, ' ', $Cz)" />
                <xsl:variable name="D" select="concat($Dx, ' ', $Dy, ' ', $Dz)" />
                <xsl:variable name="E" select="concat($Ex, ' ', $Ey, ' ', $Ez)" />

                <xsl:variable name="point" select="concat($A, ' ', $B, ' ', $C, ' ', $D, ' ', $E)" />






                <xsl:choose>
                    <xsl:when test="$type = 'vrml'">

                        <xsl:text>
    Shape{
      appearance Appearance { material Material { diffuseColor 0.5 0.5 0.5 emissiveColor 0 0.5 0 specularColor 0 1 0 shininess 1.0 transparency 0 } }
      geometry IndexedFaceSet {
        coordIndex [ 0, 1, 2, 3, 0, -1,     0, 4, 1, -1,      1, 4, 2, -1,       2, 4, 3, -1,       3, 4, 0, -1 ]
        coord Coordinate { point [ </xsl:text>
                        <xsl:value-of select="$point" />
                        <xsl:text>] }
      }
    }</xsl:text>

                    </xsl:when>

                    <xsl:otherwise>

                        <shape>
                            <appearance>
                                <material diffuseColor="0.5 0.5 0.5" emissiveColor="0 0.5 0" specularColor="0 1 0" shininess="1.0"
                                    transparency="0" />
                            </appearance>
                            <indexedFaceSet coordIndex="0, 1, 2, 3, 0, -1,     0, 4, 1, -1,      1, 4, 2, -1,       2, 4, 3, -1,       3, 4, 0, -1">
                                <xsl:element name="coordinate">
                                    <xsl:attribute name="point"><xsl:value-of select="$point" /></xsl:attribute>
                                </xsl:element>
                            </indexedFaceSet>
                        </shape>

                    </xsl:otherwise>

                </xsl:choose>




            </xsl:when>

            <xsl:otherwise>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + $size div 2" />
                    <xsl:with-param name="y" select="$y + $size div 2" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x" />
                    <xsl:with-param name="y" select="$y + $size div 2" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + $size div 2" />
                    <xsl:with-param name="y" select="$y" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiPyramid">
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="x" select="$x + $size div 4" />
                    <xsl:with-param name="y" select="$y + $size div 4" />
                    <xsl:with-param name="z" select="$z - $size div 2" />
                    <xsl:with-param name="size" select="$size div 2" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <sierpinskiSponge:sierpinskiSponge />
    <xsl:variable name="sierpinskiSponge" select="document('')/*/sierpinskiSponge:*[1]" />
    <xsl:template name="sierpinskiSponge" match="*[namespace-uri()='sierpinskiSponge']">

        <xsl:param name="stage" select="4" />
        <xsl:param name="color" select="'rgb(0, 128, 0)'" />
        <xsl:param name="size" select="1" />
        <xsl:param name="type" select="'xml'" />

        <xsl:choose>
            <xsl:when test="$type = 'vrml'">

                <xsl:text>#VRML V2.0 utf8

Background { skyColor 1 1 1 }

Group {
  children [</xsl:text>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="stage" select="$stage" />
                    <xsl:with-param name="x" select="0" />
                    <xsl:with-param name="y" select="0" />
                    <xsl:with-param name="z" select="0" />
                    <xsl:with-param name="size" select="$size" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:text>

    Viewpoint { description "basic" fieldOfView 1 jump TRUE orientation -0.84568346 -0.37529552 0.37943769 1.75019240 position -2.59999990 7.65999985 -1.77999997 }
    PointLight { color 1 1 0.5 location 1.87758946 1.36161554 -2.20474148 }
    PointLight { color 1 1 0.5 location 7.05048847 5.36687326 -0.58721435 }

  ]
}
</xsl:text>

            </xsl:when>

            <xsl:otherwise>

                <html>
                    <head>
                        <title>Sierpinski Sponge</title>
                        <meta http-equiv="Content-Type" content="text/html;charset=utf-8"></meta>
                        <script type="text/javascript" src="http://www.x3dom.org/x3dom/release/x3dom.js"></script>
                    </head>

                    <body style="margin:0">

                        <x3d id="fractal" showStat="false" showLog="false" x="0px" y="0px" width="800px" height="600px"
                            swfpath="http://www.x3dom.org/x3dom/release/x3dom.swf">
                            <scene DEF="scene">

                                <background skyColor="1 1 1"></background>

                                <group>
                                    <xsl:call-template name="doSierpinskiSponge">
                                        <xsl:with-param name="stage" select="$stage" />
                                        <xsl:with-param name="x" select="0" />
                                        <xsl:with-param name="y" select="0" />
                                        <xsl:with-param name="z" select="0" />
                                        <xsl:with-param name="size" select="$size" />
                                        <xsl:with-param name="color" select="$color" />
                                        <xsl:with-param name="type" select="'xml'" />
                                    </xsl:call-template>
                                    <ViewPoint description="basic" jump="true" fieldOfView="1" orientation="-0.84568346 -0.37529552 0.37943769 1.75019240"
                                        position="-2.59999990 7.65999985 -1.77999997"></ViewPoint>

                                    <PointLight color="1 1 0.44000000" location="1.87758946 1.36161554 -2.20474148">
                                    </PointLight>
                                    <PointLight color="1 1 0.44000000" location="7.05048847 5.36687326 -0.58721435">
                                    </PointLight>
                                </group>
                            </scene>
                        </x3d>
                    </body>
                </html>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="doSierpinskiSponge">
        <xsl:param name="stage" />
        <xsl:param name="x" />
        <xsl:param name="y" />
        <xsl:param name="z" select="0" />
        <xsl:param name="size" />
        <xsl:param name="color" />
        <xsl:param name="type" />

        <xsl:choose>

            <xsl:when test="$stage = 0">

                <xsl:variable name="xcolor">
                    <xsl:call-template name="psrgb">
                        <xsl:with-param name="color" select="$color" />
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="point" select="concat($x, ' ', $y, ' ', $z)" />
                <xsl:variable name="boxSize" select="concat($size, ' ', $size, ' ', $size)" />

                <xsl:choose>
                    <xsl:when test="$type = 'vrml'">

                        <xsl:text>
    Transform {
      translation </xsl:text><xsl:value-of select="$point" /><xsl:text>
      children Shape {
        appearance Appearance { material Material { diffuseColor 0.5 0.5 0.5 emissiveColor 0.5 0 0 specularColor 1 0 0 shininess 1.0 transparency 0 } }
        geometry Box { size </xsl:text><xsl:value-of select="$boxSize" /><xsl:text> }
      }
    }
    </xsl:text>

                    </xsl:when>

                    <xsl:otherwise>

                        <transform>
                            <xsl:attribute name="translation"><xsl:value-of select="$point" /></xsl:attribute>
                            <shape>
                                <appearance>
                                    <material diffuseColor="0.5 0.5 0.5" emissiveColor="0.5 0 0" specularColor="1 0 0" shininess="1.0"
                                        transparency="0" />
                                </appearance>
                                <xsl:element name="Box">
                                    <xsl:attribute name="size"><xsl:value-of select="$boxSize" /></xsl:attribute>
                                </xsl:element>
                            </shape>
                        </transform>

                    </xsl:otherwise>

                </xsl:choose>

            </xsl:when>


            <xsl:otherwise>

                <xsl:variable name="nsize" select="$size div 3" />

                <!-- TOP ROW 1: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <!-- MID ROW 1: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <!-- BOTTOM ROW 1: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>




               <!-- TOP ROW 2: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z - 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>


                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z - 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>



               <!-- BOTTOM ROW 2: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z - 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>


                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z - 1 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>



                <!-- TOP ROW 3: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 0 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <!-- MID ROW 3: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 1 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <!-- BOTTOM ROW 3: -->

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 0 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 1 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>

                <xsl:call-template name="doSierpinskiSponge">
                    <xsl:with-param name="x" select="$x + 2 * $nsize" />
                    <xsl:with-param name="y" select="$y + 2 * $nsize" />
                    <xsl:with-param name="z" select="$z - 2 * $nsize" />
                    <xsl:with-param name="size" select="$nsize" />
                    <xsl:with-param name="stage" select="$stage - 1" />
                    <xsl:with-param name="color" select="$color" />
                    <xsl:with-param name="type" select="$type" />
                </xsl:call-template>



            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>