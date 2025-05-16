<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
   
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/typesense_libs.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Search for persons'"/>
        <html class="h-100" lang="de">
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
                                <a href="index.html">
                                    <xsl:value-of select="$project_short_title"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Search</li>
                        </ol>
                    </nav>
                    <div class="container">
                        <h1 class="text-center">
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <div class="text-center p-3">
                            <div id="searchbox"/>
                            <div id="stats-container"/>
                            <div id="current-refinements"/>
                            <div id="clear-refinements"/>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3">
                                <h2 class="visually-hidden">Facets</h2>
                                <div id="r-forename" class="pb-3"></div>
                                <div id="r-marc" class="pb-3"></div>
                                <div id="r-marc_destiny" class="pb-3"></div>
                                <div id="r-rank" class="pb-3"></div>
                                <div id="r-role" class="pb-3"></div>
                                <div id="r-squadron" class="pb-3"></div>
                                <div id="r-bomb_group" class="pb-3"></div>
                                <div id="r-airforce" class="pb-3"></div>
                                <div id="r-prisons" class="pb-3"></div>
                                <div id="r-place_of_birth" class="pb-3"></div>
                                <div id="r-place_of_death" class="pb-3"></div>
                            </div>
                            <div class="col-md-9">
                                <div id="pagination" class="p-3"/>
                                <div id="hits"/>
                            </div>
                        </div>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <xsl:call-template name="typesense_libs"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>