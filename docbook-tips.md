# General Tips

## General Stylistic Things

* Usage of jetty.xml as a filename and a configuration style

I think we should use jetty.xml strictly as a filename, and the configuration mechanism should be referred to as 'Jetty XML'

## xml:id usage

The xml:id attribute should only be used on sections, chapters, parts, and the top level book tags.  It should also be used on the table tag as well so you can deep link a table directly.

* On the chapter tag, the xml:id becomes the name of a html file
* On the top level section tag, the xml:id becomes the name of the html file for the section content
* On the second level section tag, the xml:id becomes the hashtag for the section

The use of xml:id is what gives use the ability to create deep-linkable pages which means we need to be careful with both choosing an initial xml:id but also in subsequent changing of them.  A big example of this is all of the direct links from the jetty 7 and 8 wiki pages to their relevant jetty-9 pages. We should endeavor to make sure that we don't kill any important deep links.

## Links

There are two different types of links, internal and external.  Both should use the &lt;link tag but they use two different attributes.  Internal attributes are use the 'linkend' attribute and external use the 'xl:href' attribute.  You can also use &lt;xref linkend="foo" option as well.

## Marking up text in a paragraph

There are a number of different tags that can be used in marking up text.  It is important to tease out what the best one is to use as when they render into the xsl layers they can be treated differently.

* &lt;code&gt; : a generic catch all tag for anything code related inline to text
* &lt;filename&gt; : should wrap text that is a filename
* &lt;classname&gt; : should be used to wrap class name type text, shows in xsl as a &lt;code class="classname"&gt; which we can alter using css 
* &lt;emphasis&gt; : makes it italics
* &lt;emphasis role="bold"&gt; : make it bold

## Different list types

* &lt;itemizedlist&gt; : normal bulleted lists (like this one)
* &lt;variablelist&gt; : use for term/definition type lists
* &lt;orderedlist&gt; : gives you numbered lists, can be nested inside a &lt;listitem&gt; to do outline type lists

Note: all listitem elements should have a child para tag wrapping text.

    <itemlizedlist>
      <listitem>
        <para>
      	  text
    	</para>
    	<para>
      	  another paragraph in that list item
    	</para>
      </listitem>
    </itemlizedlist>

    <variablelist>
      <varlistentry>
        <term>foo</term>
    	<listitem>
      	  <para>
            text
      	  </para>
    	</listitem>
      </varlistentry>
    </variablelist>

    <orderedlist>
      <listitem>
        <para>
    	  text, bullet will be 1.
    	</para>
        <orderedlist>
     	  <listitem>
            <para>
              text, bullet will be a.
            </para>
      	  </listitem>
    	</orderedlist>
      </listitem>
    </orderedlist>

## Admonitions

There are a number of these that can be used within the document.  Each contains a different graphic and should render with a different color border (eventually).

* &lt;tip&gt;
* &lt;note&gt;
* &lt;caution&gt;
* &lt;warning&gt;
* &lt;important&gt;

    <tip>
      <title>Tip Title</title>
      <para>
        Text for the tip box
      </para>
    </tip>

You can use title tags in each of these to override the default test of their tag name.

## Code Blocks

This is how you should add a codeblock.  This way you don't need to escape &lt; and &gt; or anything inside, it is displayed correctly.

NOTE: ALWAYS SPECIFY A LANGUAGE!

      <informalexample>
        <programlisting language="xml" condition="[2, 3]">
    <![CDATA[
    <?xml version="1.0"  encoding="ISO-8859-1"?>
    <!DOCTYPE Configure PUBLIC "-" "http://www.eclipse.org/jetty/configure.dtd">
    <Configure class="org.eclipse.jetty.webapp.WebAppContext">
      <Set name="contextPath">/contextpath</Set>
    </Configure>
    ]]>
        </programlisting>
      </informalexample>

If you specify a 'condition' attribute you can use the '[#, #, #]' notation to highlight those lines to draw the eye there.  You can also use a 'startinglinenumber' attribute to start the line numbering at a certain number.

You can turn off linenumbering by using an attribute on programlisting like 'linenumbering="unnumbered"'

We also have a handleful of xslt extensions to fetch things remotely.

    <informalexample>
      <programlisting language="rjava">
        <filename>http://git.eclipse.org/c/jetty/org.eclipse.jetty.project.git/plain/jetty-io/src/main/java/org/eclipse/jetty/io/AbstractConnection.java</filename>
      </programlisting>  
    </informalexample>

You can also place a &lt;methodname> element as a sibling to &lt;filename> and a single method will be extracted from the file and displayed.

Valid languages are:
* bash
* rbash - get a remote bash file
* properties
* rproperties - get a remote properties file
* sql
* xml
* rxml - get a remote xml file
* java
* rjava - get a remote java file
* plain
* rplain - get a remote plain file

We use the SyntaxHighlighter from http://alexgorbatchev.com/SyntaxHighlighter/ so it is easy to add whatever languages are available with that package, it just required a bit of swizzling in the docbook.xsl file.

## Examples and Titles

There are a number of instances in the existing documentation where programlistings and screens are wrapped in <example and <informalexample so a quick note on that.  By themselves a <screen or a programlisting will simply render directly into the page, but to get them colored into pretty boxes we wrap them in <example tags.  The basic difference between an example and an informalexample is that an example has a title, which means it gets picked up in the generation of the table of contents.  Informalexamples are just that, informal examples that are suitable for something that really only needs to be seen in the context of that page.

## Tables

Please use the following format for tables as it will make use of the css which makes altering all of the look and feel of tables much easier.  Don't use the html tags.

    <table xml:id="id-to-deep-link-table">
      <title>table title</title>
      <tgroup cols="2">
        <thead>
          <row>
            <entry>1</entry>
            <entry>2</entry>
          </row>
        </thead>
        <tbody>
          <row>
            <entry>1</entry>
            <entry>2</entry>
          </row>
          <row>
            <entry>1</entry>
            <entry>2</entry>
          </row>
        </tbody>
      </tgroup>
    </table>
