<%--

  Owl Carousel (Imageless)

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" import="java.util.List,
    							  java.util.ArrayList,
								  javax.jcr.Node,
								  java.util.Random,
    							  com.demos.telcodemo.bean.GalleryPage,
    							  com.demos.telcodemo.component.OwlCarousel"
%><%

    // Default Message
    String componentName = component.getTitle();
    pageContext.setAttribute("componentName",componentName);

	String componentPath = component.getPath();
	Node componentNode = resourceResolver.getResource(componentPath).adaptTo(Node.class);
	if (componentNode.hasProperty("defaultMessage")) {
		String defaultMessage = componentNode.getProperty("defaultMessage").getString();
    	pageContext.setAttribute("defaultMessage",defaultMessage);
	}
    else {
        String defaultMessage = "Author has not configured the component default message yet.";
    	pageContext.setAttribute("defaultMessage",defaultMessage);
    };

    // Carousel Settings
	String slideSpeed = properties.get("slidespeed","800");
	String autoPlay = properties.get("autoplay",String.class);
	String autoPlaySpeed = properties.get("autoplayspeed",String.class);
	String pagination = properties.get("pagination",String.class);
	if (autoPlay == null || autoPlay.equals("")) {
        autoPlay = "false";
    }
	else {
		if (autoPlaySpeed == null) {
			autoPlay = "5000";
        }
        if (autoPlaySpeed != null) {
            autoPlay = autoPlaySpeed;
        }
    }
	if (pagination == null) {
        pagination = "false";
    }
	pageContext.setAttribute("autoPlay", autoPlay);
	pageContext.setAttribute("pagination", pagination);
	pageContext.setAttribute("slideSpeed", slideSpeed);

	// Carousel ID Randomizer (4-digit)
	Random rand = new Random();
	// int randomNum = rand.nextInt((max - min) + 1) + min;
	// nextInt is normally exclusive of the top value, so add 1 to make it inclusive
	int carousel_ID = rand.nextInt(9000) + 1000; //from 1000 to 9999
	pageContext.setAttribute("carousel_ID",carousel_ID);

	// Customizable Button
	String customBtn = properties.get("calltoaction", "Read more");
	pageContext.setAttribute("customBtn",customBtn);

	// Content Settings
    String[] pagePaths = properties.get("pages", String[].class);
	pageContext.setAttribute("pagePaths",pagePaths);

	if (pagePaths == null) {
        boolean success = false;
        pageContext.setAttribute("success",success);
    }
	else {
		boolean success = true;
        pageContext.setAttribute("success",success);
        pageContext.setAttribute("pageNumber",pagePaths.length);
        OwlCarousel pagePathList = new OwlCarousel(pagePaths);
        List<GalleryPage> pageDetails = new ArrayList<GalleryPage>();
        pageDetails = pagePathList.getPageDetails(resourceResolver);
        pageContext.setAttribute("pages",pageDetails);
    }
%>

<c:choose>
    <c:when test="${success == false}">
        <section>
            <div id="content">
               <div class="line">
                   <h2>- ${componentName} -</h2>
                   <p class="subtitile">${defaultMessage}</p>
                </div>
            </div>
        </section>
    </c:when>
    <c:when test="${success == true}">
        <section>
        <div id="fourth-block">
        <div class="line">
           <div id="owl-${carousel_ID}" class="owl-carousel owl-theme">
               <c:forEach items="${pages}" var="page" begin="0" end="${pageNumber}">
                 <div class="owl-item">
                     <div class="item">
                         <h1>${page.pageTitle}</h1>
                         <c:choose>
                             <c:when test="${page.pageDesc == null}">
                                 <p class="s-12 l-8 center margin-bottom">Right click\Edit to edit pages</p>
                             </c:when>
                             <c:otherwise>
                                 <p class="s-12 l-8 center margin-bottom">${page.pageDesc}</p>
                             </c:otherwise>
                         </c:choose>
                     </div>
                     <div>
                         <a class="button s-12 l-4 center" href="${pagePaths[status.index]}.html">${customBtn}</a>
                     </div>
                  </div>
               </c:forEach>
              </div>
            </div>
        </div>
        </section>
    </c:when>
</c:choose>

<script type="text/javascript">
         $(document).ready(function($) {
           jQuery("#owl-${carousel_ID}").owlCarousel({

               	slideSpeed	: ${slideSpeed},
                autoPlay	: ${autoPlay},
                pagination	: ${pagination},
                singleItem	: true,
               	lazyLoad	: true
           });
         });
</script>
