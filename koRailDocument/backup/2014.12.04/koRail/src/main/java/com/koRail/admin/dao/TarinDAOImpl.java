package com.koRail.admin.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.common.exception.DataDeleteException;
import com.koRail.common.to.CommonBean;

@Repository(value="trainDAO")
public class TarinDAOImpl implements TrainDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**************************
	 * 열차 조회
	 * @param commonBean
	 * @return
	 *************************/
	@Override
	public List<TrainBean> selectTrainList(CommonBean commonBean){
		return (List<TrainBean>)sqlMapClientTemplate.queryForList("Train.selectTrain", commonBean);
	}
	
	/******************************
	 * 열차 등록
	 * @param trainBean
	 *****************************/
	@Override
	public void insertTrain(TrainBean trainBean){
		sqlMapClientTemplate.insert("Train.insertTrain", trainBean);
	}

	/**********************************
	 * 열차 수정
	 * @param trainBean
	 **********************************/
	@Override
	public void updateTrain(TrainBean trainBean){
		sqlMapClientTemplate.update("Train.updateTrain", trainBean);
	}
	
	/*****************************
	 * 열차 삭제
	 * @param trainCode
	 *****************************/
	@Override
	public void deleteTrain(String trainCode){
		sqlMapClientTemplate.delete("Train.deleteTrain", trainCode);
	}
}
