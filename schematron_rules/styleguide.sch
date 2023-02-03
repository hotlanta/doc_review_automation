<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:ns uri="http://oxygenxml.com/dita/blockElements" prefix="e"/>
  
  <!-- Topic: Validate TCaaS resourceid rule -->
  <sch:pattern id="check.topic.tcaas-resourceid">
    <!-- Flag warning if <resourceid> is used in a TCaaS topic instead of a bookmap or submap. -->
    <sch:rule context="resourceid[@appname='tcaas']" role="warning">
      <sch:assert test="not(parent::prolog)">Move the element "resourceid" in your TCaaS topic to a bookmap or submap to avoid a resource ID conflict due to topic reuse.</sch:assert>
    </sch:rule>
  </sch:pattern>
    
  <!-- Map: Validate TCaaS resourceid rules -->
  <sch:pattern id="check.map.tcaas-resourceid">
    <sch:rule context="topicmeta/resourceid[@appname='tcaas']" role="error">
      <!-- Flag the other value of @ux-source-priority than "map-takes-priority" and "topic-and-map". -->
      <sch:assert test="@ux-source-priority='map-takes-priority' or @ux-source-priority='topic-and-map'">The attribute "ux-source-priority" doesn't allow other values than "map-takes-priority" or "topic-and-map" when the attribute "appname" is specified to "tcaas".</sch:assert>
      <!-- Flag if none of @appid and @id exist. -->
      <sch:assert test="@appid or @id" sqf:fix="add.tcaas-resourceid.appid">The attribute "appid" is missing. It is required when the attribute "appname" is specified to "tcaas".</sch:assert>
      <sqf:fix id="add.tcaas-resourceid.appid">
        <sqf:description>
          <sqf:title>Add the attribute "appid".</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="appid" />
      </sqf:fix>
      <!-- Flag if @appid doesn't exist, but @id exists. -->
      <sch:report test="not(@appid) and @id" sqf:fix="replace.tcaas-resourceid.id">The attribute "id" should not be used when the attribute "appname" is specified to "tcaas". Instead, use the attribute "appid".</sch:report>
      <sqf:fix id="replace.tcaas-resourceid.id">
        <sqf:description>
          <sqf:title>Replace the attribute "id" with the attribute "appid".</sqf:title>
        </sqf:description>
        <sqf:replace node-type="keep" match="@id" target="appid" select="string(.)"/>
      </sqf:fix>
      <!-- Flag if both @appid and @id exist. -->
      <sch:report test="@appid and @id" sqf:fix="delete.tcaas-resourceid.id">The attribute "id" should not be used with the attribute "appid" when the attribute "appname" is specified to "tcaas". Delete it.</sch:report>
      <sqf:fix id="delete.tcaas-resourceid.id">
        <sqf:description>
          <sqf:title>Delete the attribute "id".</sqf:title>
        </sqf:description>
        <sqf:delete match="@id" />
      </sqf:fix>
      <!-- Flag if the other characters than alphanumerics, "-", and "_" are used for @appid -->
      <sch:assert test="not(@appid) or matches(@appid, '^[A-Za-z0-9_.-]+$')">The attribute "appid" allows only alphanumerics, "-", "_", and "." when the attribute "appname" is specified to "tcaas".</sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Checks for topic & map metadata elements BEGIN -->
  
  <sch:pattern id="check.resourceid">
    <sch:rule context="resourceid[1]/@id" role="error">
      <sch:assert test="not(matches(., '.*[\s&quot;#%&lt;&gt;?\[\\\]^`{|}].*'))" sqf:fix="replace.resourceid.invalidchar">"#%&lt;&gt;?[]^`{|} and space are invalid for URI path character (RFC3986 Sec3.3). Don't use those for resourceid to replace GUID path.</sch:assert>
      <sqf:fix id="replace.resourceid.invalidchar">
        <sqf:description>
          <sqf:title>Replace invalid URI path characters with "-"</sqf:title>
        </sqf:description>
        <sqf:replace node-type="keep" target="id" select="replace(., '[-\s&quot;#%&lt;&gt;?\[\\\]^`{|}]+', '-')"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- Checks for topic & map metadata elements END -->
  
  <!--<pattern id="check.note">
    <rule context="note" role="warning">
      <let name="paragraphs" value="count(*[substring-before(substring-after(@class, ' '), ' ')='topic/p'])"/>
      <let name="blockElements" value="count(*[substring-before(substring-after(@class, ' '), ' ')=document('blockElements.xml')//e:class])"/>
      <report test="$paragraphs=1 and $blockElements=1"
        > Please remove the "<value-of select="name(*[1])"/>" element and place its text directly in
        the note. If there is just one block of text in the note, then the note should be left as
        string-only. This stores the minimum of mark-up, and simplifies the processed output. If
        there are multiple blocks in the note, then paragraphs, lists (or other block elements)
        should be used. </report>
      <report test="$blockElements > 0 and count(text()[normalize-space(.)!=''])>0" role="error"
        > You should wrap the text that you entered directly inside the note element in a "p"
        element or other block element, or move it inside one of the existing block elements.
        Alternatively remove all the block elements and leave the note to contain only text.
        String-only text should not be used in the same note alongside block elements. </report>
      <report test="matches(., 'Note:')"
        > Please remove the "Note:" text that starts your note! The mark-up of that element in DITA
        must always follow the pattern: &lt;note>Before having...&lt;/note> and never:
        &lt;note>Note: Before having...&lt;/note>. Embedding the label for an element in its text
        will limit the ways in which the element can be presented. </report>
    </rule>
  </pattern>-->
