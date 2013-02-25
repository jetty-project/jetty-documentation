<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:jfetch="java:org.eclipse.jetty.xslt.tools.JavaSourceFetchExtension"
xmlns:fetch="java:org.eclipse.jetty.xslt.tools.SourceFetchExtension"
xmlns:d="http://docbook.org/ns/docbook"
xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
xmlns:xslthl="http://xslthl.sf.net"
>

  <!-- imports the original docbook stylesheet -->
  <xsl:import href="urn:docbkx:stylesheet"/>

  <!-- set bellow all your custom xsl configuration -->
  <xsl:import href="urn:docbkx:stylesheet/highlight.xsl"/>
  <xsl:param name="highlight.source" select="1"/>

  <!-- use the xml:id on the chapter and sections when rendering chunked output" -->
  <xsl:param name="use.id.as.filename" select="1"/>

  <xsl:param name="draft.mode">maybe</xsl:param>
  <xsl:param name="draft.watermark.image">images/draft-ribbon.png</xsl:param>

  <!-- tweak the generation of toc generation -->
  <xsl:param name="generate.section.toc.level" select="1"/>
  <xsl:param name="toc.section.depth" select="1"/>
  <!--xsl:param name="chunk.tocs.and.lots" select="1"/-->
  <xsl:param name="generate.toc">
    appendix  toc,title
    article/appendix  nop
    article   toc,title
    book      toc,title,figure,table,example,equation
    chapter   toc,title
    part      toc,title
    preface   toc,title
    qandadiv  toc
    qandaset  toc
    reference toc,title
    sect1     toc
    sect2     toc
    sect3     toc
    sect4     toc
    sect5     toc
    section   toc
    set       toc,title
  </xsl:param>

  <!--
  <xsl:param name="variablelist.as.table" select="1"/>
  -->

  <!--
    Important links:
    - http://www.sagehill.net/docbookxsl/
    - http://docbkx-tools.sourceforge.net/
  -->

  <!-- This addresses the issue where 'the section called "foo"' is rendered when we really only want 'foo'
       Note: we should still be able to use xrefstyle on xrefs -->
  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
          <l:context name="xref">
        <l:template name="section" text="%t"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- squash the generation of title attributes -->
  <xsl:template name="generate.html.title"/>

  <xsl:template name="user.head.content">
    <link rel="shortcut icon" href="images/favicon.ico" />
  </xsl:template>

  <xsl:template name="user.header.navigation">
    <center><a href="http://www.eclipse.org/jetty"><img src="images/jetty-logo.svg" width="80"></img></a></center>
  </xsl:template>

  <xsl:template name="user.header.content">
    <div style="background-color: #DEF; text-align: left; font-size:80%; font-family: arial, sans; border:thin dotted blue; padding: 4px; ">
    <span style="font-variant: small-caps; font-weight: bold">
        <a href="http://www.webtide.com/support.jsp" style="text-decoration:none">Contact the core Jetty developers at
          <span style="color:#F3A"> www.webtide.com</span>
        </a>
    </span>
    <br/>
    <span  style="font-style:oblique;font-size: 80%">
 private support for your internal/customer projects ... custom extensions and distributions ... versioned snapshots for indefinite support ...
 scalability guidance for your apps and Ajax/Comet projects ... development services from 1 day to full product delivery
    </span>
   </div>
  </xsl:template>

  <xsl:template name="user.footer.content">
    <!-- content here is in a custom footer text -->
    <xsl:apply-templates select="//copyright[1]" mode="titlepage.mode"/>
  </xsl:template>

  <xsl:template name="user.footer.navigation">
  <div style="background-color: #DEF; text-align: left; font-size:80%; font-family: arial, sans; border:thin dotted blue; padding: 4px; ">
    <span  style="font-style:oblique;font-size: 80%">
