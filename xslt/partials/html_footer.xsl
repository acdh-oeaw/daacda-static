<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        <footer class="footer mt-auto py-4 bg-body-tertiary">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6 text-center">
                        <div>
                            <a href="https://www.oeaw.ac.at/acdh/"><img src="images/acdh_logo.svg" class="image" alt="ACDH-CH Logo" style="max-width: 100%; height: auto;" title="ACDH-CH Logo" /></a>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-3 col-sm-3">
                        <div>
                            <p>
                                ACDH-CH
                                <br />
                                    Austrian Centre for Digital Humanities and Cultural Heritage
                                    <br />
                                        Österreichische Akademie der Wissenschaften
                            </p>
                            <p>
                                Bäckerstraße 13
                                <br />
                                    1010 Wien
                            </p>
                            <p>
                                T: +43 1 51581-2200
                                <br />
                                    E: <a href="mailto:acdh-ch-helpdesk@oeaw.ac.at
                                        ">acdh-ch-helpdesk@oeaw.ac.at</a>
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-3">
                        <div class="row">
                            <div>
                                <span class="fs-6">HELPDESK</span>
                                <br />
                                    <p>
                                        ACDH-CH operates a helpdesk offering advice and assistance on a wide range of digital humanities issues.
                                    </p>
                                    <p>
                                        <a href="mailto:acdh-ch-helpdesk@oeaw.ac.at">e-Mail</a>
                                    </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-3">
                                <div class="col-md-4">
                                    <a id="github-logo" title="GitHub" href="{$github_url}" class="nav-link">
                                        
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- .-->
                </div>
                <div class="text-center fs-6 fw-lighter">© Copyright OEAW | <a href="imprint.html">Imprint</a>
                </div>
            </div>
        </footer>
        <script src="vendor/jquery/jquery-3.7.1.min.js"></script>
        <script src="vendor/bootstrap-5.3.5-dist/js/bootstrap.bundle.min.js"></script>
        
    </xsl:template>
</xsl:stylesheet>