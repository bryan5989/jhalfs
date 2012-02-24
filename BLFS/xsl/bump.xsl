<?xml version="1.0" encoding="ISO-8859-1"?>

<!-- $Id: bump.xsl 21 2012-02-16 15:06:19Z labastie $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:param name="packages" select="'packages.xml'"/>
  <xsl:param name="package" select="''"/>

  <xsl:output
    method="xml"
    encoding="ISO-8859-1"
    doctype-system="PACKDESC"/>

  <xsl:template match="/">
    <sublist>
      <xsl:copy-of select="./sublist/name"/>
      <xsl:apply-templates select=".//package"/>
      <xsl:if test="not(.//package[string(name)=$package])">
        <package>
          <name><xsl:value-of select="$package"/></name>
          <version><xsl:value-of select=
            "document($packages)//package[string(name)=$package]/version"/>
          </version>
        </package>
      </xsl:if>
    </sublist>
  </xsl:template>

  <xsl:template match="package">
    <xsl:choose>
      <xsl:when test="string(name)=$package">
        <package>
          <name><xsl:value-of select="name"/></name>
          <version><xsl:value-of select=
            "document($packages)//package[string(name)=$package]/version"/>
          </version>
        </package>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select='.'/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="dirname">
    <xsl:param name="filename" select="$packages"/>
    <xsl:param name="dir" select="''"/>
    <xsl:choose>
      <xsl:when test="contains($filename,'/')">
        <xsl:call-template name="dirname">
          <xsl:with-param
            name="filename"
            select="substring-after($filename,'/')"/>
          <xsl:with-param
            name="dir"
            select="concat(substring-before($filename,'/'),'/')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="not(contains($dir,'/'))">
        <xsl:message>`packages' must be an absolute path</xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$dir"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>