<!--  <pattern id="check.images">
    <rule context="image" role="fatal">
      <assert test="alt" sqf:fix="add.alt.to.image">This image requires an 'alt' tag.</assert>
<!-\-      <report test="not(alt[normalize-space(.)])">The alt tag in an image cannot be empty. Please insert a value.</report>-\->
    </rule>
    <!-\-<rule context="image" role="fatal">
      <assert test="@alt">This image needs the alt attribute.</assert>
    </rule>-\->
  </pattern>-->

  <!--<sch:pattern id="check.titles">
    <sch:rule context="*/title" role="error">
      <sch:assert test="not(b)">Title should not contain a b tag.</sch:assert>
      <sch:assert test="not(uicontrol)">Title should not contain a uicontrol tag.</sch:assert>
      <sch:assert test="not(codeph)">Title should not contain a codeph tag.</sch:assert>
    </sch:rule>
  </sch:pattern>-->
 <!-- <sch:pattern id="check.map">
    <sch:rule context="map" role="fatal">
      <sch:assert test="not(@processing-role='resource-only')" sqf:fix="remove.processing.role.attribute">Map should not contain a processing role with the value of "resource-only".</sch:assert>
    </sch:rule>
    <sch:rule context="map//*" role="fatal">
      <sch:assert test="not(@processing-role='resource-only')" sqf:fix="remove.processing.role.attribute">Any element in the map should not contain a processing role with the value of "resource-only".</sch:assert>
    </sch:rule>
  </sch:pattern>-->
  <sch:pattern id="check.checklist">
    <sch:rule context="task//steps-unordered[@outputclass='checklist']" role="error">
      <sch:assert test="ancestor::task/title[starts-with(string-join(text(), ''),'Checklist: ')]" sqf:fix="replace.text.with.checklist" >Checklist topic needs to start with 'Checklist: '.</sch:assert>
    </sch:rule>
    <sch:rule context="task/title[contains(string-join(text(), ''),'Checklist')]" role="error">
      <sch:assert test="//steps-unordered[@outputclass='checklist']" >Checklist topic needs steps-unordered with attribute outputclass='checklist'.</sch:assert>
    </sch:rule>
    <sch:rule context="steps-unordered[@outputclass]" role="warn">
      <sch:assert test="@outputclass='checklist'" sqf:fix="replace.with.checklist">Checklist needs outputclass="checklist".</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="check.alert.stacking">
    <sch:rule context="note" role="warn">
      <sch:assert test="not(preceding-sibling::*[1][self::note])">Avoid alert stacking. Too many alerts in a row tend to be ignored by readers. Review to determine if this alert is needed.</sch:assert>
    </sch:rule>
 <!--   <rule context="note" role="warn">
      <assert test="not(@type='danger')">Instead of 'Risk of', please use 'danger' or 'warning'.</assert>
    </rule>-->
  </sch:pattern>

  <!-- Checks for topic elements BEGIN -->
  <sch:pattern id="check.object">
    <sch:rule context="object/@codebase" role="error">
      <sch:assert test="not(matches(., '.*brightcove\.net([:/].*|$)'))">All brightcove.net URLs are forbidden. Always use the equivalent HPESC video display link.</sch:assert>
    </sch:rule>
    <sch:rule context="object/@data" role="error">
      <sch:assert test="not(matches(., '.*brightcove\.net[:/].*'))">All brightcove.net URLs are forbidden. Always use the equivalent HPESC video display link.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check for whole topic conditionalizing BEGIN -->
  <!-- @ishcondition attribute must not be used on a root topic element -->
  <!-- Fix: Remove @ishcondition -->
  <sch:pattern id="check.topic.ishcondition">
    <sch:rule context="/*"> <!-- Check just the root element.  Conditions in elements below root is ok  -->
      <sch:assert test="not(@ishcondition)" role="error" sqf:fix="remove.ishcondition.attribute">
        Setting the @ishcondition on a whole topic results in invalid DITA. To conditionalize whole topics, set conditions on map elements.
      </sch:assert>
      <sqf:fix id="remove.ishcondition.attribute">
        <sqf:description>
          <sqf:title> Remove ishcondition attribute.</sqf:title>
        </sqf:description>
        <sqf:delete match="@ishcondition"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- Check for whole topic conditionalizing END -->

  <!-- Troubleshooting topic checks BEGIN -->
  <!-- Trouble solution requires at least one remedy element  -->
  <sch:pattern id="check.troubleshooting.remedy">
    <sch:rule context="//troubleSolution" role="warn">
      <sch:assert test="(exists(remedy))">A &lt;troubleSolution&gt; must have a &lt;remedy&gt; element.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Troubleshooting topic checks END -->

  <!-- Alert stacking checks BEGIN -->
  <!-- Does not distinguish between note types -->
  <!-- Avoid alert stacking, which is a note immediately followed by another note. -->
  <!-- Flag if the preceding sibling of a note is another note. -->
