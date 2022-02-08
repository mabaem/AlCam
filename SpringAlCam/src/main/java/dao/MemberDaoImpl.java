package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MemberVo;

public class MemberDaoImpl implements MemberDao {

	SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<MemberVo> selectList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.member_list");
	}

	@Override
	public MemberVo selectOne(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.member_one_m_idx", m_idx);
	}

	@Override
	public MemberVo selectOne(String m_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.member_one_m_id", m_id);
	}

	@Override
	public int insert(MemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("member.member_insert", vo);
	}

	@Override
	public int update(MemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.member_update", vo);
	}

	@Override
	public int delete(int m_idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("member.member_delete", m_idx);
	}

	@Override
	public int update_img(MemberVo vo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.member_update_img", vo);
	}




}
