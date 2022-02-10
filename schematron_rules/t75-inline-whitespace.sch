<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>
        <!-- Detect leading and trailing whitespace inside inline elements.-->
        <sch:rule context="//codeph" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
        <sch:rule context="//uicontrol" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
        <sch:rule context="//keyword" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
        <sch:rule context="//b" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
        <sch:rule context="//u" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
        <sch:rule context="//i" role="warning">
            <xsl:variable name="words">
                <xsl:if test="string-length(.[text()]) > 1">
                    <xsl:for-each select="tokenize(text(), '\s')">
                        <xsl:if test="((current()[1] = ' ') or (current()[last()] = ' '))">
                            <xsl:value-of select="concat(current(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>
            <sch:report test="string-length($words) > 0">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
            <sch:report test="(not(string-length($words) > 0)) and (normalize-space(.) != text())">
                Do not put spaces as the first or last characters of <sch:value-of select="name(.)"/> elements.
            </sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>