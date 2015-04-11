package com.koRail.member.dao;

import java.util.List;

import com.koRail.common.to.RoomBean;
import com.koRail.member.to.SeatNoInfoBean;

public interface SeatNoInfoDAO {
	/***********************
	 * 예약된 좌석 조회
	 * @param roomBean
	 * @return
	 ***********************/
	public List<SeatNoInfoBean> selectSeatNoInfoBean(RoomBean roomBean);
}
