<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:jfetch="java:org.eclipse.jetty.xslt.tools.JavaSourceFetchExtension"
xmlns:fetch="java:org.eclipse.jetty.xslt.tools.SourceFetchExtension"
xmlns:d="http://docbook.org/ns/docbook"
xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
xmlns:xslthl="http://xslthl.sf.net"
xmlns:gcse="http://www.google.com"
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

  
  <xsl:param name="admon.graphics" select="1"/>
  <!--
  <xsl:param name="admon.graphics.extension">.svg</xsl:param>
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
    <!--
      - syntax highlighting bits and pieces
    -->
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shCore.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushJava.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushXml.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushBash.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushJScript.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushProperties.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      <xsl:attribute name="src">js/shBrushPlain.js</xsl:attribute>
    </xsl:element>
    <xsl:element name="link">
      <xsl:attribute name="type">text/css</xsl:attribute>
      <xsl:attribute name="rel">stylesheet</xsl:attribute>
      <xsl:attribute name="href">css/shCore.css</xsl:attribute>
    </xsl:element>
    <xsl:element name="link">
      <xsl:attribute name="type">text/css</xsl:attribute>
      <xsl:attribute name="rel">stylesheet</xsl:attribute>
      <xsl:attribute name="href">css/shThemeEclipse.css</xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:template name="user.header.navigation">
    <table>
      <tr>
        <td style="width: 50%">
          <a href="http://www.eclipse.org/jetty"><img src="images/jetty-header-logo.png" alt="Jetty Logo"></img></a>
        </td>
        <td style="width: 50%">
          <script type="text/javascript">  (function() {
            var cx = '016459005284625897022:obd4lsai2ds';
            var gcse = document.createElement('script');
            gcse.type = 'text/javascript';
            gcse.async = true;
            gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
            '//www.google.com/cse/cse.js?cx=' + cx;
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(gcse, s);
            })();
          </script>
          <gcse:search></gcse:search>
        </td>
      </tr>
    </table>6
  </xsl:template>

  <xsl:template name="user.header.content">
    <!-- Include required JS files -->

    <div class="jetty-callout">
      <h5 class="callout">
        <a href="http://www.webtide.com/support.jsp">Contact the core Jetty developers at
          <span class="website">www.webtide.com</span>
        </a>
      </h5>
      <p>
 private support for your internal/customer projects ... custom extensions and distributions ... versioned snapshots for indefinite support ...
 scalability guidance for your apps and Ajax/Comet projects ... development services from 1 day to full product delivery
      </p>
   </div>

     <xsl:if test="($draft.mode = 'yes' or
                ($draft.mode = 'maybe' and
                ancestor-or-self::*[@status][1]/@status = 'draft'))
                and $draft.watermark.image != ''">
        <div class="draft">
          <h5>DRAFT</h5>
          <p>
          This page contains content that we have migrated from Jetty 7 or Jetty 8 documentation into the correct format, but we have not yet audited it for technical accuracy in Jetty 9.  Be aware that examples or information contained on this page may be incorrect.  Please check back soon as we continue improving the documentation, or submit corrections yourself to this page through <a href="http://github.com/jetty-project/jetty-documentation" style="text-decoration:none">Github</a>. Thank you.
          </p>
        </div>

    </xsl:if>
  </xsl:template>

  <xsl:template name="user.footer.content">
    <!-- content here is in a custom footer text -->
    <xsl:apply-templates select="//copyright[1]" mode="titlepage.mode"/>
    
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      SyntaxHighlighter.all()
    </xsl:element>

  </xsl:template>

  <xsl:template name="user.footer.navigation">
    <div class="jetty-callout">
      <p>
        See an error or something missing?
        <span class="callout">
          <a href="http://github.com/jetty-project/jetty-documentation">Contribute to this documentation at
            <span class="website">Github!</span>
          </a>
        </span>
      </p>
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

 <!-- 
   - synxtax highlighting 
   -->
  <xsl:template match="d:programlisting">
    <xsl:element name="script">
      <xsl:attribute name="type">syntaxhighlighter</xsl:attribute>
      
      <xsl:variable name="highlight">
        <xsl:choose>
          <xsl:when test="@condition">; highlight: <xsl:value-of select="@condition"/></xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="startinglinenumber">
        <xsl:choose>
          <xsl:when test="@startinglinenumber">; first-line: <xsl:value-of select="@startinglinenumber"/></xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="brushstyle">;toolbar: false<xsl:copy-of select="$highlight"/><xsl:copy-of select="$startinglinenumber"/></xsl:variable>

      <xsl:choose>
        <xsl:when test="@language='bash'">
          <xsl:attribute name="class">brush: bash<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='properties'">
          <xsl:attribute name="class">brush: properties<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='java'">
          <xsl:attribute name="class">brush: java<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='rjava'">
          <xsl:attribute name="class">brush: java<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          <xsl:variable name="filename" select="./d:filename"/>
          <xsl:variable name="methodname" select="./d:methodname"/>
          <xsl:variable name="newText" select="jfetch:fetch($filename,$methodname)"/>
          &lt;![CDATA[<xsl:value-of select="$newText"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='xml'">
          <xsl:attribute name="class">brush: xml<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='rxml'">
          <xsl:attribute name="class">brush: xml<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          <xsl:variable name="filename" select="./d:filename"/>
          <xsl:variable name="newText" select="fetch:fetch($filename)"/>
          &lt;![CDATA[<xsl:value-of select="$newText"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='plain'">
          <xsl:attribute name="class">brush: plain<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
        </xsl:when>
        <xsl:when test="@language='rplain'">
          <xsl:attribute name="class">brush: plain<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          <xsl:variable name="filename" select="./d:filename"/>
          <xsl:variable name="newText" select="fetch:fetch($filename)"/>
          &lt;![CDATA[<xsl:value-of select="$newText"/>]]&gt;
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">brush: plain<xsl:copy-of select="$brushstyle"/></xsl:attribute>
          &lt;![CDATA[<xsl:value-of select="text()"/>]]&gt;
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
