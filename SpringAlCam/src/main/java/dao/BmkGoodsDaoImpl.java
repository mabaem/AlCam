package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BmkGoodsVo;

public class BmkGoodsDaoImpl implements BmkGoodsDao {
	
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<BmkGoodsVo> selectList(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("bmkgoods.bmkgoods_list", m_idx);
	}

	@Override
	public BmkGoodsVo selectOne(BmkGoodsVo paramVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bmkgoods.bmkgoods_one", paramVo);
	}

	@Override
	public int selectTotalAmount(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bmkgoods.bmkgoods_total_amount", m_idx);
	}

	@Override
	public int insert(BmkGoodsVo paramVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("bmkgoods.bmkgoods_insert", paramVo);
	}

	@Override
	public int update(BmkGoodsVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("bmkgoods.bmkgoods_update", vo);
	}

	@Override
	public int delete(int bmk_p_idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("bmkgoods.bmkgoods_delete", bmk_p_idx);
	}

	@Override
	public int selectRowTotal(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("bmkgoods.bmkgoods_row_total", m_idx);
	}

	@Override
	public List<BmkGoodsVo> selectList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("bmkgoods.bmkgoods_page_list", map);
	}

}
