<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
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
</sch:schema>