<!--  <pattern id="check.alert.stacking">
    <rule context="note" role="warn">
      <assert test="not(preceding-sibling::*[1][self::note])">Avoid altert stacking. Too many alerts
        in a row tend to be ignored by readers.</assert>
    </rule>
  </pattern>-->
  <!-- Alert stacking checks END -->

  <!-- XREF Web link checks BEGIN -->
  <sch:pattern id="check.xref">
    <sch:rule context="xref" role="error">
      <sch:let name="isGuid" value="starts-with(@href, 'GUID-')"/>
      <sch:assert test="not($isGuid and not(contains(@format, 'dita')))" sqf:fix="set.xref.format.dita">Use the attribute format="dita" if the target link is to a DITA topic.</sch:assert>
      <sch:assert test="not($isGuid and contains(@scope, 'external'))" sqf:fix="remove.xref.scope">Remove the attribute scope="external" if the target link is to a DITA topic.</sch:assert>
      <sqf:fix id="set.xref.format.dita">
        <sqf:description>
          <sqf:title>Set format attribute to "dita"</sqf:title>
        </sqf:description>
        <sqf:replace node-type="attribute" match="@format" target="format" select="xs:string('dita')"/>
      </sqf:fix>
      <sqf:fix id="remove.xref.scope">
        <sqf:description>
          <sqf:title>Remove scope attribute</sqf:title>
        </sqf:description>
        <sqf:delete match="@scope"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- No xref in bold, no bold in xref -->
  <sch:pattern id="check.xrefs.forBold">
    <sch:rule context="xref" role="warn">
      <sch:assert test="not(child::b)" sqf:fix="removeBoldChild">Bold element is not allowed in &lt;xref&gt; link text.</sch:assert>
      <sch:assert test="not(parent::b)" sqf:fix="removeBoldParent">Bold element should not contain &lt;xref&gt;.</sch:assert>
      <sqf:fix id="removeBoldChild">
        <sqf:description>
          <sqf:title>Remove child &lt;b&gt; and keep content</sqf:title>
        </sqf:description>
        <sqf:replace match="b" select="node()"/>
      </sqf:fix>
      <sqf:fix id="removeBoldParent">
        <sqf:description>
          <sqf:title>Remove parent &lt;b&gt; and keep content</sqf:title>
        </sqf:description>
        <sqf:replace match="parent::b" select="node()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="check.scope.attr.external">
    <!-- Order is important here: Check for HPE websites before checking for general websites
         After test is matched, schematron stops executing other rules in the pattern -->
    <sch:rule context="*[contains(@scope, 'external')]" role='error'>
      <!-- HPE websites must use https and not http -->
      <!-- Not yet implemented: fix to replace "http:" with "https:"  -->
      <sch:report test="contains(@href, 'http://www.hpe')">HPE Websites must use https instead of http.</sch:report>
      <sch:report test="contains(@href, 'http:')">Websites in general should use https instead of http.</sch:report>
      <!-- brightcove.net URL is forbidden -->
      <sch:report test="matches(@href, '.*brightcove\.net[:/].*')">All brightcove.net URLs are forbidden. Always use the equivalent HPESC video display link.</sch:report>
    </sch:rule>

  </sch:pattern>
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

  <!-- Image checks BEGIN -->
  <!-- Flag uses of the @scale attribute in images  -->
  <sch:pattern id="check.image.scale">
    <sch:rule context="*[contains(@class, ' topic/image ')]" role="warn">
      <sch:assert test="not(@scale)">
        Dynamically scaled images are not properly displayed.
        Scale the image with an image tool and keep it within
        the recommended width and height limits.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Each image requires an alt element -->
  <sch:pattern id="check.image.alt">
    <sch:rule context="image" role="error">
      <sch:assert test="alt" sqf:fix="add.alt.to.image">This image requires an &lt;alt&gt; element.</sch:assert>
      <sqf:fix id="add.alt.to.image">
        <sqf:description>
          <sqf:title>Add an &lt;alt&gt; element to the image.</sqf:title>
        </sqf:description>
        <sqf:add target="alt" node-type="element" position="first-child"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- Check that the alt elment contains text  -->
  <sch:pattern id="check.alt.content">
    <sch:rule context="image/alt" role="error">
      <sch:assert test="normalize-space(.)">The &lt;alt&gt; element requires text. </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Image checks END -->

  <!-- Topic title checks BEGIN -->
  <sch:pattern id="check.topic.titles">
    <sch:rule context="*[contains(@class, ' topic/topic ')]/title" role="warn">
      <sch:assert test="not(child::b)">A topic title should not contain a &lt;b&gt;.</sch:assert>
      <sch:assert test="not(starts-with(., 'Understanding '))">Starting a topic title with "Understanding" pushes the important content toward the end of the title. Instead, use a plural noun or general noun phrase.</sch:assert>
      <sch:assert test="not(starts-with(., 'Where '))">Starting a topic title with "Where" pushes the important content toward the end of the title. Instead, use a plural noun or general noun phrase.</sch:assert>
