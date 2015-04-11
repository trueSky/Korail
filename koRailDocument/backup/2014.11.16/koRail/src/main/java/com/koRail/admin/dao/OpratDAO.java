package com.koRail.admin.dao;

import java.util.List;

import com.koRail.admin.to.OpratBean;
import com.koRail.common.to.CommonBean;

public interface OpratDAO {
	/**************************
	 * 운행일정 조회
	 * @param commonBean
	 * @return
	 **************************/
	public List<OpratBean> selectOpratList(CommonBean commonBean);

	/***************************
	 * 운행일정 등록
	 * @param opratBean
	 **************************/
	public void insertOprat(OpratBean opratBean);
	
	/**************************
	 * 운행일정 수정
	 * @param opratBean
	 **************************/
	public void updateOprat(OpratBean opratBean);
	
	/**************************
	 * 운행일정 삭제
	 * @param opratCode
	 ************************/
	public void deleteOprat(String opratCode);
}
