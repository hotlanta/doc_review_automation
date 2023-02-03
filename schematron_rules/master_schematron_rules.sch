<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">
   <sch:pattern>
      <sch:rule context="*['p'] [not(' keyref ')]" role="warning">
      <!-- 'Oxford comma light': if there is an 'and' in a paragraph, enforce that it is preceded by a comma -->
         <sch:let name="whereIsAnd" value="index-of(.,' and ')"/>
         <sch:let name="thingsBeforeAnd" value="substring-before(., ' and')"/>
         <sch:let name="whereIsOr" value="index-of(.,' or ')"/>
         <sch:let name="thingsBeforeOr" value="substring-before(., ' or')"/>
         <sch:let name="whereIsBut" value="index-of(.,' but ')"/>
         <sch:let name="thingsBeforeBut" value="substring-before(., ' but')"/>
         <sch:assert test="(contains(., 'and')) and (ends-with($thingsBeforeAnd, ',')) or (not(contains(., 'and')))">
            There might be a comma missing here.
         </sch:assert>
         <sch:assert test="(contains(., ' or ')) and (ends-with($thingsBeforeOr, ',')) or (not(contains(., ' or ')))">
            There might be a comma missing here.
         </sch:assert>
         <sch:assert test="(contains(., ' but ')) and (ends-with($thingsBeforeBut, ',')) or (not(contains(., ' but ')))">
            There might be a comma missing here.
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!-- Require a title for tables. -->
      <sch:rule context="//table"  role="warning">
         <sch:assert test="title">
            Every <sch:value-of select="name(.)"/> needs a title.
         </sch:assert>
      </sch:rule>
      <!-- Require a title for figures. -->
      <sch:rule context="//fig"  role="warning">
         <sch:assert test="title">
            Every <sch:value-of select="name(.)"/> needs a title.
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="*['//body//p'] [not(' keyref ')]" role="warning">
         <!-- Enforce no extra spaces in paragraphs. -->
         <sch:report test="(string-length(.[text()]) > 0) and (normalize-space(.) != text())">
            Extra spaces detected.
         </sch:report>
         <xsl:variable name="descendantSpaces">
            <xsl:for-each select="descendant::text()">
               <xsl:variable name="word" select="tokenize(current()[text()], '\s')"/>
               <xsl:if test="normalize-space(.) != text()">
                  <xsl:value-of select="concat(current(), ', ')"/>
               </xsl:if>
            </xsl:for-each>
         </xsl:variable>
         <sch:report test="string-length($descendantSpaces) > 0">
            Extra spaces detected in one or more descendant text nodes.
         </sch:report>
      </sch:rule>
      <!-- Enforce no extra spaces in list items -->
      <sch:rule context="*['//li'] [not(' keyref ')]" role="warning">
         <sch:report test="(string-length(.[text()]) > 0) and (normalize-space(.) != text())">
            Extra spaces detected.
         </sch:report>
         <xsl:variable name="descendantSpaces">
            <xsl:for-each select="descendant::text()">
               <xsl:variable name="word" select="tokenize(current()[text()], '\s')"/>
               <xsl:if test="normalize-space(.) != text()">
                  <xsl:value-of select="concat(current(), ', ')"/>
               </xsl:if>
            </xsl:for-each>
         </xsl:variable>
         <sch:report test="string-length($descendantSpaces) > 0">
            Extra spaces detected in one or more descendant text nodes.
         </sch:report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!-- Flag lists that have only one item. -->
      <sch:rule context="ol" role="warning">
         <sch:assert test="count(./li) > 1">
            If you only have one list item, you don't need a list.
         </sch:assert>
      </sch:rule>
      <sch:rule context="ul" role="warning">
         <sch:assert test="count(./li) > 1">
            If you only have one list item, you don't need a list.
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!-- titles should start with an uppercase letter, and should have sentence case -->
      <sch:rule context="*['title'] [not(' keyref ')]"  role="warning">
         <sch:let name="first-letter"
            value="substring(.,1,1)"/>
         <sch:assert test="$first-letter = upper-case($first-letter)">
            Please start headings with an uppercase character.
         </sch:assert>
         <xsl:variable name="offendingWords">
            <xsl:for-each select="tokenize(text(), '\s')">
               <xsl:if test="position() != 1 and (substring(current(), 1, 1) = upper-case(substring(current(), 1, 1)))">
                  <xsl:value-of select="concat(current(), ', ')"/>
               </xsl:if>
            </xsl:for-each>
         </xsl:variable>
         <sch:report test="string-length($offendingWords) > 0">
            The words <sch:value-of select="$offendingWords"/> should be lower-case.
         </sch:report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!-- require a shortdesc element -->
      <sch:rule context="shortdesc" role="warning">
         <sch:assert test="(string-length(.[text()]) > 0)">
            Please add a shortdesc element.
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!-- Detect leading and trailing whitespace inside inline elements.-->
      <sch:rule context="//codeph" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
      <sch:rule context="//uicontrol" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
      <sch:rule context="//keyword" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
      <sch:rule context="//b" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
      <sch:rule context="//u" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
      <sch:rule context="//i" role="warning">
         <xsl:variable name="words">
            <xsl:if test="string-length(.[text()]) > 1">
               <xsl:for-each select="tokenize(text(), '\s')">
                  <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                     <xsl:value-of select="concat(current(), ', ')"/>
                  </xsl:if>
               </xsl:for-each>
            </xsl:if>
         </xsl:variable>
         <sch:report test="string-length($words) > 0">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
         <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
            Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
         </sch:report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <!--Enforce writing out numbers less than 10-->
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '0 ') or contains(., ' 0 ') or substring(., string-length(.) - 0) = ' 0'">Use "zero" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '1 ') or contains(., ' 1 ') or substring(., string-length(.) - 1) = ' 1'">Use "one" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '2 ') or contains(., ' 2 ') or substring(., string-length(.) - 2) = ' 2'">Use "two" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '3 ') or contains(., ' 3 ') or substring(., string-length(.) - 3) = ' 3'">Use "three" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '4 ') or contains(., ' 4 ') or substring(., string-length(.) - 4) = ' 5'">Use "four" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '5 ') or contains(., ' 5 ') or substring(., string-length(.) - 5) = ' 5'">Use "five" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '6 ') or contains(., ' 6 ') or substring(., string-length(.) - 6) = ' 6'">Use "six" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '7 ') or contains(., ' 7 ') or substring(., string-length(.) - 7) = ' 7'">Use "seven" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '8 ') or contains(., ' 8 ') or substring(., string-length(.) - 8) = ' 8'">Use "eight" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
      <sch:rule context="text()[count(ancestor::mathml) = 0][count(ancestor::table) = 0]" role="warning">
         <report test="starts-with(., '9 ') or contains(., ' 9 ') or substring(., string-length(.) - 9) = ' 9'">Use "nine" instead</report>
      </sch:rule>
   </sch:pattern>
   <sch:pattern>
    <!-- duplicate topicref detected in map -->
        <sch:rule context="*[contains(@class, ' map/topicref ')]" role="warning">
            <sch:let name="href" value="@href"/>
            <sch:report
                test="preceding::element()[contains(@class, ' map/topicref ')][@href = $href]">
                Duplicate topicref "<sch:value-of select="$href"/>" detected in map.
            </sch:report>
        </sch:rule>
    </sch:pattern>
	<sch:pattern>
        <sch:rule context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')]
           [@href][contains(@href, '#')][not(@scope = 'external')] [not(@type) or @type='dita']" role="warning">
            <!-- rule detects broken links in DITA <xref> or <link> elements, for links that contain an anchor -->
            <sch:let name="file" value="substring-before(@href, '#')"/>
            <sch:let name="idPart" value="substring-after(@href, '#')"/>
            <sch:let name="topicId"
        value="if (contains($idPart, '/')) then substring-before($idPart, '/') else $idPart"/>
            <sch:let name="id" value="substring-after($idPart, '/')"/>
    
            <sch:assert test="document($file, .)//*[@id=$topicId]">
        Invalid topic id "<value-of select="$topicId"/>" </sch:assert>
            <sch:assert test="$id ='' or document($file, .)//*[@id=$id]">
        No such id "<value-of select="$id"/>" is defined! </sch:assert>
            <sch:assert test="$id='' or document($file, .)//*[@id=$id]
        [ancestor::*[contains(@class, ' topic/topic ')][1][@id=$topicId]]"> 
        The id "<value-of select="$id"/>" is not in the scope of the referenced topic id 
        "<value-of select="$topicId"/>". </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- Avoid using the @scalefit attribute on images. -->
        <sch:rule context="*[contains(@class, ' topic/image ')]">
           <sch:assert test="not(@scalefit)">
            Dynamically scaled images are not properly displayed in PDF. Use the width attribute instead (and height attribute if needed).
           </sch:assert>
        </sch:rule>
    </sch:pattern>
