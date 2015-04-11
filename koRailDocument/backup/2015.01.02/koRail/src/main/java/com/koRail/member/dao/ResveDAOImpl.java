package com.koRail.member.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.member.to.ResveBean;
import com.koRail.member.to.TcktBean;

@SuppressWarnings({"deprecation", "unchecked"})
@Repository(value="resveDAO")
public class ResveDAOImpl implements ResveDAO {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*******************************
	 * 승차권 예매를 위한 운행정보 조회
	 * @param tcktBean
	 * @return
	 *******************************/
	@Override
	public List<TcktBean> selectTcktList(TcktBean tcktBean) {
		return sqlMapClientTemplate.queryForList("Resve.selectTcktList", tcktBean);
	}

	/********************************
	 * 예약 등록
	 * @param resveBean
	 * @return
	 ********************************/
	@Override
	public int insertResve(ResveBean resveBean){
		return sqlMapClientTemplate.update("Resve.insertResve", resveBean);
	}
}
