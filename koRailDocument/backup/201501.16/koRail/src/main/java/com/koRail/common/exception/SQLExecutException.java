package com.koRail.common.exception;

/*******************************************
 * SQL 실행중 발생한 에러메세지 출력
 * @author Administrator
 *******************************************/
public class SQLExecutException extends Exception {
	private static final long serialVersionUID = 1L;

	private String msg = null; /* 메세지 */
	
	/***********************
	 * 메세지를 입력받음
	 * @param msg
	 **********************/
	public SQLExecutException(String msg){
		this.msg = msg;
	}
	
	/************************
	 * 메세지 return
	 * @return
	 ************************/
	public String getMessage(){
		return msg;
	}
}
