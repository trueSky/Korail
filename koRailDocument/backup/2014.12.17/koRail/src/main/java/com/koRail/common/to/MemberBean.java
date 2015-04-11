package com.koRail.common.to;

/* 회원 */
public class MemberBean extends CommonBean {
	private String id;			/* 아이디 */
	private String password;	/* 비밀번호 */
	private String nm;			/* 성명 */
	private String zipCode;		/* 우편번호 */
	private String addrs;		/* 주소 */
	private String detailAddrs; /* 상세주소 */
	private String telNo;		/* 전화번호 */
	private String mbtlnum;		/* 휴대전화번호 */
	private String emal;		/* 이메일 */
	private String gndr;		/* 성별 */
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddrs() {
		return addrs;
	}
	public void setAddrs(String addrs) {
		this.addrs = addrs;
	}
	public String getDetailAddrs() {
		return detailAddrs;
	}
	public void setDetailAddrs(String detailAddrs) {
		this.detailAddrs = detailAddrs;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getMbtlnum() {
		return mbtlnum;
	}
	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}
	public String getEmal() {
		return emal;
	}
	public void setEmal(String emal) {
		this.emal = emal;
	}
	public String getGndr() {
		return gndr;
	}
	public void setGndr(String gndr) {
		this.gndr = gndr;
	}
}
