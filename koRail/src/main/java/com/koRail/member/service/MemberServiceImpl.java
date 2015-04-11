package com.koRail.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koRail.common.dao.DetailResveDAO;
import com.koRail.common.dao.MemberDAO;
import com.koRail.common.dao.RoomDAO;
import com.koRail.common.exception.SQLExecutException;
import com.koRail.common.to.CommonBean;
import com.koRail.common.to.DetailResveBean;
import com.koRail.common.to.MemberBean;
import com.koRail.common.to.RoomBean;
import com.koRail.common.util.JSONParser;
import com.koRail.member.dao.PintDAO;
import com.koRail.member.dao.ResveDAO;
import com.koRail.member.dao.SeatNoInfoDAO;
import com.koRail.member.dao.SetleDAO;
import com.koRail.member.dao.TcktDAO;
import com.koRail.member.to.DetailTcktRcrdBean1;
import com.koRail.member.to.PintBean;
import com.koRail.member.to.ResveBean;
import com.koRail.member.to.ResveRcrdBean;
import com.koRail.member.to.SetleBean;
import com.koRail.member.to.TcktBean;

@Service(value="memberService")
public class MemberServiceImpl implements MemberService {
	/* 회원DAO */
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	/*포인트DAO*/
	@Resource(name="pintDAO")
	private PintDAO pintDAO;
	
	/*승차권DAO*/
	@Resource(name="tcktDAO")
	private TcktDAO tcktDAO;

	/* 예약DAO */
	@Resource(name="resveDAO")
	private ResveDAO resveDAO;
	
	/* 상세예약DAO */
	@Resource(name="detailResveDAO")
	private DetailResveDAO detailResveDAO;
	
	/* 호실DAO */
	@Resource(name="roomDAO")
	private RoomDAO roomDAO;
	
	/* 좌석정보DAO */
	@Resource(name="seatNoInfoDAO")
	private SeatNoInfoDAO seatNoInfoDAO;
	
	/*결제DAO*/
	@Resource(name="setleDAO")
	private SetleDAO setleDAO;
	
	
	/*****************************************
					회원 게인정보
	******************************************/
	
	/***************************
	 * ID 중복확인
	 * @param id
	 * @return
	 **************************/
	public Map<String, String> doIdCheck(String id){
		Map<String, String> stringMap = new HashMap<String, String>();
		
		/* Map 설정 */
		stringMap.put("id", id);
		stringMap.put("rtId", null);
		stringMap.put("rtCode", null);
		stringMap.put("rtMsg", null);
		
		memberDAO.selectMemberId(stringMap);
		
		return stringMap;
	}
	
	/*********************************
	 * 개인정보 조회
	 * @param memberBean
	 * @return
	 **********************************/
	@Override
	public MemberBean getMember(MemberBean memberBean){
		return memberDAO.selectMember(memberBean);
	}
	
	/**********************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param memberBean
	 **********************************/
	@Override
	public void setMember(MemberBean memberBean) throws SQLExecutException {
		if("insert".equals(memberBean.getState())){
			memberDAO.insertMember(memberBean);
		}else if("update".equals(memberBean.getState())){
			memberDAO.updateMember(memberBean);
		}else if("delete".equals(memberBean.getState())){
			/*회원정보 삭제*/
			memberDAO.deleteMember(memberBean);
			
			/*삭제 실패 시*/
			if("1".equals(memberBean.getRtCode())){
				/*메세지 설정*/
				StringBuffer stringBuffer = new StringBuffer();
				stringBuffer.append("예약이 만료되지 않은 승차권 또는 결제가 진행중인 승차권이 존재합니다.\n");
				stringBuffer.append("작업을 진행하시려면 해당 승차권의 예약을 취소하셔야 합니다.");
				
				throw new SQLExecutException(stringBuffer.toString());
			}
		}else{
			return;
		}
	}
	
	/*********************************
	 * 이용내역 조회
	 * (사용내역, 포인트, 포인트 이용내역)
	 * @param commonBean
	 * @return
	 **********************************/
	public Map<String, ?> getUseHistoryMap(CommonBean commonBean){
		Map<String, Object> map = new HashMap<String, Object>();
		/*승차권 예매 내역*/
		map.put("resveRcrdList", resveDAO.selectResveRcrdList(commonBean));
		/*포인트 이용 내역*/
		map.put("pintList", pintDAO.selectPintInfoList(commonBean));
		return map;
	}
	
	/*****************************************
						포인트
	 ******************************************/
	
