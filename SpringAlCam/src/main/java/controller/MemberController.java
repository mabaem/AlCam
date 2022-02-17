package controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.MemberDao;
import myutil.MyConstant;
import myutil.Paging;
import vo.MemberVo;

@Controller
public class MemberController {
	
	MemberDao member_dao;

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	JavaMailSender mailSender;
	

	public void setMember_dao(MemberDao member_dao) {
		this.member_dao = member_dao;
	}
	
	
	//로그인폼띄우기
	@RequestMapping("/member/login_form.do")
	public String login_form() {
		return "member/member_login_form";
	}
	
	
	//로그인
	@RequestMapping("/member/login.do")
	public String login(String m_id, String m_pwd,
			            @RequestParam(value="url",defaultValue="") String url,
			            Model model) {
		
		//m_id에 해당되는 vo 얻어온다
		MemberVo user = member_dao.selectOne(m_id);
		
		//아이디가 틀린경우
		if(user==null) {
			
			model.addAttribute("reason", "fail_id");
						
			return "redirect:login_form.do";
		}
		
		//비밀번호 틀린경우
		if(user.getM_pwd().equals(m_pwd)==false) {
			
			model.addAttribute("reason", "fail_pwd");
			
			return "redirect:login_form.do";
		}
		
		//로그인 된 경우 -> 로그인정보를 세션에 저장
		session.setAttribute("user", user);
			
		//url이 비어있는 경우
		if(url.isEmpty()) {

			return "redirect:../main.do?m_idx=" + user.getM_idx();
		}
		
		//보던 페이지가 있는경우 : 해당 페이지로 이동
		return "redirect:" + url;
	}
	
	//로그아웃
	@RequestMapping("/member/logout.do")
	public String logout() {
		
		//session에서 로그인한 user정보 삭제
		session.removeAttribute("user");
		
		return "redirect:../main.do";
	}
	
	//회원가입 입력폼
	@RequestMapping("/member/insert_form.do")
	public String insert_form() {
		
		return "member/member_insert_form";
	}

