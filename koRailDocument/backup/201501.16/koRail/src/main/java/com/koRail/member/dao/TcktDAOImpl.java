package com.koRail.member.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.member.to.DetailTcktRcrdBean1;
import com.koRail.member.to.TcktBean;

@Repository(value="tcktDAO")
@SuppressWarnings({"deprecation", "unchecked"})
public class TcktDAOImpl implements TcktDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*******************************
	 * 승차권 예매를 위한 운행정보 조회
	 * @param tcktBean
	 * @return
	 *******************************/
	@Override
	public List<TcktBean> selectTcktList(TcktBean tcktBean) {
		return sqlMapClientTemplate.queryForList("Tckt.selectTcktList", tcktBean);
	}

	/*************************************
	 * 결제가 완료된 승차권에 대한 상세정보 조회
	 * @param resveCode
	 * @return
	 *************************************/
	@Override
	public DetailTcktRcrdBean1 selectDtailTcktRcrd(String resveCode){
		return (DetailTcktRcrdBean1)sqlMapClientTemplate.queryForObject("Tckt.selectDtailTcktRcrd1", resveCode);
	}
}
