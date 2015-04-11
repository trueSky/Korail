package com.koRail.member.to;

import com.koRail.common.to.CommonBean;

/* 예약된 좌석 */
public class SeatNoInfoBean extends CommonBean {
	private String room;	/* 호실 */
	private String seatNo;	/* 좌석번호 */
	
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
}
