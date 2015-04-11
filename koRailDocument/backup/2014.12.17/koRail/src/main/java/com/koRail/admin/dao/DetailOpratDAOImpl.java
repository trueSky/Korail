package com.koRail.admin.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.DetailOpratBean;

@SuppressWarnings("deprecation")
@Repository(value="detailOpratDAO")
public class DetailOpratDAOImpl implements DetailOpratDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/*****************************
	 * 상세운행정보 등록
	 * @param detailOpratBean
	 *****************************/
	@Override
	public void insertDetailOprat(DetailOpratBean detailOpratBean) {
		sqlMapClientTemplate.insert("DetailOprat.insertDetailOprat", detailOpratBean);
	}

	/**************************************
	 * 상세운행정보 삭제
	 * @param detailOpratCode
	 **************************************/
	@Override
	public void deleteDetailOprat(String detailOpratCode) {
		sqlMapClientTemplate.delete("DetailOprat.deleteDetailOprat", detailOpratCode);
	}

	/**************************************
	 * 운행에 대한 모든 상세운행정보 삭제
	 * @param opratCode
	 **************************************/
	@Override
	public void deleteDetailOpratAll(String opratCode) {
		sqlMapClientTemplate.delete("DetailOprat.deleteDetailOpratAll", opratCode);
	}
}
