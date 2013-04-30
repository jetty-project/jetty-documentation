# General Tips

## xml:id usage

The xml:id attribute should only be used on sections, chapters, parts, and the top level book tags.  It should also be used on the table tag as well so you can deep link a table directly.

* On the chapter tag, the xml:id becomes the name of a html file
* On the top level section tag, the xml:id becomes the name of the html file for the section content
* On the second level section tag, the xml:id becomes the hashtag for the section

## Marking up text in a paragraph

There are a number of different tags that can be used in marking up text.  It is important to tease out what the best one is to use as when they render into the xsl layers they can be treated differently.

* &lt;code&gt; : a generic catch all tag for anything code related inline to text
* &lt;filename&gt; : should wrap text that is a filename
* &lt;classname&gt; : should be used to wrap class name type text, shows in xsl as a &lt;code class="classname"&gt; which we can alter using css 

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