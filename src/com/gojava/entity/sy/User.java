package com.gojava.entity.sy;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
@Getter
@Setter
@Table(name="user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "username")
	private String username;
	
	@Column(name = "password")
	private String password;
	
	@Column(name = "roleId")
	private Long roleId;//所属角色id
	
	private  String photo;
	
	private int sex;
	
	private Integer age;
	
	private String address;
}
