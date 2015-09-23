package com.demos.telcodemo.component;
import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;

import org.apache.sling.api.resource.ResourceResolver;

import com.demos.telcodemo.bean.BlockItem;

public class BlockInfo {
	List<BlockItem> blockItemsList;
	String[] GPath;
	
	public BlockInfo(String[] GPathValue){
		this.GPath = GPathValue;
	}
	
	public List<BlockItem> GetBlockItemsCollection(ResourceResolver resourceResolver){
			
			List<BlockItem> myList = new ArrayList<BlockItem>();
			
			String[] strList = this.GPath;
			
			BlockItem item = null;
			
			for(String str : strList){
				item = new BlockItem();
				
				item.setGridTitle(getBlockItemTitle(str, resourceResolver));
				item.setGridSubTitle(getBlockItemDesc(str, resourceResolver));
				item.setGridPath(getBlockItemImgPath(str, resourceResolver));
			    myList.add(item);
				
			}		
			return myList;
			
		}
	
	public String getBlockItemTitle(String path, ResourceResolver res){
		
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
	
	public String getBlockItemDesc(String path, ResourceResolver res){
		
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
	
	public String getBlockItemImgPath(String path, ResourceResolver res){
		
		String str = "";
		
		Node nodeURL = res.getResource(path + "/jcr:content").adaptTo(Node.class);
		    
	    try {
	    	str = nodeURL.getProperty("infoblockicon").getString();
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

