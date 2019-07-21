package com.gojava.dao.sy;

import java.util.List;
import java.util.Map;

import com.gojava.common.IBaseMapper;
import com.gojava.entity.sy.Menu;

public interface MenuDao extends IBaseMapper<Menu> {
	public List<Menu> findList(Map<String, Object> queryMap);
	public int getTotal(Map<String, Object> queryMap);
	public void add(Map<String,Object> map);
	public  List<Menu> selectTopMenu();
}
