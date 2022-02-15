package vo;

public class BmkGoodsVo {
	
	int     bmk_g_idx;
	String  g_idx;
	String  g_name;
	int     g_price;
	String  g_category;
	String  g_image;
	String  g_link;
	int     bmk_g_cnt;
	int     amount;
	int     m_idx;
	
	public BmkGoodsVo() {
		// TODO Auto-generated constructor stub
	}
	
	public BmkGoodsVo(int bmk_g_idx, String g_idx, String g_name, int g_price, String g_category, String g_image,
			String g_link, int bmk_g_cnt, int amount, int m_idx) {
		super();
		this.bmk_g_idx = bmk_g_idx;
		this.g_idx = g_idx;
		this.g_name = g_name;
		this.g_price = g_price;
		this.g_category = g_category;
		this.g_image = g_image;
		this.g_link = g_link;
		this.bmk_g_cnt = bmk_g_cnt;
		this.amount = amount;
		this.m_idx = m_idx;
	}
	public int getBmk_g_idx() {
		return bmk_g_idx;
	}
	public void setBmk_g_idx(int bmk_g_idx) {
		this.bmk_g_idx = bmk_g_idx;
	}
	public String getG_idx() {
		return g_idx;
	}
	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public int getG_price() {
		return g_price;
	}
	public void setG_price(int g_price) {
		this.g_price = g_price;
	}
	public String getG_category() {
		return g_category;
	}
	public void setG_category(String g_category) {
		this.g_category = g_category;
	}
	public String getG_image() {
		return g_image;
	}
	public void setG_image(String g_image) {
		this.g_image = g_image;
	}
	public String getG_link() {
		return g_link;
	}
	public void setG_link(String g_link) {
		this.g_link = g_link;
	}
	public int getBmk_g_cnt() {
		return bmk_g_cnt;
	}
	public void setBmk_g_cnt(int bmk_g_cnt) {
		this.bmk_g_cnt = bmk_g_cnt;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	
	
	

}
