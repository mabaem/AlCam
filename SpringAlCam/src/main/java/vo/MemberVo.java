package vo;

import org.springframework.web.multipart.MultipartFile;

public class MemberVo {

	
	int    m_idx;
	String m_name;
	String m_id;
	String m_pwd;
	int    m_byear;
	int    m_bmonth;
	int    m_bday;
	String m_gender;
	String m_tel;
	String m_addr;
	String m_zipcode;
	String m_email;
	String m_grade;
	String m_filename;
	String m_regdate;
	String filename;
	
	MultipartFile photo;

	//조회 시 비밀번호 보안처리
	String m_pwd_hidden;
	
	
	public MemberVo() {
		// TODO Auto-generated constructor stub
	}

	public MemberVo(int m_idx, String m_name, String m_id, String m_pwd, int m_byear, int m_bmonth, int m_bday,
			String m_gender, String m_tel, String m_addr, String m_zipcode, String m_email, String m_grade,
			String m_filename, String m_regdate) {
		super();
		this.m_idx = m_idx;
		this.m_name = m_name;
		this.m_id = m_id;
		this.m_pwd = m_pwd;
		this.m_byear = m_byear;
		this.m_bmonth = m_bmonth;
		this.m_bday = m_bday;
		this.m_gender = m_gender;
		this.m_tel = m_tel;
		this.m_addr = m_addr;
		this.m_zipcode = m_zipcode;
		this.m_email = m_email;
		this.m_grade = m_grade;
		this.m_filename = m_filename;
		this.m_regdate = m_regdate;
	}

	//조회 시 비밀번호 보안처리
	public String getM_pwd_hidden() {
		
		int len = m_pwd.length();
		
		StringBuffer sb = new StringBuffer();
		sb.append(m_pwd.substring(0, len/2));
		
		for(int i=0; i<(len-len/2); i++)
			sb.append("*");
		
		return sb.toString();
	}
	
	public MultipartFile getPhoto() {
		return photo;
	}
	
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}


	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pwd() {
		return m_pwd;
	}
	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}
	public int getM_byear() {
		return m_byear;
	}
	public void setM_byear(int m_byear) {
		this.m_byear = m_byear;
	}
	public int getM_bmonth() {
		return m_bmonth;
	}
	public void setM_bmonth(int m_bmonth) {
		this.m_bmonth = m_bmonth;
	}
	public int getM_bday() {
		return m_bday;
	}
	public void setM_bday(int m_bday) {
		this.m_bday = m_bday;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}
	public String getM_tel() {
		return m_tel;
	}
	public void setM_tel(String m_tel) {
		this.m_tel = m_tel;
	}
	public String getM_addr() {
		return m_addr;
	}
	public void setM_addr(String m_addr) {
		this.m_addr = m_addr;
	}
	public String getM_zipcode() {
		return m_zipcode;
	}
	public void setM_zipcode(String m_zipcode) {
		this.m_zipcode = m_zipcode;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_grade() {
		return m_grade;
	}
	public void setM_grade(String m_grade) {
		this.m_grade = m_grade;
	}
	public String getM_filename() {
		return m_filename;
	}
	public void setM_filename(String m_filename) {
		this.m_filename = m_filename;
	}

	public String getM_regdate() {
		return m_regdate;
	}

	public void setM_regdate(String m_regdate) {
		this.m_regdate = m_regdate;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
	
}
