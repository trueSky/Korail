package com.koRail.member.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.DetailResveBean;

@Repository(value="detatilResveDAO")
@SuppressWarnings("deprecation")
public class DetatilResveDAOImpl implements DetatilResveDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	/****************************
	 * 상세예약 등록
	 * @param detailResveBean
	 ****************************/
	@Override
	public void insertDetailResve(DetailResveBean detailResveBean) {
		sqlMapClientTemplate.insert("DetailResve.insertDetailResve", detailResveBean);
	}

}
