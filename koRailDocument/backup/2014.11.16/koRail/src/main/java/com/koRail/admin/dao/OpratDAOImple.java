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
	
	@Override
	public List<OpratBean> selectOpratList(CommonBean commonBean) {
		return (List<OpratBean>)sqlMapClientTemplate.queryForList("Oprat.selectOprat", commonBean);
	}

	@Override
	public void insertOprat(OpratBean opratBean) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateOprat(OpratBean opratBean) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteOprat(String opratCode) {
		// TODO Auto-generated method stub

	}

}
