<%@include file="/libs/foundation/global.jsp"%>
<%@page
	import="java.util.List,com.demos.telcodemo.bean.ArticleItem,
		com.demos.telcodemo.component.ArticlePage, 
		java.util.ArrayList"
		%>
<%
String artcPaths = properties.get("artcpath", "");
Boolean passPoints = false;
if(artcPaths == ""){
    passPoints = false;
}else{
    passPoints = true;
    ArticlePage myArtc = new ArticlePage(artcPaths);
    ArticleItem itemCollection = new ArticleItem();
    itemCollection =  myArtc.GetArtcItemsCollection(resourceResolver);
    pageContext.setAttribute("ArtcItems", itemCollection);
}
pageContext.setAttribute("passPoint", passPoints);
%>

<div class="line">
	<div class="margin-bottom">
		<div class="margin">
			<article class="s-12 l-8 center">
				<c:choose>
					<c:when test="${passPoint == true}">
						<h1>${ArtcItems.articleName}</h1>
						<p class="margin-bottom">${ArtcItems.articleDesc}</p>
						<br />
						<a class="button s-4 l-4 center" href="<%=artcPaths%>.html">Read
							more</a>
					</c:when>
					<c:when test="${passPoint == false}">
						<h1>Featured Page/Article Component</h1>
						<p class="margin-bottom">No entries by author yet</p>
					</c:when>
				</c:choose>
			</article>
		</div>
	</div>
</div>
