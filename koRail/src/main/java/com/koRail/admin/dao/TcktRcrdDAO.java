package com.koRail.admin.dao;

import java.util.List;

import com.koRail.admin.to.TcktRcrdBean;

public interface TcktRcrdDAO {
	/*****************************
	 * 승차권 발권 현황 조회
	 * @param tcktRcrdBean
	 * @return
	 *****************************/
	public List<TcktRcrdBean> selectTcktRcrdList(TcktRcrdBean tcktRcrdBean);
}
