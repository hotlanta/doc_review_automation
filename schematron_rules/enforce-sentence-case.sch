<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
    <!-- titles should start with an uppercase letter, and should have sentence case -->
        <sch:rule context="*['title'] [not(' keyref ')]" role="warning">
            <sch:let name="first-letter"
                value="substring(.,1,1)"/>
            <sch:assert test="$first-letter = upper-case($first-letter)">
                Please start headings with an uppercase character.
            </sch:assert>
            <xsl:variable name="offendingWords">
                <xsl:for-each select="tokenize(text(), '\s')">
                    <xsl:if test="position() != 1 and (substring(current(), 1, 1) = upper-case(substring(current(), 1, 1)))">
                        <xsl:value-of select="concat(current(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:report test="string-length($offendingWords) > 0">
                The words <sch:value-of select="$offendingWords"/> should be lower-case.
            </sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>