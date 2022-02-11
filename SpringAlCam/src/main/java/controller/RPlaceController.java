package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dao.RPlaceDao;
import myutil.MyConstant;
import myutil.Paging;
import vo.MemberVo;
import vo.RPlaceVo;

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
	
	
	//팝업창 띄우기
	@RequestMapping("/recommend_place/popup.do")
	public String popup(){
		
		return "recommend_place/popup";
	}
	
	
	//장소 키워드로 검색
	@RequestMapping("/recommend_place/keyword_search.do")
	public String keyword_search(@RequestParam(value = "search_text_rplace", defaultValue = "") String search_text_rplace,
							     Model model) {
			
			// 검색범위 및 조건을 담을 객체
			// 데이터 전달을 위한 list 생성
			List<RPlaceVo> list = new ArrayList<RPlaceVo>();
			// 카카오API를 통한 임시좌표 변수
			String imsi_x = "";
			String imsi_y = "";
			// 카카오 API
			try {
				search_text_rplace = URLEncoder.encode(search_text_rplace, "utf-8");
				System.out.printf("카카오인코딩%s",search_text_rplace);
				String kakaoAK = "KakaoAK 6b374997db253e62e6e35773bd3daf88";
				// 검색 조건 : 키워드로 장소 검색
				String urlStr = String.format("https://dapi.kakao.com/v2/local/search/keyword.json?query=%s", search_text_rplace);
				URL k_url = new URL(urlStr);
				HttpURLConnection connection = (HttpURLConnection) k_url.openConnection();
				// 발급받은 key
				connection.setRequestProperty("Authorization", kakaoAK);
				connection.setRequestProperty("Content-Type", "application/plain");
				connection.connect();
	
				InputStreamReader isr = new InputStreamReader(connection.getInputStream(), "utf-8");
				BufferedReader br = new BufferedReader(isr);
	
				String k_sb = "";
				String k_line;
				while ((k_line = br.readLine()) != null) {
					k_sb = k_sb.concat(k_line);
					k_sb.concat(k_line);
					// ---------------------------------------
					JSONParser parser = new JSONParser();
	
					JSONObject obj = (JSONObject) parser.parse(k_sb);
					// 검색결과정보
					JSONObject meta = (JSONObject) obj.get("meta");
					// 검색목록
					JSONArray local_array = (JSONArray) obj.get("documents");
					for (int i = 0; i < local_array.size(); i++) {
						JSONObject local = (JSONObject) local_array.get(i);
						imsi_x = local.get("x").toString();
						imsi_y = local.get("y").toString();
					}
				}
				connection.disconnect();
				// 카카오에서 구한 좌표를 double 형변환
				double mapX = Double.parseDouble(imsi_x);
				double mapY = Double.parseDouble(imsi_y);
				//System.out.printf("좌표X=%f\n", mapX);
				//System.out.printf("좌표Y=%f\n", mapY);
				String serviceKey = "HUGsei948k7GTAIm951Gwaph5wGoiBzWrH7jKaVNWZ56lzC84RVFoXia4FQqpBlT3ncDyVnrgO%2BGaIG0gvp%2BOQ%3D%3D";
				String urlBuilder = "http://api.visitkorea.or.kr/openapi/service/rest/GoCamping/locationBasedList?"
						+ "serviceKey=" + serviceKey + "&MobileOS=ETC" + "&MobileApp=AppTest" + "&mapX=" + mapX + "&mapY="
						+ mapY + "&radius=15000" + "&_type=json";
	
				URL url = new URL(urlBuilder);
				//System.out.printf("URL=%s\n",url);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");
				BufferedReader rd;
				if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); // "UTF-8" 하여 받는 데이터 인코딩
				} else {
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
				}
				String sb = "";
				String line;
				while ((line = rd.readLine()) != null) {
					sb = sb.concat(line);
				}
				// 최종 데이터가 있는 "item" 오브젝트까지 접근 및 JSON배열이기에 item은 배열선언
				JSONParser parser = new JSONParser();
				JSONObject obj = (JSONObject) parser.parse(sb);
				JSONObject parse_response = (JSONObject) obj.get("response");
				JSONObject parse_body = (JSONObject) parse_response.get("body");
				JSONObject parse_items = (JSONObject) parse_body.get("items");
				JSONArray parse_item = (JSONArray) parse_items.get("item");
				JSONObject camping_data;
								
				for (int i = 0; i < parse_item.size(); i++) {
					camping_data = (JSONObject) parse_item.get(i);
					RPlaceVo vo = new RPlaceVo();
					vo.setP_name((String) camping_data.get("facltNm"));
					vo.setP_addr((String) camping_data.get("addr1"));
					
					list.add(vo);
				}
				
				//System.out.printf("인코딩확인 %s",paging_text);
				//String search_filter = String.format("search_text_rplace=%s", search_text_rplace);
				 
				rd.close();
				conn.disconnect();
	
			} // end try-catch
			catch (Exception e) {
				 System.out.println(e.getMessage());
			}
			
			model.addAttribute("list", list);
			
			return "recommend_place/rplace_keyword_search";
	}// end-keyword_search
	
	
	
	
}