See an error or something missing?<br/>
    </span>
    <span style="font-variant: small-caps; font-weight: bold">
        <a href="http://github.com/jetty-project/jetty-documentation" style="text-decoration:none">Contribute to this documentation at
        <span style="color:#F3A"> Github!</span>
        </a>
    </span>
    <br/>
   </div>

    <script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-1149868-7']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
    </script>
  </xsl:template>

  <xsl:template match="d:programlisting[@language='rjava']">

    <xsl:param name="suppress-numbers" select="'0'"/>

    <xsl:call-template name="anchor"/>

    <xsl:variable name="div.element">pre</xsl:variable>

    <xsl:if test="$shade.verbatim != 0">
      <xsl:message>
        <xsl:text>The shade.verbatim parameter is deprecated. </xsl:text>
        <xsl:text>Use CSS instead,</xsl:text>
      </xsl:message>
      <xsl:message>
        <xsl:text>for example: pre.</xsl:text>
        <xsl:value-of select="local-name(.)"/>
        <xsl:text> { background-color: #E0E0E0; }</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:element name="{$div.element}">
          <xsl:apply-templates select="." mode="common.html.attributes"/>

          <xsl:if test="@width != ''">
            <xsl:attribute name="width">
              <xsl:value-of select="@width"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$highlight.source != 0">
              <xsl:variable name="filename" select="./d:filename"/>
              <xsl:variable name="methodname" select="./d:methodname"/>
              <xsl:variable name="newText" select="jfetch:fetch($filename,$methodname)"/>

              <xsl:value-of select="$newText"/>
              <!--xsl:call-template name="apply-highlighting"/-->
            </xsl:when>
            <xsl:otherwise>

            <xsl:if test="function-available('jfetch:fetch')">
              <xsl:variable name="filename" select="./d:/filename"/>
              <xsl:variable name="methodname" select="./d:methodname"/>
              <xsl:variable name="newText" select="jfetch:fetch($filename,$methodname)"/>

              <xsl:apply-templates select="$newText"/>
              <xsl:value-of select="$newText"/>
           </xsl:if>

            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>

  </xsl:template>

    <xsl:template match="d:programlisting[@language='fetch']">

    <xsl:param name="suppress-numbers" select="'0'"/>

    <xsl:call-template name="anchor"/>

    <xsl:variable name="div.element">pre</xsl:variable>

    <xsl:if test="$shade.verbatim != 0">
      <xsl:message>
        <xsl:text>The shade.verbatim parameter is deprecated. </xsl:text>
        <xsl:text>Use CSS instead,</xsl:text>
      </xsl:message>
      <xsl:message>
        <xsl:text>for example: pre.</xsl:text>
        <xsl:value-of select="local-name(.)"/>
        <xsl:text> { background-color: #E0E0E0; }</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:element name="{$div.element}">
          <xsl:apply-templates select="." mode="common.html.attributes"/>

          <xsl:if test="@width != ''">
            <xsl:attribute name="width">
              <xsl:value-of select="@width"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$highlight.source != 0">
              <xsl:variable name="filename" select="./d:filename"/>
              <xsl:variable name="newText" select="fetch:fetch($filename)"/>

              <xsl:value-of select="$newText"/>
              <!--xsl:call-template name="apply-highlighting"/-->
            </xsl:when>
            <xsl:otherwise>

            <xsl:if test="function-available('jfetch:fetch')">
              <xsl:variable name="filename" select="./d:/filename"/>
              <xsl:variable name="newText" select="fetch:fetch($filename)"/>

              <xsl:apply-templates select="$newText"/>
              <xsl:value-of select="$newText"/>
           </xsl:if>

            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>

  </xsl:template>

  <!-- By default, DocBook surrounds highlighted elements with one or more HTML elements
  that already have an explicit style, which makes difficult to customize them via CSS.
  Here we override the surrounding using a span element with the right class, easily
  customizable in the CSS. -->
    <xsl:template match="xslthl:comment" mode="xslthl">
        <span class="hl-comment">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="xslthl:string" mode="xslthl">
        <span class="hl-string">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="xslthl:annotation" mode="xslthl">
        <span class="hl-annotation">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="xslthl:keyword" mode="xslthl">
        <span class="hl-keyword">
            <xsl:apply-templates />
        </span>
    </xsl:template>

</xsl:stylesheet>
