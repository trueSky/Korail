package com.koRail.member.to;

import java.util.List;

import com.koRail.common.to.CommonBean;

/*승차권 상세현황*/
public class DetailTcktRcrdBean1 extends CommonBean {
	private String id;								/*아이디*/
	private String rgsde;							/*결제일*/
	private String resveCo;							/*예약매수*/
	private String frAmount;						/*운임금액*/
	private String usePint;							/*사용포인트*/
	private String dscntAmount;						/*할인금액*/
	private String setleAmount;						/*결제금액*/
	
	private List<DetailTcktRcrdBean2> seatInList;	/*좌석정보*/

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRgsde() {
		return rgsde;
	}

	public void setRgsde(String rgsde) {
		this.rgsde = rgsde;
	}

	public String getResveCo() {
		return resveCo;
	}

	public void setResveCo(String resveCo) {
		this.resveCo = resveCo;
	}

	public String getFrAmount() {
		return frAmount;
	}

	public void setFrAmount(String frAmount) {
		this.frAmount = frAmount;
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

	public List<DetailTcktRcrdBean2> getSeatInList() {
		return seatInList;
	}

	public void setSeatInList(List<DetailTcktRcrdBean2> seatInList) {
		this.seatInList = seatInList;
	}
}
