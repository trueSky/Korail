package com.koRail.member.dao;

import java.util.List;

import com.koRail.member.to.TcktBean;

public interface ResveDAO {
	/*******************************
	 * 승차권 예매를 위한 운행정보 조회
	 * @param tcktBean
	 * @return
	 *******************************/
	public List<TcktBean> selectTcktList(TcktBean tcktBean);
}