<!-- Flag absolute column widths BEGIN -->
  <!-- Rule:  Table colspec element should use colwidth attributes that are proportional.
       The characteristic of colwidth that makes it proportional that the value ends with the '*' character.
       Testing that colwidth contains an astrisk is sufficient. -->
  <sch:pattern id="check.proportional.colwidths">
    <sch:rule context="colspec" role="warn">
      <sch:assert test="contains(@colwidth, '*')">Use proportional column widths, such as "2*", instead of absolute column widths.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Flag absolute column widths END -->
    <!-- XREF Web link checks BEGIN -->
  <!-- xref element should not contain text that is identical to the URL in @href -->
  <!-- Fix: remove the text. Ideally there should be text that represents the destination of the link instead. -->
  <sch:pattern id="check.xrefs.redundant.link.content">
    <sch:rule context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')]" role="warn">
      <sch:report test="@scope='external' and @href=text()" sqf:fix="removeText">
        Link text is same as @href attribute value.
        Do not type in a URL for link text. The HPE Style Guide standard is to use text that
        represents the link destination. Using an xref without link text ouptputs the URL in href
        automatically as the link text.
      </sch:report>
      <sqf:fix id="removeText">
        <sqf:description>
          <sqf:title>Remove the text</sqf:title>
        </sqf:description>
        <sqf:delete match="text()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- XREF Web link checks END -->  
 <sch:pattern id="check-lists">
    <sch:rule context="ul | ol">
      <sch:let name="filtered-elements" value="('fig', 'codeblock', 'screen', 'table', 'filepath', 'codeph', 'msgblock', 'msgph', 'uicontrol', 'wintitle', 'userinput')"/>
      <sch:let name="filtered-list">
        <!--\-Filter list item descendant nodes. Remove elements which could be ended with any character if these elements do not have following siblings-\-->
        <xsl:for-each select="*">
          <li>
            <xsl:for-each select="node()">
              <xsl:choose>
                <xsl:when test="(name() = $filtered-elements)
                  and not(following-sibling::*)">
                  <!--\-do not copy these elements if they are the last element in the list item-\-->
                </xsl:when>
                <xsl:otherwise>
                  <!--\-copy any node (text, element) except any in a list above-\-->
                  <xsl:copy>
                    <!--\-do the same step for 2-nd level list item children-\-->
                    <xsl:for-each select="node()">
                      <xsl:choose>
                        <xsl:when test="(name() = $filtered-elements)
                          and not(following-sibling::*)"/>
                        <xsl:otherwise>
                          <!--\-copy any node (text, element) except any in a list above-\-->
                          <xsl:copy-of select="."/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                  </xsl:copy>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </li>
        </xsl:for-each>
      </sch:let>
      <!--\- Check if one or more list items in filtered list is a complete sentence, all list items should end with a period -\-->
      <sch:report test="$filtered-list/*[ends-with(normalize-space(.), '.')]
        and $filtered-list/*[not(ends-with(normalize-space(.), '.'))]"
        role="warn">Avoid combining both fragments and sentences in a list. If you cannot avoid combining
        fragments and sentences, end all items in the list with a period.
      </sch:report>
    </sch:rule>
  </sch:pattern> 
</sch:schema>