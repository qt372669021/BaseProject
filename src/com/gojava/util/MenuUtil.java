package com.gojava.util;

import java.util.ArrayList;
import java.util.List;

import com.gojava.entity.sy.Menu;

public class MenuUtil {
	/**
	 * 
		获取给定的菜单的顶部菜单
	*
	 */
	public  static List<Menu> getTopMenuList (List<Menu> menuList){
		  List<Menu> list=new ArrayList<Menu>();
		 for(Menu  m:menuList){
			 if(m.getParentId()==0){
				 list.add(m);
			 }
		 }
		return  list;
	}
	/**
	 * 获取所有的二级菜单
	 */
	public  static List<Menu> getSecondMenuList(List<Menu> menuList){
		List<Menu> list=new ArrayList<Menu>();
		List<Menu> topmList=getTopMenuList(menuList);
		for(Menu menu:menuList){
			for(Menu top:topmList){
				if(top.getId()==menu.getParentId()){
					list.add(menu);
					break;
				}
			}
		}
		return  list;
	}
}
