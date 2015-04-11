package com.koRail.common.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.MemberBean;

@Repository(value="memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;	
	
	/*********************************
	 * 회원조회
	 * @param memberBean
	 * @return
	 *********************************/
	@Override
	public List<MemberBean> selectMemberList(MemberBean memberBean) {
		return (List<MemberBean>)sqlMapClientTemplate.queryForList("Member.selectMember", memberBean);
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

	/***********************************
	 * 회원 삭제
	 * @param id
	 ***********************************/
	@Override
	public void deleteMember(String id){
		sqlMapClientTemplate.delete("Member.deleteMember", id);
	}
}
