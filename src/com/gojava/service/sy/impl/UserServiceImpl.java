package com.gojava.service.sy.impl;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.util.StringUtil;
import com.gojava.common.BaseServiceImpl;
import com.gojava.common.PaginationResult;
import com.gojava.common.exception.SystemException;
import com.gojava.dao.sy.UserDao;
import com.gojava.entity.sy.Authority;
import com.gojava.entity.sy.Menu;
import com.gojava.entity.sy.Role;
import com.gojava.entity.sy.User;
import com.gojava.service.sy.AuthorityService;
import com.gojava.service.sy.MenuService;
import com.gojava.service.sy.RoleService;
import com.gojava.service.sy.UserService;
import com.gojava.util.Page;
@Service
public class UserServiceImpl extends BaseServiceImpl<User,Serializable>implements UserService{
	@Autowired
	private UserDao  userDao;
	
	@Autowired
	private  RoleService  roleService;
	
	@Autowired
	private  AuthorityService  authorityService;
	@Autowired
	private MenuService  menuService;
	
	@Override
	public void selectLogin(User user,String cpacha, HttpServletRequest req) {
		if(user ==null){
			 throw new SystemException("填写用户信息！");
			}
			if(StringUtil.isEmpty(user.getUsername())){
				throw new SystemException("用户名不能为空");
			}
			if(StringUtil.isEmpty(user.getPassword())){
				throw new SystemException("密码不能为空");
			}
			if(StringUtil.isEmpty(cpacha)){
				throw new SystemException("验证码不能为空！");
			}
			
		Object  loginCpacha=	req.getSession().getAttribute("cpachaType");
		if(loginCpacha==null){
			throw new SystemException("会话超时！");
		}
			if(!cpacha.toUpperCase().equals(loginCpacha.toString().toUpperCase())){
				throw new SystemException("验证码不正确！");
			}
			Example  example=new  Example(User.class);
			Criteria cri=	example.createCriteria();
			cri.andEqualTo("username", user.getUsername());
			cri.andEqualTo("password", user.getPassword());
		List<User> listUser=	super.selectByExample(example);
		if(listUser ==null || listUser.size()==0){
			throw new SystemException("用户名或者密码错误！");
		}else{
			User  u=listUser.get(0);
			if(!u.getPassword().equals(user.getPassword())){
				throw new SystemException("密码错误！");
			}
			//查询用户角色，权限
			Role role=roleService.selectRoleById(u.getRoleId());
			List<Authority> authorityLists=authorityService.selectAuthorityByRoleId(role.getId());
			String  manuIds="";
			for(Authority  authority:authorityLists){
				manuIds+=authority.getMenuId()+",";
			}
			if(manuIds.contains(",")){
				manuIds=manuIds.substring(0, manuIds.length()-1);
			}
			List<Menu> userMenu=	menuService.selectMenuByMenuIds(manuIds);
			//角色 菜单信息放入到session中
			req.getSession().setAttribute("login_user", u);
			req.getSession().setAttribute("userMenu", userMenu);
			req.getSession().setAttribute("role", role);
		}
	}

	@Override
	public JSONObject selectUser(Page page, User user) {
		Example example=new Example(User.class);
		Criteria cri=example.createCriteria();
		if(StringUtil.isNotEmpty(user.getUsername())){
			cri.andLike("username", "%"+user.getUsername()+"%");
		}
		int count=userDao.selectCountByExample(example);
		PaginationResult<User>  pagUser=	super.selectPageByExample(page.getPage(), page.getRows(), example);
		JSONObject json=new JSONObject();
		json.put("rows", pagUser.getRows());
		json.put("total", count);
		return json;
	}

	@Override
	public void addUser(User user) {
		if(user ==null){
			throw new SystemException("请填写用户信息");
		}
		if( StringUtil.isEmpty(user.getUsername())){
			throw new SystemException("用户名称不能为空");
		}
		if( StringUtil.isEmpty(user.getPassword())){
			throw new SystemException("密码不能为空");
		}
	 if(selectOneUser(user.getUsername())){
		 throw new SystemException("用户名"+user.getUsername()+"已经存在");
	 }
		userDao.insertSelective(user);
		
	}

	public  Boolean selectOneUser(String username){
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("username", username);
		List<User> lists=userDao.selectByExample(example);
		if(lists !=null  && lists.size()>0){
			return true;
		}else{
			return  false;
		}
	}
	
/*	@Override
	public void deleteUser(String  ids) {
	  if(ids.contains(",")){
		  ids.substring(0, ids.length()-1);
	  }
	  String[]  strs=ids.split(",");
	  for(String sid:strs){
		  userDao.deleteByPrimaryKey(Long.valueOf(sid));
	  }
		
	}*/
	
	@Override
	public void deleteUser(String  ids) {
		String[] strs=ids.split(",");
		 for(String sid:strs){
			  userDao.deleteByPrimaryKey(Long.valueOf(sid));
		  }
		
	}
	
	@Override
	public void editUser(User user) {
 		if(isExist(user.getUsername(),user.getId())){
			throw new SystemException("用户名"+user.getUsername()+"存在");
		}
		userDao.updateByPrimaryKeySelective(user);
		
	}
	private boolean isExist(String username,Long id){
		Boolean flag=true;
		Example example =new Example(User.class);
		Criteria cri=example.createCriteria();
		cri.andEqualTo("username", username);
		List<User> user = userDao.selectByExample(example);
		if(user == null){//不存在
			return !flag;
		}
		if(user !=null && user.size()>0){
			if(user.get(0).getId().longValue() == id.longValue()){
				return flag;
			}
		}
		return  !flag;
	}

	@Override
	public void modifPassWord(User user) {
	 userDao.updateByPrimaryKeySelective(user);
	}

}
