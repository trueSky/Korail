package com.koRail.member.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.member.to.SetleBean;

@Repository(value="setleDAO")
@SuppressWarnings("deprecation")
public class SetleDAOImpl implements SetleDAO {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	/*******************************
	 * 결제 등록
	 * @param setleBean
	 *******************************/
	@Override
	public void insertSetle(SetleBean setleBean){
		sqlMapClientTemplate.insert("Setle.insertSetle", setleBean);
	}
}
