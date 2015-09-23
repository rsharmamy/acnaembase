<%@page session="false"%><%--
  Copyright 1997-2009 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Shows information about the currently logged in user.

--%><%@include file="/libs/foundation/global.jsp"%><%
%><%@ page import="com.adobe.cq.commerce.api.CommerceConstants,
                   com.day.cq.i18n.I18n,
                   com.day.cq.personalization.UserPropertiesUtil,
                   com.day.cq.wcm.api.WCMMode,
                   java.util.Locale" %><%
%>
<%@taglib prefix="personalization" uri="http://www.day.com/taglibs/cq/personalization/1.0" %>
<%
    Locale pageLang = currentPage.getLanguage(false);
    final I18n i18n = new I18n(slingRequest.getResourceBundle(pageLang));
    final boolean isAnonymous = UserPropertiesUtil.isAnonymous(slingRequest);
	pageContext.setAttribute("isAnonymous",isAnonymous);
    final boolean isDisabled = WCMMode.DISABLED.equals(WCMMode.fromRequest(request));
	pageContext.setAttribute("isDisabled",isDisabled);

	//final String logoutPath = request.getContextPath() + "/system/sling/logout.html";
	 String logoutPath = WCMUtils.getInheritedProperty(currentPage, resourceResolver, "cq:logoutPage");
    if (logoutPath == null) {
        logoutPath = currentStyle.get("logoutPage", String.class);        // for legacy, pre-5.6.1 sites
    }

	if (logoutPath == null) {
        logoutPath = "/content/telcodemo/en.html";        // for legacy, pre-5.6.1 sites
    }

	if( !logoutPath.endsWith(".html")) {
        logoutPath += ".html";
    }

    String profilePagePath = WCMUtils.getInheritedProperty(currentPage, resourceResolver, "cq:profilePage");
    if (profilePagePath == null) {
        profilePagePath = currentStyle.get("profilePage", "");    // for legacy, pre-5.6.1 sites
    }
	//final String myProfileLink = "${profile.path}.form.html" + profilePagePath;
	String myProfileLink = profilePagePath;

	if( !myProfileLink.endsWith(".html")) {
        myProfileLink += ".html";
    }

    String loginPagePath = WCMUtils.getInheritedProperty(currentPage, resourceResolver, "cq:loginPage");
    if (loginPagePath == null) {
        loginPagePath = currentStyle.get("loginPage", String.class);        // for legacy, pre-5.6.1 sites
    }

	if( !loginPagePath.endsWith(".html")) {
        loginPagePath += ".html";
    }
%>

<script type="text/javascript">

    function logout() {

    	if (_g && _g.shared && _g.shared.ClientSidePersistence) {
        	_g.shared.ClientSidePersistence.clearAllMaps();
    	}

        <c:choose>
    		<c:when test="${not isDisabled}">
				 if (CQ_Analytics && CQ_Analytics.CCM) {
                    CQ_Analytics.ProfileDataMgr.loadProfile("anonymous");
                    CQ.shared.Util.reload();
                }
			</c:when>
            <c:otherwise>
				if (CQ_Analytics && CQ_Analytics.CCM) {
                    CQ_Analytics.ProfileDataMgr.clear();
                    CQ_Analytics.CCM.reset();
                }
			</c:otherwise>
		</c:choose>

       CQ.shared.HTTP.clearCookie("<%= CommerceConstants.COMMERCE_COOKIE_NAME %>", "/");
       CQ.shared.Util.load("<%= xssAPI.encodeForJSString(logoutPath) %>");
	}
</script>


	<c:choose>
    	<c:when test="${isDisabled}">
        	<c:choose>
            	<c:when test="${not isAnonymous}">
                	<li>
                    	<a href="<%= myProfileLink %>"> <i class="icon-user"></i>Profile</a>
                    </li>
                    <li>
                            <a href="javascript:logout();"> <i class="icon-unlock"></i>LogOut</a>
                    </li>
              	</c:when>
    		    <c:otherwise>
            		<li>
                    		<a href="<%= loginPagePath %>"> <i class="icon-lock"></i>Login</a>
                    </li>
                </c:otherwise>
            </c:choose>
		</c:when>
        <c:otherwise>
        	<c:choose>
            	<c:when test="${not isAnonymous}">
                	<li>
                    	<a href="<%= myProfileLink %>"> <i class="icon-user"></i>Profile</a>
                    </li>
                    <li>
                            <a href="javascript:logout();"> <i class="icon-unlock"></i>LogOut</a>
                    </li>
              	</c:when>
    		    <c:otherwise>
            		<li>
                    		<a href="<%= loginPagePath %>"> <i class="icon-lock"></i>Login</a>
                    </li>
                </c:otherwise>
            </c:choose>
       	</c:otherwise>
	</c:choose>