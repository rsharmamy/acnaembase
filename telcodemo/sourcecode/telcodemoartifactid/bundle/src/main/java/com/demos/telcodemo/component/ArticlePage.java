package com.demos.telcodemo.component;

import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;

import org.apache.sling.api.resource.ResourceResolver;

import com.demos.telcodemo.bean.ArticleItem;

public class ArticlePage {
	String props;
	
	public ArticlePage(String value){
		this.props = value;
	}
	
	public ArticleItem GetArtcItemsCollection(ResourceResolver resourceResolver){
		
		String storeValue = this.props;
		ArticleItem item = new ArticleItem();
		item.setArticleName(getArtItemTitle(storeValue, resourceResolver));
		item.setArticleDesc(getArtItemDesc(storeValue, resourceResolver));
				
		return item;
	}

	public String getArtItemTitle(String storeValue, ResourceResolver res){
		String str = "";
		Node nodeURL = res.getResource(storeValue + "/jcr:content").adaptTo(Node.class);
		try {
			str = nodeURL.getProperty("jcr:title").getString();
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
		return str;
	}
	
	public String getArtItemDesc(String path, ResourceResolver res){
		String str = "";
		Node nodeURL = res.getResource(path + "/jcr:content").adaptTo(Node.class);
		try {
			str = nodeURL.getProperty("jcr:description").getString();
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
		return str;
	}
}
