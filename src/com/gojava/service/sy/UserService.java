package com.gojava.service.sy;

import javax.servlet.http.HttpServletRequest;

import com.gojava.entity.sy.User;

public interface  UserService   {
	  public void selectLogin(User user, String cpacha,HttpServletRequest request);
}
