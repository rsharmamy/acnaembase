	<%@include file="/libs/foundation/global.jsp"%>
<%@page import="java.util.List,
    	com.demos.telcodemo.bean.NavItem,
		com.demos.telcodemo.component.TopNav, 
            java.util.ArrayList"
%>

<p class="nav-text">Custom Menu</p>
<div class="top-nav s-12 l-5">
    <ul class="right top-ul chevron">
        <%

    String[] myPaths = null;
	if(properties.get("paths",currentStyle.get("paths", String[].class)) != null ){
			myPaths = properties.get("paths",currentStyle.get("paths", String[].class));
    }else{
		myPaths = new  String[1];
		myPaths[0] = "/content/telcodemo/en/user";
  	}

TopNav myNav = new TopNav(myPaths);
List<NavItem> itemCollection = new ArrayList();
itemCollection =  myNav.GetNavItemsCollection(resourceResolver);
pageContext.setAttribute("navItems", itemCollection);


%>
        <c:forEach items="${navItems}" var="navItem" begin="0" end="<%=myPaths.length/2+myPaths.length%2-1 %>"> 
            <li><a href="${navItem.itemPath}.html">${navItem.itemTitle}</a></li> 
        </c:forEach>
    </ul>
</div>
<ul class="s-12 l-2">
    <li class="logo hide-s">
        <a class="mainLogo" href="/content/telcodemo/en.html">
            <cq:include path="logo" resourceType="telcodemo/components/logo" />
        </a>
    </li>
</ul>
<div class="top-nav s-12 l-5">
    <ul class="top-ul chevron">
        <c:forEach items="${navItems}" var="navItem" begin="<%=myPaths.length/2+myPaths.length%2 %>" end="<%=myPaths.length-1 %>"> 
            <li><a href="${navItem.itemPath}.html">${navItem.itemTitle}</a></li> 
        </c:forEach>

        <cq:include path="userinfo" resourceType="telcodemo/components/userinfo"/>
    </ul>
</div>

