<%@include file="/libs/foundation/global.jsp"%><%
%><%@ page import="java.util.HashMap,
                   java.util.Map,
                   org.apache.commons.lang.StringUtils,
				   com.adobe.cq.commerce.api.CommerceConstants,
                   com.day.cq.i18n.I18n,
                   com.day.cq.personalization.UserPropertiesUtil,
                   com.day.cq.wcm.api.WCMMode,
                   com.day.cq.wcm.foundation.forms.FormsHelper,
                   java.util.Locale" %><%
%><%@taglib prefix="personalization" uri="http://www.day.com/taglibs/cq/personalization/1.0" %>
<%
    final String DEFAULT_TITLE = "My Title";
	final String DEFAULT_LEFT_DETAILS[] = {"Salution=salution", "User Name=userName", "User Id=userId", "User Id Type=userIdType", "Race=race", "Nationality=nationality", "Mobile Number=mobileNumber", "Home Number=homeNumber", "Office Number=officeNumber", "Email=email", "Address=address"};
	final String DEFAULT_RIGHT_DETAILS[] = {"User Since=userSince", "User Type=userType", "Preferred Contact Method=contactMethod", "Preferred Contact Time=contactTime","Preferred Contact Language=contactLanguage", "GST Tax Relief=taxRelief"};

%>


<%

	String title = properties.get("headTitle",DEFAULT_TITLE);
	pageContext.setAttribute("title",title);

	final boolean isAnonymous = UserPropertiesUtil.isAnonymous(slingRequest);
	pageContext.setAttribute("isAnonymous",isAnonymous);

    final boolean isDisabled = WCMMode.DISABLED.equals(WCMMode.fromRequest(request));
	pageContext.setAttribute("isDisabled",isDisabled);
	//final String logoutPath = request.getContextPath() + "/system/sling/logout.html";

	// managed URIs should respect sling mapping
	String defaultRedirect = "/content/telcodemo/en/user.html";
    String logoutPath = properties.get("./redirectTo", "");
    if (!StringUtils.isBlank(logoutPath)) {
        logoutPath = slingRequest.getResourceResolver().map(request, logoutPath);
    } else {
        logoutPath = defaultRedirect;
    }

    if( !logoutPath.endsWith(".html")) {
        logoutPath += ".html";
        }

	//Get Left Value
	String leftValues[] = properties.get("detail_left",DEFAULT_LEFT_DETAILS);
	pageContext.setAttribute("leftValues",leftValues);

    //Get Right Value
	String rightValues[] = properties.get("detail_right",DEFAULT_RIGHT_DETAILS);
	pageContext.setAttribute("rightValues",rightValues);


    // managed URIs should respect sling mapping
    String redirectTo = properties.get("./redirectTo", "");
	if (!StringUtils.isBlank(redirectTo)) {
        redirectTo = slingRequest.getResourceResolver().map(request, redirectTo);
    }else {
        redirectTo = "/content/telcodemo/en.html";
    }

	if( !redirectTo.endsWith(".html")) {
        redirectTo += ".html";
    }
%>


<c:if test="${isAnonymous}">
    <script type="text/javascript">
         var url = CQ.shared.HTTP.noCaching("<%= xssAPI.encodeForJSString(redirectTo) %>");
          CQ.shared.Util.load(url);
    </script>
</c:if>


         <div id="content">
            <div class="line">
				<table class="customerProfile">
					<thead>
						<tr>
						<th>
                            ${title}
						</th>
						</tr>
					</thead>
				</table>
			</div>
		 
            <div class="line div-withborder">
                <div class="l-6 s-12">
	<table class="customerProfile">
		<tbody>
            <c:forEach items="${leftValues}" var="lValue">

				<c:set var="val" value="${fn:split(lValue, '=')}" />

					<tr>
                        <td>${val[0]}</td>
                        <td>:</td>
                        <td width="50%">
                            <div id="userprofile_${val[1]}">-</div>
                        </td>
                    </tr>
            </c:forEach>
		</tbody>
	</table>
</div>
<div class="l-6 s-12">
	<table class="customerProfile">
		<tbody>
            <c:forEach items="${rightValues}" var="rValue">

				<c:set var="val" value="${fn:split(rValue, '=')}" />

					<tr>
                        <td>${val[0]}</td>
                        <td>:</td>
                        <td width="50%">
                            <div id="userprofile_${val[1]}">-</div>
                        </td>
                    </tr>
            </c:forEach>
		</tbody>
	</table>
</div>
            </div>
         </div>


<script>ajaxhit_get();</script>