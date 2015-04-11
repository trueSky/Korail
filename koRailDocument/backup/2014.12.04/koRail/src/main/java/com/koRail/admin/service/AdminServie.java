package com.koRail.admin.service;

import java.util.List;

import com.koRail.admin.to.OpratBean;
import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.common.exception.DataDeleteException;
import com.koRail.common.to.CommonBean;

public interface AdminServie {
	/*************************************
	 				역 관리
	 *************************************/
	
	/********************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 ********************************/
	public List<StatnBean> getStatnList(CommonBean commonBean);
	
	/********************************
	 * 역 등록, 수정, 삭제
	 * @param statnBean
	 * @param deleteCodeArray
	 * @throws DataDeleteException
	 *******************************/
	public void setStatn(StatnBean statnBean, String[] deleteCodeArray) throws DataDeleteException;

	/*************************************
				열차 관리
	*************************************/
	
	/****************************
	 * 열차 조회
	 * @param commonBean
	 * @return
	 ***************************/
	public List<TrainBean> getTrainList(CommonBean commonBean);
	
	/*********************************
	 * 열차 등록, 수정, 삭제
	 * @param trainBean
	 * @param deleteCodeArray
	 * @throws DataDeleteException
	 ********************************/
	public void setTrain(TrainBean trainBean, String[] deleteCodeArray) throws DataDeleteException;
	
	/*************************************
				운행일정 관리
	*************************************/
	
	/*********************************
	 * 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 *********************************/
	public List<OpratBean> getOpratList(CommonBean commonBean);
	
	/*************************************
	 * 운행일정 등록, 수정, 삭제
	 * 상세운행 등록, 삭제
	 * 호실	 등록,삭제
	 * @param opratBean
	 * @param json
	 * @param deleteCodeArray
	 * @throws DataDeleteException
	 ************************************/
	public void setOprat(OpratBean opratBean, String[] json, String[] deleteCodeArray) throws DataDeleteException;
}
