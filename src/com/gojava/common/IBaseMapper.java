package com.gojava.common;

import tk.mybatis.mapper.common.BaseMapper;
import tk.mybatis.mapper.common.ConditionMapper;
import tk.mybatis.mapper.common.ExampleMapper;
import tk.mybatis.mapper.common.MySqlMapper;
import tk.mybatis.mapper.common.RowBoundsMapper;



public interface IBaseMapper <T> extends 
								BaseMapper<T>, 
								ExampleMapper<T>, 
								ConditionMapper<T>, 
								RowBoundsMapper<T>,
								MySqlMapper<T> {

}
