<%--

  Page Components body.jsp

--%><%
%><%@include file="/libs/foundation/global.jsp"%>

<%
    StringBuffer cls = new StringBuffer();
    for (String c: componentContext.getCssClassNames()) {
        cls.append(c).append(" ");
    }

pageContext.setAttribute("designPath",currentDesign.getPath());
%>



<body class="size-1140" style="background:url('/etc/designs/telcodemo/images/img/background.jpg') no-repeat fixed center center / 100% auto rgba(0, 0, 0, 0);">
<cq:include path="clientcontext" resourceType="cq/personalization/components/clientcontext"/>



        <cq:include script="header.jsp"/>


        <cq:include script="content.jsp"/>


        <cq:include script="footer.jsp"/>


    <script type="text/javascript" src="${designPath}/clientlibs/js/owl.carousel.js"></script> 
</body>
