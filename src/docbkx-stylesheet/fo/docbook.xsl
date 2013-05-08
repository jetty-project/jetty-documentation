<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:jfetch="java:org.eclipse.jetty.xslt.tools.JavaSourceFetchExtension"
  xmlns:fetch="java:org.eclipse.jetty.xslt.tools.SourceFetchExtension"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
  xmlns:xverb="com.nwalsh.xalan.Verbatim"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="sverb xverb lxslt exsl d"
>

  <!-- imports the original docbook stylesheet -->
  <xsl:import href="urn:docbkx:stylesheet"/>

  <!-- set bellow all your custom xsl configuration -->
  <xsl:import href="urn:docbkx:stylesheet/highlight.xsl"/>
  <xsl:param name="highlight.source" select="1"/>


<xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="hyphenation-character">\</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="monospace.verbatim.properties">
  <xsl:attribute name="font-size">
    <xsl:choose>
      <xsl:when test="processing-instruction('db-font-size')"><xsl:value-of
           select="processing-instruction('db-font-size')"/></xsl:when>
      <xsl:otherwise>75%</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<xsl:param name="shade.verbatim" select="1"/>

<xsl:attribute-set name="shade.verbatim.style">
  <xsl:attribute name="background-color">#E0E0E0</xsl:attribute>
  <xsl:attribute name="border-width">0.5pt</xsl:attribute>
  <xsl:attribute name="border-style">solid</xsl:attribute>
  <xsl:attribute name="border-color">#575757</xsl:attribute>
  <xsl:attribute name="padding">3pt</xsl:attribute>
</xsl:attribute-set>

<!-- 
   - synxtax highlighting 
   -->
  <xsl:template match="d:programlisting">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="content">
    <xsl:choose>
      <xsl:when test="@language='rjava'">
        <xsl:variable name="filename" select="./d:filename"/>
        <xsl:variable name="methodname" select="./d:methodname"/>
        <xsl:value-of select="jfetch:fetch($filename,$methodname)"/>
      </xsl:when>
      <xsl:when test="@language='rxml'">
        <xsl:variable name="filename" select="./d:filename"/>
        <xsl:value-of select="fetch:fetch($filename)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="apply-highlighting"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

    <fo:block id="{$id}"
                xsl:use-attribute-sets="monospace.verbatim.properties shade.verbatim.style">
        <xsl:choose>
          <xsl:when test="$hyphenate.verbatim != 0 and function-available('exsl:node-set')">
            <xsl:apply-templates select="exsl:node-set($content)" mode="hyphenate.verbatim"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="$content"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
  </xsl:template>

  <!--
    Important links:
    - http://www.sagehill.net/docbookxsl/
    - http://docbkx-tools.sourceforge.net/
  -->
<!--
  <xsl:template match="text()">
    <xsl:call-template name="intersperse-with-zero-spaces">
        <xsl:with-param name="str" select="."/>
    </xsl:call-template>
</xsl:template>
<xsl:template name="intersperse-with-zero-spaces">
    <xsl:param name="str"/>
    <xsl:variable name="spacechars">
        &#x9;&#xA;
        &#x2000;&#x2001;&#x2002;&#x2003;&#x2004;&#x2005;
        &#x2006;&#x2007;&#x2008;&#x2009;&#x200A;&#x200B;
    </xsl:variable>

    <xsl:if test="string-length($str) &gt; 0">
        <xsl:variable name="c1" select="substring($str, 1, 1)"/>
        <xsl:variable name="c2" select="substring($str, 2, 1)"/>

        <xsl:value-of select="$c1"/>
        <xsl:if test="$c2 != '' and
            not(contains($spacechars, $c1) or
            contains($spacechars, $c2))">
            <xsl:text>&#x200B;</xsl:text>
        </xsl:if>

        <xsl:call-template name="intersperse-with-zero-spaces">
            <xsl:with-param name="str" select="substring($str, 2)"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>
-->
</xsl:stylesheet>