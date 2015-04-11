package com.koRail.member.to;

/*승차권 예매 현황*/
public class ResveRcrdBean {
	private String resveCode;		/* 예약코드 */
	private String trainNo;			/* 열차번호 */			
	private String trainKnd;		/* 열차종류 */
	private String startStatn;		/* 출발역 */
	private String startTm;			/* 출발시각 */
	private String arvlStatn;		/* 도착역 */
	private String arvlTm;			/* 도착시각 */
	private String resveCo;			/* 예약매수 */
	private String setleSttusCode;	/* 결제상태 코드 */
	private String setleSttusValue;	/* 결제상태 값 */
	private String setleAmount;		/* 결제금액 */
	
	public String getResveCode() {
		return resveCode;
	}
	public void setResveCode(String resveCode) {
		this.resveCode = resveCode;
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
	public String getResveCo() {
		return resveCo;
	}
	public void setResveCo(String resveCo) {
		this.resveCo = resveCo;
	}
	public String getSetleSttusCode() {
		return setleSttusCode;
	}
	public void setSetleSttusCode(String setleSttusCode) {
		this.setleSttusCode = setleSttusCode;
	}
	public String getSetleSttusValue() {
		return setleSttusValue;
	}
	public void setSetleSttusValue(String setleSttusValue) {
		this.setleSttusValue = setleSttusValue;
	}
	public String getSetleAmount() {
		return setleAmount;
	}
	public void setSetleAmount(String setleAmount) {
		this.setleAmount = setleAmount;
	}
}
