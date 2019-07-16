package com.gojava.common;

public enum ResponseStatusEnum {
	 SUCCESS(200, "成功"),
	    FAIL(101, "失败"),
	    RUNTIME(501, "RuntimeException"),
	    CHECKED(502, "CheckedException"),
	    NOT_LOGGED(503, "会话超时或未登录"),
	    REPEAT_LOGGED(504, "重复登录");

	    public Integer code;
	    public String msg;

	    private ResponseStatusEnum(Integer code, String msg) {
	        this.code = code;
	        this.msg = msg;
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
}
