package com.koRail.member.dao;

import java.util.List;

import com.koRail.common.to.CommonBean;
import com.koRail.member.to.ResveBean;
import com.koRail.member.to.ResveRcrdBean;

public interface ResveDAO {
	/********************************
	 * 예약 등록
	 * @param resveBean
	 * @return
	 ********************************/
	public int insertResve(ResveBean resveBean);
	
	/*********************************
	 * 결제할 예매 정보 조회
	 * @param resveCode
	 * @return
	 ********************************/
	public ResveBean selectResve(String resveCode);

	/***********************************
	 * 승차권 예매 현황 조회
	 * @param id
	 * @return
	 ***********************************/
	public List<ResveRcrdBean> selectResveRcrdList(String id);
	
	/*****************************
	 * 예매취소
	 * @param commonBean
	 *****************************/
	public void deleteResve(CommonBean commonBean);
}
