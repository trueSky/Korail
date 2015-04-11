package com.koRail.member.to;

import com.koRail.common.to.CommonBean;

/*포안트*/
public class PintBean extends CommonBean {
	private String pintCpde;	/*포인트코드*/
	private String id;			/*아이디*/
	private String tdyPint;		/*현재포인트*/
	private String allUsePint;	/*총 사용포인트*/
	private String usePint;		/*사용포인트*/
	private String svPint;		/*적립포인트*/
	private String useHistry;	/*사용내역*/
	private String setleAmount;	/*결제금액*/
	private String useDe;		/*사용일자*/
	
	public String getPintCpde() {
		return pintCpde;
	}
	public void setPintCpde(String pintCpde) {
		this.pintCpde = pintCpde;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTdyPint() {
		return tdyPint;
	}
	public void setTdyPint(String tdyPint) {
		this.tdyPint = tdyPint;
	}
	public String getAllUsePint() {
		return allUsePint;
	}
	public void setAllUsePint(String allUsePint) {
		this.allUsePint = allUsePint;
	}
	public String getUsePint() {
		return usePint;
	}
	public void setUsePint(String usePint) {
		this.usePint = usePint;
	}
	public String getSvPint() {
		return svPint;
	}
	public void setSvPint(String svPint) {
		this.svPint = svPint;
	}
	public String getUseHistry() {
		return useHistry;
	}
	public void setUseHistry(String useHistry) {
		this.useHistry = useHistry;
	}
	public String getSetleAmount() {
		return setleAmount;
	}
	public void setSetleAmount(String setleAmount) {
		this.setleAmount = setleAmount;
	}
	public String getUseDe() {
		return useDe;
	}
	public void setUseDe(String useDe) {
		this.useDe = useDe;
	}
}
