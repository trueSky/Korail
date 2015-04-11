package com.koRail.common.dao;

import java.util.List;
import java.util.Map;

import com.koRail.common.to.MemberBean;

public interface MemberDAO {
	/**************************
	 * ID 중복확인
	 * @param stringMap
	 ***************************/
	public void selectMemberId(Map<String, String> stringMap);
	
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

	/*********************************
	 * 회원 등록
	 * @param memberBean
	 *********************************/
	public void insertMember(MemberBean memberBean);
	
	/***********************************
	 * 회원 수정
	 * @param memberBean
	 **********************************/
	public void updateMember(MemberBean memberBean);
	
	/***********************************
	 * 회원 삭제
	 * @param memberBean
	 ***********************************/
	public void deleteMember(MemberBean memberBean);
}