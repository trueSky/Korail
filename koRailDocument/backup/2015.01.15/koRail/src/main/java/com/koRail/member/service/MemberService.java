package com.koRail.member.service;

import java.util.List;
import java.util.Map;

import com.koRail.common.to.MemberBean;
import com.koRail.common.to.RoomBean;
import com.koRail.member.to.DetailTcktRcrdBean1;
import com.koRail.member.to.ResveBean;
import com.koRail.member.to.ResveRcrdBean;
import com.koRail.member.to.SetleBean;
import com.koRail.member.to.TcktBean;

public interface MemberService {
	
	/*****************************************
 					회원 게인정보
	******************************************/
	
	/***************************
	 * ID 중복확인
	 * @param id
	 * @return
	 **************************/
	public Map<String, String> doIdCheck(String id);
	
	/**********************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param memberBean
	 ********************************/
	public void setMember(MemberBean memberBean);

	/*****************************************
					포인트
	 ******************************************/
	
	/**************************
	 * 현제포인트 조회
	 * @param id
	 * @return
	 **************************/
	public int getTdyPint(String id);
	
	/*****************************************
						승차권
	******************************************/
	
	/***********************************
	 * 승차권 예매를 위한 운행일정 조회
	 * @param tcktBean
	 * @return
	 **********************************/
	public List<TcktBean> getTcktList(TcktBean tcktBean);

	/*****************************************
	 * 예약을 위해 선택한 승차권에 대한 호실정보 조회
	 * @param roomBean
	 * @return
	 *****************************************/
	public Map<String, ?> getTcktRoomInfoList(RoomBean roomBean);

	/*****************************************
	 * 예약 등록, 삭제
	 * @param resveBean
	 * @param json
	 * @return
	 *****************************************/
	public String setResve(ResveBean resveBean, String json);

	/*****************************************
						결제
	 ******************************************/

	/*****************************************
	 * 결제할 예매 정보 조회
	 * @param resveCode
	 * @return
	 ****************************************/
	public ResveBean getResve(String resveCode);

	/******************************************
	 * 결제, 결제취소
	 * @param setleBean
	 ******************************************/
	public void setSetle(SetleBean setleBean);

	/*********************************************
	 				승차권 현황
	 *********************************************/
	
	/*********************************
	 * 승차권 예매 현황 조회
	 * @param id
	 * @return
	 **********************************/
	public List<ResveRcrdBean> getResveRcrdList(String id);
	
	/*************************************
	 * 결제가 완료된 승차권에 대한 상세정보 조회
	 * @param resveCode
	 * @return
	 *************************************/
	public DetailTcktRcrdBean1 getDetailTcktRcrdList(String resveCode);
}
