<%@include file="/libs/foundation/global.jsp"%>
<%
    String myIm = "";
myIm = currentStyle.get("myImages","No Images");
%>
<img alt="Maxis" src="<%=myIm%>" />