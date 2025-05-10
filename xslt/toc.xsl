<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="partials/html_navbar.xsl"/>
    <xsl:import href="partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/tabulator_dl_buttons.xsl"/>
    <xsl:import href="partials/tabulator_js.xsl"/>


    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Crashed Airplanes'"/>
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
                        <h1 class="text-center pt-3">
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <div class="text-center p-1"><span id="counter1"></span> of <span id="counter2"></span> Airplanes</div>
                        <table id="myTable">
                            <thead>
                                <tr>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-formatter="html" tabulator-download="false" tabulator-minWidth="200">MACR-Nr</th>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-visible="false" tabulator-download="true">MACR-Nr_</th>
                                    <th scope="col" tabulator-headerFilter="input">Squadron</th>
                                    <th scope="col" tabulator-headerFilter="input">Crash date</th>
                                    <th scope="col" tabulator-headerFilter="input">Crash place</th>
                                    <th scope="col" tabulator-headerFilter="input" tabulator-visible="false" tabulator-download="true">ID</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each
                                    select="collection('../data/editions?select=*.xml')//tei:TEI">
                                    <xsl:variable name="full_path">
                                        <xsl:value-of select="data(@xml:id)"/>
                                    </xsl:variable>
                                    <xsl:variable name="link">
                                        <xsl:value-of
                                            select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"
                                        />
                                    </xsl:variable>
                                    <tr>
                                        <td>
                                            <a href="{$link}">
                                                <xsl:value-of select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='data'][1]/tei:idno/text()"/>
                                            </a>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='data'][1]/tei:idno/text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='data'][5]//text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='data'][6]//text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select=".//tei:table[@xml:id='bomber_table']//tei:cell[@role='data'][9]//text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="$link"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        <xsl:call-template name="tabulator_dl_buttons"/>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <xsl:call-template name="tabulator_js"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>