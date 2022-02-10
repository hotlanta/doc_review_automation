<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">
   <sch:pattern>
   <!-- Flag lists that have only one item. -->
      <sch:rule context="ol">
         <sch:assert test="count(./li) > 1">
            If you only have one list item, you don't need a list.
         </sch:assert>
      </sch:rule>
      <sch:rule context="ul">
         <sch:assert test="count(./li) > 1">
            If you only have one list item, you don't need a list.
         </sch:assert>
      </sch:rule>
   </sch:pattern>
</sch:schema>