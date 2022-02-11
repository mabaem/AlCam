package dao;

import java.util.List;
import java.util.Map;

import vo.BmkPlaceVo;

public interface BmkPlaceDao {
	
	
	List<BmkPlaceVo> selectList(int m_idx);
	BmkPlaceVo       selectOne(BmkPlaceVo vo);
	
	int          insert(BmkPlaceVo vo);
	int          delete(int bmk_p_idx);
	
	//페이징 처리
	int selectRowTotal(int m_idx);
	List<BmkPlaceVo> selectList(Map map);

}
