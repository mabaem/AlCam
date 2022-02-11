package controller;

import java.io.File;
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

import dao.NoticeDao;
import myutil.MyConstant;
import myutil.Paging;
import vo.MemberVo;
import vo.NoticeVo;

@Controller
public class NoticeController {

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ServletContext application;
	
	NoticeDao notice_dao;

	public void setNotice_dao(NoticeDao notice_dao) {
		this.notice_dao = notice_dao;
	}
	
	
	//�ֽű� 10�� ��ȸ
	@RequestMapping("/notice/recent.do")
	public String recent(Model model) {
		
		//�Խñ� ��ϰ�������
		List<NoticeVo> list = notice_dao.selectRecentList();
		
		
		model.addAttribute("list", list);

		return "notice/notice_recent_list";
	}
	
	
	
	// �Խñ� ��ȸ
		@RequestMapping("/notice/list.do")
		public String list(@RequestParam(name="page",       defaultValue="1")     int nowPage,  
				           @RequestParam(value="search",     defaultValue="all")   String search, 
				           @RequestParam(value="search_text",defaultValue="")      String search_text,
				           Model model) {
			
			//System.out.println(nowPage);
			
			//�Խù����� ������ ���� ���
			int start = (nowPage-1) * MyConstant.Notice.BLOCK_LIST + 1;
			int end   = start + MyConstant.Notice.BLOCK_LIST - 1;
			
			//�˻����� �� ������ ���� ��ü
			Map map = new HashMap();
			map.put("start", start);
			map.put("end", end);
		
			//�˻������� map�� ��´�
			if(!search.equals("all")) {//��ü�˻��� �ƴϸ�
				
				if(search.equals("name_subject_content")) {
					
					//�̸�+����+����
					map.put("name", search_text);
					map.put("subject", search_text);
					map.put("content", search_text);
					
				}else if(search.equals("name")) {
					//�̸��˻�
					map.put("name", search_text);
					
				}else if(search.equals("subject")) {
					//����˻�
					map.put("subject", search_text);
					
				}else if(search.equals("content")) {
					//����˻�
					map.put("content", search_text);
					
				}
			}
	
			//��ü�Խù���
			int rowTotal = notice_dao.selectRowTotal(map);
			
			//����¡ �޴� ����
			//�˻�����
			String search_filter = String.format("search=%s&search_text=%s", search,search_text);
			
			String pageMenu = Paging.getPaging("list.do", 
					                            search_filter,
					                            nowPage, 
					                            rowTotal, 
					                            MyConstant.Notice.BLOCK_LIST,
					                            MyConstant.Notice.BLOCK_PAGE
					                            );
			
			//System.out.println(pageMenu);
			
			//�Խñ� ��ϰ�������
			List<NoticeVo> list = notice_dao.selectList(map);
			
			//session�� �ôٴ� ������ ����
			session.removeAttribute("show");
			
			//model���ؼ� request binding
			model.addAttribute("list", list);
			model.addAttribute("pageMenu", pageMenu);
			
			return "notice/notice_list";
		}
		
	//�Խñۺ���
		@RequestMapping("/notice/view.do")
		public String view(int n_idx,@RequestParam(name="page",defaultValue="1") int page, Model model) {
			
			NoticeVo  vo = notice_dao.selectOne(n_idx);
			
			//���� �Խñ��� �ó� ��������� ���ǿ��� �˻�
			if(session.getAttribute("show")==null) {
			
				//��ȸ�� ����
				int res = notice_dao.update_readhit(n_idx);
				
				//session�� �ôٴ� ���� ���
				session.setAttribute("show", true);
			}
			
			model.addAttribute("vo", vo);
			model.addAttribute("page", page);
			
			return "notice/notice_view";
		}
		
		//�۾��� ��
		@RequestMapping("/notice/insert_form.do")
		public String insert_form(int page, Model model) {
			
			model.addAttribute("page", page);
			
			return "notice/notice_insert_form";
		}
		
		//���۾���
		
		// /notice/insert.do?b_subject=����&b_content=����
		
