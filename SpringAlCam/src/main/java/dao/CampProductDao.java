package dao;

import vo.CampProductVo;

public interface CampProductDao {
	
	int          insert(CampProductVo vo);

	String selectlist(String g_idx);

}
