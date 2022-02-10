<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
    <!-- titles should start with an uppercase letter, and should have sentence case -->
        <sch:rule context="*[contains(@class, ' map/topicref ')]" role="warning">
            <sch:let name="href" value="@href"/>
            <sch:report
                test="preceding::element()[contains(@class, ' map/topicref ')][@href = $href]">
                Duplicate topicref "<sch:value-of select="$href"/>" detected in map.
            </sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>