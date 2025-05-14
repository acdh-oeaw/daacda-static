<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100" lang="{$default_lang}">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <link rel="stylesheet" href="vendor/leaflet/leaflet.css"/>
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
                                <a href="toc.html"><xsl:value-of select="'Crashed Airplanes'"/></a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-left" title="Back to previous entry" visually-hidden="true">
                                            <span class="visually-hidden">Back to previous entry</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1>
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2" title="Download TEI/XML Document" visually-hidden="true">
                                            <span class="visually-hidden">Download TEI/XML Document</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($next, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-right" title="Next document" visually-hidden="true">
                                            <span class="visually-hidden">Next document</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <h2 class="text-center p-2">About the Airplane</h2>
                                <dl>
                                    <xsl:for-each select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='label']">
                                        <xsl:variable name="curNr" select="position()"/>
                                        <dt>
                                            <xsl:value-of select=".//tei:expan"/>
                                        </dt>
                                        <dd>
                                            <xsl:apply-templates select=".//ancestor::tei:table//tei:cell[@role='data'][$curNr]"/>
                                        </dd>
                                    </xsl:for-each>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <h2 class="text-center p-2">Map of related places</h2>
                                <div id="airplaneMap"></div>
                            </div>
                        </div>
                        <div>
                            <h2 class="text-center p-2">The Crew</h2>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Rank</th>
                                        <th scope="col">Function</th>
                                        <th scope="col">Destiny</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select=".//tei:table[@xml:id='crew_table']/tei:row[@role='data']">
                                        <xsl:sort select=".//tei:surname[1]"></xsl:sort>
                                        <tr>
                                            <td>
                                                <a>
                                                    <xsl:attribute name="href"><xsl:value-of select="concat('person__', ./tei:cell[1], '.html')"/></xsl:attribute>
                                                    <xsl:value-of select=".//tei:surname"/>, <xsl:value-of select="string-join(.//tei:forename, ' ')"/>
                                                </a>
                                            </td>
                                            <td>
                                                <xsl:value-of select="./tei:cell[7]"/>
                                            </td>
                                            <td>
                                                <xsl:value-of select="./tei:cell[6]"/>
                                            </td>
                                            <td>
                                                <xsl:value-of select="./tei:cell[8]"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <script src="vendor/leaflet/leaflet.js"></script>
                <script src="js/detail_view_map.js"></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
