<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
        <sch:rule context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')]
    [@href][contains(@href, '#')][not(@scope = 'external')] [not(@type) or @type='dita']">
            <!-- rule detects broken links in DITA <xref> or <link> elements, for links that contain an anchor -->
            <sch:let name="file" value="substring-before(@href, '#')"/>
            <sch:let name="idPart" value="substring-after(@href, '#')"/>
            <sch:let name="topicId"
        value="if (contains($idPart, '/')) then substring-before($idPart, '/') else $idPart"/>
            <sch:let name="id" value="substring-after($idPart, '/')"/>
    
            <sch:assert test="document($file, .)//*[@id=$topicId]">
        Invalid topic id "<value-of select="$topicId"/>" </sch:assert>
            <sch:assert test="$id ='' or document($file, .)//*[@id=$id]">
        No such id "<value-of select="$id"/>" is defined! </sch:assert>
            <sch:assert test="$id='' or document($file, .)//*[@id=$id]
        [ancestor::*[contains(@class, ' topic/topic ')][1][@id=$topicId]]"> 
        The id "<value-of select="$id"/>" is not in the scope of the referenced topic id 
        "<value-of select="$topicId"/>". </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>