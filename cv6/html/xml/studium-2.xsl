<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Seznam předmětů s různými barvami pozadí</title>
        <style>
          .KI { background-color: lightblue; }
          .KF { background-color: lightgreen; }
        </style>
      </head>
      <body>
        <h1>Seznam předmětů s různými barvami pozadí</h1>
        <ul>
          <xsl:for-each select="//predmet">
            <li class="{@katedra}">
              <xsl:value-of select="@katedra"/> - <xsl:value-of select="nazev"/>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
