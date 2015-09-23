package com.demos.telcodemo.component;

import java.util.ArrayList;
import java.util.List;
import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;

import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import com.day.cq.wcm.api.Page;
import com.demos.telcodemo.bean.GalleryPage;

public class OwlCarousel {

	private String[] inputList;

	public OwlCarousel(String[] pagePathList){
		this.inputList = pagePathList;
	}

	public List<GalleryPage> getPageDetails(ResourceResolver r) {

		List<GalleryPage> list = new ArrayList<GalleryPage>();
		String[] pgList = this.inputList;
		for (String pg: pgList) {
			GalleryPage item = null;
			item = new GalleryPage();
			item.setPageTitle(getPgTitle(pg, r));
			item.setPageDesc(getPgDesc(pg, r));
			item.setPageImage(getPgImage(pg, r));
			list.add(item);
		}
		return list;
	}

	public String getPgTitle(String path, ResourceResolver r) {
		String title = null;
		if (path == null || path.equals("")) {
			title = "ERROR: Empty page path is added!";
		}
		else {
			Resource resource= r.getResource(path);
			if (resource == null) {
				title = "ERROR: Page path is invalid!";
			}
			else {
				Page pageObject = r.getResource(path).adaptTo(Page.class);
				title = pageObject.getPageTitle();
				if (title == null || title.equals("")) {
					title = pageObject.getTitle();
				};
				if (title == null || title.equals("")) {
					title = pageObject.getName();
				};
				if (title == null) {
					title = "";
				};
			}
		}
		return title;
	}

	public String getPgDesc(String path, ResourceResolver r) {
		String desc = null;
		if (path == null || path.equals("")) {
			return desc;
		}
		else {
			Resource resource= r.getResource(path);
			if (resource == null) {
				return desc;
			}
			else {
				Page pageObject = r.getResource(path).adaptTo(Page.class);
				desc = pageObject.getDescription();
				if (desc == null) {
					desc = "";
				};     
				return desc;
			}
		}
	}

	public String getPgImage (String path, ResourceResolver r){
		String imagePath = null;
		if (path == null || path.equals("")) {
			imagePath = "";
		}
		else {
			Resource resource= r.getResource(path);
			if (resource == null) {
				imagePath = "";
			}
			else {
				Node pathNode = r.getResource(path).adaptTo(Node.class);
				try {
					if (pathNode.hasNode("jcr:content/image")) {
						Node imageNode = r.getResource(path + "/jcr:content/image").adaptTo(Node.class);
						try {
							imagePath = imageNode.getProperty("fileReference").getString();
						} catch (ValueFormatException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (PathNotFoundException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (RepositoryException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						if (imagePath == null) {
							imagePath = "";
						};
					}
					else {
						imagePath = "";
					}
				} catch (RepositoryException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return imagePath;
	}
}