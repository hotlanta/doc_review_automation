<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
    <!--require a shortdesc element -->
        <sch:rule context="shortdesc" role="warning">
            <sch:assert test="(string-length(.[text()]) > 0)"> Please add a shortdesc element. </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>