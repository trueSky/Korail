package com.koRail.admin.to;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.common.to.RoomBean;

/*운행일정*/
public class OpratBean extends CommonBean {
	private String opratCode;						/*운행일정코드*/
	private String trainCode;						/*열차코드*/
	private String trainNo;							/*열차번호*/
	private String trainKndCode;					/*열차종류코드*/
	private String trainKndValue;					/*열차종류코드 값*/
	private String startStatnCode;					/*출발역코드*/
	private String startStatnValue;					/*출발역코드 값*/
	private String arvlStatnCode;					/*도착역코드*/
	private String arvlStatnValue;					/*도착역코드 값*/
	private String routeCode;						/*노선코드*/
	private String routeValue;						/*노선코드 값*/
	private String startTm;							/*출발시각*/
	private String arvlTm;							/*도착시각*/
	private String distnc;							/*거리*/
	private String fare;							/*요금*/
	
	private List<DetailOpratBean> detailOpratList;	/*상세운행정보*/
	private List<RoomBean> roomList;				/*호실정보*/
	

	public String getOpratCode() {
		return opratCode;
	}

	public void setOpratCode(String opratCode) {
		this.opratCode = opratCode;
	}

	public String getTrainCode() {
		return trainCode;
	}

	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
	}

	public String getTrainNo() {
		return trainNo;
	}

	public void setTrainNo(String trainNo) {
		this.trainNo = trainNo;
	}

	public String getTrainKndCode() {
		return trainKndCode;
	}

	public void setTrainKndCode(String trainKndCode) {
		this.trainKndCode = trainKndCode;
	}

	public String getTrainKndValue() {
		return trainKndValue;
	}

	public void setTrainKndValue(String trainKndValue) {
		this.trainKndValue = trainKndValue;
	}

	public String getStartStatnCode() {
		return startStatnCode;
	}

	public void setStartStatnCode(String startStatnCode) {
		this.startStatnCode = startStatnCode;
	}

	public String getStartStatnValue() {
		return startStatnValue;
	}

	public void setStartStatnValue(String startStatnValue) {
		this.startStatnValue = startStatnValue;
	}

	public String getArvlStatnCode() {
		return arvlStatnCode;
	}

	public void setArvlStatnCode(String arvlStatnCode) {
		this.arvlStatnCode = arvlStatnCode;
	}

	public String getArvlStatnValue() {
		return arvlStatnValue;
	}

	public void setArvlStatnValue(String arvlStatnValue) {
		this.arvlStatnValue = arvlStatnValue;
	}

	public String getRouteCode() {
		return routeCode;
	}

	public void setRouteCode(String routeCode) {
		this.routeCode = routeCode;
	}

	public String getRouteValue() {
		return routeValue;
	}

	public void setRouteValue(String routeValue) {
		this.routeValue = routeValue;
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

	public String getDistnc() {
		return distnc;
	}

	public void setDistnc(String distnc) {
		this.distnc = distnc;
	}

	public String getFare() {
		return fare;
	}

	public void setFare(String fare) {
		this.fare = fare;
	}

	public List<DetailOpratBean> getDetailOpratList() {
		return detailOpratList;
	}

	public void setDetailOpratList(List<DetailOpratBean> detailOpratList) {
		this.detailOpratList = detailOpratList;
	}

	public List<RoomBean> getRoomList() {
		return roomList;
	}

	public void setRoomList(List<RoomBean> roomList) {
		this.roomList = roomList;
	}
}
