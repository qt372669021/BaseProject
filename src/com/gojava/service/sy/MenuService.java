package com.gojava.service.sy;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.gojava.entity.sy.Menu;
import com.gojava.util.Page;

public interface MenuService {
	public  void addMenu(Menu menu);
	public  void deleteMenu(Long id);
	public  void  edit(Menu menu);
	
	public  JSONObject  selectAllMenu(String name,Page page);
	
	/**
	 * 获取所有菜单权限
	 */
	public  List<Menu>  getAllMenu();
	
	public  List<Menu>  selectTolMenu();
	
	/**
	 * ids为角色所拥有的菜单id，一个角色对应多个菜单id

	 */
	public List<Menu> selectMenuByMenuIds(String ids);
}
