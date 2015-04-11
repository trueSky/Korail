package com.koRail.common.to;

/*주소*/
public class AddrBean extends CommonBean {
	private String zipCode;		/*우편번호*/
	private String sNumber;		/*일련번호*/
	private String cDate;		/*변경일*/
	private String sd;			/*시 / 도*/
	private String sgg;			/*시 / 군 / 구*/
	private String umd;			/*읍 / 면 / 동*/
	private String ri;			/*리*/
	private String ds;			/*도서*/
	private String bg; 			/*번지*/
	private String ap; 			/*아파트 / 건물명*/
	private String addr; 		/*주소*/
	
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getsNumber() {
		return sNumber;
	}
	public void setsNumber(String sNumber) {
		this.sNumber = sNumber;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	public String getSd() {
		return sd;
	}
	public void setSd(String sd) {
		this.sd = sd;
	}
	public String getSgg() {
		return sgg;
	}
	public void setSgg(String sgg) {
		this.sgg = sgg;
	}
	public String getUmd() {
		return umd;
	}
	public void setUmd(String umd) {
		this.umd = umd;
	}
	public String getRi() {
		return ri;
	}
	public void setRi(String ri) {
		this.ri = ri;
	}
	public String getDs() {
		return ds;
	}
	public void setDs(String ds) {
		this.ds = ds;
	}
	public String getBg() {
		return bg;
	}
	public void setBg(String bg) {
		this.bg = bg;
	}
	public String getAp() {
		return ap;
	}
	public void setAp(String ap) {
		this.ap = ap;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
}
