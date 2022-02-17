package controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
	
	
	//최신글 10건 조회
	@RequestMapping("/notice/recent.do")
	public String recent(Model model) {
		
		//게시글 목록가져오기
		List<NoticeVo> list = notice_dao.selectRecentList();
		
		if(list.isEmpty()) {
			
			return "notice/notice_recent_list";
			
		}
		
		model.addAttribute("list", list);

		return "notice/notice_recent_list";
	}
	
	
	
	// 게시글 조회
		@RequestMapping("/notice/list.do")
		public String list(@RequestParam(name="page",       defaultValue="1")     int nowPage,  
				           @RequestParam(value="search",     defaultValue="all")   String search, 
				           @RequestParam(value="search_text",defaultValue="")      String search_text,
				           Model model) {
			
			//System.out.println(nowPage);
			
			//게시물에서 가져올 범위 계산
			int start = (nowPage-1) * MyConstant.Notice.BLOCK_LIST + 1;
			int end   = start + MyConstant.Notice.BLOCK_LIST - 1;
			String pageMenu = "";
			
			//검색범위 및 조건을 담을 객체
			Map map = new HashMap();
			map.put("start", start);
			map.put("end", end);
		
			//검색조건을 map에 담는다
			if(!search.equals("all")) {//전체검색이 아니면
				
				if(search.equals("name_subject_content")) {
					
					//이름+제목+내용
					map.put("name", search_text);
					map.put("subject", search_text);
					map.put("content", search_text);
					
				}else if(search.equals("name")) {
					//이름검색
					map.put("name", search_text);
					
				}else if(search.equals("subject")) {
					//제목검색
					map.put("subject", search_text);
					
				}else if(search.equals("content")) {
					//내용검색
					map.put("content", search_text);
					
				}
			}
	
			//전체게시물수
			int rowTotal = notice_dao.selectRowTotal(map);
			
			//페이징 메뉴 생성
			//검색필터
			String search_filter = String.format("search=%s&search_text=%s", search,search_text);
			
			pageMenu = Paging.getPaging("list.do", 
					                    search_filter,
					                    nowPage, 
					                    rowTotal, 
					                    MyConstant.Notice.BLOCK_LIST,
					                    MyConstant.Notice.BLOCK_PAGE
					                    );
			
			//System.out.println(pageMenu);
			
			//게시글 목록가져오기
			List<NoticeVo> list = notice_dao.selectList(map);
			
			//session에 봤다는 정보는 삭제
			session.removeAttribute("show");
			
			//model통해서 request binding
			model.addAttribute("list", list);
			model.addAttribute("pageMenu", pageMenu);
			
			return "notice/notice_list";
		}
		
	//게시글보기
		@RequestMapping("/notice/view.do")
		public String view(int n_idx,@RequestParam(name="page",defaultValue="1") int page, Model model) {
			
			NoticeVo  vo = notice_dao.selectOne(n_idx);
			
			//현재 게시글을 봤냐 라는정보를 세션에서 검사
			if(session.getAttribute("show")==null) {
			
				//조회수 증가
				int res = notice_dao.update_readhit(n_idx);
				
				//session에 봤다는 정보 기록
				session.setAttribute("show", true);
			}
			
			model.addAttribute("vo", vo);
			model.addAttribute("page", page);
			
			return "notice/notice_view";
		}
		
		//글쓰기 폼
		@RequestMapping("/notice/insert_form.do")
		public String insert_form(int page, Model model) {
			
			model.addAttribute("page", page);
			
			return "notice/notice_insert_form";
		}
		
		//새글쓰기
		
		// /notice/insert.do?b_subject=제목&b_content=내용
		
		@RequestMapping("/notice/insert.do")
		public String insert(NoticeVo vo,int page,Model model) throws Exception {
			
			//로그인된 유저 정보 얻어오기
			MemberVo user = (MemberVo) session.getAttribute("user");
			if(user==null) {
				
				model.addAttribute("reason", "session_timeout");
				
				model.addAttribute("page", page);
				
				return "redirect:list.do";
			}
			
			//회원idx와 회원명을 vo에 넣는다
			vo.setM_idx(user.getM_idx());
			vo.setM_name(user.getM_name());
			
			String n_content = vo.getN_content().replaceAll("\r\n", "<br>");
			vo.setN_content(n_content);
			
			
			
			
			//이미지 넣기
			//상대경로->절대(저장경로)
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			String n_filename = "no_file";
			MultipartFile n_photo = vo.getN_photo();
			
			//프로필 사진 업로드 안 된 경우 기본사진 적용
			if(n_photo.isEmpty()) {
				n_filename = "no_file";
			}
			
			//프로필 사진 업로드 된 경우
			if(!n_photo.isEmpty()) {
				n_filename = n_photo.getOriginalFilename();
				
				//저장경로
				File f = new File(absPath, n_filename);
				
				//동일이름의 화일이 존재하는지 여부
				if(f.exists()) {
					long tm = System.currentTimeMillis();
					//화일명 = 시간_화일명
					n_filename = String.format("%d_%s", tm, n_filename);
					
					//저장경로 재설정
					f = new File(absPath, n_filename);
				}
				
				//임시경로화일->지정된 위치로 복사
				n_photo.transferTo(f);

			}//end: if(m_filename.isEmpty())
			
			String n = n_filename;
			vo.setN_filename(n);
			
			//DB insert
			int res = notice_dao.insert(vo);
			
			return "redirect:list.do";
		}
		
		//삭제하기
		// /notice/delete.do?b_idx=5&page=3&search=all&search_text=
		@RequestMapping("/notice/delete.do")
		public String delete(int n_idx,
							@RequestParam(name="page",defaultValue="1") int page,
				              String search,
				              String search_text,
				              Model model) {
			
			//기존 사진화일 삭제
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			NoticeVo vo = notice_dao.selectOne(n_idx);
			
			if(!vo.getN_filename().equals("notice_default_img.jpg")) {
				File f_origin = new File(absPath,vo.getN_filename());
				f_origin.delete();
			}
			
			int res = notice_dao.update_use_yn(n_idx);
			res = notice_dao.delete(n_idx);
			
			//어떤용도? query로 사용
			model.addAttribute("page", page);
			model.addAttribute("search", search);
			model.addAttribute("search_text",search_text);
			
			return "redirect:list.do"; //   list.do?page=3&search=all&search_text=
		}
		//수정폼 띄우기
		@RequestMapping("/notice/modify_form.do")
		public String modify_form(int n_idx, @RequestParam(name="page",defaultValue="1") int page, Model model) {
			
			//수정할 게시물 얻어오기
			NoticeVo vo = notice_dao.selectOne(n_idx);
			
			//model통해서 request binding
			model.addAttribute("vo", vo);
			model.addAttribute("page", page);
			
			return "notice/notice_modify_form";
		}
		
		//수정하기
		@RequestMapping("/notice/modify.do")
		public String modify(NoticeVo vo, @RequestParam(name="page",defaultValue="1") int page, String search, String search_text, Model model) throws Exception {
			
			//로그인된 유저 정보 얻어오기
			MemberVo user = (MemberVo) session.getAttribute("user");
			
			
			if(user==null) {
				
				model.addAttribute("reason", "session_timeout");
				model.addAttribute("page", page);
				model.addAttribute("search", search);
				model.addAttribute("search_text", search_text);
				
				return "redirect:list.do";
			}
			
			String n_content = vo.getN_content().replaceAll("\r\n", "<br>");
			vo.setN_content(n_content);
			
			
			//이미지 넣기
			//상대경로->절대(저장경로)
			String webPath = "/resources/image/";
			String absPath = application.getRealPath(webPath);
			
			String n_filename = vo.getN_filename();
			MultipartFile n_photo = vo.getN_photo();
			
			//파일명이 없는 경우(원래 글에 사진이 없었을 경우)
			if(Objects.equals(n_filename, "no_file")) {
				//System.out.println("통과");
				
			}else{	//파일명이 있는 경우(원래 사진이 있었을 경우)
				//System.out.println("저장");
				
				n_filename = n_photo.getOriginalFilename();
				
				//저장경로
				File f = new File(absPath, n_filename);
				
				//동일이름의 화일이 존재하는지 여부
				if(f.exists()) {
					long tm = System.currentTimeMillis();
					//화일명 = 시간_화일명
					n_filename = String.format("%d_%s", tm, n_filename);
					
					//저장경로 재설정
					f = new File(absPath, n_filename);
				}
				
				//임시경로화일->지정된 위치로 복사
				n_photo.transferTo(f);
			}
			
			
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
