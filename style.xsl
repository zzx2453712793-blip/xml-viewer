<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- 输出HTML并指定编码，增加缩进提升可读性 -->
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <!-- 定义可复用的样式变量，统一管理样式 -->
  <xsl:variable name="mainColor" select="'#2c3e50'"/>
  <xsl:variable name="bgColor" select="'#f8f9fa'"/>
  <xsl:variable name="borderColor" select="'#dee2e6'"/>

  <!-- 匹配根节点badges，重构页面整体结构 -->
  <xsl:template match="badges">
    <html>
      <head>
        <title>Scout Activity Badges</title>
        <!-- 内嵌CSS样式，美化页面 -->
        <style>
          body { font-family: Arial, sans-serif; max-width: 1000px; margin: 0 auto; padding: 20px; color: {$mainColor}; }
          .badge-card { background: {$bgColor}; border: 1px solid {$borderColor}; border-radius: 8px; padding: 20px; margin: 15px 0; }
          .badge-title { color: #e74c3c; margin-top: 0; }
          .availability-item { margin: 5px 0; padding-left: 10px; border-left: 3px solid #3498db; }
          .copyright { margin-top: 30px; color: #7f8c8d; font-style: italic; text-align: center; }
        </style>
      </head>
      <body>
        <h1>🏕️ Scout Activity Badges</h1>
        <!-- 筛选activity类型徽章并按名称升序排序 -->
        <xsl:apply-templates select="badge[@type='activity']">
          <xsl:sort order="ascending" select="name" case-order="upper-first"/>
        </xsl:apply-templates>
        <!-- 调整版权信息样式和位置 -->
        <p class="copyright">© College Productions Ltd</p>
      </body>
    </html>
  </xsl:template>

  <!-- 重构badge模板，使用卡片式布局 -->
  <xsl:template match="badge">
    <div class="badge-card">
      <h2 class="badge-title"><xsl:value-of select="name"/></h2>
      <p><strong>Description:</strong> <xsl:value-of select="description"/></p>
      <h4>Availability by Level:</h4>
      <xsl:apply-templates select="levels/availability"/>
    </div>
  </xsl:template>

  <!-- 优化availability模板，增加样式和语义 -->
  <xsl:template match="availability">
    <div class="availability-item">
      <xsl:choose>
        <!-- 调整文字表述，增加em标签强调等级 -->
        <xsl:when test="@level = 'beaver'"><em>Beaver Level:</em> </xsl:when>
        <xsl:when test="@level = 'scout'"><em>Scout Level:</em> </xsl:when>
        <xsl:when test="@level = 'cub'"><em>Cub Level:</em> </xsl:when>
        <xsl:otherwise><em>Unknown Level:</em> </xsl:otherwise>
      </xsl:choose>
      <!-- 对"Not Available"做特殊样式处理 -->
      <xsl:choose>
        <xsl:when test=". = 'Not Available'">
          <span style="color: #c0392b; font-weight: bold;"><xsl:value-of select="."/></span>
        </xsl:when>
        <xsl:otherwise>
          <span style="color: #27ae60;"><xsl:value-of select="."/></span>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>