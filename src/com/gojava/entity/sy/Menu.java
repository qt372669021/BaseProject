package com.gojava.entity.sy;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;
/**
 * 
 *Menu
 *	菜单实体类
 * 2019年7月17日上午10:30:20
 */
@Getter
@Setter
@Table(name="menu")
public class Menu {
	@Id
	private Long id;
	@Column(name="parentId")
	private Long parentId;//父类id
	
	@Transient
	private Long _parentId;//用来匹配父类id用以easuiy树形网格
	
	private String name;//菜单名称
	private String url;//点击后的url
	private String icon;//菜单icon图标
	
	
	public Long get_parentId() {
		_parentId=parentId;
		return _parentId;
	}
	public void set_parentId(Long _parentId) {
		this._parentId = _parentId;
	}

	
}
