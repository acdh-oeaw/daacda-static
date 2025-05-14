<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:person" name="person_detail">
        <xsl:variable name="marc-link">
            <xsl:value-of select="replace(.//tei:note[@type='mentions'][1]/@target, '.xml', '.html')"/>
        </xsl:variable>
        <div class="row">
            <div class="col-md-6">
                <h2 class="text-center p-2">Info</h2>
                <dl>
                    <dt>Last name</dt>
                    <dd><xsl:value-of select=".//tei:surname[1]"/></dd>
                    
                    <dt>First name</dt>
                    <dd><xsl:value-of select="string-join(.//tei:forename, ' ')"/></dd>
                    
                    <dt>Squadron</dt>
                    <dd><xsl:value-of select=".//tei:affiliation[@type='bomb-group']"/></dd>
                    
                    <dt>Airforce</dt>
                    <dd><xsl:value-of select=".//tei:affiliation[@type='airforce']"/></dd>
                    
                    <dt>Position</dt>
                    <dd><xsl:value-of select=".//tei:occupation[1]"/></dd>
                    
                    <dt>Rank</dt>
                    <dd><xsl:value-of select=".//tei:occupation[1]/@role"/></dd>
                    
                    <dt>ID number</dt>
                    <dd><xsl:value-of select=".//tei:idno[@type='dog-tag']"/></dd>
                    
                    <dt>MARC-ID</dt>
                    <dd>
                        <a href="{$marc-link}">
                            <xsl:value-of select=".//tei:idno[@type='marc-id']"/>
                        </a>
                    </dd>
                    
                </dl>
            </div>
            <div class="col-md-6">
                <h2 class="text-center p-2">detained in</h2>
                <xsl:if test=".//tei:residence//tei:geo">
                    <div id="airplaneMap"></div>
                </xsl:if>
                <ul>
                    <xsl:for-each select=".//tei:residence">
                        <li>
                            <xsl:value-of select="./tei:orgName"/>
                            <xsl:if test=".//tei:location/tei:geo">
                                <xsl:variable name="rsid" select=".//tei:placeName[1]/@key"/>
                                <xsl:variable name="name" select=".//tei:placeName[1]"/>
                                <xsl:variable name="lat" select="tokenize(.//tei:geo[1], ' ')[1]"/>
                                <xsl:variable name="lng" select="tokenize(.//tei:geo[1], ' ')[2]"/>
                                <span class="dse-place" data-rsid="{$rsid}" data-name="{$name}" data-lat="{$lat}" data-lng="{$lng}">
                                    <xsl:value-of select="concat(' (', .//tei:placeName, ')')"/>
                                </span>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
                
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>