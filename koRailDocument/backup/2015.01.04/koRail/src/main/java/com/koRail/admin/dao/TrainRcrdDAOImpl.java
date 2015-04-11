package com.koRail.admin.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.TrainRcrdBean;

@Repository(value="trainRcrdDAO")
@SuppressWarnings({ "unchecked", "deprecation" })
public class TrainRcrdDAOImpl implements TrainRcrdDAO {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	/***************************
	 * 열차별 승객 현황 조회
	 * @param trainRcrdBean
	 * @return
	 ****************************/
	public List<TrainRcrdBean> selectTrainRcrdList(TrainRcrdBean trainRcrdBean){
		return sqlMapClientTemplate.queryForList("TrainRcrd.selectTrainRcrdList", trainRcrdBean);
	}
}
