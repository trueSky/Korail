package com.koRail.member.dao;

import java.util.List;

import com.koRail.member.to.DetailTcktRcrdBean1;
import com.koRail.member.to.TcktBean;

public interface TcktDAO {
	/*******************************
	 * 승차권 예매를 위한 운행정보 조회
	 * @param tcktBean
	 * @return
	 *******************************/
	public List<TcktBean> selectTcktList(TcktBean tcktBean);

	/*************************************
	 * 결제가 완료된 승차권에 대한 상세정보 조회
	 * @param resveCode
	 * @return
	 *************************************/
	public DetailTcktRcrdBean1 selectDtailTcktRcrd(String resveCode);
}
