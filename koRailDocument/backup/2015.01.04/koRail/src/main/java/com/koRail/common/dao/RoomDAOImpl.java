package com.koRail.common.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.RoomBean;

@Repository(value="roomDAO")
@SuppressWarnings({ "deprecation", "unchecked" })
public class RoomDAOImpl implements RoomDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*******************************************
	 * 예약을 위해 선택한 승차권에 대한 호실정보 조회
	 * @param roomBean
	 * @return
	 *******************************************/
	@Override
	public List<RoomBean> selectTcktRommList(RoomBean roomBean){
		return sqlMapClientTemplate.queryForList("Room.selectTcktRommList", roomBean);
	}
	
	/***************************
	 * 호실 등록
	 * @param roomBean
	 ***************************/
	@Override
	public void insertRoom(RoomBean roomBean) {
		sqlMapClientTemplate.insert("Room.insertRoom", roomBean);
	}

	/*****************************
	 * 호실 삭제
	 * @param roomCode
	 ****************************/
	@Override
	public void deleteRoom(String roomCode) {
		sqlMapClientTemplate.delete("Room.deleteRoom", roomCode);
	}

	/*****************************
	 * 운행에 대한 모든 호실 삭제
	 * @param opratCode
	 ****************************/
	@Override
	public void deleteRoomAll(String opratCode) {
		sqlMapClientTemplate.delete("Room.deleteRoomAll", opratCode);
	}
}
