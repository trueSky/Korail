package com.koRail.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.CommonBean;

/**************************************************************
* @Method name
* insert* : 등록, select* : 조회, update* : 수정, delete* : 삭제
**************************************************************/
@Repository(value="commonDAO")
public class CommonDAOImpl implements CommonDAO {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;	
	
	/******************************
	 * 회원(관리자 포함) 찾기 : 로그인
	 * @param memberMap
	 *******************************/
	@Override
	public void selectMember(Map<String, String> memberMap) {
		sqlMapClientTemplate.queryForObject("Common.selectMember", memberMap);
	}

	/*********************************
	 * 공통코드 조회
	 * @param commonBean
	 * @return
	 ********************************/
	@Override
	public List<CommonBean> selectCommonCode(CommonBean commonBean) {
		return (List<CommonBean>)sqlMapClientTemplate.queryForList("Common.selectCmmnCode", commonBean);
	}
}
