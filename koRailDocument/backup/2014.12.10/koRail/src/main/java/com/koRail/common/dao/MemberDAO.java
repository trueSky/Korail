package com.koRail.common.dao;

import java.util.List;

import com.koRail.common.to.MemberBean;

public interface MemberDAO {
	/*********************************
	 * 회원조회
	 * @param memberBean
	 * @return
	 *********************************/
	public List<MemberBean> selectMemberList(MemberBean memberBean);

	/*********************************
	 * 회원조회
	 * @param memberBean
	 * @return
	 *********************************/
	public MemberBean selectMember(MemberBean memberBean);

	/***********************************
	 * 회원 삭제
	 * @param id
	 ***********************************/
	public void deleteMember(String id);
}