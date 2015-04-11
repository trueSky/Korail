package com.koRail.admin.to;

import com.koRail.common.to.CommonBean;

/* 승차권 발권 현황 */
public class TcktRcrdBean extends CommonBean {
	private String opratCode;		/* 운행코드 */
	private String tcktTm;			/* 승차일자 */
	private String trainNo;			/* 열차번호 */
	private String trainKndCode;	/* 열차종류 코드 */
	private String trainKndValue;	/* 열차종류 값 */
	private String startStatnValue;	/* 출발역 값 */
	private String arvlStatnValue;	/* 도착역 값 */
	private String startTm;			/* 출발시각 */
	private String arvlTm;			/* 도착시각 */
	private String prtclrSeatYCo;	/* 특실 좌석수 */
	private String prtclrRoomYCo;	/* 예약된 특실 좌석수 */
	private String prtclrSeatNCo;	/* 일반실 좌석수 */
	private String prtclrRoomNCo;	/* 예약된 일반실 좌석수 */
	
	public String getOpratCode() {
		return opratCode;
	}
	public void setOpratCode(String opratCode) {
		this.opratCode = opratCode;
	}
	public String getTcktTm() {
		return tcktTm;
	}
	public void setTcktTm(String tcktTm) {
		this.tcktTm = tcktTm;
	}
	public String getTrainNo() {
		return trainNo;
	}
	public void setTrainNo(String trainNo) {
		this.trainNo = trainNo;
	}
	public String getTrainKndValue() {
		return trainKndValue;
	}
	public void setTrainKndValue(String trainKndValue) {
		this.trainKndValue = trainKndValue;
	}
	public String getStartStatnValue() {
		return startStatnValue;
	}
	public void setStartStatnValue(String startStatnValue) {
		this.startStatnValue = startStatnValue;
	}
	public String getArvlStatnValue() {
		return arvlStatnValue;
	}
	public void setArvlStatnValue(String arvlStatnValue) {
		this.arvlStatnValue = arvlStatnValue;
	}
	public String getStartTm() {
		return startTm;
	}
	public void setStartTm(String startTm) {
		this.startTm = startTm;
	}
	public String getArvlTm() {
		return arvlTm;
	}
	public void setArvlTm(String arvlTm) {
		this.arvlTm = arvlTm;
	}
	public String getPrtclrSeatYCo() {
		return prtclrSeatYCo;
	}
	public void setPrtclrSeatYCo(String prtclrSeatYCo) {
		this.prtclrSeatYCo = prtclrSeatYCo;
	}
	public String getPrtclrRoomYCo() {
		return prtclrRoomYCo;
	}
	public void setPrtclrRoomYCo(String prtclrRoomYCo) {
		this.prtclrRoomYCo = prtclrRoomYCo;
	}
	public String getPrtclrSeatNCo() {
		return prtclrSeatNCo;
	}
	public void setPrtclrSeatNCo(String prtclrSeatNCo) {
		this.prtclrSeatNCo = prtclrSeatNCo;
	}
	public String getPrtclrRoomNCo() {
		return prtclrRoomNCo;
	}
	public void setPrtclrRoomNCo(String prtclrRoomNCo) {
		this.prtclrRoomNCo = prtclrRoomNCo;
	}
	public String getTrainKndCode() {
		return trainKndCode;
	}
	public void setTrainKndCode(String trainKndCode) {
		this.trainKndCode = trainKndCode;
	}
}