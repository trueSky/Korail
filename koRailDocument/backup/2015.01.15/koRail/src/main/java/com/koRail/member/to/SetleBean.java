package com.koRail.member.to;

import com.koRail.common.to.CommonBean;

/*결제*/
public class SetleBean extends CommonBean {
	private String resveCode;	/*예약코드*/
	private String id;			/*아이디*/
	private String cardSe;		/*카드구분*/
	private String cardKnd;		/*카드종류*/
	private String cardNo;		/*카드번호*/
	private String valIdPd;		/*유효기간*/
	private String instlmt;		/*할부*/
	private String scrtyCadrNo;	/*보안카드번호*/
	private String ihidnum;		/*주민등록번호*/
	private String usePint;		/*사용포인트*/
	private String pintUseYN;	/*포인트사용여부*/
	private String setleSttus;	/*결제상태*/
	private String frAmount;	/*운임금액*/
	private String dscntAmount;	/*할인금액*/
	private String setleAmount;	/*결제금액*/
	
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
	public String getCardSe() {
		return cardSe;
	}
	public void setCardSe(String cardSe) {
		this.cardSe = cardSe;
	}
	public String getCardKnd() {
		return cardKnd;
	}
	public void setCardKnd(String cardKnd) {
		this.cardKnd = cardKnd;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getValIdPd() {
		return valIdPd;
	}
	public void setValIdPd(String valIdPd) {
		this.valIdPd = valIdPd;
	}
	public String getInstlmt() {
		return instlmt;
	}
	public void setInstlmt(String instlmt) {
		this.instlmt = instlmt;
	}
	public String getScrtyCadrNo() {
		return scrtyCadrNo;
	}
	public void setScrtyCadrNo(String scrtyCadrNo) {
		this.scrtyCadrNo = scrtyCadrNo;
	}
	public String getIhidnum() {
		return ihidnum;
	}
	public void setIhidnum(String ihidnum) {
		this.ihidnum = ihidnum;
	}
	public String getUsePint() {
		return usePint;
	}
	public void setUsePint(String usePint) {
		this.usePint = usePint;
	}
	public String getPintUseYN() {
		return pintUseYN;
	}
	public void setPintUseYN(String pintUseYN) {
		this.pintUseYN = pintUseYN;
	}
	public String getSetleSttus() {
		return setleSttus;
	}
	public void setSetleSttus(String setleSttus) {
		this.setleSttus = setleSttus;
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
	public String getSetleAmount() {
		return setleAmount;
	}
	public void setSetleAmount(String setleAmount) {
		this.setleAmount = setleAmount;
	}
}
