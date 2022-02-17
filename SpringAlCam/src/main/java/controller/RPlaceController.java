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
	
	//����Ʈ�� 4�� ��ȸ
	@RequestMapping("/recommend_place/best.do")
	public String best(Model model) {
		
		//�Խñ� ��ϰ�������
		List<RPlaceVo> res = rplace_dao.selectList();
		
		
		if(res.size() < 4) {
			return "recommend_place/rplace_best_list";
		}
		
		List<RPlaceVo> list = rplace_dao.selectBestList();
		
				
		//1��
		int idx1 = list.get(0).getIdx();
		String filename1 = list.get(0).getFilename();	
		String subject1 = list.get(0).getSubject();
		String m_name1 = list.get(0).getM_name();
		int readhit1 = list.get(0).getReadhit();
		
		
		//2��
		int idx2 = list.get(1).getIdx();
		String filename2 = list.get(1).getFilename();	
		String subject2 = list.get(1).getSubject();
		String m_name2 = list.get(1).getM_name();
		int readhit2 = list.get(1).getReadhit();
		
		
		//3��
		int idx3 = list.get(2).getIdx();
		String filename3 = list.get(2).getFilename();	
		String subject3 = list.get(2).getSubject();
		String m_name3 = list.get(2).getM_name();
		int readhit3 = list.get(2).getReadhit();
		
		
		//4��
		int idx4 = list.get(3).getIdx();
		String filename4 = list.get(3).getFilename();	
		String subject4 = list.get(3).getSubject();
		String m_name4 = list.get(3).getM_name();
		int readhit4 = list.get(3).getReadhit();
		
		
		
		
		model.addAttribute("res", res);
		model.addAttribute("list", list);
		
		model.addAttribute("idx1", idx1);
		model.addAttribute("filename1", filename1);
		model.addAttribute("subject1", subject1);
		model.addAttribute("m_name1", m_name1);
		model.addAttribute("readhit1", readhit1);

		model.addAttribute("idx2", idx2);
		model.addAttribute("filename2", filename2);
		model.addAttribute("subject2", subject2);
		model.addAttribute("m_name2", m_name2);
		model.addAttribute("readhit2", readhit2);

		model.addAttribute("idx3", idx3);
		model.addAttribute("filename3", filename3);
		model.addAttribute("subject3", subject3);
		model.addAttribute("m_name3", m_name3);
		model.addAttribute("readhit3", readhit3);

		model.addAttribute("idx4", idx4);
		model.addAttribute("filename4", filename4);
		model.addAttribute("subject4", subject4);
		model.addAttribute("m_name4", m_name4);
		model.addAttribute("readhit4", readhit4);
		

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
		String pageMenu = "";
		
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
		pageMenu = Paging.getPaging("list.do",
									search_filter,
				                    nowPage, 
				                    rowTotal, 
				                    MyConstant.RPlace.BLOCK_LIST,
				                    MyConstant.RPlace.BLOCK_PAGE
				                    );
		
		//System.out.printf("%s\n", pageMenu);
				
		//�Խñ� ��ϰ�������
		List<RPlaceVo> list = rplace_dao.selectList(map);
				
		//session�� �ôٴ� ������ ����
		session.removeAttribute("show");
		
		//model���ؼ� request binding
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("list", list);
		
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
	public String delete(int idx, @RequestParam(name="page",defaultValue="1") int page, String search, String search_text, Model model) {
		
		//���� ����ȭ�� ����
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		if(!vo.getFilename().equals("rplace_default_img.jpg")) {
			File f_origin = new File(absPath, vo.getFilename());	
			f_origin.delete();
		}

		int res = rplace_dao.update_use_yn(idx);
		
		res=rplace_dao.delete(idx);
		
		//��뵵? query�� ���
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);
		
		return "redirect:list.do"; //   list.do?page=3
	}
	
	
	//������ ����
	// /recommend_place/modify_form.do?b_idx=5
	@RequestMapping("/recommend_place/modify_form.do")
	public String modify_form(int idx, @RequestParam(name="page",defaultValue="1") int page, Model model) {
		
		//������ �Խù� ������
		RPlaceVo vo = rplace_dao.selectOne(idx);
		
		//model���ؼ� request binding
		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
		
		return "recommend_place/rplace_modify_form";
	}
	
	//�����ϱ�
	@RequestMapping("/recommend_place/modify.do")
	public String modify(RPlaceVo vo, @RequestParam(name="page",defaultValue="1") int page, String search, String search_text, Model model) throws Exception {
		
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
		
		String content = vo.getContent().replaceAll("\r\n", "<br>");
		vo.setContent(content);
		
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
		
		
		String content = vo.getContent().replaceAll("\r\n", "<br>");
		vo.setContent(content);
		
		//System.out.printf("%d %s", vo.getM_idx(), vo.getM_name());
		
		
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
	
	
	//�˾�â ����
	@RequestMapping("/recommend_place/popup.do")
	public String popup(){
		
		return "recommend_place/popup";
	}
	
	
	//��� Ű����� �˻�
	@RequestMapping("/recommend_place/keyword_search.do")
	public String keyword_search(@RequestParam(value = "search_text_rplace", defaultValue = "") String search_text_rplace,
							     Model model) {
			
			// �˻����� �� ������ ���� ��ü
			// ������ ������ ���� list ����
			List<RPlaceVo> list = new ArrayList<RPlaceVo>();
			// īī��API�� ���� �ӽ���ǥ ����
			String imsi_x = "";
			String imsi_y = "";
			// īī�� API
			try {
				search_text_rplace = URLEncoder.encode(search_text_rplace, "utf-8");
				//System.out.printf("īī�����ڵ�%s",search_text_rplace);
				String kakaoAK = "KakaoAK 6b374997db253e62e6e35773bd3daf88";
				// �˻� ���� : Ű����� ��� �˻�
				String urlStr = String.format("https://dapi.kakao.com/v2/local/search/keyword.json?query=%s", search_text_rplace);
				URL k_url = new URL(urlStr);
				HttpURLConnection connection = (HttpURLConnection) k_url.openConnection();
				// �߱޹��� key
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
					// �˻��������
					JSONObject meta = (JSONObject) obj.get("meta");
					// �˻����
					JSONArray local_array = (JSONArray) obj.get("documents");
					for (int i = 0; i < local_array.size(); i++) {
						JSONObject local = (JSONObject) local_array.get(i);
						imsi_x = local.get("x").toString();
						imsi_y = local.get("y").toString();
					}
				}
				connection.disconnect();
				// īī������ ���� ��ǥ�� double ����ȯ
				double mapX = Double.parseDouble(imsi_x);
				double mapY = Double.parseDouble(imsi_y);
				//System.out.printf("��ǥX=%f\n", mapX);
				//System.out.printf("��ǥY=%f\n", mapY);
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
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); // "UTF-8" �Ͽ� �޴� ������ ���ڵ�
				} else {
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
				}
				String sb = "";
				String line;
				while ((line = rd.readLine()) != null) {
					sb = sb.concat(line);
				}
				// ���� �����Ͱ� �ִ� "item" ������Ʈ���� ���� �� JSON�迭�̱⿡ item�� �迭����
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
				
				//System.out.printf("���ڵ�Ȯ�� %s",paging_text);
				//String search_filter = String.format("search_text_rplace=%s", search_text_rplace);
				 
				rd.close();
				conn.disconnect();
	
			} // end try-catch
			catch (Exception e) {
				 System.out.println(e.getMessage());
			}
			
			model.addAttribute("list", list);
			
			return "recommend_place/popup_result";
	}// end-keyword_search
	
	
	
	
}
