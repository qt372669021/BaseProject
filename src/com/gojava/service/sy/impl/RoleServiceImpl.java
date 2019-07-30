package com.gojava.service.sy.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.util.StringUtil;
import com.gojava.common.BaseServiceImpl;
import com.gojava.common.PaginationResult;
import com.gojava.common.exception.SystemException;
import com.gojava.dao.sy.RoleDao;
import com.gojava.entity.sy.Role;
import com.gojava.service.sy.RoleService;
import com.gojava.util.Page;
@Service
public class RoleServiceImpl  extends BaseServiceImpl<Role,Serializable> implements RoleService {
	
	@Autowired
	private  RoleDao  roleDao;

	@Override
	public void addRole(Role role) {
		if(role ==null){
			throw new SystemException("填写信息");
		}
		roleDao.insertSelective(role);
	}

	@Override
	public void deleteRole(Role role) {
		if(role ==null){
			throw new  SystemException("选择删除的信息");
		}
		roleDao.deleteByPrimaryKey(role.getId());

	}

	@Override
	public void editRole(Role role) {
		if(role ==null){
			throw new  SystemException("填写信息");
		}
		roleDao.updateByPrimaryKeySelective(role);
	}

	@Override
	public JSONObject selectRoleList(Page page, Role role) {
		Example example=new Example(Role.class);
		Criteria cri=example.createCriteria();
		if(!StringUtil.isEmpty(role.getName())){
			cri.andLike("name", "%"+role.getName()+"%");
		}
		int count=roleDao.selectCountByExample(example);
		PaginationResult<Role>  result=super.selectPageByExample(page.getPage(), page.getRows(), example);
		JSONObject obj=new JSONObject();
		obj.put("total", count);
		obj.put("rows", result.getRows());
		return obj;
	}

	@Override
	public List<Role> selectRoleList() {
		return roleDao.selectAll();
	}

}
