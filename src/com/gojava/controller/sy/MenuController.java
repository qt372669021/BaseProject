package com.gojava.controller.sy;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.gojava.common.Result;
import com.gojava.entity.sy.Menu;
import com.gojava.service.sy.MenuService;
import com.gojava.util.Page;


@Controller
@RequestMapping("/menu")
public class MenuController {
	@Autowired
	private  MenuService menuService;
	
	@RequestMapping(value="/menuList",method=RequestMethod.GET)
	public  ModelAndView  log(ModelAndView mv){
		mv.addObject("topMenu", menuService.selectTolMenu());
		mv.setViewName("menu/menuList"); 
	
		return  mv;
	}
	
/*	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public ResponseContent add(Menu menu){
		ResponseContent   rc=new ResponseContent();
		try{
			menuService.addMenu(menu);
			rc.setSuccess(true);
			rc.setMsg("添加成功");
		}catch(Exception e){
			rc.setSuccess(false);
			rc.setMsg(e.getMessage());
		}
		return rc;
	}*/
	
		@RequestMapping(value="/add",method=RequestMethod.POST)
		@ResponseBody
		public Result add2(Menu menu){
			menuService.addMenu(menu);
			return Result.ok();
		}
	
/*	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> add3(Menu menu){
		Map<String,String> map=new HashMap<String,String>();
		try{
			menuService.addMenu(menu);
			map.put("type", "sucess");
			map.put("msg", "新增成功!");
		}catch(Exception e){
			map.put("type", "false");
			map.put("msg", e.getMessage());
		}
		return map;
	}*/
	
	
		@RequestMapping(value="/selectMenuList",method=RequestMethod.POST,produces = "application/json;charset=utf-8")
		@ResponseBody
		public JSONObject getMenuList(Page page, String name){
			JSONObject  obj=menuService.selectAllMenu(name, page);
			return  obj;
		}
		//获取系统下所有图标
		@RequestMapping(value="/get_icons",method=RequestMethod.POST)
		@ResponseBody
		public   Map<String, Object> getIncons(HttpServletRequest req){
			Map<String, Object> ret = new HashMap<String, Object>();
		List<String> icons = new ArrayList<String>(); 
		String realPath = req.getSession().getServletContext().getRealPath(File.separator);
		File file = new File(realPath + "\\resources\\admin\\easyui\\css\\icons");
		if(!file.exists()) {
			ret.put("type", "error");
			ret.put("msg", "文件目录不存在！");
			return ret;
		}
		File[] files=file.listFiles();
		for(File f:files) {
			if(f!= null && f.getName().contains("png")){
				icons.add("icon-" + f.getName().substring(0, f.getName().indexOf(".")).replace("_", "-"));
			}
		}
		ret.put("type", "success");
		ret.put("content", icons);
		return ret;
		}

}
