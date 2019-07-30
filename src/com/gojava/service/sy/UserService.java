package com.gojava.service.sy;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.gojava.entity.sy.User;
import com.gojava.util.Page;

public interface  UserService   {
	  public void selectLogin(User user, String cpacha,HttpServletRequest request);
	  public JSONObject  selectUser(Page page, User user);
	  public void  addUser (User user);
	  public void  deleteUser (Long id);
	  public void  editUser (User user);
}
