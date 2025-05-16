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
        <xsl:variable name="doc_title" select="'Squadrons'" />
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
                        <h1 class="text-center">
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <div class="text-center p-1"><span id="counter1"></span> of <span id="counter2"></span> Squadrons</div>
                        
                        <table id="myTable">
                            <thead>
                                <tr>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-formatter="html" tabulator-download="false" tabulator-minWidth="200">Name</th>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-visible="false" tabulator-download="true">name_</th>
                                    <th scope="col" tabulator-headerFilter="input">Group</th>
                                    <th scope="col" tabulator-headerFilter="input">Airforce</th>
                                    <th scope="col" tabulator-headerFilter="input">related records count</th>
                                    <th scope="col" tabulator-visible="false" tabulator-download="true">ID</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select=".//tei:org[./tei:orgName[@type='airforce']]">
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
                                            <xsl:value-of select=".//tei:orgName[2]/text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:orgName[3]/text()"/>
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
                                <xsl:with-param name="pageId" select="'squadrons.html'"></xsl:with-param>
                            </xsl:call-template>
                        </div>
                    </div>
                    </main>
                    <xsl:call-template name="html_footer"/>
                    <xsl:call-template name="tabulator_js"/>
            </body>
        </html>
        <xsl:for-each select=".//tei:org[./tei:orgName[@type='airforce']]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="normalize-space(string-join(./tei:orgName[1]//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html class="h-100" lang="{$default_lang}">
                    <head>
                        <xsl:call-template name="html_head">
                            <xsl:with-param name="html_title" select="$name"></xsl:with-param>
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
                                    <li class="breadcrumb-item">
                                        <a href="squadrons.html"><xsl:value-of select="'Squadrons'"/></a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$name"/></li>
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
                                     
                                            <dt>Bomb group</dt>
                                            <dd>
                                                <xsl:value-of select="./tei:orgName[2]"/>
                                            </dd>
                                            
                                            <dt>Airforce</dt>
                                            <dd>
                                                <xsl:value-of select="./tei:orgName[3]"/>
                                            </dd>
                                        </dl>
                                    </div>
                                    
                                    <div class="col-md-6">
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
                                </div>
                                  
                                <div class="text-center p-4">
                                    <xsl:call-template name="blockquote">
                                        <xsl:with-param name="pageId" select="$filename"></xsl:with-param>
                                    </xsl:call-template>
                                </div>
                            </div>
                        </main>
                        <xsl:call-template name="html_footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>