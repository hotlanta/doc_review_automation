<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
        <sch:rule context="*['//body//p'] [not(' keyref ')]" role="warning">
        <!-- Enforce no extra spaces in paragraphs. -->
            <sch:report test="(string-length(.[text()]) > 0) and (normalize-space(.) != text())">
                Extra spaces detected.
            </sch:report>
            <xsl:variable name="descendantSpaces">
                <xsl:for-each select="descendant::text()">
                    <xsl:variable name="word" select="tokenize(current()[text()], '\s')"/>
                    <xsl:if test="normalize-space(.) != text()">
                        <xsl:value-of select="concat(current(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:report test="string-length($descendantSpaces) > 0">
                Extra spaces detected in one or more descendant text nodes.
            </sch:report>
        </sch:rule>
        <!-- Enforce no extra spaces in list items -->
        <sch:rule context="*['//li'] [not(' keyref ')]" role="warning">
            <sch:report test="(string-length(.[text()]) > 0) and (normalize-space(.) != text())">
                Extra spaces detected.
            </sch:report>
            <xsl:variable name="descendantSpaces">
                <xsl:for-each select="descendant::text()">
                    <xsl:variable name="word" select="tokenize(current()[text()], '\s')"/>
                    <xsl:if test="normalize-space(.) != text()">
                        <xsl:value-of select="concat(current(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:report test="string-length($descendantSpaces) > 0">
                Extra spaces detected in one or more descendant text nodes.
            </sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>