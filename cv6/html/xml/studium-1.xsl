<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Seznam předmětů</title>
      </head>
      <body>
        <h1>Seznam všech předmětů</h1>
        <ul>
          <xsl:for-each select="//predmet">
            <li><xsl:value-of select="@katedra"/> - <xsl:value-of select="nazev"/></li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>