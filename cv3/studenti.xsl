<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">

    <html>
      <body>

        <h2>Krásní studenti</h2>

       <table>
        <tr>
          <th>Nádherní studenti</th>
        </tr>
        <xsl:for-each select="studenti/student">
          <tr>
            <td><xsl:value-of select="osobni_udaje/jmeno" /> <xsl:value-of select="osobni_udaje/prijmeni" /></td>
            <td><xsl:value-of select="fakulta" /></td>
          </tr>
        </xsl:for-each>
      </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>