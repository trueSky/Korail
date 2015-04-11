package com.koRail.admin.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.TcktRcrdBean;

@Repository(value="tcktRcrdDAO")
@SuppressWarnings({ "unchecked", "deprecation" })
public class TcktRcrdDAOImpl implements TcktRcrdDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*****************************
	 * 승차권 발권 현황 조회
	 * @param tcktRcrdBean
	 * @return
	 *****************************/
	@Override
	public List<TcktRcrdBean> selectTcktRcrdList(TcktRcrdBean tcktRcrdBean) {
		return sqlMapClientTemplate.queryForList("TcktRcrd.selectTcktRcrdList", tcktRcrdBean);
	}

}
