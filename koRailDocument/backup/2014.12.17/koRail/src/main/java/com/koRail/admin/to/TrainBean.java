package com.koRail.admin.to;

import com.koRail.common.to.CommonBean;

/*열차*/
public class TrainBean extends CommonBean {
	private String trainCode;		/*열차코드*/
	private String trainKndCode;	/*열차종류코드*/
	private String trainKndValue;	/*열차종류 값*/
	private String trainNo;			/*열차번호*/
	
	public String getTrainCode() {
		return trainCode;
	}
	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
	}
	public String getTrainKndCode() {
		return trainKndCode;
	}
	public void setTrainKndCode(String trainKndCode) {
		this.trainKndCode = trainKndCode;
	}
	public String getTrainKndValue() {
		return trainKndValue;
	}
	public void setTrainKndValue(String trainKndValue) {
		this.trainKndValue = trainKndValue;
	}
	public String getTrainNo() {
		return trainNo;
	}
	public void setTrainNo(String trainNo) {
		this.trainNo = trainNo;
	}
}
