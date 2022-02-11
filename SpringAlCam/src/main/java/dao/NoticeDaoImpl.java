package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVo;

public class NoticeDaoImpl implements NoticeDao {

	SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<NoticeVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("notice.notice_list");
	}

	@Override
	public List<NoticeVo> selectList(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("notice.notice_condition_list",map);
	}

	@Override
	public NoticeVo selectOne(int n_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("notice.notice_one", n_idx);
	}

	@Override
	public int selectRowTotal(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("notice.notice_rowtotal", map);
	}

	@Override
	public int insert(NoticeVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("notice.notice_insert", vo);
	}

	@Override
	public int update(NoticeVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("notice.notice_update", vo);
	}

	@Override
	public int update_use_yn(int n_idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("notice.notice_update_use_yn", n_idx);
	}

	@Override
	public int delete(int n_idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("notice.notice_delete", n_idx);
	}

	@Override
	public int update_readhit(int n_idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("notice.notice_update_readhit", n_idx);
	}

	@Override
	public List<NoticeVo> selectRecentList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("notice.notice_recent_list");
	}

	

	

	

}
