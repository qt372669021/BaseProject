package com.gojava.service.sy.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.util.StringUtil;
import com.gojava.common.BaseServiceImpl;
import com.gojava.common.exception.SystemException;
import com.gojava.dao.sy.MenuDao;
import com.gojava.entity.sy.Menu;
import com.gojava.service.sy.MenuService;
import com.gojava.util.Page;

@Service
public class MenuServiceImpl  extends BaseServiceImpl<Menu,Serializable> implements MenuService {
	@Autowired
	private  MenuDao  menuDao;
	@Override
	public void addMenu(Menu menu) {
		Map<String,Object> map=new HashMap<String,Object>();
		if(menu==null){
			throw  new SystemException("璇峰～鍐欎俊鎭�");
		}
		if(StringUtil.isEmpty(menu.getName())){
			throw  new SystemException("鑿滃崟鍚嶇О涓嶈兘涓虹┖");
		}
		if(menu.getParentId() == null){
			menu.setParentId(0l);
		}
		map.put("map", menu);
		menuDao.add(map);
		
	}
	@Override
	public JSONObject selectAllMenu(String name,Page page) {
		Map<String,Object> map=new HashMap<String,Object>();
		if(!StringUtil.isEmpty(name)){
			map.put("name", name);
		}
		int total=	menuDao.getTotal(map);
		map.put("offset", (page.getPage()-1)*page.getRows());
		map.put("pageSize", page.getRows());
		List<Menu> listM=menuDao.findList(map);
		JSONObject obj=new JSONObject();
		obj.put("rows", listM);
		obj.put("total", total);
		return obj;
	}
	@Override
	public List<Menu> selectTolMenu() {
		List<Menu> lists=menuDao.selectTopMenu();
		return lists;
	}
	@Override
	public void edit(Menu menu) {
		if(StringUtil.isEmpty(menu.getName())){
			throw new SystemException("菜单名不能为空");
		}
		if(StringUtil.isEmpty(menu.getParentId().toString())){
			menu.setParentId(0l);
		}
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("map", menu);
		menuDao.edit(map);
	}
	@Override
	public void deleteMenu(Long id) {
		if(StringUtil.isEmpty(id.toString())){
			throw new SystemException("请选择菜单！");
		}
		List<Menu> listM=	menuDao.selectChildByParentId(id);
		if(listM !=null && listM.size()>0){
		throw new SystemException("该菜单存在子菜单不能删除");
		}
		menuDao.deleteMenu(id);
	}
	@Override
	public List<Menu> getAllMenu() {
		return  menuDao.selectAll();
	}
	
	/**
	 * 通过角色所拥有的菜单id 查询菜单
	 */
	@Override
	public List<Menu> selectMenuByMenuIds(String ids) {
		List<Menu> menuList=new ArrayList<Menu>();
		String[] manuId=ids.split(",");
		for(String id:manuId){
			menuList.add(menuDao.selectByPrimaryKey(Long.valueOf(id)));
		}
	return menuList;
	}

}
