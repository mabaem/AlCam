package dao;

import java.util.List;
import java.util.Map;

import vo.RPlaceVo;

public interface RPlaceDao {

	List<RPlaceVo> selectList();
	List<RPlaceVo> selectList(Map map);
	RPlaceVo       selectOne(int idx);
	int            selectRowTotal(Map map);
	
	int            insert(RPlaceVo vo);
	int            update(RPlaceVo vo);
	int            update_use_yn(int idx);
	
	
	int            delete(int idx);
	
	int            update_readhit(int idx);
	
}
