package dao;

import org.apache.ibatis.session.SqlSession;

import vo.CampProductVo;

public class CampProductDaoImpl implements CampProductDao {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public int insert(CampProductVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("campproduct.campproduct_insert",vo);
	}

	@Override
	public String selectlist(String g_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("campproduct.campproduct_list",g_idx);
	}

}
