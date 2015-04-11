package com.koRail.common.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.common.to.DetailResveBean;

@Repository(value="detailResveDAO")
@SuppressWarnings({ "deprecation", "unchecked" })
public class DetailResveDAOImpl implements DetailResveDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**************************
	 * 상세예약 조회
	 * @param detailResveBean
	 * @return
	 **************************/
	public List<DetailResveBean> selectDetailResveList(DetailResveBean detailResveBean){
		return sqlMapClientTemplate.queryForList("DetailResve.selectDetailResveList", detailResveBean);
	}
	
	/****************************
	 * 상세예약 등록
	 * @param detailResveBean
	 ****************************/
	@Override
	public void insertDetailResve(DetailResveBean detailResveBean) {
		sqlMapClientTemplate.insert("DetailResve.insertDetailResve", detailResveBean);
	}
}

