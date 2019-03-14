package com.edu.backstage.pojo;

public class ResultVO {
	
	private Integer total; 
	private Object rows;
	private String msg; //提示信息
	
	
	
	public ResultVO(Integer total, Object rows, String msg) {
		super();
		this.total = total;
		this.rows = rows;
		this.msg = msg;
	}
	
	public ResultVO() {
		super();
	}

	
	public ResultVO(String msg) {
		super();
		this.msg = msg;
	}

	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Object getRows() {
		return rows;
	}
	public void setRows(Object rows) {
		this.rows = rows;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	@Override
	public String toString() {
		return "ResultVO [total=" + total + ", rows=" + rows + ", msg=" + msg + "]";
	}
	
}
