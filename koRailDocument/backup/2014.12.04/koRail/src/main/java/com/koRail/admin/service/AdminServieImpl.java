package com.koRail.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.koRail.admin.dao.DetailOpratDAO;
import com.koRail.admin.dao.OpratDAO;
import com.koRail.admin.dao.RoomDAO;
import com.koRail.admin.dao.StatnDAO;
import com.koRail.admin.dao.TrainDAO;
import com.koRail.admin.to.DetailOpratBean;
import com.koRail.admin.to.OpratBean;
import com.koRail.admin.to.RoomBean;
import com.koRail.admin.to.StatnBean;
import com.koRail.admin.to.TrainBean;
import com.koRail.common.exception.DataDeleteException;
import com.koRail.common.to.CommonBean;
import com.koRail.common.util.JSONParser;

@Service(value="adminServie")
public class AdminServieImpl implements AdminServie {
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
	 * @throws DataDeleteException
	 *****************************/
	@Override
	public void setStatn(StatnBean statnBean, String[] deleteCodeArray) throws DataDeleteException{
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
				throw new DataDeleteException(code);
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
	 * @throws DataDeleteException
	 *******************************/
	@Override
	public void setTrain(TrainBean trainBean, String[] deleteCodeArray) throws DataDeleteException{
		/*등록*/
		if("insert".equals(trainBean.getState())){
			trainDAO.insertTrain(trainBean);
		}
		/*수정*/
		else if("update".equals(trainBean.getState())){
			trainDAO.updateTrain(trainBean);
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
				throw new DataDeleteException(code);
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
	* 운행일정 등록, 수정, 삭제
	* 상세운행 등록, 삭제
	* 호실	 등록,삭제
	* @param opratBean
	* @param deleteCodeArray
	* @throws DataDeleteException
	********************************/
	public void setOprat(OpratBean opratBean, String[] json, String[] deleteCodeArray) throws DataDeleteException {
		int rows = 0; /* insert, update, delete가 발생한 row 수 */
		
		if("insert".equals(opratBean.getState())){
			rows = opratDAO.insertOprat(opratBean);
		}else if("update".equals(opratBean.getState())){
			rows = opratDAO.updateOprat(opratBean);
		}else if("delete".equals(opratBean.getState()) && deleteCodeArray != null){
			for(String opratCode : deleteCodeArray){
				/* 운행에 대한 모든 상세운행 삭제 */
				detailopratDAO.deleteDetailOpratAll(opratCode);
				/* 운행에 대한 모든 호실 삭제 */
				roomDAO.deleteRoomAll(opratCode);
				/* 운행 삭제 */
				opratDAO.deleteOprat(opratCode);
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
				List<DetailOpratBean> detailOpratList = (List<DetailOpratBean>)JSONParser.getInstance().processJSONToBean(json[0], "detailOprat", "com.koRail.admin.to.DetailOpratBean");
				/* 호실정보 */
				@SuppressWarnings("unchecked")
				List<RoomBean> roomList = (List<RoomBean>)JSONParser.getInstance().processJSONToBean(json[1], "room", "com.koRail.admin.to.RoomBean");
				
				/* 상세운행정보: insert, delete */
				for(DetailOpratBean detailOpratBean : detailOpratList){
					if("insert".equals(detailOpratBean.getState())){
						/* 등록자 설정 */
						detailOpratBean.setRegister(opratBean.getupdUsr());
						
						/* 이전역, 다음역 거리 재설정 (parmType: number km -> resetTyp: number) */
						String[] prvDistnc = detailOpratBean.getPrvDistnc().split(" ");
						detailOpratBean.setPrvDistnc(prvDistnc[0].trim());
						
						String[] nxtDistnc = detailOpratBean.getNxtDistnc().split(" ");
						detailOpratBean.setNxtDistnc(nxtDistnc[0].trim());
						
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
}