package com.koRail.admin.to;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.common.to.DetailResveBean;

/* 열차별 승객 현황 */
public class TrainRcrdBean extends CommonBean {
	private String resveCode;					/* 예약코드 */
	private String register;					/* 예예약자명 */
	private String eldrlyCo;					/* 경로우대 대상자 */
	private String dspsnCo;						/* 장애인 */
	private String chldCo;						/* 어린이 수 */
private String resveCo;							/* 총 인원수 */
	private String allRcptAmount;				/* 영수금액 */
	private String setelSttus;					/* 결제상태 */
	private String usePint;						/* 사용포인트 */
	private String dscntAmount;					/* 할인금액 */
	private String setleAmount;					/* 결제금액 */
	
	private List<DetailResveBean> seatList;		/* 좌석정보 */
	
	public String getResveCode() {
		return resveCode;
	}
	public void setResveCode(String resveCode) {
		this.resveCode = resveCode;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getEldrlyCo() {
		return eldrlyCo;
	}
	public void setEldrlyCo(String eldrlyCo) {
		this.eldrlyCo = eldrlyCo;
	}
	public String getDspsnCo() {
		return dspsnCo;
	}
	public void setDspsnCo(String dspsnCo) {
		this.dspsnCo = dspsnCo;
	}
	public String getChldCo() {
		return chldCo;
	}
	public void setChldCo(String chldCo) {
		this.chldCo = chldCo;
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
	public String getSetelSttus() {
		return setelSttus;
	}
	public void setSetelSttus(String setelSttus) {
		this.setelSttus = setelSttus;
	}
	public String getUsePint() {
		return usePint;
	}
	public void setUsePint(String usePint) {
		this.usePint = usePint;
	}
	public String getDscntAmount() {
		return dscntAmount;
	}
	public void setDscntAmount(String dscntAmount) {
		this.dscntAmount = dscntAmount;
	}
	public String getSetleAmount() {
		return setleAmount;
	}
	public void setSetleAmount(String setleAmount) {
		this.setleAmount = setleAmount;
	}
	public List<DetailResveBean> getSeatList() {
		return seatList;
	}
	public void setSeatList(List<DetailResveBean> seatList) {
		this.seatList = seatList;
	}
}