<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">
      <div id="options_nav_box" class="mir-prop-nav">
        <nav>
          <ul class="navbar-nav ml-auto flex-row">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>
      </div>

      <div id="project_logo_box">
        <a href="{concat($WebApplicationBaseURL,substring($loaded_navigation_xml/@hrefStartingPage,2),$HttpSession)}"
           class="">
          <img src="{$WebApplicationBaseURL}images/logos/hu_emporion-logo-colored.svg" alt="" />
        </a>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav">
      <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark bg-secondary">

          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav__entries"
            aria-controls="mir-main-nav__entries"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div id="mir-main-nav__entries" class="collapse navbar-collapse mir-main-nav__entries">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'brand'"/>
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>

          <div class="searchBox">
            <xsl:variable name="core">
              <xsl:text>/find</xsl:text>
            </xsl:variable>
            <form
              action="{$WebApplicationBaseURL}servlets/solr{$core}"
              class="searchfield_box form-inline my-2 my-lg-0"
              role="search">
              <input
                name="condQuery"
                placeholder="{i18n:translate('mir.navsearch.placeholder')}"
                class="form-control search-query"
                id="searchInput"
                type="text"
                aria-label="Search" />
              <xsl:if test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                <input name="owner" type="hidden" value="createdby:*" />
              </xsl:if>
              <button type="submit" class="btn btn-secondary my-2 my-sm-0">
                <i class="fas fa-search"></i>
              </button>
            </form>
          </div>

        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />
    <li class="nav-item">
      <xsl:variable name="activeClass">
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item[@href = $browserAddress ]">
          <xsl:text>active</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>not-active</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <a id="{$menuID}" href="{$WebApplicationBaseURL}{$loaded_navigation_xml/menu[@id=$menuID]/item/@href}" class="nav-link {$activeClass}" >
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)] != ''">
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($DefaultLang)]" />
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>

  <xsl:template name="mir.footer">

    <div class="flatmir-footer__feature">
      <div class="container">
        <div class="row">
          <div class="col">
            <div class="logo-section">
              <a class="openaire logo" href="https://explore.openaire.eu/search/dataprovider?pid=r3d100014123" target="_blank" alt="Logo OpenAIRE" title="Logo OpenAIRE">
                <img class="openaire_logo img-fluid mr-5" src="{$WebApplicationBaseURL}/images/logos/web_footer-openaire.webp" />
              </a>
              <object type="image/svg+xml" data="{$WebApplicationBaseURL}/images/logos/re3data-emporion-logo.svg">
                <img alt="re3data logo" src="{$WebApplicationBaseURL}/images/logos/web_footer-re3data.png" />
              </object>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="flatmir-footer__menu">
      <div class="container">
        <div class="row">
          <div class="col">
            <ul class="internal_links nav">
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" mode="footerMenu" />
            </ul>
          </div>
        </div>
      </div>
    </div>

    <div class="flatmir-footer__partner">
      <div class="container">
        <div class="row">
          <div class="col">
            <div class="logo-section">
              <a class="sbb logo" href="https://staatsbibliothek-berlin.de/" target="_blank" alt="Logo Staatsbibliothek" title="Logo Staatsbibliothek">
                <img class="sbb_logo img-fluid" src="{$WebApplicationBaseURL}/images/logos/web_footer-sbb-full-cut.svg" />
              </a>
              <a class="gswg logo" href="https://www.gswg.eu" target="_blank" alt="Logo GSWG" title="Logo GSWG">
                <img class="gswg_logo img-fluid" src="{$WebApplicationBaseURL}/images/logos/web_footer-gswg-full.jpg" />
              </a>
              <a class="spp logo" href="https://www.experience-expectation.de" target="_blank" alt="Logo SPP" title="Logo SPP">
                <img class="spp_logo img-fluid" src="{$WebApplicationBaseURL}/images/logos/web_footer-spp-full.png" />
              </a>
              <a class="dfg logo" href="https://www.dfg.de" target="_blank" alt="Logo DFG" title="Logo DFG">
                <img class="dfg_logo img-fluid" src="{$WebApplicationBaseURL}/images/logos/web_footer-dfg-full-cut.gif" />
              </a>
              <a class="VZG logo" href="https://www.gbv.de" target="_blank" alt="Logo VZG" title="Logo VZG">
                <img class="vzg_logo img-fluid" src="{$WebApplicationBaseURL}/images/logos/web_footer-vzg-full.png" />
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

  </xsl:template>


  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_powered_120x30_blaue_schrift_frei.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

  <xsl:template name="getLayoutSearchSolrCore">
    <xsl:choose>
      <xsl:when test="mcrxsl:isCurrentUserInRole('editor') or mcrxsl:isCurrentUserInRole('admin')">
        <xsl:text>/find</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>/findPublic</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
