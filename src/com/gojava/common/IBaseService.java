package com.gojava.common;

import java.io.Serializable;
import java.util.List;

import tk.mybatis.mapper.entity.Example;

public abstract interface IBaseService<T, PK extends Serializable> {

	public abstract int insert(T record);

	public abstract int insertSelective(T record);
	
	public abstract int insertList(List<T> records);

	public abstract int deleteByPrimaryKey(PK entityId);

	public abstract int updateByPrimaryKeySelective(T record);

	public abstract int updateByPrimaryKey(T record);

	public abstract T selectByPrimaryKey(PK entityId);

	public abstract List<T> selectByExample(Example example);
	
	public abstract List<T> selectPageByExample(int page, int rows, Example example);
	
	public abstract T selectOne(T record);
	
	public abstract T selectOne(Example example);

}
