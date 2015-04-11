package com.koRail.admin.to;

import com.koRail.common.to.CommonBean;

/*역*/
public class StatnBean extends CommonBean {
	private String statnCode;	/*역 코드*/
	private String areaCode;	/*지역 코드*/
	private String areaName;	/*지역 명*/
	private String statnNm;		/*역 명*/
	
	public String getStatnCode() {
		return statnCode;
	}
	public void setStatnCode(String statnCode) {
		this.statnCode = statnCode;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getStatnNm() {
		return statnNm;
	}
	public void setStatnNm(String statnNm) {
		this.statnNm = statnNm;
	}
}