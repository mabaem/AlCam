package dao;

import org.apache.ibatis.session.SqlSession;

import vo.PlaceVo;

public class PlaceDaoImpl implements PlaceDao {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public int insert(PlaceVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("place.place_insert",vo);
	}

	@Override
	public String selectlist(String p_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("place.place_list",p_idx);
	}

}
