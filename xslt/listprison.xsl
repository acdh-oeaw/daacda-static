<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/> 
   
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/tabulator_dl_buttons.xsl"/>
    <xsl:import href="./partials/tabulator_js.xsl"/>
    <xsl:import href="./partials/blockquote.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Detention centers'" />
        <html class="h-100" lang="{$default_lang}">

            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>

                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="ps-5 p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html"><xsl:value-of select="$project_short_title"/></a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    <div class="container">                        
                        <h1>
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <div class="text-center p-1"><span id="counter1"></span> of <span id="counter2"></span> Detention centers</div>
                        
                        <table id="myTable">
                            <thead>
                                <tr>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-formatter="html" tabulator-download="false" tabulator-minWidth="200">Name</th>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-visible="false" tabulator-download="true">name_</th>
                                    <th scope="col" tabulator-headerFilter="input">located at</th>
                                    <th scope="col" tabulator-headerFilter="input">type</th>
                                    <th scope="col" tabulator-headerFilter="input">related records count</th>
                                    <th scope="col" tabulator-visible="false" tabulator-download="true">ID</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select=".//tei:org[./tei:location]">
                                    <xsl:variable name="id">
                                        <xsl:value-of select="data(@xml:id)"/>
                                    </xsl:variable>
                                    <xsl:variable name="link">
                                        <xsl:value-of select="concat($id, '.html')"/>
                                    </xsl:variable>
                                    <tr>
                                        <td>
                                            <a>
                                              <xsl:attribute name="href">
                                              <xsl:value-of select="concat($id, '.html')"/>
                                              </xsl:attribute>
                                                <xsl:value-of select=".//tei:orgName[1]/text()"/>
                                            </a>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:orgName[1]/text()"/>
                                        </td>
                                        
                                        <td>
                                            <xsl:value-of select=".//tei:placeName[1]/text()"/>
                                        </td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="./tei:note[@type='station-type']">
                                                    <xsl:value-of select="./tei:note[@type='station-type']"/>
                                                </xsl:when>
                                                <xsl:otherwise>other</xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                        <td>
                                            <xsl:value-of select="count(.//tei:note[@type='mentions'])"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="$link"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        <xsl:call-template name="tabulator_dl_buttons"/>
                        <div class="text-center p-4">
                            <xsl:call-template name="blockquote">
                                <xsl:with-param name="pageId" select="'listprison.html'"></xsl:with-param>
                            </xsl:call-template>
                        </div>
                    </div>
                    </main>
                    <xsl:call-template name="html_footer"/>
                    <xsl:call-template name="tabulator_js"/>
            </body>
        </html>
        <xsl:for-each select=".//tei:org[./tei:location]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="normalize-space(string-join(./tei:orgName[1]//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html class="h-100" lang="{$default_lang}">
                    <head>
                        <xsl:call-template name="html_head">
                            <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                        </xsl:call-template>
                        <link rel="stylesheet" href="vendor/leaflet/leaflet.css"/>
                        <link rel="stylesheet" href="vendor/leaflet.markercluster/MarkerCluster.css"/>
                        <link rel="stylesheet" href="vendor/leaflet.markercluster/MarkerCluster.Default.css"/>
                        <script src="vendor/leaflet/leaflet.js"></script>
                        <script src="vendor/leaflet.markercluster/leaflet.markercluster.js"></script>
                    </head>
                    <body class="d-flex flex-column h-100">
                        <xsl:call-template name="nav_bar"/>
                        <main class="flex-shrink-0 flex-grow-1">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="ps-5 p-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="index.html"><xsl:value-of select="$project_short_title"/></a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="listprison.html"><xsl:value-of select="'Detention Centers'"/></a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                                </ol>
                            </nav>
                            <div class="container">
                                <h1 class="text-center p-3">
                                    <xsl:value-of select="$name"/>
                                </h1>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h2 class="text-center p-2">Info</h2>
                                        <dl>
                                            <dt>Name</dt>
                                            <dd><xsl:value-of select="$name"/></dd>
                                     
                                            <dt>Type</dt>
                                            <dd>
                                                <xsl:choose>
                                                    <xsl:when test="./tei:note[@type='station-type']">
                                                        <xsl:value-of select="./tei:note[@type='station-type']"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>other</xsl:otherwise>
                                                </xsl:choose>
                                            </dd>
                                            
                                            <dt>Location</dt>
                                            <dd>
                                                <xsl:variable name="rsid" select=".//tei:placeName[1]/@key"/>
                                                <xsl:variable name="name" select=".//tei:placeName[1]"/>
                                                <xsl:variable name="lat" select="tokenize(.//tei:geo[1], ' ')[1]"/>
                                                <xsl:variable name="lng" select="tokenize(.//tei:geo[1], ' ')[2]"/>
                                                <a href="{$rsid||'.html'}" class="dse-place" data-rsid="{$rsid}" data-name="{$name}" data-lat="{$lat}" data-lng="{$lng}">
                                                    <xsl:value-of select=".//tei:placeName"/>
                                                </a>
                                            </dd>
                                        </dl>
                                        <h2 class="text-center p-2">related crews</h2>
                                        <ul class="multi-column list-unstyled">
                                            <xsl:for-each select=".//tei:note[@type='mentions']">
                                                <xsl:sort select="./text()"></xsl:sort>
                                                <li>
                                                    <a href="{replace(./@target, '.xml', '.html')}">
                                                        <xsl:value-of select="."/>
                                                    </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <h2 class="text-center p-2">Map</h2>
                                        <xsl:if test=".//tei:geo">
                                            <div id="airplaneMap"></div>
                                        </xsl:if>
                                    </div>
                                </div>
                                  
                                <div class="text-center p-4">
                                    <xsl:call-template name="blockquote">
                                        <xsl:with-param name="pageId" select="$filename"></xsl:with-param>
                                    </xsl:call-template>
                                </div>
                            </div>
                        </main>
                        <xsl:call-template name="html_footer"/>
                        <script src="js/detail_view_map.js"></script>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>