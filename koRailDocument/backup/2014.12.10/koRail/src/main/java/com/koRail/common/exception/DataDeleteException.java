package com.koRail.common.exception;

/*******************************************
 * 데이터 삭제 중 FK 무결성 제약조건 위배 시 발생
 * @author Administrator
 *******************************************/
public class DataDeleteException extends Exception {
	private static final long serialVersionUID = 1L;

	private String msg = null; /* 메세지 */
	
	/***********************
	 * 메세지를 입력받음
	 * @param msg
	 **********************/
	public DataDeleteException(String msg){
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
