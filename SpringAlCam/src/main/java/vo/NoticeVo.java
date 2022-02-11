package vo;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVo {

	int    no;
	int    comment_count;
	
	int    n_idx;
	String n_subject;
	String n_content;
	String n_regdate;
	String n_modifydate;
	String n_filename;
	int    n_readhit;
	String n_use_yn;
	int    m_idx;
	String m_name;
	
	MultipartFile n_photo;
	
	
	
	public int getComment_count() {
		return comment_count;
	}
	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	public MultipartFile getN_photo() {
		return n_photo;
	}
	public void setN_photo(MultipartFile n_photo) {
		this.n_photo = n_photo;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	public int getN_idx() {
		return n_idx;
	}
	public void setN_idx(int n_idx) {
		this.n_idx = n_idx;
	}
	public String getN_subject() {
		return n_subject;
	}
	public void setN_subject(String n_subject) {
		this.n_subject = n_subject;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public String getN_regdate() {
		return n_regdate;
	}
	public void setN_regdate(String n_regdate) {
		this.n_regdate = n_regdate;
	}
	public String getN_modifydate() {
		return n_modifydate;
	}
	public void setN_modifydate(String n_modifydate) {
		this.n_modifydate = n_modifydate;
	}
	public String getN_filename() {
		return n_filename;
	}
	public void setN_filename(String n_filename) {
		this.n_filename = n_filename;
	}
	public int getN_readhit() {
		return n_readhit;
	}
	public void setN_readhit(int n_readhit) {
		this.n_readhit = n_readhit;
	}
	public String getN_use_yn() {
		return n_use_yn;
	}
	public void setN_use_yn(String n_use_yn) {
		this.n_use_yn = n_use_yn;
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
	
	
	
	
	
}
