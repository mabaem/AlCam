package vo;

public class CampProductVo {

		
		int g_idx;
		String g_name;
		int g_price;
		String g_category;
		String g_filename;
		String g_link;
		
		public CampProductVo() {
			// TODO Auto-generated constructor stub
		}
		
		
		public CampProductVo(int g_idx, String g_name, int g_price, String g_category, String g_filename, String g_link) {
			super();
			this.g_idx = g_idx;
			this.g_name = g_name;
			this.g_price = g_price;
			this.g_category = g_category;
			this.g_filename = g_filename;
			this.g_link = g_link;
		}

		public String getG_link() {
			return g_link;
		}
		public void setG_link(String g_link) {
			this.g_link = g_link;
		}
		public int getG_idx() {
			return g_idx;
		}
		public void setG_idx(int g_idx) {
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
		public String getG_filename() {
			return g_filename;
		}
		public void setG_filename(String g_filename) {
			this.g_filename = g_filename;
		}
		
}
