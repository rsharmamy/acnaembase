<%--
    
    Image Gallery
    
    --%><%
    %><%@include file="/libs/foundation/global.jsp"%><%
    %><%@page session="false" import=	"com.day.cq.dam.api.Asset,
                                      	java.util.List,
                                      	java.util.ArrayList,
                                        com.demos.telcodemo.bean.GalleryImage,
                                        com.demos.telcodemo.component.ImageGallery"
    %><%
    // Heading and Subheading
    String heading = properties.get("heading","");
    String subheading = properties.get("subheading","");
    pageContext.setAttribute("heading",heading);
    pageContext.setAttribute("subheading",subheading);
    
    // Grid Size
    int colNumber = Integer.parseInt(properties.get("colnumber","3"));
    
    if (colNumber >= 5) {
        colNumber = 5;
    }

    if (colNumber == 5) {
        String gridSize = "five";
        pageContext.setAttribute("gridSize",gridSize);
    }
    else {
        int gridSize = 12 / colNumber;
        pageContext.setAttribute("gridSize",gridSize);
    };

    // Custom Descriptions
    String[] customDescriptions = properties.get("descriptions", String[].class);
    pageContext.setAttribute("customDescriptions",customDescriptions);
    
    // Image and Custom Descriptions
    String[] imagePaths = properties.get("images", String[].class);
    
    if (imagePaths == null) {
        boolean success = false;
        pageContext.setAttribute("success",success);
    }
    else {
        boolean success = true;
        pageContext.setAttribute("success",success);
        pageContext.setAttribute("imageNumber",imagePaths.length);
        ImageGallery imagePathList = new ImageGallery(imagePaths);
        List<GalleryImage> imageDetails = new ArrayList<GalleryImage>();
        imageDetails = imagePathList.getImageDetails(resourceResolver);
        pageContext.setAttribute("images",imageDetails);
    }
%>

<c:choose>
    <c:when test="${success == false}">
        <section>
            <div id="content">
                <div class="line">
                    <h2>Image Gallery</h2>
                    <p class="subtitile">Showcase your images here.<b> Right Click\Edit to add images</b></p>
                </div>
            </div>
        </section>
    </c:when>
    <c:when test="${success == true}">
        <section>
            <div id="content">
                <div class="line">
                    <h2>${heading}</h2>
                    <p class="subtitile">${subheading}</p>
                    <div class="margin">
                        <c:forEach items="${images}" var="image" begin="0" end="${imageNumber}" varStatus="status">
                            <div class="s-12 l-${gridSize}">
                                <img src="${image.imagePath}">
                                <c:choose>
                                    <c:when test="${image.imageTitle == null}">
                                        <p class="subtitile border">ERROR: Image path is invalid! Right click\Edit to edit the paths</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${not empty customDescriptions[status.index] && customDescriptions[status.index] != null}">
                                                <p class="subtitile">${customDescriptions[status.index]}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${not empty image.imageTitle}">
                                                        <p class="subtitile">${image.imageTitle}</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${not empty image.imageDesc}">
                                                                <p class="subtitile">${image.imageDesc}</p>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
    </c:when>
</c:choose>