<!--      <sch:assert test="not(starts-with(., 'About '))">Starting a title with "About" pushes the important content toward the end of the title. Instead, use a plural noun or general noun phrase.</sch:assert>-->
      <sch:assert test="not(ends-with(., '?'))">Do not use questions for topic titles.</sch:assert>
      <sch:assert test="not(matches(., '(^|.*\s)[!&quot;(),.:;&lt;&gt;\[\]{}]*information[!&quot;(),.:;&lt;&gt;\[\]{}]*($|\s.*)', 'i'))">"information" in a topic title is superfluous.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Topic title checks END -->

  <!-- Multiple substeps in a step BEGIN -->
  <!--
    Design from Ryffine 4_6_2017 HPESCH_10: Alert when more than one set of substeps is in a step.
    Rule: Allow no more than one <substeps> element per <step>.
    Alert: Do not use more than one <substeps> tag within a <step> tag.
    InfoModel: This rule comes from the section "Structure of the step element" in the KM Topic Writing Guide.
    -->
  <sch:pattern id="check.step.substeps"
    see="This rule comes from the section Structure of the step element in the KM Topic Writing Guide.">
    <!-- @see attribute can be added to pattern to link to HPE web documentation -->
    <sch:rule context="step | *[contains(@class, ' task/step ')]" role="warn">
      <sch:report test="count(child::substeps) > 1" role="warn">Each &lt;step&gt; can contain only one &lt;substeps&gt;.</sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- Multiple substeps in a step END -->
  <!-- Flag ol in substeps BEGIN -->
  <sch:pattern id="check.substep.for.ol">
    <sch:rule context="substep" role="warn">
      <sch:assert test="not(descendant::ol)">Do not use &lt;ol&gt; to create third level of nesting in a task.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Flag ol in substeps END -->

  <!-- <stepsection> should be like a title BEGIN -->
  <!-- <stepsection> should be like a title (no block elements, inline formatting only, no <b>) -->
  <sch:pattern id="check.stepsection">
    <sch:rule context="stepsection" role="error">
      <sch:assert test="not(child::b)">&lt;stepsection&gt; is treated like a title in output. Do not include block elements or &lt;b&gt;.</sch:assert>
      <sch:assert test="not(child::p or child::note or child::ul or child::ol or child::dl or child::sl or child::image or child::fig or child::object or child::table or child::codeblock or child::msgblock or child::screen )">&lt;stepsection&gt; is treated like a title in output. Do not include block elements.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- <stepsection> should be like a title END -->

  <!-- No conditions on inline elements BEGIN -->
  <!--
    Design from:  Ryffine3_17_2017 HPESCH_8 and HPESCH_82: Alert for conditions set on children inline elements of <p>
    Rule: Do not allow conditions to be set on inline elements
    Exceptions:
       <image>
       <object>
       <ph> if in topic <title> and no other text is present outside of <ph> elements
    Alert Message : Do not conditionalize inline elements. Conditionalizing inline elements hinders translation.  Conditionalize the containing block element instead.

    Need rule to apply to all inline elements (except image or object) within any block element.
        Check any element that has a child.  Inline elements have to be nested within a block to be allowed in DITA so looking for children will apply the code correctly.
        Revise this list whenever we remove constraints/add any new inline elements to the info model

        Should only alert on these inline elements:
        name() = 'abbreviated-form'
        name() = 'b'
        name() = 'cite'
        name() = 'codeph'
        name() = 'fn'
        name() = 'keyword'
        name() = 'menucascade'
        name() = 'uicontrol'
        name() = 'filepath'
        name() = 'wintitle'
        name() = 'msgnum'
        name() = 'msgph'
        name() = 'ph'
        name() = 'q'
        name() = 'required-cleanup'
        name() = 'sub'
        name() = 'sup'
        name() = 'tm'
        name() = 'userinput'
        name() = 'varname'
        name() = 'xref'
        -->
  <sch:pattern id="check.conditions.inline.elements">
    <sch:rule context="*/child::*[@ishcondition]" role="warn">
      <sch:report test="not((parent::title[parent::troubleshooting] or parent::title[parent::task] or parent::title[parent::concept] or parent::title[parent::reference]) and
        (preceding-sibling::ph[@ishcondition] or following-sibling::ph[@ishcondition]) and
        name() = 'ph' and
        parent::title[count(child::ph) = count(node())]) and (name() = 'abbreviated-form' or name() = 'b' or name() = 'cite' or name() = 'codeph' or name() = 'fn' or name() = 'keyword' or name() = 'menucascade' or name() = 'uicontrol' or name() = 'filepath' or name() = 'wintitle' or name() = 'msgnum' or name() = 'msgph' or name() = 'ph' or name() = 'q' or name() = 'required-cleanup' or name() = 'sub' or name() = 'sup' or name() = 'tm' or name() = 'userinput' or name() = 'varname' or name() = 'xref')"
        role="warning" >Do not conditionalize inline elements. Conditionalizing inline elements hinders translation.  Conditionalize the containing block element instead.</sch:report>
    </sch:rule>
  </sch:pattern>
