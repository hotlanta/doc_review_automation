<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
 xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://purl.oclc.org/dsdl/schematron">
 <sch:pattern>
<!-- Avoid using the @scalefit attribute on images. -->
  <sch:rule context="*[contains(@class, ' topic/image ')]">
   <sch:assert test="not(@scalefit)">
    Dynamically scaled images are not properly displayed in PDF. Use the width attribute instead (and height attribute if needed).
   </sch:assert>
  </sch:rule>
 </sch:pattern>
</sch:schema>