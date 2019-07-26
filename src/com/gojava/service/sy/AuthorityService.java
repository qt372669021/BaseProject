package com.gojava.service.sy;

import java.util.List;

import com.gojava.entity.sy.Authority;


public interface AuthorityService {
	public void add(Authority authority);
	public void deleteByRoleId(Long roleId);
	public List<Authority> findListByRoleId(Long roleId);
}
