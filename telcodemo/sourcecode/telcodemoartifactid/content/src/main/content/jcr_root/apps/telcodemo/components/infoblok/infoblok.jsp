<%@include file="/libs/foundation/global.jsp"%>
<%@page
	import="java.util.List,com.demos.telcodemo.bean.BlockItem,
		java.util.ArrayList,
		com.demos.telcodemo.component.BlockInfo"
		%>
<%

String blokmainTitle = "";
String blokmainsubTitle = "";
String circularClass = "";
String[] myGPath = properties.get("blokpath", String[].class);
boolean isChecked = properties.get("checkTest", false);
blokmainTitle = properties.get("blokmaintitle","Block Component");
blokmainsubTitle = properties.get("blokmainsubtitle","No entries by author yet");

pageContext.setAttribute("blokmainsubTitle", blokmainsubTitle);
    pageContext.setAttribute("blokmainTitle", blokmainTitle);

if(myGPath == null){

	}
	else{
    	if(isChecked){
        	circularClass = "circular";
    	}else
        {
        circularClass = "notcircular";
    	}


    BlockInfo myBlock = new BlockInfo(myGPath);
    List<BlockItem> itemCollection = new ArrayList();
    itemCollection =  myBlock.GetBlockItemsCollection(resourceResolver);
    pageContext.setAttribute("blockItem", itemCollection);
    pageContext.setAttribute("circularClass", circularClass);


}
%>

<div class="line">
	<h2>${blokmainTitle}</h2>
	<p class="subtitile">${blokmainsubTitle}</p>
	<div class="margin">
		<c:forEach items="${blockItem}" var="blockItems">
			<div class="s-12 l-3 margin-bottom">
				<img src="${blockItems.gridPath}" alt="${blockItems.gridPath}"
					class="${circularClass}" />
				<h3>${blockItems.gridTitle}</h3>
				<p>${blockItems.gridSubTitle}</p>
			</div>
		</c:forEach>
	</div>
</div>

