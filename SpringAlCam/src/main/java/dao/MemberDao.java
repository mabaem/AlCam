package dao;

import java.util.List;
import java.util.Map;

import vo.MemberVo;

public interface MemberDao {

	MemberVo       selectOne(int m_idx);
	MemberVo       selectOne(String m_id);
	
	int insert(MemberVo vo);
	int update(MemberVo vo);
	int delete(int m_idx);
	
	int update_img(MemberVo vo);
	
	//����¡ ó��
	int            selectRowTotal();
	List<MemberVo> selectList(Map map);
	
}
