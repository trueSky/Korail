package com.koRail.common.to;

import com.koRail.common.to.CommonBean;

/* 상세예약 */
public class DetailResveBean extends CommonBean {
	private String detailResveCode;	/* 상세예약코드 */
	private String resveCode;		/* 예약코드 */
	private String psngrNm;			/* 승차자명 */
	private String roomKndCode;		/* 호실유형코드 */
	private String roomKndValue;	/* 호실유형 값: 특실, 일반실 */
	private String seatNo;			/* 좌석번호 */
	private String psngrKndCode;	/* 승객유형코드 */
	private String psngrKndValue;	/* 승객유형 값: 일반, 어린이, 경로, 장애인 */
	private String dspsnGradCode;	/* 장애인 등급코드 */
	private String dspsnGradValue;	/* 장애인 등급 값: 1~3, 4~6 */
	private String room;			/* 호실 */
	private String frAmount;		/* 운임금액 */
	private String dscntAmount;		/* 할인금액 */
	private String rcptAmount;		/* 영수금액 */
	
	public String getDetailResveCode() {
		return detailResveCode;
	}
	public void setDetailResveCode(String detailResveCode) {
		this.detailResveCode = detailResveCode;
	}
	public String getResveCode() {
		return resveCode;
	}
	public void setResveCode(String resveCode) {
		this.resveCode = resveCode;
	}
	public String getPsngrNm() {
		return psngrNm;
	}
	public void setPsngrNm(String psngrNm) {
		this.psngrNm = psngrNm;
	}
	public String getRoomKndCode() {
		return roomKndCode;
	}
	public void setRoomKndCode(String roomKndCode) {
		this.roomKndCode = roomKndCode;
	}
	public String getRoomKndValue() {
		return roomKndValue;
	}
	public void setRoomKndValue(String roomKndValue) {
		this.roomKndValue = roomKndValue;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public String getPsngrKndCode() {
		return psngrKndCode;
	}
	public void setPsngrKndCode(String psngrKndCode) {
		this.psngrKndCode = psngrKndCode;
	}
	public String getPsngrKndValue() {
		return psngrKndValue;
	}
	public void setPsngrKndValue(String psngrKndValue) {
		this.psngrKndValue = psngrKndValue;
	}
	public String getDspsnGradCode() {
		return dspsnGradCode;
	}
	public void setDspsnGradCode(String dspsnGradCode) {
		this.dspsnGradCode = dspsnGradCode;
	}
	public String getDspsnGradValue() {
		return dspsnGradValue;
	}
	public void setDspsnGradValue(String dspsnGradValue) {
		this.dspsnGradValue = dspsnGradValue;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
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
}
