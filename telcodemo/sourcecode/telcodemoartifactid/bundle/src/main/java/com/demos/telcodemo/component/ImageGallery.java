package com.demos.telcodemo.component;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import java.util.ArrayList;
import java.util.List;
import com.day.cq.dam.api.Asset;
import com.demos.telcodemo.bean.GalleryImage;


public class ImageGallery {
	private String[] inputList;

	public ImageGallery(String[] imagePathList){
		this.inputList = imagePathList;
	}

	public List<GalleryImage> getImageDetails(ResourceResolver r) {
		List<GalleryImage> list = new ArrayList<GalleryImage>();
		String[] imgList = this.inputList;
		for (String img: imgList) {
			GalleryImage item = null;
			item = new GalleryImage();
			if (img == null || img.equals("")) {
				item.setImagePath("");
			}
			else {
				Resource resource= r.getResource(img);
				if (resource == null) {
					item.setImagePath("");
				}
				else {
					item.setImagePath(img);
				}
			}
			item.setImageTitle(getMetaTitle(img, r));
			item.setImageDesc(getMetaDesc(img, r));
			list.add(item);
		}
		return list;
	}

	public String getMetaTitle(String path, ResourceResolver r) {
		String title = null;
		if (path == null || path.equals("")) {
			title = null;
			return title;
		}
		else {
			Resource resource= r.getResource(path);
			if (resource == null) {
				title = null;
				return title;
			}
			else {
				Asset asset = r.getResource(path).adaptTo(Asset.class);
				title = asset.getMetadataValue("dc:title");
				if (title == null) {
					title = "";
				};
				return title;
			}
		}
	}

	public String getMetaDesc(String path, ResourceResolver r) {
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
				Asset asset = r.getResource(path).adaptTo(Asset.class);
				desc = asset.getMetadataValue("dc:description");
				if (desc == null) {
					desc = "";
				};
			}
		}
		return desc;
	}
}
