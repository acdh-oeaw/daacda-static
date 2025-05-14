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
                    
                    <xsl:if test="./tei:birth/tei:date[@when-iso]">
                        <dt>Date of birth</dt>
                        <dd><xsl:value-of select="./tei:birth/tei:date/@when-iso"/></dd>
                    </xsl:if>
                    <xsl:if test="./tei:birth/tei:placeName">
                        <dt>Place of birth</dt>
                        <dd>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat(./tei:birth/tei:placeName/@key, '.html')"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="./tei:birth//tei:geo">
                                        <xsl:variable name="rsid" select="./tei:birth/tei:placeName[1]/@key"/>
                                        <xsl:variable name="name" select="./tei:birth/tei:placeName[1]"/>
                                        <xsl:variable name="lat" select="tokenize(./tei:birth//tei:geo[1], ' ')[1]"/>
                                        <xsl:variable name="lng" select="tokenize(./tei:birth//tei:geo[1], ' ')[2]"/>
                                        <span class="dse-place" data-rsid="{$rsid}" data-name="{$name}" data-lat="{$lat}" data-lng="{$lng}">
                                            <xsl:value-of select="./tei:birth/tei:placeName"/>
                                        </span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="./tei:birth/tei:placeName"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                
                            </a>
                        </dd>
                    </xsl:if>
                    
                    <xsl:if test="./tei:death/tei:date[@when-iso]">
                        <dt>Date of death</dt>
                        <dd><xsl:value-of select="./tei:death/tei:date/@when-iso"/></dd>
                    </xsl:if>
                    <xsl:if test="./tei:death/tei:placeName">
                        <dt>Place of death</dt>
                        <dd>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat(./tei:death/tei:placeName/@key, '.html')"/>
                                </xsl:attribute>
                                <xsl:value-of select="./tei:death/tei:placeName"/>
                            </a>
                        </dd>
                    </xsl:if>
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
                <h2 class="text-center p-2">Map</h2>
                <xsl:if test=".//tei:geo">
                    <div id="airplaneMap"></div>
                </xsl:if>
                <h2 class="text-center p-2">detained in</h2>
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