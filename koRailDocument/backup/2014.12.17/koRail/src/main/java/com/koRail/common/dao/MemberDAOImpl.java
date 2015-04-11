package com.koRail.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.MemberBean;

@SuppressWarnings("deprecation")
@Repository(value="memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;	
	
	/**************************
	 * ID 중복확인
	 * @param stringMap
	 ***************************/
	@Override
	public void selectMemberId(Map<String, String> stringMap){
		sqlMapClientTemplate.queryForObject("Member.selectMemberId", stringMap);
	}

	/*********************************
	 * 회원조회
	 * @param memberBean
	 * @return
	 *********************************/
	@SuppressWarnings("unchecked")
	@Override
	public List<MemberBean> selectMemberList(MemberBean memberBean) {
		return sqlMapClientTemplate.queryForList("Member.selectMember", memberBean);
	}
	
	/*********************************
	 * 회원조회
	 * @param memberBean
	 * @return
	 *********************************/
	@Override
	public MemberBean selectMember(MemberBean memberBean) {
		return (MemberBean)sqlMapClientTemplate.queryForObject("Member.selectMember", memberBean);
	}

	/*********************************
	 * 회원 등록
	 * @param memberBean
	 *********************************/
	@Override
	public void insertMember(MemberBean memberBean){
		sqlMapClientTemplate.insert("Member.insertMember", memberBean);
	}
	
	/***********************************
	 * 회원 수정
	 * @param memberBean
	 **********************************/
	@Override
	public void deleteMember(MemberBean memberBean){
		System.out.println("delete");
	}
	
	
	/***********************************
	 * 회원 삭제
	 * @param id
	 ***********************************/
	@Override
	public void deleteMember(String id){
		sqlMapClientTemplate.delete("Member.deleteMember", id);
	}
}
