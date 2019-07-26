package com.gojava.service.sy;

import com.alibaba.fastjson.JSONObject;
import com.gojava.entity.sy.Role;
import com.gojava.util.Page;

public interface RoleService {
	public  void  addRole(Role role);
	public  void  deleteRole(Role role);
	public  void  editRole(Role role);
	public JSONObject selectRoleList(Page page,Role role);

}
