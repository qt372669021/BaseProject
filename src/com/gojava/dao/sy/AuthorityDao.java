package com.gojava.dao.sy;

import java.util.Map;

import com.gojava.common.IBaseMapper;
import com.gojava.entity.sy.Authority;

public interface AuthorityDao  extends IBaseMapper<Authority>{
	public  void  addAuthority(Map<String,Object> map);
}
