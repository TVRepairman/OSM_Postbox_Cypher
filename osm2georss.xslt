<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:template match="/osm">
<?xml-stylesheet href="http://yelp.com/css/atom.css" type="text/css" media="screen"?>
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"> 
	<rights></rights> 
	<title>Post Boxes with EVIIIR Royal Cyphers</title>
	<link href="http://www.technomancy.org/osm-hackerspaces/" />
	<updated>
        <xsl:for-each select="./node">
            <xsl:sort select="@timestamp" data-type="text" order="descending" />
            <xsl:if test="position() = 1">
                <xsl:value-of select="@timestamp" />
            </xsl:if>
        </xsl:for-each>
    </updated>
	<author>
		<name>OpenStreetMap contributors</name>
	</author>

    
    <xsl:for-each select="./node">
        <entry>
            <title><xsl:value-of select="./tag[@k='name']/@v" /></title>
            <xsl:choose>
                <xsl:when test="not(./tag[@k='website']/@v)">
                    <link rel="alternate" type="text/html" href="" />
                    <id></id>
                </xsl:when>
                <xsl:when test="substring(./tag[@k='website']/@v, 0, 5) = 'http'">
                    <xsl:variable name="website" select="./tag[@k='website']/@v" />
                    <link rel="alternate" type="text/html" href="{$website}" />
                    <id><xsl:value-of select="$website" /></id>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="website">http://<xsl:value-of select="./tag[@k='website']/@v" /></xsl:variable>
                    <link rel="alternate" type="text/html" href="{$website}" />
                    <id><xsl:value-of select="$website" /></id>
                </xsl:otherwise>
            </xsl:choose>
            <updated><xsl:value-of select="./@timestamp" /></updated>

            <summary type="html"><xsl:value-of select="./tag[@k='addr:full']/@v" /><xsl:text> </xsl:text><xsl:value-of select="./tag[@k='note']/@v" /></summary>
            <geo:long><xsl:value-of select="./@lon" /></geo:long>	
            <geo:lat><xsl:value-of select="./@lat" /></geo:lat>
        </entry>
    </xsl:for-each>

</feed>
</xsl:template>

</xsl:stylesheet>