	//회원가입
	@RequestMapping("/member/insert.do")
	public String insert(MemberVo vo, 
			              @RequestParam(value="m_byear")  int m_byear, 
			              @RequestParam(value="m_bmonth") int m_bmonth, 
			              @RequestParam(value="m_bday")   int m_bday) throws Exception {
		
		//프로필사진
		//상대경로->절대(저장경로)
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
		
		String filename = "no_file";
		MultipartFile photo = vo.getPhoto();
		
		//프로필 사진 업로드 안 된 경우 기본사진 적용
		if(photo.isEmpty()) {
			filename = "default_img.png";
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
		
		vo.setM_filename(filename);
		
		
		//생년월일
		vo.setM_byear(m_byear);
		vo.setM_bmonth(m_bmonth);
		vo.setM_bday(m_bday);
		
		
		//회원등급
		vo.setM_grade("일반");
		
		
		//DB insert
		int res = member_dao.insert(vo);
		
		return "redirect:../main.do";
	}

	//회원가입 시 아이디 중복 체크
	@RequestMapping("/member/check_id.do")
	@ResponseBody
	public Map check_id(String m_id) {
		MemberVo vo = member_dao.selectOne(m_id);
		
		boolean bResult = true;
		
		//m_id 중복 시
		if(vo != null)
			bResult = false;
		
		Map map = new HashMap();
		map.put("result", bResult);
		
		return map;
	}
	
	//이메일 인증
	@RequestMapping(value = "/member/check_email.do", method = RequestMethod.GET)
	@ResponseBody
	public String check_email(String m_email) throws Exception{
	    int random_key = (int)((Math.random()* (99999 - 10000 + 1)) + 10000);

	    String from = "alcamcompany@gmail.com";
	    String to = m_email;
	    String title = "[AlCam] 회원가입 인증번호입니다.";
	    String content = "[인증번호] "+ random_key +" 입니다. <br> 인증번호 확인란에 기입하세요.";
	    String num = "";
	    
	    try {
	    	
	    	MimeMessage mail = mailSender.createMimeMessage();
	        MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	        
	        mailHelper.setFrom(from);
	        mailHelper.setTo(to);
	        mailHelper.setSubject(title);
	        mailHelper.setText(content, true);       
	        
	        mailSender.send(mail);
	        
	        //인증 성공 시 인증번호 전달
	        num = Integer.toString(random_key);
	        
	    } catch(Exception e) {
	    	//인증 실패
	        num = "fail";
	    }
	    
	    return num;
	}
	
	//회원정보 수정폼 띄우기
	@RequestMapping("/member/modify_form.do")
	public String modify_form(int m_idx, Model model) {
	
		MemberVo vo = member_dao.selectOne(m_idx);

		model.addAttribute("vo", vo);
		
		return "member/member_modify_form";
	}
	
	//관리자페이지 수정폼 띄우기
	@RequestMapping("/member/admin_modify_form.do")
	public String admin_modify_form(int m_idx, int page, Model model) {
	
		MemberVo vo = member_dao.selectOne(m_idx);

		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
		
		return "member/admin_modify_form";
	}

	//회원정보 수정
	@RequestMapping("/member/modify.do")
	public String modify(MemberVo vo,
						 @RequestParam(value="m_grade")  String m_grade, 
						 @RequestParam(value="m_byear")  int    m_byear, 
			             @RequestParam(value="m_bmonth") int    m_bmonth, 
			             @RequestParam(value="m_bday")   int    m_bday) {
			
		//생년월일
		vo.setM_byear(m_byear);
		vo.setM_bmonth(m_bmonth);
		vo.setM_bday(m_bday);
		
		//회원등급
		vo.setM_grade(m_grade);
		
		int res = member_dao.update(vo);
		
		return "redirect:list.do?m_idx=" + vo.getM_idx();
	}
	
	//관리자페이지 수정
	@RequestMapping("/member/admin_modify.do")
	public String admin_modify(MemberVo vo,
						 @RequestParam(value="m_grade")  String m_grade, 
						 @RequestParam(value="m_byear")  int    m_byear, 
			             @RequestParam(value="m_bmonth") int    m_bmonth,         
			             @RequestParam(value="m_bday")   int    m_bday,
			             @RequestParam(value="page")     int    page) {
			
		//생년월일
		vo.setM_byear(m_byear);
		vo.setM_bmonth(m_bmonth);
		vo.setM_bday(m_bday);
		
		//회원등급
		vo.setM_grade(m_grade);
		
		int res = member_dao.update(vo);
		
		return "redirect:admin_list.do?m_idx=" + vo.getM_idx() + "&page=" + page;
	}
	
	//프로필사진 수정
	@RequestMapping(value="/member/photo_upload.do", method=RequestMethod.POST)
	@ResponseBody
	public Map photo_upload(MultipartHttpServletRequest req) throws Exception {
		
		//기존 화일 삭제
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
			
		int m_idx = Integer.parseInt(req.getParameter("m_idx"));

		MemberVo vo = member_dao.selectOne(m_idx);
		
		if(!vo.getM_filename().equals("default_img.png")) {
			File f_origin = new File(absPath, vo.getM_filename());	
			f_origin.delete();
		}
		
		//변경된 화일로 업로드
		String filename = "no_file";
		MultipartFile photo = req.getFile("photo");

		filename = photo.getOriginalFilename();

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

		vo.setM_filename(filename);
		
		int res = member_dao.update_img(vo);
		//System.out.println(absPath);
		Map map = new HashMap();
		map.put("filename", filename);


		
		return map;
	}
	
	//관리자 회원삭제
	@RequestMapping("/member/delete.do")
	public String delete(int m_idx, @RequestParam(value="page") int page) {
		
		//기존 프로필화일 삭제
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		MemberVo vo = member_dao.selectOne(m_idx);
		
		if(!vo.getM_filename().equals("default_img.png")) {
			File f_origin = new File(absPath, vo.getM_filename());	
			f_origin.delete();
		}
				
		int res = member_dao.delete(m_idx);
		
		return "redirect:admin_list.do?page=" + page;
	}
	
	//회원탈퇴
	@RequestMapping("/member/delete_mem.do")
	public String delete_mem(int m_idx) {
		
		//기존 프로필화일 삭제
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		MemberVo vo = member_dao.selectOne(m_idx);
		
		if(!vo.getM_filename().equals("default_img.png")) {
			File f_origin = new File(absPath, vo.getM_filename());	
			f_origin.delete();
		}
				
		int res = member_dao.delete(m_idx);
		
		return "redirect:logout.do";
	}
	
	//회원정보수정 페이지
	@RequestMapping("/member/list.do")
	public String list(Model model, @RequestParam(value="m_idx", defaultValue="0", required = false) int m_idx) {
		
		MemberVo user_vo    = member_dao.selectOne(m_idx);
		
		model.addAttribute("user_vo",user_vo);
		
		return "member/member_profile";
	}
	
	//관리자 페이지
	@RequestMapping("/member/admin_list.do")
	public String admin_list(@RequestParam(name="page",           defaultValue="1")     int nowPage,
							  @RequestParam(value = "search",      defaultValue = "all") String search,
							  @RequestParam(value = "search_text", defaultValue = "")    String search_text,
			                  Model model) {
		
		//페이징 처리
		int start    = (nowPage-1) * MyConstant.Member.BLOCK_LIST + 1;
		int end      = start + MyConstant.Member.BLOCK_LIST - 1;

		//페이징조건을 담을 맵
		Map map = new HashedMap();
		map.put("start", start);
		map.put("end", end);
		
		//검색조건을 map에 담기
		if(!search.equals("all")) {
			
			//아이디+이름 검색
			if(search.equals("id_name")) {
				//아이디+이름 검색
				map.put("id", search_text);
				map.put("name", search_text);

			}
			//아이디 검색
			else if(search.equals("id")) {
				//아이디 검색
				map.put("id", search_text);
				
			}
			//이름 검색
			else if(search.equals("name")) {
				//이름 검색
				map.put("name", search_text);
				
			}
		}
		
		//전체게시물수
		int rowTotal = member_dao.selectRowTotal(map);
		
		//검색필터 생성
		String search_filter = String.format("search=%s&search_text=%s", search, search_text);		
		
		String pageMenu = Paging.getPaging("admin_list.do",
											search_filter,
										    nowPage,     
					                        rowTotal,
					                        MyConstant.Member.BLOCK_LIST, 
					                        MyConstant.Member.BLOCK_PAGE
					                        );
		
		List<MemberVo> list = member_dao.selectList(map);
		
		model.addAttribute("list",list);
		model.addAttribute("pageMenu", pageMenu);
		
		return "member/admin_list";
	}
	
	//마이페이지 클릭 시 첫 화면
	@RequestMapping("/member/welcome.do")
	public String my_page(Model model, @RequestParam(value="m_idx", defaultValue="0", required = false) int m_idx) {

		MemberVo vo    = member_dao.selectOne(m_idx);
		
		model.addAttribute("vo",vo);
		
		return "member/member_welcome";
	}
	
}
