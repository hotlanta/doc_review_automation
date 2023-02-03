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
</sch:schema>