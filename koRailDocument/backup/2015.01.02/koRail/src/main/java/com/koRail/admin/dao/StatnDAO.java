package com.koRail.admin.dao;

import java.util.List;

import com.koRail.admin.to.StatnBean;
import com.koRail.common.to.CommonBean;

public interface StatnDAO {
	/**************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 *************************/
	public List<StatnBean> selectStatnList(CommonBean commonBean);
	
	/******************************
	 * 역 등록
	 * @param statnBean
	 *****************************/
	public void insertStatn(StatnBean statnBean);

	/**********************************
	 * 역 수정
	 * @param statnBean
	 **********************************/
	public void updateStatn(StatnBean statnBean);
	
	/*****************************
	 * 역 삭제
	 * @param statnCode
	 *****************************/
	public void deleteStatn(String statnCode);
}
	
