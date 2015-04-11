package com.koRail.member.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.RoomBean;
import com.koRail.member.to.SeatNoInfoBean;

@Repository(value="seatNoInfoDAO")
@SuppressWarnings({ "unchecked", "deprecation" })
public class SeatNoInfoDAOImpl implements SeatNoInfoDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/***********************
	 * 예약된 좌석 조회
	 * @param roomBean
	 * @return
	 ***********************/
	@Override
	public List<SeatNoInfoBean> selectSeatNoInfoBean(RoomBean roomBean){
		return sqlMapClientTemplate.queryForList("SeatNo.selectSeatNoList", roomBean);
	}
}
