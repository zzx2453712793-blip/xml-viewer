<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="badges">
    <html>
      <head>
        <title>Activity Badges</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.5; }
          .badge-item { margin: 15px 0; padding: 10px; border: 1px solid #eee; border-radius: 4px; }
          .unavailable { color: #d9534f; font-weight: 500; }
          .available { color: #5cb85c; }
          .level-label { font-weight: 600; }
        </style>
      </head>
      <body>
        <h1>Activity Badges</h1>
        <xsl:apply-templates select="badge[@type='activity']">
          <xsl:sort order="ascending" select="name"/>
        </xsl:apply-templates>
        <p><i>&#xA9; College Productions Ltd</i></p>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="badge">
    <div class="badge-item">
      <h2><xsl:value-of select="name"/></h2>
      <p><xsl:value-of select="description"/></p>
      <xsl:apply-templates select="levels/availability"/>
    </div>
  </xsl:template>

  <xsl:template match="availability">
    <p>
      <span class="level-label">
        <xsl:choose>
          <xsl:when test="@level = 'beaver'">Beaver: </xsl:when>
          <xsl:when test="@level = 'scout'">Scout: </xsl:when>
          <xsl:otherwise>Cub: </xsl:otherwise>
        </xsl:choose>
      </span>
      <xsl:choose>
        <xsl:when test=". = 'Not Available'">
          <span class="unavailable"><xsl:value-of select="."/></span>
        </xsl:when>
        <xsl:otherwise>
          <span class="available"><xsl:value-of select="."/></span>
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>
</xsl:stylesheet>