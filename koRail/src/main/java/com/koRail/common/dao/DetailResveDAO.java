package com.koRail.common.dao;

import java.util.List;

import com.koRail.common.to.DetailResveBean;

public interface DetailResveDAO {
	/**************************
	 * 상세예약 조회
	 * @param detailResveBean
	 * @return
	 **************************/
	public List<DetailResveBean> selectDetailResveList(DetailResveBean detailResveBean);

	/****************************
	 * 상세예약 등록
	 * @param detailResveBean
	 ****************************/
	public void insertDetailResve(DetailResveBean detailResveBean);

	/******************************
	 * 승차자명 등록
	 * @param detailResveBean
	 ******************************/
	public void updatePsngrNm(DetailResveBean detailResveBean);
}
