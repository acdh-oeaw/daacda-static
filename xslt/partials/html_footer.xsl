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
                                <a href="https://www.oeaw.ac.at/acdh/acdh-home">ACDH</a>
                                <br />
                                    Austrian Centre for Digital Humanities
                                    <br />
                                        Austrian Academy of Sciences
                            </p>
                            <p>
                                Bäckerstraße 13
                                <br />
                                    1010 Wien
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-3">
                        <div class="row">
                            <div>
                                <span class="fs-4">Questions and Feedback:</span>
                                
                                    <p class="fs-5">
                                        <a href="mailto:daacda@gmx.at">daacda@gmx.at</a>
                                    </p>
                            </div>
                        </div>
                    </div>
                    <!-- .-->
                </div>
                <div class="text-center fs-6 fw-lighter">© Copyright OEAW | <a href="imprint.html">Imprint</a><br/>
                    <a id="github-logo" href="{$github_url}">
                                        <i class="bi bi-github fs-1" visually-hidden="true"><span class="visually-hidden">Link to application's code repo</span></i>
                                    </a>
                </div>
            </div>
        </footer>
        <script src="vendor/jquery/jquery-3.7.1.min.js"></script>
        <script src="vendor/bootstrap-5.3.5-dist/js/bootstrap.bundle.min.js"></script>
        
    </xsl:template>
</xsl:stylesheet>