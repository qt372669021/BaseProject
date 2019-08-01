package com.gojava.controller.sy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.gojava.common.Result;
import com.gojava.entity.sy.User;
import com.gojava.service.sy.RoleService;
import com.gojava.service.sy.UserService;
import com.gojava.util.Page;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private  UserService       userService;
	@Autowired
	private  RoleService       roleService;
	
	@RequestMapping(value="/showUser",method=RequestMethod.GET)
	public  ModelAndView  showUser (ModelAndView mv){
		mv.addObject("roleList", roleService.selectRoleList());
		mv.setViewName("user/userList");
		return  mv;
	}
	
	@RequestMapping(value="/addUser",method=RequestMethod.POST)
	@ResponseBody
	public  Result addUser(User user){
		userService.addUser(user);
		return  Result.ok();
	}
	@RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	@ResponseBody
	public  Result deleteUser(String ids){
		userService.deleteUser(ids);
		return  Result.ok();
	}
	@RequestMapping(value="/editUser",method=RequestMethod.POST)
	@ResponseBody
	public  Result editUser(User  user){
		userService.editUser(user);
		return  Result.ok();
	}
	
	@RequestMapping(value="/selectUser",method=RequestMethod.POST)
	@ResponseBody
	public  JSONObject selectUser(Page page,User user ){
		return userService.selectUser(page, user);
	}

}
