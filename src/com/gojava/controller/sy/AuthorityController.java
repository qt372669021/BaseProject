package com.gojava.controller.sy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.util.StringUtil;
import com.gojava.common.Result;
import com.gojava.common.exception.SystemException;
import com.gojava.entity.sy.Authority;
import com.gojava.entity.sy.Menu;
import com.gojava.service.sy.AuthorityService;
import com.gojava.service.sy.MenuService;
import com.gojava.service.sy.RoleService;


@Controller
@RequestMapping("/authority")
public class AuthorityController {
	
	@Autowired
	private AuthorityService authorityService;
	
	@Autowired
	private MenuService menuService;
	
	
	@RequestMapping(value="/getMenuList",method=RequestMethod.POST)
	@ResponseBody
	public List<Menu>   getMenuList(){
		return menuService.getAllMenu();
	}
	@RequestMapping(value="/addAuthority",method=RequestMethod.POST)
	@ResponseBody
	public Result   addAuthority(String ids,Authority authority,Long roleId ){
		if( StringUtil.isEmpty(ids)){
			throw  new SystemException("请选择权限");
		}
		if(ids.contains(",")){
			ids=ids.substring(0, ids.length()-1);
		}
		String[] strId=ids.split(",");
		if(strId.length>0){//勾选权限时删掉已有的权限
			authorityService.deleteByRoleId(roleId);
		}
		for(String id:strId ){
			authority.setMenuId(Long.valueOf(id));
			authorityService.add(authority);
		}
		return Result.ok();
	}
	
	@RequestMapping(value="/selectAuthorityByRoleId",method=RequestMethod.POST)
	@ResponseBody
	public  List<Authority> selectAuthorityByRoleId(Long roleId){
		return authorityService.selectAuthorityByRoleId(roleId);
	}
	
	
}
