package com.koRail.member.to;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.common.to.DetailResveBean;

/* 예약 */
public class ResveBean extends CommonBean {
	private String resveCode;						/* 예약코드 */
	private String id;								/* 아이디 */
	private String opratCode;						/* 운행코드 */
	private String routeType;						/* 여정경로 */
	private String resveCo;							/* 예약매수 */
	private String allRcptAmount;					/* 총 영수금액 */
	
	private List<DetailResveBean> detailResveList;	/* 상세예약 리스트 */
	
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
	public String getrouteType() {
		return routeType;
	}
	public void setrouteType(String routeType) {
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
	public List<DetailResveBean> getDetailResveList() {
		return detailResveList;
	}
	public void setDetailResveList(List<DetailResveBean> detailResveList) {
		this.detailResveList = detailResveList;
	}
}
