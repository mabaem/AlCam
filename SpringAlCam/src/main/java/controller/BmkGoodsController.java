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

import dao.BmkGoodsDao;
import myutil.MyMember;
import myutil.Paging;
import vo.BmkGoodsVo;
import vo.MemberVo;

@Controller
public class BmkGoodsController {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	BmkGoodsDao bmkgoods_dao;

	public void setBmkgoods_dao(BmkGoodsDao bmkgoods_dao) {
		this.bmkgoods_dao = bmkgoods_dao;
	}
	
	//ķ�ο�ǰ ���ã�� ��ȸ
	@RequestMapping("/member/bmkgoods_list.do")
	public String list(@RequestParam(name="page",defaultValue="1") int nowPage,
			            Model model) {
		
		MemberVo user = (MemberVo) session.getAttribute("user");

		//ȸ���Ϸù�ȣ ���ϱ�
		int m_idx = user.getM_idx();

		//����¡ ó��
		int rowTotal = bmkgoods_dao.selectRowTotal(m_idx);
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
			
		//ķ�ο�ǰ ���ã�� ��ȸ
		List<BmkGoodsVo> list = bmkgoods_dao.selectList(map);
		
		
		
		String pageMenu = Paging.getPaging("bmkgoods_list.do",
										    nowPage,     
					                        rowTotal,
					                        MyMember.Bookmark.BLOCK_LIST, 
					                        MyMember.Bookmark.BLOCK_PAGE
					                        );
		
		int total_amount  = bmkgoods_dao.selectTotalAmount(m_idx);

		model.addAttribute("list",list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("total_amount", total_amount);

		return "member/bookmark_goods";
	}
	
	//ķ�ο�ǰ ���� ����
	@RequestMapping("/member/bmkgoods_update.do")
	public String bmkgoods_update(BmkGoodsVo vo, @RequestParam(value="page", defaultValue="1") int page) {

		int res = bmkgoods_dao.update(vo);
		
		return "redirect:bmkgoods_list.do?page=" + page;
	}
	
	//ķ�ο�ǰ �߰�
	@RequestMapping("/member/bmkgoods_insert.do")
	@ResponseBody
	public Map bmkgoods_insert(BmkGoodsVo paramVo) {
		
		BmkGoodsVo vo2 = bmkgoods_dao.selectOne(paramVo);
		
		String g_idx = paramVo.getG_idx();
		int m_idx = paramVo.getM_idx();
		System.out.printf("g_idx=%s",g_idx);
		System.out.println();
		System.out.printf("m_idx=%s",m_idx);
		System.out.println();
		
		
		Map map = new HashMap();
		
		if(vo2!=null) {
			
			map.put("result", "exist");
		}else {
			
			int res = bmkgoods_dao.insert(paramVo);
			map.put("result", "success");
		}
		
		return map;
	}
	
	//ķ�ο�ǰ ���ã�� ����
	@RequestMapping("/member/bmkgoods_delete.do")
	public String bmkgoods_delete(int bmk_g_idx, @RequestParam(value="page", defaultValue="1") int page) {

		int res   = bmkgoods_dao.delete(bmk_g_idx);
		
		return "redirect:bmkgoods_list.do?page=" + page;
	}
	
	//ķ�ο�ǰ ���ã�� ���� ����
	@RequestMapping("/member/bmkgoods_del_all.do")
	public String bmkgoods_del_all(@RequestParam(value="check_box") String [] bmk_g_idx_array,
			                        @RequestParam(value="page", defaultValue="1") int page) {

		for(String str_bmk_g_idx : bmk_g_idx_array) {
			int bmk_g_idx = Integer.parseInt(str_bmk_g_idx);
			
			int res = bmkgoods_dao.delete(bmk_g_idx);
		}
		
		return "redirect:bmkgoods_list.do?page=" + page;
	}
	
	
	

}
