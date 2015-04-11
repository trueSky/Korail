package com.koRail.member.dao;

import com.koRail.member.to.SetleBean;

public interface SetleDAO {
	/*******************************
	 * 결제 등록
	 * @param setleBean
	 *******************************/
	public void insertSetle(SetleBean setleBean);
}
