package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.BmkPlaceDao;
import myutil.MyMember;
import myutil.Paging;
import vo.BmkPlaceVo;
import vo.MemberVo;


@Controller
public class BmkPlaceController {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	BmkPlaceDao bmkplace_dao;

	public void setBmkplace_dao(BmkPlaceDao bmkplace_dao) {
		this.bmkplace_dao = bmkplace_dao;
	}
	
	//������ã�� ��ȸ
	@RequestMapping("/member/bmkplace_list.do")
	public String list(@RequestParam(name="page",defaultValue="1") int nowPage,
			            Model model) {
	
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		//ȸ���Ϸù�ȣ ���ϱ�
		int m_idx = user.getM_idx();
		
		//����¡ ó��
		int rowTotal = bmkplace_dao.selectRowTotal(m_idx);
		int start = (nowPage-1) * MyMember.Bookmark.BLOCK_LIST + 1;
			
		if(start>rowTotal && nowPage!=1) 
			nowPage = nowPage-1;
		
		start = (nowPage-1) * MyMember.Bookmark.BLOCK_LIST + 1;
		int end   = start + MyMember.Bookmark.BLOCK_LIST - 1;
		
		//����¡������ ���� ��
		Map map = new HashedMap();
		map.put("m_idx", m_idx);
		map.put("start", start);
		map.put("end", end);
		
		//��ٱ��� ��� ��ȸ
		List<BmkPlaceVo> list = bmkplace_dao.selectList(map);
		
		String pageMenu = Paging.getPaging("bmkplace_list.do",
										    nowPage,     
							                rowTotal,
							                MyMember.Bookmark.BLOCK_LIST, 
							                MyMember.Bookmark.BLOCK_PAGE
							                );

		model.addAttribute("list",list);
		model.addAttribute("pageMenu", pageMenu);
			
		return "member/bookmark_place";
	}
	
	//������ã�� �߰�
	@RequestMapping("/member/bmkplace_insert.do")
	@ResponseBody
	public Map bmkplace_insert(BmkPlaceVo paramVo) {
		
		
		BmkPlaceVo vo = bmkplace_dao.selectOne(paramVo);
		
		Map map = new HashMap();
		
		if(vo!=null) {
			
			map.put("result", "exist");
		}else {
			
			int res = bmkplace_dao.insert(paramVo);
			map.put("result", "success");
		}
		
		return map;
	}
	
	//������ã�� ����
	@RequestMapping("/member/bmkplace_delete.do")
	public String bmkplace_delete(int bmk_p_idx, @RequestParam(value="page", defaultValue="1") int page) {

		int res   = bmkplace_dao.delete(bmk_p_idx);
		
		return "redirect:bmkplace_list.do?page=" + page;
	}
	
	//������ã�� ���� ����
	@RequestMapping("/member/bmkplace_del_all.do")
	public String bmkplace_del_all(@RequestParam(value="check_box") String [] bmk_p_idx_array,
								    @RequestParam(name="page",defaultValue="1") int page) {

		for(String str_bmk_p_idx : bmk_p_idx_array) {
			int bmk_p_idx = Integer.parseInt(str_bmk_p_idx);
			
			int res = bmkplace_dao.delete(bmk_p_idx);
		}
		
		return "redirect:bmkplace_list.do?page=" + page;
	}
	
	

}
