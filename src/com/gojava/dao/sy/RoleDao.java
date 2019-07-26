package com.gojava.dao.sy;

import com.gojava.common.IBaseMapper;
import com.gojava.entity.sy.Role;
/**
 * 什么都不用写，增删改查由底层的通用Mapper来为我们实现数据实体的增删改查 
 * 如果需要写复杂SQL，需结合XML来配合通用mapper
 */
public interface RoleDao extends IBaseMapper<Role>{


}
