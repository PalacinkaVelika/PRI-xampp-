<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Tabulka předmětů v prvním roce studia, v zimním semestru</title>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
          }
          th {
            background-color: #f2f2f2;
          }
        </style>
      </head>
      <body>
        <h1>Tabulka předmětů v prvním roce studia, v zimním semestru</h1>
        <table>
          <thead>
            <tr>
              <th>Kód předmětu</th>
              <th>Počet kreditů</th>
              <th>Vyučující</th>
              <th>Status</th>
              <th>Zakončení</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="//rocnik[@cislo='1']/semestr[@nazev='zimni']/predmet">
              <tr>
                <td><xsl:value-of select="@kod"/></td>
                <td><xsl:value-of select="kredity"/></td>
                <td><xsl:value-of select="vyucujici"/></td>
                <td><xsl:value-of select="status"/></td>
                <td><xsl:value-of select="zakonceni"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
