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

	/***************************
	 * 운행일정 등록
	 * @param opratBean
	 * @return
	 **************************/
	@Override
	public int insertOprat(OpratBean opratBean) {
		return sqlMapClientTemplate.update("Oprat.insertOprat", opratBean);
	}

	/**************************
	 * 운행일정 수정
	 * @param opratBean
	 * @return
	 **************************/
	@Override
	public int updateOprat(OpratBean opratBean) {
		return sqlMapClientTemplate.update("Oprat.updateOprat", opratBean);
	}

	/**************************
	 * 운행일정 삭제
	 * @param opratCode
	 * @return
	 ************************/
	@Override
	public void deleteOprat(String opratCode) {
		sqlMapClientTemplate.update("Oprat.deleteOprat", opratCode);			
	}
}
