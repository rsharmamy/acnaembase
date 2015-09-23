<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="java.util.Date,
		java.text.*"
		%>
<%
	Date dNow = new Date();	
	SimpleDateFormat ft = new SimpleDateFormat ("yyyy");
	String ftNote = currentStyle.get("footnote","");
    if(ftNote != ""){
        ftNote = ftNote.replace("(yyyy)",ft.format(dNow));
    }else{
		ftNote = "Copyright "+ft.format(dNow)+", Maxis.";
    }
        %>
<footer>
	<div class="line">
		<div class="s-12 l-6">
			<p><%=ftNote%></p>
		</div>
		<div class="s-12 l-6">
			<p class="right">
				<a class="right" href="#" title="This Maxis work">Developed by
					Accenture Malaysia</a>
			</p>
		</div>
	</div>
</footer>