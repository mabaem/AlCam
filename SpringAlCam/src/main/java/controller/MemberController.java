package controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	
	//ȸ������ ��ȸ ������
	@RequestMapping("/member/list.do")
	public String list(Model model, @RequestParam(value="m_idx", defaultValue="0", required = false) int m_idx) {
		
		List<MemberVo> list = member_dao.selectList();
		MemberVo user_vo    = member_dao.selectOne(m_idx);
		
		model.addAttribute("list",list);
		model.addAttribute("user_vo",user_vo);
		
		return "member/member_list";
	}
	
	
	//�α���������
	@RequestMapping("/member/login_form.do")
	public String login_form() {
		return "member/member_login_form";
	}
	
	
	//�α���
	@RequestMapping("/member/login.do")
	public String login(String m_id, String m_pwd,
			            @RequestParam(value="url",defaultValue="") String url,
			            Model model) {
		
		//System.out.println(url);
		
		//m_id�� �ش�Ǵ� vo ���´�
		MemberVo user = member_dao.selectOne(m_id);
		
		//���̵� Ʋ�����
		if(user==null) {
			
			model.addAttribute("reason", "fail_id");
						
			return "redirect:login_form.do";
		}
		
		//��й�ȣ Ʋ�����
		if(user.getM_pwd().equals(m_pwd)==false) {
			
			model.addAttribute("reason", "fail_pwd");
			
			return "redirect:login_form.do";
		}
		
		//�α��� �� ��� -> �α��������� ���ǿ� ����
		session.setAttribute("user", user);
			
		//url�� ����ִ� ���
		if(url.isEmpty()) {

			return "redirect:list.do?m_idx=" + user.getM_idx();
		}
		
		//���� �������� �ִ°�� : �ش� �������� �̵�
		return "redirect:" + url;
	}
	
	//�α׾ƿ�
	@RequestMapping("/member/logout.do")
	public String logout() {
		
		//session���� �α����� user���� ����
		session.removeAttribute("user");
		
		return "redirect:list.do";
	}
	
	//ȸ������ �Է���
	@RequestMapping("/member/insert_form.do")
	public String insert_form() {
		
		return "member/member_insert_form";
	}

	//ȸ������
	@RequestMapping("/member/insert.do")
	public String insert(MemberVo vo, 
			              @RequestParam(value="m_byear")  int m_byear, 
			              @RequestParam(value="m_bmonth") int m_bmonth, 
			              @RequestParam(value="m_bday")   int m_bday) throws Exception {
		
		//�����ʻ���
		//�����->����(������)
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
		
		String filename = "no_file";
		MultipartFile photo = vo.getPhoto();
		
		//������ ���� ���ε� �� �� ��� �⺻���� ����
		if(photo.isEmpty()) {
			filename = "default_img.png";
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
		
		vo.setM_filename(filename);
		
		
		//�������
		vo.setM_byear(m_byear);
		vo.setM_bmonth(m_bmonth);
		vo.setM_bday(m_bday);
		
		
		//ȸ�����
		vo.setM_grade("�Ϲ�");
		
		
		//DB insert
		int res = member_dao.insert(vo);
		
		return "redirect:list.do";
	}

	//ȸ������ �� ���̵� �ߺ� üũ
	@RequestMapping("/member/check_id.do")
	@ResponseBody
	public Map check_id(String m_id) {
		MemberVo vo = member_dao.selectOne(m_id);
		
		boolean bResult = true;
		
		//m_id �ߺ� ��
		if(vo != null)
			bResult = false;
		
		Map map = new HashMap();
		map.put("result", bResult);
		
		return map;
	}
	
	//�̸��� ����
	@RequestMapping(value = "/member/check_email.do", method = RequestMethod.GET)
	@ResponseBody
	public String check_email(String m_email) throws Exception{
	    int random_key = (int)((Math.random()* (99999 - 10000 + 1)) + 10000);

	    String from = "alcamcompany@gmail.com";
	    String to = m_email;
	    String title = "[AlCam] ȸ������ ������ȣ�Դϴ�.";
	    String content = "[������ȣ] "+ random_key +" �Դϴ�. <br> ������ȣ Ȯ�ζ��� �����ϼ���.";
	    String num = "";
	    
	    try {
	    	
	    	MimeMessage mail = mailSender.createMimeMessage();
	        MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	        
	        mailHelper.setFrom(from);
	        mailHelper.setTo(to);
	        mailHelper.setSubject(title);
	        mailHelper.setText(content, true);       
	        
	        mailSender.send(mail);
	        
	        //���� ���� �� ������ȣ ����
	        num = Integer.toString(random_key);
	        
	    } catch(Exception e) {
	    	//���� ����
	        num = "fail";
	    }
	    
	    return num;
	}
	
	//������ ����
	@RequestMapping("/member/modify_form.do")
	public String modify_form(int m_idx, Model model) {
	
		MemberVo vo = member_dao.selectOne(m_idx);

		model.addAttribute("vo", vo);
		
		return "member/member_modify_form";
	}

	//����
	@RequestMapping("/member/modify.do")
	public String modify(MemberVo vo,
						 @RequestParam(value="m_grade")  String m_grade, 
						 @RequestParam(value="m_byear")  int    m_byear, 
			             @RequestParam(value="m_bmonth") int    m_bmonth, 
			             @RequestParam(value="m_bday")   int    m_bday) {
			
		//�������
		vo.setM_byear(m_byear);
		vo.setM_bmonth(m_bmonth);
		vo.setM_bday(m_bday);
		
		//ȸ�����
		vo.setM_grade(m_grade);
		
		int res = member_dao.update(vo);
		
		return "redirect:list.do?m_idx=" + vo.getM_idx();
	}
	
	//�����ʻ��� ����
	@RequestMapping(value="/member/photo_upload.do", method=RequestMethod.POST)
	@ResponseBody
	public Map photo_upload(MultipartHttpServletRequest req) throws Exception {
		
		//���� ȭ�� ����
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);
			
		int m_idx = Integer.parseInt(req.getParameter("m_idx"));

		MemberVo vo = member_dao.selectOne(m_idx);
		
		if(!vo.getM_filename().equals("default_img.png")) {
			File f_origin = new File(absPath, vo.getM_filename());	
			f_origin.delete();
		}
		
		//����� ȭ�Ϸ� ���ε�
		String filename = "no_file";
		MultipartFile photo = req.getFile("photo");

		filename = photo.getOriginalFilename();

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

		vo.setM_filename(filename);
		
		int res = member_dao.update_img(vo);
		
		Map map = new HashMap();
		map.put("filename", filename);
		
		return map;
	}
	
	//������ ȸ������
	@RequestMapping("/member/delete.do")
	public String delete(int m_idx) {
		
		//���� ������ȭ�� ����
		String webPath = "/resources/image/";
		String absPath = application.getRealPath(webPath);

		MemberVo vo = member_dao.selectOne(m_idx);
		
		if(!vo.getM_filename().equals("default_img.png")) {
			File f_origin = new File(absPath, vo.getM_filename());	
			f_origin.delete();
		}
				
		int res = member_dao.delete(m_idx);
		
		return "redirect:list.do";
	}
	
	//ȸ��Ż��
	@RequestMapping("/member/delete_mem.do")
	public String delete_mem(int m_idx) {
		
		//���� ������ȭ�� ����
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
	
}
