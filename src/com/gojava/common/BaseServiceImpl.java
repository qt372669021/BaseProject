package com.gojava.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tk.mybatis.mapper.entity.Example;

import com.github.pagehelper.PageHelper;


@Service
public abstract class BaseServiceImpl<T, PK extends Serializable> {

    @Autowired
    private IBaseMapper<T> mapper;

    public int insert(T record) {
        return mapper.insert(record);
    }

    public int insertSelective(T record) {
        return mapper.insertSelective(record);
    }

    public int insertList(List<T> records) {
        return mapper.insertList(records);
    }

    public int deleteByPrimaryKey(PK entityId) {
        return mapper.deleteByPrimaryKey(entityId);
    }

    public int updateByPrimaryKeySelective(T record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    public int updateByPrimaryKey(T record) {
        return mapper.updateByPrimaryKey(record);
    }

    public T selectByPrimaryKey(Serializable entityId) {
        return mapper.selectByPrimaryKey(entityId);
    }

    public T selectOne(T record) {
        return mapper.selectOne(record);
    }

    public T selectOne(Example example) {
        List<T> list = selectByExample(example);
        if (list == null || list.size() == 0) {
            return null;
        } else if (list.size() > 1) {
            throw new SystemException("查询存在多条记录");
        }
        return list.get(0);
    }

    public List<T> selectByExample(Example example) {
        return mapper.selectByExample(example);
    }

    public PaginationResult<T> selectPageByExample(int page, int rows, Example example) {
        List<T> data = new ArrayList<T>();
        Integer total = mapper.selectCountByExample(example);
        if (total > 0) {
            PageHelper.startPage(page, rows);
            data = mapper.selectByExample(example);
        }
        return new PaginationResult<T>(total, data);
    }

}
