package com.koRail.admin.to;

import com.koRail.common.to.CommonBean;

/*호실*/
public class RoomBean extends CommonBean {
	private String roomCode;		/*호실코드*/
	private String opratCode;		/*운행코드*/
	private String room;			/*호실*/
	private String seatCo;			/*좌석수*/
	private String prtclrRoomYN;	/*특실여부 : Y, N*/
	
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getOpratCode() {
		return opratCode;
	}
	public void setOpratCode(String opratCode) {
		this.opratCode = opratCode;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getSeatCo() {
		return seatCo;
	}
	public void setSeatCo(String seatCo) {
		this.seatCo = seatCo;
	}
	public String getPrtclrRoomYN() {
		return prtclrRoomYN;
	}
	public void setPrtclrRoomYN(String prtclrRoomYN) {
		this.prtclrRoomYN = prtclrRoomYN;
	}
}