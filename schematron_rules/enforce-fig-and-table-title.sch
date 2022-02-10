<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">
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
</sch:schema>