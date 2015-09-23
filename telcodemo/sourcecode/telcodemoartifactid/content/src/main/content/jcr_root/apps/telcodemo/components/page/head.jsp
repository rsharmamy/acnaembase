<%@include file="/libs/foundation/global.jsp" %>

<%
%>


<%@ page import="com.day.cq.commons.Doctype" %><%

    String xs = Doctype.isXHTML(request) ? "/" : "";
    String favIcon = currentDesign.getPath() + "/favicon.ico";
    if (resourceResolver.getResource(favIcon) == null) {
        favIcon = null;
    }
%>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width" />

    <cq:include script="headlibs.jsp"/>

	<cq:include script="/libs/wcm/core/components/init/init.jsp"/>

    <% if (favIcon != null) { %>

    	<link rel="icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>

    	<link rel="shortcut icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>

    <% } %>

    <title>
        <%= currentPage.getTitle() == null ? xssAPI.encodeForHTML(currentPage.getName()) : xssAPI.encodeForHTML(currentPage.getTitle()) %>
    </title>


    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css'>

    <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>

    <![endif]-->


</head>
