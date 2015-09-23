package com.demos.telcodemo.component;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;

import org.apache.sling.api.resource.ResourceResolver;

import com.demos.telcodemo.bean.NavItem;

public class TopNav {
	
	List<NavItem> navItemsList;
	String[] properties;
	
	public TopNav(String[] propertyValue){
	
		this.properties = propertyValue;
		
	}
	
	public List<NavItem> GetNavItemsCollection(ResourceResolver resourceResolver){
			
			List<NavItem> myList = new ArrayList<NavItem>();
			
			String[] strList = this.properties;
			
			NavItem item = null;
			String titleURL = "dummy";
			
			for(String str : strList){
				item = new NavItem();
				item.setItemPath(str);
				item.setItemTitle(getNavItemTitle(str,resourceResolver));
			    myList.add(item);
				
			}		
			return myList;
			
			
		}
	
	public String getNavItemTitle(String path, ResourceResolver res){
		
		String str = "";
		
		Node nodeURL = res.getResource(path + "/jcr:content").adaptTo(Node.class);
		    
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
}
