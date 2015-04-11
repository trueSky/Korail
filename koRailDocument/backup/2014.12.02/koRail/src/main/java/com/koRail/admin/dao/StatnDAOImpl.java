package com.koRail.admin.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.koRail.admin.to.StatnBean;
import com.koRail.common.to.CommonBean;

@Repository(value="statnDAO")
public class StatnDAOImpl implements StatnDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**************************
	 * 역 조회
	 * @param commonBean
	 * @return
	 *************************/
	@Override
	public List<StatnBean> selectStatnList(CommonBean commonBean) {
		return (List<StatnBean>)sqlMapClientTemplate.queryForList("Statn.selectStatn", commonBean);
	}

	/****************************
	 * 역 등록
	 * @param StatnBean
	 ***************************/
	@Override
	public void insertStatn(StatnBean statnBean) {
		sqlMapClientTemplate.insert("Statn.insertStatn", statnBean);
	}

	/***************************
	 * 역 수정
	 * @param StatnBean
	 **************************/
	@Override
	public void updateStatn(StatnBean statnBean) {
		sqlMapClientTemplate.update("Statn.updateStatn", statnBean);
	}

	/*****************************
	 * 역 삭제
	 * @param statnCode
	 *****************************/
	@Override
	public void deleteStatn(String statnCode) {
		sqlMapClientTemplate.delete("Statn.deleteStatn", statnCode);
	}
}
