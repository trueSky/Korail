package com.koRail.member.to;

import com.koRail.common.to.CommonBean;

/*승차권 상세현황에 대한 좌석정보*/
public class DetailTcktRcrdBean2 extends CommonBean {
	private String trainNo;		/*열차번호*/
	private String trainKnd;	/*열차종류*/
	private String startStatn;	/*출발역*/
	private String startTm;		/*출발시각*/
	private String arvlStatn;	/*도착역*/
	private String arvlTm;		/*도착시각*/
	private String roomKnd;		/*객실유형*/
	private String room;		/*호실*/
	private String psngrKnd;	/*승객유형 : 장애인(급수), 일반, 경로, 어린이*/
	private String psngrNm;		/*승차자명*/
	private String seatNo;		/*좌석번호*/
	private String frAmount;	/*운임금액*/
	private String dscntAmount;	/*할인금액*/
	private String rcptAmount;	/*영수금액*/
	
	public String getTrainNo() {
		return trainNo;
	}
	public void setTrainNo(String trainNo) {
		this.trainNo = trainNo;
	}
	public String getTrainKnd() {
		return trainKnd;
	}
	public void setTrainKnd(String trainKnd) {
		this.trainKnd = trainKnd;
	}
	public String getStartStatn() {
		return startStatn;
	}
	public void setStartStatn(String startStatn) {
		this.startStatn = startStatn;
	}
	public String getStartTm() {
		return startTm;
	}
	public void setStartTm(String startTm) {
		this.startTm = startTm;
	}
	public String getArvlStatn() {
		return arvlStatn;
	}
	public void setArvlStatn(String arvlStatn) {
		this.arvlStatn = arvlStatn;
	}
	public String getArvlTm() {
		return arvlTm;
	}
	public void setArvlTm(String arvlTm) {
		this.arvlTm = arvlTm;
	}
	public String getRoomKnd() {
		return roomKnd;
	}
	public void setRoomKnd(String roomKnd) {
		this.roomKnd = roomKnd;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getPsngrNm() {
		return psngrNm;
	}
	public void setPsngrNm(String psngrNm) {
		this.psngrNm = psngrNm;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public String getFrAmount() {
		return frAmount;
	}
	public void setFrAmount(String frAmount) {
		this.frAmount = frAmount;
	}
	public String getDscntAmount() {
		return dscntAmount;
	}
	public void setDscntAmount(String dscntAmount) {
		this.dscntAmount = dscntAmount;
	}
	public String getRcptAmount() {
		return rcptAmount;
	}
	public void setRcptAmount(String rcptAmount) {
		this.rcptAmount = rcptAmount;
	}
	public String getPsngrKnd() {
		return psngrKnd;
	}
	public void setPsngrKnd(String psngrKnd) {
		this.psngrKnd = psngrKnd;
	}
}
