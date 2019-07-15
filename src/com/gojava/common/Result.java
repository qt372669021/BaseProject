package com.gojava.common;


public class Result {

	private Integer code; // 状态码
	private String msg; // 提示信息
	private Object obj; // 返回的封装对象
	
	
public Result(){
		
	}
	

	public static Result ok() {
		return new Result(200);
	}
	
	public static Result error() {
        return new Result(101);
    }
	
	public static Result error(String msg) {
        return new Result(101, msg);
    }

	public static Result ok(Object obj) {
		return new Result(200, obj);
	}

	public Result(Integer code) {
		super();
		this.code = code;
	}

	public Result(Integer code, Object obj) {
		super();
		this.code = code;
		this.obj = obj;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
}