	/*********************
	 * 포인트 조회
	 * @param id
	 * @return
	 *********************/
	@Override
	public PintBean getPint(String id){
		return pintDAO.selectPint(id);
	}
	
	/**************************
	 * 현제포인트 조회
	 * @param id
	 * @return
	 **************************/
	@Override
	public String getTdyPint(String id){
		try {
			return pintDAO.selectTdyPint(id);
		} catch (NullPointerException e) {
			return "0";
		}
	}
	
	/*****************************************
						승차권
	******************************************/

	/***********************************
	 * 승차권 예매를 위한 운행일정 조회
	 * @param tcktBean
	 * @return
	 **********************************/
	@Override
	public List<TcktBean> getTcktList(TcktBean tcktBean){
		return tcktDAO.selectTcktList(tcktBean);
	}

	/***********************************************************
	 * 예약을 위해 선택한 승차권에 대한 호실정보 조회 및 예약된 좌석정보 조회
	 * @param roomBean
	 * @return
	 *********************************************************/
	@Override
	public Map<String, ?> getTcktRoomInfoList(RoomBean roomBean) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("roomList", roomDAO.selectTcktRommList(roomBean));
		map.put("seatNoList", seatNoInfoDAO.selectSeatNoInfoBean(roomBean));
		
		return map;
	}
	
	/*****************************************
	 * 예약 등록, 삭제
	 * @param resveBean
	 * @param json
	 * @return
	 *****************************************/
	@Override
	public String setResve(ResveBean resveBean, String json) {
		String resveCode = null;
		
		/*등록*/
		if("insert".equals(resveBean.getState())){
			/* 예약이 등록되었다면 상세예약을 등록 */
			if(resveDAO.insertResve(resveBean) > 0){
				/* 상세예약 리스트 */
				@SuppressWarnings("unchecked")
				List<DetailResveBean> detailResvList = (List<DetailResveBean>) JSONParser.getInstance().processJSONToBean(json, "detailResveList", DetailResveBean.class);
				
				/* 상세예약 등록 */
				for(DetailResveBean detailResveBean : detailResvList){
					detailResveDAO.insertDetailResve(detailResveBean);
					/* 예약코드 설정 */
					resveCode = detailResveBean.getCode();
				}
			}
		}
		/*삭제*/
		else if("delete".equals(resveBean.getState())){
			resveDAO.deleteResve(resveBean);
		}
		
		return resveCode;
	}
	
	/**********************************
	 * 승차자명 등록
	 * @param json
	 **********************************/
	@Override
	public void setPsngrNm(String json){
		JSONParser jsonParser = JSONParser.getInstance();
		/*Json to bean*/
		@SuppressWarnings("unchecked")
		List<DetailResveBean> detailResveList
			= (List<DetailResveBean>)jsonParser.processJSONToBean(json, "detailResveList", DetailResveBean.class);
		
		/*승차자명 등록*/
		for(DetailResveBean detailResveBean : detailResveList){
			detailResveDAO.updatePsngrNm(detailResveBean);
		}
	}
	
	/*****************************************
						결제
	******************************************/
	
	/*****************************************
	 * 결제할 예매 정보 조회
	 * @param resveCode
	 * @return
	 ****************************************/
	@Override
	public ResveBean getResve(String resveCode){
		return resveDAO.selectResve(resveCode);
	}
	
	/******************************************
	 * 결제, 결제취소
	 * @param setleBean
	 ******************************************/
	@Override
	public void setSetle(SetleBean setleBean){
		/*결제*/
		if("insert".equals(setleBean.getState())){
			setleDAO.insertSetle(setleBean);
		}
		/*결제취소*/
		else if("delete".equals(setleBean.getState())){			
			System.out.println("d");
		}
	}
	
	/**********************************************
	 					승차권 현황
	 **********************************************/
	
	/*********************************
	 * 승차권 예매 현황 조회
	 * @param id
	 * @return
	 **********************************/
	@Override
	public List<ResveRcrdBean> getResveRcrdList(String id){
		CommonBean commonBean = new CommonBean();
		/*아이디를 검색형식으로 설정*/
		commonBean.setSrcType(id);
		return resveDAO.selectResveRcrdList(commonBean);
	}
	
	/*************************************
	 * 결제가 완료된 승차권에 대한 상세정보 조회
	 * @param resveCode
	 * @return
	 *************************************/
	@Override
	public DetailTcktRcrdBean1 getDetailTcktRcrdList(String resveCode){
		return tcktDAO.selectDtailTcktRcrd(resveCode);
	}
}
