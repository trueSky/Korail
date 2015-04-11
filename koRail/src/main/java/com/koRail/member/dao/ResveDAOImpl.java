package com.koRail.member.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.CommonBean;
import com.koRail.member.to.ResveBean;
import com.koRail.member.to.ResveRcrdBean;

@SuppressWarnings({"deprecation", "unchecked"})
@Repository(value="resveDAO")
public class ResveDAOImpl implements ResveDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	/********************************
	 * 예약 등록
	 * @param resveBean
	 * @return
	 ********************************/
	@Override
	public int insertResve(ResveBean resveBean){
		return sqlMapClientTemplate.update("Resve.insertResve", resveBean);
	}
	
	/*********************************
	 * 결제할 예매 정보 조회
	 * @param resveCode
	 * @return
	 ********************************/
	@Override
	public ResveBean selectResve(String resveCode){
		return (ResveBean) sqlMapClientTemplate.queryForObject("Resve.selectResve", resveCode);
	}
	
	/***********************************
	 * 승차권 예매 현황 조회
	 * @param commonBean
	 * @return
	 ***********************************/
	@Override
	public List<ResveRcrdBean> selectResveRcrdList(CommonBean commonBean){
		return sqlMapClientTemplate.queryForList("Resve.selectResveRcrdList", commonBean);
	}
	
	/*****************************
	 * 예매취소
	 * @param resveBean
	 *****************************/
	@Override
	public void deleteResve(ResveBean resveBean){
		sqlMapClientTemplate.delete("Resve.deleteResve", resveBean);
	}
}
