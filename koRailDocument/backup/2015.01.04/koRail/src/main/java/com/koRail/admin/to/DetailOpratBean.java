package com.koRail.admin.to;

import com.koRail.common.to.CommonBean;

/*상세운행*/
public class DetailOpratBean extends CommonBean {
	private String detailOpratCode;	/*상세운행코드*/
	private String opratCode;		/*운행일정코드*/
	private String startStatnCode;	/*출발역코드*/
	private String startStatnValue;	/*출발역코드 값*/
	private String arvlStatnCode;	/*도착역코드*/
	private String arvlStatnValue;	/*도착역코드 값*/
	private String startTm;			/*출발시각*/
	private String arvlTm;			/*도착시각*/
	private String prvStatnCode;	/*이전역코드*/
	private String prvStatnValue;	/*이전역코드 값*/
	private String nxtStatnCode;	/*다음역코드*/
	private String nxtStatnValue;	/*다음역코드 값*/
	private String prvDistnc;		/*이전역거리코드*/
	private String nxtDistnc;		/*다음역거리코드*/
	
	public String getDetailOpratCode() {
		return detailOpratCode;
	}
	public void setDetailOpratCode(String detailOpratCode) {
		this.detailOpratCode = detailOpratCode;
	}
	public String getOpratCode() {
		return opratCode;
	}
	public void setOpratCode(String opratCode) {
		this.opratCode = opratCode;
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
	public String getPrvStatnCode() {
		return prvStatnCode;
	}
	public void setPrvStatnCode(String prvStatnCode) {
		this.prvStatnCode = prvStatnCode;
	}
	public String getPrvStatnValue() {
		return prvStatnValue;
	}
	public void setPrvStatnValue(String prvStatnValue) {
		this.prvStatnValue = prvStatnValue;
	}
	public String getNxtStatnCode() {
		return nxtStatnCode;
	}
	public void setNxtStatnCode(String nxtStatnCode) {
		this.nxtStatnCode = nxtStatnCode;
	}
	public String getNxtStatnValue() {
		return nxtStatnValue;
	}
	public void setNxtStatnValue(String nxtStatnValue) {
		this.nxtStatnValue = nxtStatnValue;
	}
	public String getPrvDistnc() {
		return prvDistnc;
	}
	public void setPrvDistnc(String prvDistnc) {
		this.prvDistnc = prvDistnc;
	}
	public String getNxtDistnc() {
		return nxtDistnc;
	}
	public void setNxtDistnc(String nxtDistnc) {
		this.nxtDistnc = nxtDistnc;
	}
}
