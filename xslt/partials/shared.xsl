<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"

    exclude-result-prefixes="xs"
    version="2.0">
    
   <xsl:template match="tei:rs[@type='place']">
       <xsl:variable name="rstype" select="@type"/>
       <xsl:variable name="rsid" select="replace(@ref, '#', '')"/>
       <xsl:variable name="ent" select="root()//tei:back//*[@xml:id=$rsid]"/>
       <xsl:variable name="name" select="$ent//tei:placeName[1]/text()"/>
       <span class="dse-place" data-rsid="{$rsid}" data-name="{$name}">
           <xsl:choose>
               <xsl:when test="$ent//tei:location">
                   <xsl:attribute name="data-lat">
                       <xsl:value-of select="tokenize($ent//tei:geo, ' ')[1]"/>
                   </xsl:attribute>
                   <xsl:attribute name="data-lng">
                       <xsl:value-of select="tokenize($ent//tei:geo, ' ')[2]"/>
                   </xsl:attribute>
               </xsl:when>
           </xsl:choose>
           <xsl:apply-templates/>
       </span>
   </xsl:template>
    
</xsl:stylesheet>
