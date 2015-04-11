package com.koRail.admin.dao;

import java.util.List;

import com.koRail.admin.to.TrainRcrdBean;

public interface TrainRcrdDAO {
	/***************************
	 * 열차별 승객 현황 조회
	 * @param trainRcrdBean
	 * @return
	 ****************************/
	public List<TrainRcrdBean> selectTrainRcrdList(TrainRcrdBean trainRcrdBean);
}
