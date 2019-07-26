package com.gojava.controller.sy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.gojava.common.Result;
import com.gojava.entity.sy.Role;
import com.gojava.service.sy.RoleService;
import com.gojava.util.Page;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Autowired
	private  RoleService roleService;
	
	@RequestMapping(value="/showRoleList",method=RequestMethod.GET)
	public  ModelAndView  show(ModelAndView mv){
		mv.setViewName("role/roleList"); 
		return  mv;
	}
	
	@RequestMapping(value="/selectRoleList",method=RequestMethod.POST)
	@ResponseBody
	public  JSONObject  selecttRoleList(Role role,Page page){
		return roleService.selectRoleList(page, role);
	}
	
	@RequestMapping(value="/addRole",method=RequestMethod.POST)
	@ResponseBody
	public  Result  addRole(Role role){
		roleService.addRole(role);
		return  Result.ok();
	}
	@RequestMapping(value="/deleteRole",method=RequestMethod.POST)
	@ResponseBody
	public  Result  deleteRole(Role role){
		roleService.deleteRole(role);
		return  Result.ok();
	}
	@RequestMapping(value="/editRole",method=RequestMethod.POST)
	@ResponseBody
	public  Result  editRole(Role role){
		roleService.editRole(role);
		return  Result.ok();
	}
}
