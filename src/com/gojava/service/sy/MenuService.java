package com.gojava.service.sy;

import com.alibaba.fastjson.JSONObject;
import com.gojava.entity.sy.Menu;
import com.gojava.util.Page;

public interface MenuService {
	public  void addMenu(Menu menu);
	
	public  JSONObject  selectAllMenu(String name,Page page);
	
}