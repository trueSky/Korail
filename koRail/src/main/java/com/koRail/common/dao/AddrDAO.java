package com.koRail.common.dao;

import java.util.List;

import com.koRail.common.to.AddrBean;


public interface AddrDAO {
	/************************
	 * 주소검섹
	 * @param umd
	 * @return
	 *************************/
	public List<AddrBean> selectAddrList(String umd);
}