<!-- No conditions on inline elements END -->

<!-- Flag absolute column widths BEGIN -->
  <!-- Rule:  Table colspec element should use colwidth attributes that are proportional.
       The characteristic of colwidth that makes it proportional that the value ends with the '*' character.
       Testing that colwidth contains an astrisk is sufficient. -->
  <sch:pattern id="check.proportional.colwidths"
    see="See Adding a table to a topic in the KM Content Development Process Guide.">
    <!-- @see attribute can be added to pattern to link to HPE web documentation -->
    <sch:rule context="colspec" role="warn">
      <sch:assert test="contains(@colwidth, '*')">Use proportional column widths, such as "2*", instead of absolute column widths.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Flag absolute column widths END -->

  <!-- Checks for numbers of words BEGIN -->
  <!-- Abstract pattern to use for word limit checks.  Instances of word checking patterns follow -->
  <sch:pattern id="LimitNoOfWords" abstract="true">
    <sch:rule context="$parentElement" role="warn"><sch:let name="words" value="count(tokenize(normalize-space(.), ' '))"/>
      <sch:assert test="$words lt $maxWords">$message You have <sch:value-of select="$words"></sch:value-of> word(s).</sch:assert>
      <sch:assert test="$words gt $minWords">$message You have <sch:value-of select="$words"></sch:value-of> word(s).</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- Check number of words in shortdesc (numbers are small for testing purposes. Set max to 50 for production) -->
 <!-- <sch:pattern is-a="LimitNoOfWords">
    <sch:param name="parentElement" value="shortdesc"/>
    <sch:param name="minWords" value="1"/>
    <sch:param name="maxWords" value="50"/>
    <sch:param name="message" value="Keep short descriptions between one and fifty words."/>
  </sch:pattern>-->
  <!-- Checks for numbers of words END -->

  <!-- Checks for topic elements END -->

  <!-- Checks for topic/map common attributes BEGIN -->

  <sch:pattern id="check.attr.keyref">
    <sch:rule context="*[@href]" role="warning">
      <sch:assert test="not(@keyref)">Using both href and keyref attributes may result in inconsistent processing. Use either href or keyref.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Checks for topic/map common attributes END -->

  <!-- Checks for map elements BEGIN -->

  <!-- Bookmeta checks BEGIN -->
  <sch:pattern id="check.bookchangehistory">
    <sch:rule context="bookmeta" role="error">
      <sch:report test="bookchangehistory">The use of &lt;bookchangehistory&gt; is deprecated. Use the revision history topic instead.</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="check.copyfirst.copylast">
    <sch:rule context="bookrights" role="warn">
      <sch:assert test="(copyrfirst and copyrlast) or (copyrlast and not(copyrfirst))" sqf:fix="replace.with.copyrlast">If you have only one copyright year, use the &lt;copyrlast&gt; element.</sch:assert>
    <sqf:fix id="replace.with.copyrlast">
      <sqf:description>
        <sqf:title>Change copyrfirst to copyrlast</sqf:title>
      </sqf:description>
      <sqf:replace match="copyrfirst" node-type="element" target="copyrlast" select="node()"/>
    </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- Check that <month> contains the month name and not a number, and that the name is spelled correctly -->
  <sch:pattern id="check.month.format">
    <sch:rule context="bookmeta/publisherinformation/published/completed/month" role="warn">
      <sch:assert test="(contains(text(),'January')) or (contains(text(),'February')) or (contains(text(),'March'))or (contains(text(),'April')) or (contains(text(),'May')) or (contains(text(),'June')) or (contains(text(),'July')) or (contains(text(),'August')) or (contains(text(),'September')) or (contains(text(),'October')) or (contains(text(),'November')) or (contains(text(),'December'))">The &lt;month&gt; element should contain the full name of the month.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Bookmeta checks END -->

  <!-- Check that if rev history topic exits, it is last topic in notification section -->
  <sch:pattern id="check.revhistory.topic">
    <sch:rule context="notices/topicref" role="error">
      <sch:report test="count(following-sibling::topicref)!=0 and topicmeta/navtitle[starts-with(text(),'Revision')]">If a revision history topic is included, it should be the last topic in the notices.</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Flag chunk="to-navigation" attribute value as deprecated -->
  <sch:pattern id="check.chunking.to.navigation">
    <sch:rule context="bookmap" role="error">
      <sch:assert test="not(@chunk='to-navigation' or chapter[@chunk='to-navigation'] or appendix[@chunk='to-navigation'] or topicref[@chunk='to-navigation'])">The "to-navigation" value of @chunk is deprecated.</sch:assert>
    </sch:rule>
    <sch:rule context="map" role="error">
      <sch:assert test="not(@chunk='to-navigation' or topicref[@chunk='to-navigation'])">The "to-navigation" value of @chunk is deprecated.</sch:assert>
    </sch:rule>
  </sch:pattern>
   
  <!-- Flag error if the extension of the file name set to the copy-to attribute is not ".xml" or ".dita". -->
  <sch:pattern id="check.copyto.extension">
    <sch:rule context="*/@copy-to" role="error">
      <sch:assert test="(substring(.,string-length(.) - 3,4)='.xml') or (substring(.,string-length(.) - 4,5)='.dita')">The extension of the file name set to the copy-to attribute must be .xml or .dita.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Checks for map elements END -->

