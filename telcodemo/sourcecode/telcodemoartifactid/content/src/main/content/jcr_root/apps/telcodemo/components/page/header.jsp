<%--

  Page Components header.jsp

--%><%
%><%@include file="/libs/foundation/global.jsp"%>

<%

%>

<header>
    <nav>
        <div class="line">
            <div class="logo hide-l">
                <a class="mainLogo" href="/content/telcodemo/en.html">
                    <cq:include path="mobileLogo" resourceType= "telcodemo/components/logo"/>
                </a>
            </div>
            <div class="top-nav">
                <cq:include path="topnav" resourceType="telcodemo/components/topnav"/>
            </div>
        </div>
    </nav>
</header> 