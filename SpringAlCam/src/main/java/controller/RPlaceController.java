package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dao.RPlaceDao;
import myutil.MyConstant;
import myutil.Paging;
import vo.RPlaceVo;
import vo.MemberVo;

@Controller
public class RPlaceController {

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ServletContext application;
	
	RPlaceDao rplace_dao;

	public void setRplace_dao(RPlaceDao rplace_dao) {
		this.rplace_dao = rplace_dao;
	}
	
	//����Ʈ�� 10�� ��ȸ
	@RequestMapping("/recommend_place/best.do")
	public String best(Model model) {
		
		//�Խñ� ��ϰ�������
		List<RPlaceVo> list = rplace_dao.selectBestList();
		
		
		model.addAttribute("list", list);

		return "recommend_place/rplace_best_list";
	}
	
	

	//�Խñ� ��ȸ
	@RequestMapping("/recommend_place/list.do")
	public String list(@RequestParam(name="page",defaultValue="1") int nowPage,
			@RequestParam(value = "search", defaultValue = "all") String search,
			@RequestParam(value = "search_text", defaultValue = "") String search_text,
			Model model) {
		
		//�Խù����� ������ ���� ���
		int start = (nowPage-1) * MyConstant.RPlace.BLOCK_LIST + 1;
		int end   = start + MyConstant.RPlace.BLOCK_LIST - 1;
		
		//�˻����� �� ������ ���� ��ü
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		
		//�˻������� map�� ��´�.
		
		//��ü�˻��� �ƴѰ��
		if(!search.equals("all")) {
			
			//�̸�+����+���� �˻�
			if(search.equals("name_subject_content")) {
				
				map.put("name", search_text);
				map.put("subject", search_text);
				map.put("content", search_text);
				
			}
			//�̸� �˻�
			else if(search.equals("name")) {
				
				map.put("name", search_text);
				
			}
			//���� �˻�
			else if(search.equals("subject")) {
				
				map.put("subject", search_text);
				
			}
			//���� �˻�
			else if(search.equals("content")) {
				
				map.put("content", search_text);
				
			}
		}
		
		
		//��ü�Խù���
		int rowTotal = rplace_dao.selectRowTotal(map);
				
		//�˻����� ����
		String search_filter = String.format("search=%s&search_text=%s", search, search_text);
		
		//����¡ �޴� ���� + �˻����� �߰�
		String pageMenu = Paging.getPaging("list.do",
											search_filter,
				                            nowPage, 
				                            rowTotal, 
				                            MyConstant.RPlace.BLOCK_LIST,
				                            MyConstant.RPlace.BLOCK_PAGE
				                            );
				
		//�Խñ� ��ϰ�������
		List<RPlaceVo> list = rplace_dao.selectList(map);
		
		//session�� �ôٴ� ������ ����
		session.removeAttribute("show");
		
		//model���ؼ� request binding
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return "recommend_place/rplace_list";
	}

	//�Խñۺ���
	@RequestMapping("/recommend_place/view.do")
	public String view(int idx, @RequestParam(name="page",defaultValue="1") int page, Model model) {
		
		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		//���� �Խñ��� �ó� ��������� ���ǿ��� �˻�
		if(session.getAttribute("show")==null) {
		
			//��ȸ�� ����
			int res = rplace_dao.update_readhit(idx);
			
			//session�� �ôٴ� ���� ���
			session.setAttribute("show", true);
		}
		
		model.addAttribute("vo", vo);
		
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_view";
	}

	//�����ϱ�
	// /recommend_place/delete.do?b_idx=5&page=3&search=all%search_text=
	@RequestMapping("/recommend_place/delete.do")
	public String delete(int idx, int page, String search, String search_text, Model model) {
		
		//���� ����ȭ�� ����
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		if(!vo.getFilename().equals("rplace_default_img.jpg")) {
			File f_origin = new File(absPath, vo.getFilename());	
			f_origin.delete();
		}

		int res = rplace_dao.update_use_yn(idx);
		
		//��뵵? query�� ���
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);
		
		return "redirect:list.do"; //   list.do?page=3
	}
	
	
	//������ ����
	// /recommend_place/modify_form.do?b_idx=5
	@RequestMapping("/recommend_place/modify_form.do")
	public String modify_form(int idx, int page, Model model) {
		
		//������ �Խù� ������
		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		//model���ؼ� request binding
		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_modify_form";
	}
	
	//�����ϱ�
	@RequestMapping("/recommend_place/modify.do")
	public String modify(RPlaceVo vo, int page, String search, String search_text, Model model) {
		
		//�α��ε� ���� ���� ������
		MemberVo user = (MemberVo) session.getAttribute("user");
		if(user==null) {
			
			model.addAttribute("reason", "session_timeout");
			model.addAttribute("page", page);
			model.addAttribute("search", search);
			model.addAttribute("search_text", search_text);
			
			return "redirect:list.do";
		}
		
		
		//IP���ϱ�
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		//DB update
		int res = rplace_dao.update(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);
		
		
		return "redirect:view.do";
	}
	
	//���۾����� ����
	@RequestMapping("/recommend_place/insert_form.do")
	public String insert_form(int page, Model model) {
		
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_insert_form";
	}
	
	//���۾���
	@RequestMapping("/recommend_place/insert.do")
	public String insert(RPlaceVo vo, int page, Model model) throws Exception {
		
		//�α��ε� ���� ���� ������
		MemberVo user = (MemberVo) session.getAttribute("user");
		if(user==null) {
			
			model.addAttribute("reason", "session_timeout");
			
			model.addAttribute("page", page);
			
			return "redirect:list.do";
		}
		
		
		//IP���ϱ�
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		

		//ȸ��idx�� ȸ������ vo�� �ִ´�
		vo.setM_idx(user.getM_idx());
		vo.setM_name(user.getM_name());
		
		//System.out.printf("%d %s", vo.getM_idx(), vo.getM_name());
		
		
		//#########���idx ���� ���� = 1##########
		vo.setP_idx(1);
		vo.setP_name("");
		vo.setP_addr("");

		
		//�̹��� �ֱ�
		//�����->����(������)
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
		
		String filename = "no_file";
		MultipartFile photo = vo.getPhoto();
		
		//������ ���� ���ε� �� �� ��� �⺻���� ����
		if(photo.isEmpty()) {
			filename = "rplace_default_img.jpg";
		}
		
		//������ ���� ���ε� �� ���
		if(!photo.isEmpty()) {
			filename = photo.getOriginalFilename();
			
			//������
			File f = new File(absPath, filename);
			
			//�����̸��� ȭ���� �����ϴ��� ����
			if(f.exists()) {
				long tm = System.currentTimeMillis();
				//ȭ�ϸ� = �ð�_ȭ�ϸ�
				filename = String.format("%d_%s", tm, filename);
				
				//������ �缳��
				f = new File(absPath, filename);
			}
			
			//�ӽð��ȭ��->������ ��ġ�� ����
			photo.transferTo(f);

		}//end: if(m_filename.isEmpty())
		
		vo.setFilename(filename);
		
	
		//DB insert
		int res = rplace_dao.insert(vo);
		
		model.addAttribute("page", page);
		
		
		return "redirect:list.do";
	}
	
	
	
}
