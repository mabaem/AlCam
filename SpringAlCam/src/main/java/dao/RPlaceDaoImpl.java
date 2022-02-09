package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.RPlaceVo;

public class RPlaceDaoImpl implements RPlaceDao {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<RPlaceVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("rplace.rplace_list");
	}

	@Override
	public List<RPlaceVo> selectList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("rplace.rplace_condition_list", map);
	}

	@Override
	public RPlaceVo selectOne(int idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("rplace.rplace_one", idx);	
	}

	@Override
	public int selectRowTotal(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("rplace.rplace_rowtotal", map);
	}

	@Override
	public int insert(RPlaceVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("rplace.rplace_insert", vo);
	}

	@Override
	public int update(RPlaceVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("rplace.rplace_update", vo);
	}
	@Override
	public int delete(int idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("rplace.rplace_delete", idx);
	}

	@Override
	public int update_readhit(int idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("rplace.rplace_update_readhit", idx);
	}

	@Override
	public int update_use_yn(int idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("rplace.rplace_update_use_yn", idx);
	}

	@Override
	public List<RPlaceVo> selectBestList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("rplace.rplace_best_list");
	}

}
