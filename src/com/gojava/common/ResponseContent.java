package com.gojava.common;

public class ResponseContent {
	private String msg;// 返回给客户端(页面)的信息
	private boolean success;// 业务操作是否成功
	private String path; //导出功能返回给前台的下载文件路径

	public ResponseContent() {
		super();
	}

	public ResponseContent(String msg, boolean success) {
		super();
		this.msg = msg;
		this.success = success;
	}
	
	public ResponseContent(String msg, boolean success, String path) {
		super();
		this.msg = msg;
		this.success = success;
		this.path = path;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {//msg=http://localhost:8080/jmkx.data/resource/attachments/download/export/Materiel/admin/2018-06-21 1119466812.xls
		this.msg = msg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

}
