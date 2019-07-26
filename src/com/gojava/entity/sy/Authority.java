package com.gojava.entity.sy;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

//权限
@Table(name="authority")
@Data
public class Authority {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name="roleId")
	private Long roleId;
	
	@Column(name="menuId")
	private Long menuId;

}
