package com.gojava.service.sy.impl;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

import com.github.pagehelper.util.StringUtil;
import com.gojava.common.BaseServiceImpl;
import com.gojava.common.SystemException;
import com.gojava.dao.sy.UserDao;
import com.gojava.entity.sy.User;
import com.gojava.service.sy.UserService;
@Service
public class UserServiceImpl extends BaseServiceImpl<User,Serializable>implements UserService{
	@Autowired
	private UserDao  userDao;
	
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
			req.getSession().setAttribute("login_user", u);
		}
	}

}
