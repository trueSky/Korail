package com.koRail.member.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.CommonBean;
import com.koRail.member.to.PintBean;

@Repository(value="pintDAO")
@SuppressWarnings({"deprecation", "unchecked"})
public class PintDAOImpl implements PintDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/***********************
	 * 포인트 조회
	 * @param id
	 * @return
	 **********************/
	@Override
	public PintBean selectPint(String id){
		return (PintBean)sqlMapClientTemplate.queryForObject("Pint.selectPint", id);
	}
	
	/************************
	 * 현재포인트 조회
	 * @param id
	 * @return
	 *************************/
	@Override
	public String selectTdyPint(String id){
		return (String)sqlMapClientTemplate.queryForObject("Pint.selectTdyPint", id);
	}
	
	/*************************
	 * 포인트 사용내역
	 * @param commonBean
	 * @return
	 *************************/
	@Override
	public List<PintBean> selectPintInfoList(CommonBean commonBean){
		return sqlMapClientTemplate.queryForList("Pint.selectPintInfoList", commonBean);
	}
}
