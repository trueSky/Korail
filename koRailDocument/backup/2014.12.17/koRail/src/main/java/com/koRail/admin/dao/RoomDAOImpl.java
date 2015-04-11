package com.koRail.admin.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.RoomBean;

@SuppressWarnings("deprecation")
@Repository(value="roomDAO")
public class RoomDAOImpl implements RoomDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
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
