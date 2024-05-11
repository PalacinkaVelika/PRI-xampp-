<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="studium">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <title>Program studia</title>
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
        <uni-studium>
          <h1>Program studia</h1>
          <xsl:apply-templates select="rocnik"/>
        </uni-studium>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="rocnik">
    <uni-rocnik>
      <h2>Rocník <xsl:value-of select="@cislo"/></h2>
      <xsl:apply-templates select="semestr"/>
    </uni-rocnik>
  </xsl:template>

  <xsl:template match="semestr">
    <uni-semestr>
      <h3>Semestr: <xsl:value-of select="@nazev"/></h3>
      <table>
        <thead>
          <tr>
            <th>Kód předmětu</th>
            <th>Název předmětu</th>
            <th>Vyučující</th>
            <th>Kredity</th>
            <th>Status</th>
            <th>Zakončení</th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="predmet"/>
        </tbody>
      </table>
    </uni-semestr>
  </xsl:template>

  <xsl:template match="predmet">
    <tr>
      <td><xsl:value-of select="@kod"/></td>
      <td><xsl:value-of select="nazev"/></td>
      <td><xsl:value-of select="vyucujici/jméno"/></td>
      <td><xsl:value-of select="kredity"/></td>
      <td><xsl:value-of select="status"/></td>
      <td><xsl:value-of select="zakonceni"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
