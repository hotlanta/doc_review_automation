<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://purl.oclc.org/dsdl/schematron">
<sch:pattern id="check-lists">
    <sch:rule context="ul | ol">
      <sch:let name="filtered-elements" value="('fig', 'codeblock', 'screen', 'table', 'filepath', 'codeph', 'msgblock', 'msgph', 'uicontrol', 'wintitle', 'userinput')"/>
      <sch:let name="filtered-list">
        <!--\-Filter list item descendant nodes. Remove elements which could be ended with any character if these elements do not have following siblings-\-->
        <xsl:for-each select="*">
          <li>
            <xsl:for-each select="node()">
              <xsl:choose>
                <xsl:when test="(name() = $filtered-elements)
                  and not(following-sibling::*)">
                  <!--\-do not copy these elements if they are the last element in the list item-\-->
                </xsl:when>
                <xsl:otherwise>
                  <!--\-copy any node (text, element) except any in a list above-\-->
                  <xsl:copy>
                    <!--\-do the same step for 2-nd level list item children-\-->
                    <xsl:for-each select="node()">
                      <xsl:choose>
                        <xsl:when test="(name() = $filtered-elements)
                          and not(following-sibling::*)"/>
                        <xsl:otherwise>
                          <!--\-copy any node (text, element) except any in a list above-\-->
                          <xsl:copy-of select="."/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                  </xsl:copy>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </li>
        </xsl:for-each>
      </sch:let>
      <!--\- Check if one or more list items in filtered list is a complete sentence, all list items should end with a period -\-->
      <sch:report test="$filtered-list/*[ends-with(normalize-space(.), '.')]
        and $filtered-list/*[not(ends-with(normalize-space(.), '.'))]"
        role="warn">Avoid combining both fragments and sentences in a list. If you cannot avoid combining
        fragments and sentences, end all items in the list with a period.
      </sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>