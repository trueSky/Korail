package com.koRail.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.koRail.admin.dao.DetailOpratDAO;
import com.koRail.admin.dao.OpratDAO;
import com.koRail.admin.dao.StatnDAO;
import com.koRail.admin.dao.TcktRcrdDAO;
import com.koRail.admin.dao.TrainDAO;
import com.koRail.admin.dao.TrainRcrdDAO;
import com.koRail.admin.to.DetailOpratBean;
import com.koRail.admin.to.OpratBean;
import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TcktRcrdBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.admin.to.TrainRcrdBean;
import com.koRail.common.dao.MemberDAO;
import com.koRail.common.dao.RoomDAO;
import com.koRail.common.exception.SQLExecutException;
import com.koRail.common.to.CommonBean;
import com.koRail.common.to.MemberBean;
import com.koRail.common.to.RoomBean;
import com.koRail.common.util.JSONParser;

@Service(value="adminServie")
public class AdminServieImpl implements AdminServie {
	/* 승차권 발권 현황 DAO */
	@Resource(name="tcktRcrdDAO")
	private TcktRcrdDAO tcktRcrdDAO;
	
	/* 열차별 승객 현황 DAO */
	@Resource(name="trainRcrdDAO")
	private TrainRcrdDAO trainRcrdDAO;
	
	/*역 DAO*/
	@Resource(name="statnDAO")
	private StatnDAO statnDAO;
	
	/*열차 DAO*/
	@Resource(name="trainDAO")
	private TrainDAO trainDAO;
	
	/*운행일정 DAO*/
	@Resource(name="opratDAO")
	private OpratDAO opratDAO;
	
	/* 상세운행일정 DAO */
	@Resource(name="detailOpratDAO")
	private DetailOpratDAO detailopratDAO;
	
	/* 호실 DAO */
	@Resource(name="roomDAO")
	private RoomDAO roomDAO;
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;

	/*************************************
					현황
	*************************************/
	
	/*****************************
	 * 승차권 발권 현황 조회
	 * @param tcktRcrdBean
	 * @return
	 *****************************/
	@Override
	public List<TcktRcrdBean> getTcktRcrdList(TcktRcrdBean tcktRcrdBean){
		return tcktRcrdDAO.selectTcktRcrdList(tcktRcrdBean);
	}
	
	/*************************************
	 * 열차별 승객 현황 조회
	 * @param trainRcrdBean
	 * @return
	 *************************************/
	public List<TrainRcrdBean> getTrainRcrdList(TrainRcrdBean trainRcrdBean){
		return trainRcrdDAO.selectTrainRcrdList(trainRcrdBean);
	}
	
	/*************************************
					역 관리
	 *************************************/
	
	/******************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 * @exception
	 ******************************/
	@Override
	public List<StatnBean> getStatnList(CommonBean commonBean){
		return statnDAO.selectStatnList(commonBean);
	}

	/******************************
	 * 역 등록, 수정, 삭제
	 * @param statnBean
	 * @param deleteCodeArray
	 * @throws SQLExecutException
	 *****************************/
	@Override
	public void setStatn(StatnBean statnBean, String[] deleteCodeArray) throws SQLExecutException{
		/*등록*/
		if("insert".equals(statnBean.getState())){
			statnDAO.insertStatn(statnBean);
		}
		/*수정*/
		else if("update".equals(statnBean.getState())){
			statnDAO.updateStatn(statnBean);
		}
		/*삭제*/
		else if("delete".equals(statnBean.getState()) && deleteCodeArray != null){
			String code = null; /* exception이 발생할 경우 발생한 코드 */
			
			try{
				for(String statnCode : deleteCodeArray){
					code = statnCode;
					statnDAO.deleteStatn(statnCode);
				}
			}catch(DataAccessException e){
				throw new SQLExecutException(code);
			}
		}else{
			return;
		}
	}
	
	/*************************************
					열차 관리
	*************************************/
	
	/******************************
	* 열차 조회
	* @param commonBean
	* @return
	******************************/
	@Override
	public List<TrainBean> getTrainList(CommonBean commonBean) {
		return trainDAO.selectTrainList(commonBean);
	}

	/*******************************
	 * 열차 등록, 수정, 삭제
	 * @param trainBean
	 * @param deleteCodeArray
	 * @throws SQLExecutException
	 *******************************/
	@Override
	public void setTrain(TrainBean trainBean, String[] deleteCodeArray) throws SQLExecutException{
		/*등록*/
		if("insert".equals(trainBean.getState())){
			/*열차번호 검사*/
			if(trainDAO.selectTrainNo(trainBean.getTrainNo()) == 0){
				trainDAO.insertTrain(trainBean);				
			}else{
				throw new SQLExecutException(trainBean.getTrainNo());
			}
		}
		/*수정*/
		else if("update".equals(trainBean.getState())){
			/*열차번호 검사*/
			if(trainDAO.selectTrainNo(trainBean.getTrainNo()) == 0){
				trainDAO.updateTrain(trainBean);
			}else{
				throw new SQLExecutException(trainBean.getTrainNo());
			}
		}
		/*삭제*/
		else if("delete".equals(trainBean.getState())){
			String code = null; /* exception이 발생할 경우 발생한 코드 */
			
			try{
				for(String trainCode : deleteCodeArray){
					code = trainCode;
					trainDAO.deleteTrain(trainCode);
				}
			}catch(DataAccessException e){
				throw new SQLExecutException(code);
			}
		}else{
			return;
		}
	}
	
