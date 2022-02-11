package dao;

import java.util.List;
import java.util.Map;

import vo.BmkGoodsVo;

public interface BmkGoodsDao {
	
	List<BmkGoodsVo> selectList(int m_idx);
	BmkGoodsVo       selectOne(BmkGoodsVo vo);
	int              selectTotalAmount(int m_idx);
	
	int          insert(BmkGoodsVo vo);
	int          update(BmkGoodsVo vo);
	int          delete(int bmk_p_idx);
	
	//페이징 처리
	int               selectRowTotal(int m_idx);
	List<BmkGoodsVo>  selectList(Map map);

}
