package dao;

import vo.PlaceVo;

public interface PlaceDao {

	int insert(PlaceVo vo);
	String selectlist(String p_idx);
}
