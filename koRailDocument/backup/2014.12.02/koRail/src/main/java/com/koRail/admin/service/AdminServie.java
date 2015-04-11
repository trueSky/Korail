package com.koRail.admin.service;

import java.util.List;

import com.koRail.admin.to.OpratBean;
import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.common.to.CommonBean;

public interface AdminServie {
	/*************************************
	 				역 관리
	 *************************************/
	
	/******************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 ******************************/
	public List<StatnBean> getStatnList(CommonBean commonBean);
	
	/******************************
	 * 역 등록, 수정, 삭제
	 * @param statnBean
	 * @param deleteCodeArray
	 *****************************/
	public void setStatn(StatnBean statnBean, String[] deleteCodeArray);

	/*************************************
				열차 관리
	*************************************/
	
	/******************************
	* 열차 조회
	* @param commonBean
	* @return
	******************************/
	public List<TrainBean> getTrainList(CommonBean commonBean);
	
	/*******************************
	 * 열차 등록, 수정, 삭제
	 * @param trainBean
	 * @param deleteCodeArray
	 *******************************/
	public void setTrain(TrainBean trainBean, String[] deleteCodeArray);
	
	/*************************************
				운행일정 관리
	*************************************/
	
	/*******************************
	 * 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 *******************************/
	public List<OpratBean> getOpratList(CommonBean commonBean);
	
	/*********************************
	 * 운행일정 등록, 수정, 삭제
	 * @param opratBean
	 * @param deleteCodeArray
	 ********************************/
	public void setOprat(OpratBean opratBean, String[] deleteCodeArray);
}
