<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
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
</sch:schema>