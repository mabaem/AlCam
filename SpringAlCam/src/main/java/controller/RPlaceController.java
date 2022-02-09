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
	
	//베스트글 10건 조회
	@RequestMapping("/recommend_place/best.do")
	public String best(Model model) {
		
		//게시글 목록가져오기
		List<RPlaceVo> list = rplace_dao.selectBestList();
		
		
		model.addAttribute("list", list);

		return "recommend_place/rplace_best_list";
	}
	
	

	//게시글 조회
	@RequestMapping("/recommend_place/list.do")
	public String list(@RequestParam(name="page",defaultValue="1") int nowPage,
			@RequestParam(value = "search", defaultValue = "all") String search,
			@RequestParam(value = "search_text", defaultValue = "") String search_text,
			Model model) {
		
		//게시물에서 가져올 범위 계산
		int start = (nowPage-1) * MyConstant.RPlace.BLOCK_LIST + 1;
		int end   = start + MyConstant.RPlace.BLOCK_LIST - 1;
		
		//검색범위 및 조건을 담을 객체
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		
		//검색조건을 map에 담는다.
		
		//전체검색이 아닌경우
		if(!search.equals("all")) {
			
			//이름+제목+내용 검색
			if(search.equals("name_subject_content")) {
				
				map.put("name", search_text);
				map.put("subject", search_text);
				map.put("content", search_text);
				
			}
			//이름 검색
			else if(search.equals("name")) {
				
				map.put("name", search_text);
				
			}
			//제목 검색
			else if(search.equals("subject")) {
				
				map.put("subject", search_text);
				
			}
			//내용 검색
			else if(search.equals("content")) {
				
				map.put("content", search_text);
				
			}
		}
		
		
		//전체게시물수
		int rowTotal = rplace_dao.selectRowTotal(map);
				
		//검색필터 생성
		String search_filter = String.format("search=%s&search_text=%s", search, search_text);
		
		//페이징 메뉴 생성 + 검색필터 추가
		String pageMenu = Paging.getPaging("list.do",
											search_filter,
				                            nowPage, 
				                            rowTotal, 
				                            MyConstant.RPlace.BLOCK_LIST,
				                            MyConstant.RPlace.BLOCK_PAGE
				                            );
				
		//게시글 목록가져오기
		List<RPlaceVo> list = rplace_dao.selectList(map);
		
		//session에 봤다는 정보는 삭제
		session.removeAttribute("show");
		
		//model통해서 request binding
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return "recommend_place/rplace_list";
	}

	//게시글보기
	@RequestMapping("/recommend_place/view.do")
	public String view(int idx, @RequestParam(name="page",defaultValue="1") int page, Model model) {
		
		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		//현재 게시글을 봤냐 라는정보를 세션에서 검사
		if(session.getAttribute("show")==null) {
		
			//조회수 증가
			int res = rplace_dao.update_readhit(idx);
			
			//session에 봤다는 정보 기록
			session.setAttribute("show", true);
		}
		
		model.addAttribute("vo", vo);
		
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_view";
	}

	//삭제하기
	// /recommend_place/delete.do?b_idx=5&page=3&search=all%search_text=
	@RequestMapping("/recommend_place/delete.do")
	public String delete(int idx, int page, String search, String search_text, Model model) {
		
		//기존 사진화일 삭제
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		if(!vo.getFilename().equals("rplace_default_img.jpg")) {
			File f_origin = new File(absPath, vo.getFilename());	
			f_origin.delete();
		}

		int res = rplace_dao.update_use_yn(idx);
		
		//어떤용도? query로 사용
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);
		
		return "redirect:list.do"; //   list.do?page=3
	}
	
	
	//수정폼 띄우기
	// /recommend_place/modify_form.do?b_idx=5
	@RequestMapping("/recommend_place/modify_form.do")
	public String modify_form(int idx, int page, Model model) {
		
		//수정할 게시물 얻어오기
		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		//model통해서 request binding
		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_modify_form";
	}
	
	//수정하기
	@RequestMapping("/recommend_place/modify.do")
	public String modify(RPlaceVo vo, int page, String search, String search_text, Model model) {
		
		//로그인된 유저 정보 얻어오기
		MemberVo user = (MemberVo) session.getAttribute("user");
		if(user==null) {
			
			model.addAttribute("reason", "session_timeout");
			model.addAttribute("page", page);
			model.addAttribute("search", search);
			model.addAttribute("search_text", search_text);
			
			return "redirect:list.do";
		}
		
		
		//IP구하기
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
	
	//새글쓰기폼 띄우기
	@RequestMapping("/recommend_place/insert_form.do")
	public String insert_form(int page, Model model) {
		
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_insert_form";
	}
	
	//새글쓰기
	@RequestMapping("/recommend_place/insert.do")
	public String insert(RPlaceVo vo, int page, Model model) throws Exception {
		
		//로그인된 유저 정보 얻어오기
		MemberVo user = (MemberVo) session.getAttribute("user");
		if(user==null) {
			
			model.addAttribute("reason", "session_timeout");
			
			model.addAttribute("page", page);
			
			return "redirect:list.do";
		}
		
		
		//IP구하기
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		

		//회원idx와 회원명을 vo에 넣는다
		vo.setM_idx(user.getM_idx());
		vo.setM_name(user.getM_name());
		
		//System.out.printf("%d %s", vo.getM_idx(), vo.getM_name());
		
		
		//#########장소idx 임의 지정 = 1##########
		vo.setP_idx(1);
		vo.setP_name("");
		vo.setP_addr("");

		
		//이미지 넣기
		//상대경로->절대(저장경로)
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
		
		String filename = "no_file";
		MultipartFile photo = vo.getPhoto();
		
		//프로필 사진 업로드 안 된 경우 기본사진 적용
		if(photo.isEmpty()) {
			filename = "rplace_default_img.jpg";
		}
		
		//프로필 사진 업로드 된 경우
		if(!photo.isEmpty()) {
			filename = photo.getOriginalFilename();
			
			//저장경로
			File f = new File(absPath, filename);
			
			//동일이름의 화일이 존재하는지 여부
			if(f.exists()) {
				long tm = System.currentTimeMillis();
				//화일명 = 시간_화일명
				filename = String.format("%d_%s", tm, filename);
				
				//저장경로 재설정
				f = new File(absPath, filename);
			}
			
			//임시경로화일->지정된 위치로 복사
			photo.transferTo(f);

		}//end: if(m_filename.isEmpty())
		
		vo.setFilename(filename);
		
	
		//DB insert
		int res = rplace_dao.insert(vo);
		
		model.addAttribute("page", page);
		
		
		return "redirect:list.do";
	}
	
	
	
}
