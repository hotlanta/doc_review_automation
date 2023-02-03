<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
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
</sch:schema>