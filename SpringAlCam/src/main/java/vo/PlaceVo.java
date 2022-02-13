package vo;

public class PlaceVo {

	String p_idx;
	String p_name;
	String p_addr;
	String p_tel;
	String p_filename;
	

	public PlaceVo() {
		// TODO Auto-generated constructor stub
	}

	public PlaceVo(String p_idx, String p_name, String p_addr, String p_tel, String p_filename) {
		super();
		this.p_idx = p_idx;
		this.p_name = p_name;
		this.p_addr = p_addr;
		this.p_tel = p_tel;
		this.p_filename = p_filename;
	}
	public String getP_idx() {
		return p_idx;
	}
	public void setP_idx(String p_idx) {
		this.p_idx = p_idx;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_addr() {
		return p_addr;
	}
	public void setP_addr(String p_addr) {
		this.p_addr = p_addr;
	}
	public String getP_tel() {
		return p_tel;
	}
	public void setP_tel(String p_tel) {
		this.p_tel = p_tel;
	}
	public String getP_filename() {
		return p_filename;
	}
	public void setP_filename(String p_filename) {
		this.p_filename = p_filename;
	}


	
	
	
	
}
