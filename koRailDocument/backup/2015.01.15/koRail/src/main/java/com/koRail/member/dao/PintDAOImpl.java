package com.koRail.member.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository(value="pintDAO")
@SuppressWarnings("deprecation")
public class PintDAOImpl implements PintDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/************************
	 * 현재포인트 조회
	 * @param id
	 * @return
	 *************************/
	@Override
	public int selectTdyPint(String id){
		return (Integer)sqlMapClientTemplate.queryForObject("Pint.selectTdyPint", id);
	}
}
