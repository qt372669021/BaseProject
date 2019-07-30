package com.gojava.service.sy.impl;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;

import com.github.pagehelper.util.StringUtil;
import com.gojava.common.BaseServiceImpl;
import com.gojava.common.exception.SystemException;
import com.gojava.dao.sy.AuthorityDao;
import com.gojava.entity.sy.Authority;
import com.gojava.service.sy.AuthorityService;
@Service
public class AuthorityServiceImpl extends BaseServiceImpl<Authority,Serializable> implements AuthorityService {

	@Autowired
	private  AuthorityDao  authorityDao;
	
	@Override
	public void add(Authority authority) {
		if(authority ==null){
			throw new SystemException("至少勾选一条权限！");
		}
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("map", authority);
		authorityDao.addAuthority(map);

	}

	@Override
	public void deleteByRoleId(Long roleId) {
		if(StringUtil.isEmpty(roleId.toString())){
			throw new SystemException("请选择删除的信息");
		}
		List<Authority> lists=selectAuthorityByRoleId(roleId);
		for(Authority  record:lists){
			authorityDao.deleteByPrimaryKey(record.getId());
		}

	}

	@Override
	public List<Authority> selectAuthorityByRoleId(Long roleId) {
		Example example=new Example(Authority.class);
		example.createCriteria().andEqualTo("roleId", roleId);
		return authorityDao.selectByExample(example);
	}

}