<!--New rules from hpe.sch start-->

  <!--<sch:pattern id="check-lists">
    <sch:rule context="ul | ol">
      <sch:let name="filtered-elements" value="('fig', 'codeblock', 'screen', 'table', 'filepath', 'codeph', 'msgblock', 'msgph', 'uicontrol', 'wintitle', 'userinput')"/>
      <sch:let name="filtered-list">
        <!-\-Filter list item descendant nodes. Remove elements which could be ended with any character if these elements do not have following siblings-\->
        <xsl:for-each select="*">
          <li>
            <xsl:for-each select="node()">
              <xsl:choose>
                <xsl:when test="(name() = $filtered-elements)
                  and not(following-sibling::*)">
                  <!-\-do not copy these elements if they are the last element in the list item-\->
                </xsl:when>
                <xsl:otherwise>
                  <!-\-copy any node (text, element) except any in a list above-\->
                  <xsl:copy>
                    <!-\-do the same step for 2-nd level list item children-\->
                    <xsl:for-each select="node()">
                      <xsl:choose>
                        <xsl:when test="(name() = $filtered-elements)
                          and not(following-sibling::*)"/>
                        <xsl:otherwise>
                          <!-\-copy any node (text, element) except any in a list above-\->
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
      <!-\- Check if one or more list items in filtered list is a complete sentence, all list items should end with a period -\->
      <sch:report test="$filtered-list/*[ends-with(normalize-space(.), '.')]
        and $filtered-list/*[not(ends-with(normalize-space(.), '.'))]"
        role="warn">Avoid
        combining both fragments and sentences in a list. If you cannot avoid combining
        fragments and sentences, end all items in the list with a period.
      </sch:report>
    </sch:rule>

  </sch:pattern>-->

  <!-- Make sure authors use variables for the HPE company names where possible:

     Unless the "HPE" or "Hewlett Packard Enterprise" is in a <uicontrol> or <screen>:

     Make sure the phrases are surrounded by the following elements:

     <ph varref="company.short.name">HPE</ph>
     <ph varref="company.full.name">Hewlett Packard Enterprise</ph>

     If the elements are not in <uicontrol> or <screen> and aren't surrounded by those <ph> elements:

     1. Trigger a "fatal" error, displaying the text: "Where possible, use variables instead of plain text for the company name."

     2. Use Schematron Quick Fix to suggest replacing the text with <ph varref="company.short.name">HPE</ph>
        or <ph varref="company.full.name">Hewlett Packard Enterprise</ph>.

     If the elements are in <uicontrol> or <screen> and can't be surrounded by <ph> elements, trigger a "warn" error, displaying
     the text: "Where possible, use variables instead of plain text for the company name."

     Below is additional homework-->
  <!--Richard 9/17: Need IA to determine elements that DON'T allow ph.
            The schematron rule directly below specifies all elements that allow ph and gives them a quickfix
            outside of the elements specified in the context that DON'T allow it (may need to specify more)-->
  <sch:pattern id="check-company-short-name-variable">
    <sch:rule context="text()[not(ancestor::uicontrol)]
      [not(ancestor::apiname)]
      [not(ancestor::cmdname)]
      [not(ancestor::filepath)]
      [not(ancestor::kwd)]
      [not(ancestor::menucascade)]
      [not(ancestor::msgblock)]
      [not(ancestor::msgnum)]
      [not(ancestor::msgph)]
      [not(ancestor::option)]
      [not(ancestor::synblk)]
      [not(ancestor::synnoteref)]
      [not(ancestor::synph)]
      [not(ancestor::syntaxdiagram)]
      [not(ancestor::systemoutput)]
      [not(ancestor::userinput)]
      [not(ancestor::varname)]
      [not(ancestor::wintitle)]
      [not(ancestor::organization)]
      [not(ancestor::keyword)]
      [not(ancestor::bookpartno)]
      [not(ancestor::edition)]
      [not(ancestor::draft-comment)]
      [matches(normalize-space(.), 'HPE')]"
      role="warn">
      <sch:report sqf:fix="replace-company-short-name" test="not(ancestor::*[@varref or @varid])">Where possible, use variables instead of plain text for the company name.</sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="check-company-full-name-variable">
    <sch:rule context="text()[not(ancestor::uicontrol)]
      [not(ancestor::apiname)]
      [not(ancestor::cmdname)]
      [not(ancestor::filepath)]
      [not(ancestor::kwd)]
      [not(ancestor::menucascade)]
      [not(ancestor::msgblock)]
      [not(ancestor::msgnum)]
      [not(ancestor::msgph)]
      [not(ancestor::option)]
      [not(ancestor::synblk)]
      [not(ancestor::synnoteref)]
      [not(ancestor::synph)]
      [not(ancestor::syntaxdiagram)]
      [not(ancestor::systemoutput)]
      [not(ancestor::userinput)]
      [not(ancestor::varname)]
      [not(ancestor::wintitle)]
      [not(ancestor::organization)]
      [not(ancestor::keyword)]
      [not(ancestor::bookpartno)]
      [not(ancestor::draft-comment)]
      [not(ancestor::edition)][matches(normalize-space(.), 'Hewlett Packard Enterprise')]"
      role="warn">
      <sch:report sqf:fix="replace-company-full-name" test="not(ancestor::*[@varid or @varref])">Where possible, use variables instead of plain text for the company name.</sch:report>
    </sch:rule>
  </sch:pattern>

  <!--<sch:pattern id="check-company-short-name-variable-warn">
    <sch:rule context="text()[ancestor::uicontrol or ancestor::screen][matches(normalize-space(.), 'HPE')]"
      role="warn">
      <sch:report test="not(parent::*[@varref = 'company.short.name'])">Where possible, use variables instead of plain text for the company name.</sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="check-company-full-name-variable-warn">
    <sch:rule context="text()[ancestor::uicontrol or ancestor::screen][matches(normalize-space(.), 'Hewlett Packard Enterprise')]"
      role="warn">
      <sch:report test="not(parent::*[@varref = 'company.full.name'])">Where possible, use variables instead of plain text for the company name.</sch:report>
    </sch:rule>
  </sch:pattern>-->

  <sch:pattern id="check-section">
    <sch:rule context="reference//section[1]"
      role="warn">
      <sch:report sqf:fix="replace.section" test="ancestor::reference//section/title[contains(string-join(text(), ''), 'Syntax')]">In command descriptions, the first section must be &lt;refsyn&gt;.</sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="check-refsyn">
    <sch:rule context="reference//refsyn"
      role="warn">
      <sch:report sqf:fix="add-section-with-title" test="not(following-sibling::section[1]/title[contains(string-join(text(), ''), 'Description')])">Refsyn needs a &lt;section&gt; following it with a &lt;title&gt; that contains "Description".</sch:report>
    </sch:rule>
  </sch:pattern>


  <!--  HPE'S HOMEWORK... AKA RICHARD'S >:) Richard: :(
    If a <reference> contains a <section> that has <title> containing the word, "Syntax:"

    1. Flag as some kind of error; warn or error

    2. Change <section> to <refsyn>.

    If a reference topic contains <refsyn>:

    1. Check whether <refsyn> is followed by <section> with <title> containing the word, "Description."

    2. If not, create a SQF to insert a new <section> with <title> containing "Description."


    IA team still needs to determine whether these rules should trigger "info" or "warn."
    -->

  <xsl:template match="node()" mode="copy">
    <xsl:copy>
      <xsl:apply-templates mode="copy"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="copy">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*[not(name() = 'class')]" mode="copy"/>
      <xsl:apply-templates mode="copy"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*" mode="copy">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

<!--hpe.sch updates END-->


  <sqf:fixes>
    <sqf:fix id="add.alt.to.image">
      <sqf:description>
        <sqf:title>Add an alt tag to the image.</sqf:title>
      </sqf:description>
      <sqf:add target="alt" node-type="element" position="first-child"/>
    </sqf:fix>
    <sqf:fix id="remove.processing.role.attribute">
      <sqf:description>
        <sqf:title> Remove processing-role attribute.</sqf:title>
      </sqf:description>
      <sqf:delete match="@processing-role"/>
    </sqf:fix>
    <sqf:fix id="replace.with.checklist">
      <sqf:description>
        <sqf:title>Change the value of outputclass to 'checklist'.</sqf:title>
      </sqf:description>
      <sqf:replace match="@outputclass" target="outputclass" node-type="attribute" select="xs:string('checklist')"/>
    </sqf:fix>
    <sqf:fix id="remove.note">
      <sqf:description>
        <sqf:title>Remove subsequent note element.</sqf:title>
      </sqf:description>
      <sqf:delete/>
    </sqf:fix>
    <sqf:fix id="replace.text.with.checklist">
      <sqf:description>
        <sqf:title>Change the value of title to 'checklist'.</sqf:title>
      </sqf:description>
      <sqf:replace match="task/title" target="title" node-type="element" select="Checklist"/>
    </sqf:fix>
  </sqf:fixes>
  <!-- hpe.sch quickfixes START -->
  <sqf:fixes>
    <sqf:fix id="replace-company-short-name">
      <sqf:description>
        <sqf:title>Replace company short name with &lt;ph varref="company.short.name"&gt;HPE&lt;/ph&gt; variable.</sqf:title>
      </sqf:description>
      <sqf:stringReplace regex="HPE">
        <ph varref="company.short.name">HPE</ph>
      </sqf:stringReplace>
    </sqf:fix>
    <sqf:fix id="replace-company-short-name-cite">
      <sqf:description>
        <sqf:title>Replace company short name with &lt;cite varref="company.short.name"&gt;HPE&lt;/cite&gt; variable.</sqf:title>
      </sqf:description>
      <sqf:stringReplace regex="HPE">
        <cite varref="company.short.name">HPE</cite>
      </sqf:stringReplace>
    </sqf:fix>
    <sqf:fix id="replace-company-full-name">
      <sqf:description>
        <sqf:title>Replace company full name with &lt;ph varref="company.full.name"&gt;Hewlett Packard Enterprise&lt;/ph&gt; variable.</sqf:title>
      </sqf:description>
      <sqf:stringReplace regex="Hewlett Packard Enterprise">
        <ph varref="company.full.name">Hewlett Packard Enterprise</ph>
      </sqf:stringReplace>
    </sqf:fix>
    <sqf:fix id="replace-company-full-name-cite">
      <sqf:description>
        <sqf:title>Replace company full name with &lt;cite varref="company.full.name"&gt;Hewlett Packard Enterprise&lt;/cite&gt; variable.</sqf:title>
      </sqf:description>
      <sqf:stringReplace regex="Hewlett Packard Enterprise">
        <cite varref="company.full.name">Hewlett Packard Enterprise</cite>
      </sqf:stringReplace>
    </sqf:fix>

    <sqf:fix id="replace.section">
      <sqf:description>
        <sqf:title>Replace Section with refysn.</sqf:title>
      </sqf:description>

      <sqf:replace target="refsyn" node-type="element" select="./*">
      </sqf:replace>

      <!--The below XSL code revision doesn't get rid of the error for some reason
        <sqf:replace target="refsyn" node-type="element">
        <xsl:apply-templates select="@*[not(name() = 'class')]" mode="copy"/>
        <xsl:apply-templates mode="copy"/>
      </sqf:replace>-->
    </sqf:fix>

    <sqf:fix id="add-section-with-title">
      <sqf:description>
        <sqf:title>Add a &lt;section&gt; with &lt;title&gt; "Description".</sqf:title>
      </sqf:description>
      <sqf:add  target="section" node-type="element" position="after">
        <title>Description</title>
        <p></p>
      </sqf:add>
    </sqf:fix>

    <sqf:fix id="add-text-to-title">
      <sqf:description>
        <sqf:title>Add title "Description." to the first &lt;section&gt; following &lt;refsyn&gt;.</sqf:title>
      </sqf:description>
      <sqf:replace match="following-sibling::section[1]/title" target="title" node-type="element" select="xs:string('Description.')" >
      </sqf:replace>
    </sqf:fix>
  </sqf:fixes>
<!--hpe.sch quickfixes END-->




</sch:schema>
