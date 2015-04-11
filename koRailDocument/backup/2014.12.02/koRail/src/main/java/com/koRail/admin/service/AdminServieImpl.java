package com.koRail.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koRail.admin.dao.OpratDAO;
import com.koRail.admin.dao.StatnDAO;
import com.koRail.admin.dao.TrainDAO;
import com.koRail.admin.to.OpratBean;
import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.common.to.CommonBean;

@Service(value="adminServie")
public class AdminServieImpl implements AdminServie {
	/*역 DAO*/
	@Resource(name="statnDAO")
	private StatnDAO statnDAO;
	
	/*열차 DAO*/
	@Resource(name="trainDAO")
	private TrainDAO trainDAO;
	
	/*운행일정 DAO*/
	@Resource(name="opratDAO")
	private OpratDAO opratDAO;
	
	/*************************************
					역 관리
	 *************************************/
	
	/******************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 ******************************/
	@Override
	public List<StatnBean> getStatnList(CommonBean commonBean) {
		return statnDAO.selectStatnList(commonBean);
	}

	/******************************
	 * 역 등록, 수정, 삭제
	 * @param statnBean
	 * @param deleteCodeArray
	 *****************************/
	@Override
	public void setStatn(StatnBean statnBean, String[] deleteCodeArray) {
		/*등록*/
		if("insert".equals(statnBean.getState())){
			statnDAO.insertStatn(statnBean);
		}
		/*수정*/
		else if("update".equals(statnBean.getState())){
			statnDAO.updateStatn(statnBean);
		}
		/*삭제*/
		else{
			for(String statnCode : deleteCodeArray){
				statnDAO.deleteStatn(statnCode);
			}
		}
	}
	
	/*************************************
					열차 관리
	*************************************/
	
	/******************************
	* 열차 조회
	* @param commonBean
	* @return
	******************************/
	@Override
	public List<TrainBean> getTrainList(CommonBean commonBean) {
		return trainDAO.selectTrainList(commonBean);
	}

	/*******************************
	 * 열차 등록, 수정, 삭제
	 * @param trainBean
	 * @param deleteCodeArray
	 *******************************/
	@Override
	public void setTrain(TrainBean trainBean, String[] deleteCodeArray) {
		/*등록*/
		if("insert".equals(trainBean.getState())){
			trainDAO.insertTrain(trainBean);
		}
		/*수정*/
		else if("update".equals(trainBean.getState())){
			trainDAO.updateTrain(trainBean);
		}
		/*삭제*/
		else{
			for(String trainCode : deleteCodeArray){
				trainDAO.deleteTrain(trainCode);
			}
		}
	}
	
	/*************************************
				운행일정 관리
	*************************************/
	
	/*******************************
	 * 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 *******************************/
	public List<OpratBean> getOpratList(CommonBean commonBean){
		/*수정화면*/
		if("update".equals(commonBean.getFormType())){
			return opratDAO.selectAllOpratList(commonBean);
		}
		/*조회화면*/
		else{			
			return opratDAO.selectOpratList(commonBean);
		}
	}
	
	/*********************************
	* 운행일정 등록, 수정, 삭제
	* @param opratBean
	* @param deleteCodeArray
	********************************/
	public void setOprat(OpratBean opratBean, String[] deleteCodeArray){
		if("inser".equals(opratBean.getState())){
			System.out.println("i");
		}else if("update".equals(opratBean.getState())){
			opratDAO.updateOprat(opratBean);
		}else{
			System.out.println("d");
		}
	}
}