	/*************************************
				운행일정 관리
	*************************************/
	
	/*******************************
	 * 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 *******************************/
	public List<OpratBean> getOpratList(CommonBean commonBean){
		/*수정화면*/
		if("update".equals(commonBean.getFormType())){
			return opratDAO.selectAllOpratList(commonBean);
		}
		/*조회화면*/
		else{			
			return opratDAO.selectOpratList(commonBean);
		}
	}
	
	/*********************************
	 * 운행일정 중복체크
	 * @param commonBean
	 * @return
	 *********************************/
	@Override
	public int getOpratCount(CommonBean commonBean){
		return opratDAO.selectOpratCount(commonBean);
	}
	
	/*********************************
	* 운행일정 등록, 수정, 삭제
	* 상세운행 등록, 삭제
	* 호실	 등록,삭제
	* @param opratBean
	* @param deleteCodeArray
	* @throws SQLExecutException
	********************************/
	@Override
	public void setOprat(OpratBean opratBean, String[] json, String[] deleteCodeArray) throws SQLExecutException{
		int rows = 0; /* insert, update 발생한 row 수 */
		
		if("insert".equals(opratBean.getState())){
			rows = opratDAO.insertOprat(opratBean);
		}else if("update".equals(opratBean.getState())){
			rows = opratDAO.updateOprat(opratBean);
		}else if("delete".equals(opratBean.getState()) && deleteCodeArray != null){
			for(String opratCode : deleteCodeArray){
				/*삭제할 운행일정 설정*/
				OpratBean oprat = new OpratBean();
				oprat.setOpratCode(opratCode);
				/* 운행 삭제 */
				opratDAO.deleteOprat(oprat);
				/*rtCode (0 : 성공, 1 : 에러)*/
				/*삭제 실패 시 exception 발생*/
				if("1".equals(oprat.getRtCode())){
					throw new SQLExecutException(opratCode);
				}
			}
		}else{
			return;
		}
		
		/* 상세운행, 호실 : 등록, 삭제 */
		if(json == null){
			return;
		}else{
			if(rows == 0){
				return;
			}else{
				/* 상세운행일정 */
				@SuppressWarnings("unchecked")
				List<DetailOpratBean> detailOpratList = (List<DetailOpratBean>)JSONParser.getInstance().processJSONToBean(json[0], "detailOprat", DetailOpratBean.class);
				/* 호실정보 */
				@SuppressWarnings("unchecked")
				List<RoomBean> roomList = (List<RoomBean>)JSONParser.getInstance().processJSONToBean(json[1], "room", RoomBean.class);
				
				/* 상세운행정보: insert, delete */
				for(DetailOpratBean detailOpratBean : detailOpratList){
					if("insert".equals(detailOpratBean.getState())){
						/* 등록자 설정 */
						detailOpratBean.setRegister(opratBean.getupdUsr());
						
						/* 상세운행 등록 */
						detailopratDAO.insertDetailOprat(detailOpratBean);
					}else if("delete".equals(detailOpratBean.getState())){
						/* 상세운행 삭제 */
						detailopratDAO.deleteDetailOprat(detailOpratBean.getDetailOpratCode());
					}
				}
				
				/* 호실정보: insert, delete */
				for(RoomBean roomBean : roomList){
					if("insert".equals(roomBean.getState())){
						/* 호실 재설정 (parmType: number 호실 -> resetTyp: number) */
						String[] room = roomBean.getRoom().split(" ");
						roomBean.setRoom(room[0].trim());
						
						/* 좌석 재설정 (parmType: number 석 -> resetTyp: number) */
						String[] seatCo = roomBean.getSeatCo().split(" ");
						roomBean.setSeatCo(seatCo[0].trim());
						
						/* 특실여부 값 변경 */
						if(roomBean.getPrtclrRoomYN().equals("Yes")){
							roomBean.setPrtclrRoomYN("Y");
						}else if(roomBean.getPrtclrRoomYN().equals("No")){
							roomBean.setPrtclrRoomYN("N");
						}
						
						/* 호실 등록 */
						roomDAO.insertRoom(roomBean);
					}else if("delete".equals(roomBean.getState())){
						/* 호실 삭제 */
						roomDAO.deleteRoom(roomBean.getRoomCode());
					}
				}
			}
		}
	}
	
	/*****************************************
						회원
	*****************************************/
	
	/******************************
	* 회원조회
	* @param memberBean
	* @return
	******************************/
	@Override
	public List<MemberBean> getMemberList(MemberBean memberBean){
		return memberDAO.selectMemberList(memberBean);
	}

	/*******************************
	 * 회원 삭제
	 * @param deleteCodeArray
	 * @throws SQLExecutException
	 *******************************/
	@Override
	public void setMember(String[] deleteCodeArray) throws SQLExecutException{
		for(String value : deleteCodeArray){
			/*아이디 설정 후 회원삭제*/
			MemberBean memberBean = new MemberBean();
			memberBean.setId(value);
			memberDAO.deleteMember(memberBean);
			
			/*삭제 실패 시*/
			if("1".equals(memberBean.getRtCode())){
				throw new SQLExecutException(value);
			}
		}
	}
}