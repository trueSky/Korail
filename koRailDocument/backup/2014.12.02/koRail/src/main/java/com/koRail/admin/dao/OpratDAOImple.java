package com.koRail.admin.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.OpratBean;
import com.koRail.common.to.CommonBean;

@Repository(value="opratDAO")
public class OpratDAOImple implements OpratDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*******************************
	 * 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 *******************************/
	@Override
	public List<OpratBean> selectOpratList(CommonBean commonBean) {
		return (List<OpratBean>)sqlMapClientTemplate.queryForList("Oprat.selectOprat", commonBean);
	}
	
	/*****************************************
	 * 수정을 위한 운행일정, 상세운행일정, 호실 조회
	 * @param commonBean
	 * @return
	 ******************************************/
	@Override
	public List<OpratBean> selectAllOpratList(CommonBean commonBean) {
		return (List<OpratBean>)sqlMapClientTemplate.queryForList("Oprat.selectAllOprat", commonBean);
	}

	@Override
	public void insertOprat(OpratBean opratBean) {
		// TODO Auto-generated method stub

	}

	/**************************
	 * 운행일정 수정
	 * @param opratBean
	 **************************/
	@Override
	public void updateOprat(OpratBean opratBean) {
		sqlMapClientTemplate.update("Oprat.updateOprat", opratBean);
	}

	@Override
	public void deleteOprat(String opratCode) {
		// TODO Auto-generated method stub

	}
}