		@RequestMapping("/notice/insert.do")
		public String insert(NoticeVo vo,int page,Model model) throws Exception {
			
			//�α��ε� ���� ���� ������
			MemberVo user = (MemberVo) session.getAttribute("user");
			if(user==null) {
				
				model.addAttribute("reason", "session_timeout");
				
				model.addAttribute("page", page);
				
				return "redirect:list.do";
			}
			
			//ȸ��idx�� ȸ������ vo�� �ִ´�
			vo.setM_idx(user.getM_idx());
			vo.setM_name(user.getM_name());
			
			//�̹��� �ֱ�
			//�����->����(������)
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			String n_filename = "no_file";
			MultipartFile n_photo = vo.getN_photo();
			
			//������ ���� ���ε� �� �� ��� �⺻���� ����
			if(n_photo.isEmpty()) {
				n_filename = "no_file";
			}
			
			//������ ���� ���ε� �� ���
			if(!n_photo.isEmpty()) {
				n_filename = n_photo.getOriginalFilename();
				
				//������
				File f = new File(absPath, n_filename);
				
				//�����̸��� ȭ���� �����ϴ��� ����
				if(f.exists()) {
					long tm = System.currentTimeMillis();
					//ȭ�ϸ� = �ð�_ȭ�ϸ�
					n_filename = String.format("%d_%s", tm, n_filename);
					
					//������ �缳��
					f = new File(absPath, n_filename);
				}
				
				//�ӽð��ȭ��->������ ��ġ�� ����
				n_photo.transferTo(f);

			}//end: if(m_filename.isEmpty())
			
			String n = n_filename;
			vo.setN_filename(n);
			
			//DB insert
			int res = notice_dao.insert(vo);
			
			return "redirect:list.do";
		}
		
		//�����ϱ�
		// /notice/delete.do?b_idx=5&page=3&search=all&search_text=
		@RequestMapping("/notice/delete.do")
		public String delete(int n_idx,
				              int page,
				              String search,
				              String search_text,
				              Model model) {
			
			//���� ����ȭ�� ����
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			NoticeVo vo = notice_dao.selectOne(n_idx);
			
			if(!vo.getN_filename().equals("notice_default_img.jpg")) {
				File f_origin = new File(absPath,vo.getN_filename());
				f_origin.delete();
			}
			
			int res = notice_dao.update_use_yn(n_idx);
			
			//��뵵? query�� ���
			model.addAttribute("page", page);
			model.addAttribute("search", search);
			model.addAttribute("search_text",search_text);
			
			return "redirect:list.do"; //   list.do?page=3&search=all&search_text=
		}
		//������ ����
		@RequestMapping("/notice/modify_form.do")
		public String modify_form(int n_idx, int page, Model model) {
			
			//������ �Խù� ������
			NoticeVo vo = notice_dao.selectOne(n_idx);
			
			//model���ؼ� request binding
			model.addAttribute("vo", vo);
			model.addAttribute("page", page);
			
			return "notice/notice_modify_form";
		}
		
		//�����ϱ�
		@RequestMapping("/notice/modify.do")
		public String modify(NoticeVo vo, int page, String search, String search_text, Model model) throws Exception {
			
			//�α��ε� ���� ���� ������
			MemberVo user = (MemberVo) session.getAttribute("user");
			
			
			if(user==null) {
				
				model.addAttribute("reason", "session_timeout");
				model.addAttribute("page", page);
				model.addAttribute("search", search);
				model.addAttribute("search_text", search_text);
				
				return "redirect:list.do";
			}
			
			
			//�̹��� �ֱ�
			//�����->����(������)
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			String n_filename = "no_file";
			MultipartFile n_photo = vo.getN_photo();
			
			//������ ���� ���ε� �� �� ��� �⺻���� ���� ����!!
			if(n_photo.isEmpty()) {
				n_filename = null;
			}
			
			//������ ���� ���ε� �� ���
			if(!n_photo.isEmpty()) {
				n_filename = n_photo.getOriginalFilename();
				
				//������
				File f = new File(absPath, n_filename);
				
				//�����̸��� ȭ���� �����ϴ��� ����
				if(f.exists()) {
					long tm = System.currentTimeMillis();
					//ȭ�ϸ� = �ð�_ȭ�ϸ�
					n_filename = String.format("%d_%s", tm, n_filename);
					
					//������ �缳��
					f = new File(absPath, n_filename);
				}
				
				//�ӽð��ȭ��->������ ��ġ�� ����
				n_photo.transferTo(f);

			}//end: if(m_filename.isEmpty())
			
			vo.setN_filename(n_filename);
			
		
			//DB update
			int res = notice_dao.update(vo);
			
			model.addAttribute("n_idx", vo.getN_idx());
			model.addAttribute("page", page);
			model.addAttribute("search", search);
			model.addAttribute("search_text", search_text);
			
			
			return "redirect:view.do";
		}
		
		
}
