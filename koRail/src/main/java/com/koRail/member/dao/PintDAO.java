package com.koRail.member.dao;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.member.to.PintBean;

public interface PintDAO {
	/***********************
	 * 포인트 조회
	 * @param id
	 * @return
	 **********************/
	public PintBean selectPint(String id);
	
	/************************
	 * 현재포인트 조회
	 * @param id
	 * @return
	 *************************/
	public String selectTdyPint(String id);
	
	/*************************
	 * 포인트 사용내역
	 * @param commonBean
	 * @return
	 *************************/
	public List<PintBean> selectPintInfoList(CommonBean commonBean);
}
