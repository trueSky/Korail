package com.koRail.admin.dao;

import com.koRail.admin.to.DetailOpratBean;

public interface DetailOpratDAO {
	/*****************************
	 * 상세운행정보 등록
	 * @param detailOpratBean
	 *****************************/
	public void insertDetailOprat(DetailOpratBean detailOpratBean);
	
	/**************************************
	 * 상세운행정보 삭제
	 * @param detailOpratCode
	 **************************************/
	public void deleteDetailOprat(String detailOpratCode);
}
