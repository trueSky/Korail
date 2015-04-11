package com.koRail.member.to;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.common.to.DetailResveBean;

/* 예약 */
public class ResveBean extends CommonBean {
	private String resveCode;		/* 예약코드 */
	private String id;				/* 아이디 */
	private String opratCode;		/* 운행코드 */
	private String routeType;		/* 여정경로 */
	private String resveCo;			/* 예약매수 */
	private String allFrAmount;		/* 총 운임금액 */
	private String allDscntAmount;	/* 총 할인금액 */
	private String allRcptAmount;	/* 총 영수금액 */
	private String trainNo;			/* 열차번호 */			
	private String trainKnd;		/* 열차종류 */
	private String startStatn;		/* 출발역 */
	private String startTm;			/* 출발시각 */
	private String arvlStatn;		/* 도착역 */
	private String arvlTm;			/* 도착시각 */
	
	private List<DetailResveBean> detailResveList;

	public String getResveCode() {
		return resveCode;
	}

	public void setResveCode(String resveCode) {
		this.resveCode = resveCode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOpratCode() {
		return opratCode;
	}

	public void setOpratCode(String opratCode) {
		this.opratCode = opratCode;
	}

	public String getRouteType() {
		return routeType;
	}

	public void setRouteType(String routeType) {
		this.routeType = routeType;
	}

	public String getResveCo() {
		return resveCo;
	}

	public void setResveCo(String resveCo) {
		this.resveCo = resveCo;
	}

	public String getAllRcptAmount() {
		return allRcptAmount;
	}

	public void setAllRcptAmount(String allRcptAmount) {
		this.allRcptAmount = allRcptAmount;
	}

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

	public List<DetailResveBean> getDetailResveList() {
		return detailResveList;
	}

	public void setDetailResveList(List<DetailResveBean> detailResveList) {
		this.detailResveList = detailResveList;
	}

	public String getAllFrAmount() {
		return allFrAmount;
	}

	public void setAllFrAmount(String allFrAmount) {
		this.allFrAmount = allFrAmount;
	}

	public String getAllDscntAmount() {
		return allDscntAmount;
	}

	public void setAllDscntAmount(String allDscntAmount) {
		this.allDscntAmount = allDscntAmount;
	}
}