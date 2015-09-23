<%--

  Page Head component.

  A block to show page title.

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%

    String headTitle = properties.get("headtitle",properties.get(NameConstants.PN_TITLE, String.class));
    if (headTitle == null || headTitle.equals("")) {
        headTitle = resourcePage.getPageTitle();
    }
    if (headTitle == null || headTitle.equals("")) {
        headTitle = resourcePage.getTitle();
    }
    if (headTitle == null || headTitle.equals("")) {
        headTitle = resourcePage.getName();
    }

	pageContext.setAttribute("headTitle",headTitle);

%>
<section>
    <div id="head" class="hide-s">
        <div class="line">
            <h1>${headTitle}</h1>
        </div>
    </div>
    <div id="head_mobile" class="hide-l">
        <div class="line">
            <h1>${headTitle}</h1>
        </div>
    </div>
</section>
