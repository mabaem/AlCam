package dao;

import java.util.List;
import java.util.Map;

import vo.NoticeVo;

public interface NoticeDao {
	
	List<NoticeVo> selectList();
	List<NoticeVo> selectList(Map map);
	NoticeVo	   selectOne(int n_idx);
	int			   selectRowTotal(Map map);
	
	int            insert(NoticeVo vo);
	int            update(NoticeVo vo);
	int            update_use_yn(int n_idx);
	
	int            delete(int n_idx);
	
	int            update_readhit(int n_idx);
	
	

}
