package com.koRail.admin.dao;

import java.util.List;

import com.koRail.admin.to.TrainBean;
import com.koRail.common.to.CommonBean;

public interface TrainDAO {
	/**************************
	 * 열차 조회
	 * @param commonBean
	 * @return
	 *************************/
	public List<TrainBean> selectTrainList(CommonBean commonBean);
	
	/******************************
	 * 열차 등록
	 * @param trainBean
	 *****************************/
	public void insertTrain(TrainBean trainBean);

	/**********************************
	 * 열차 수정
	 * @param trainBean
	 **********************************/
	public void updateTrain(TrainBean trainBean);
	
	/*****************************
	 * 열차 삭제
	 * @param trainCode
	 *****************************/
	public void deleteTrain(String trainCode);
}
