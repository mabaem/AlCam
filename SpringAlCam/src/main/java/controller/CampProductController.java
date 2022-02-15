package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import dao.BmkGoodsDao;
import dao.CampProductDao;
import myutil.MyProduct;
import myutil.Paging;
import vo.BmkGoodsVo;
import vo.CampProductVo;


@Controller
public class CampProductController {
	
	@Autowired
	HttpServletRequest request;

	CampProductDao campproduct_dao;
	
	public void setCampproduct_dao(CampProductDao campproduct_dao) {
		this.campproduct_dao = campproduct_dao;
	}

	@RequestMapping(value = "/goods/camp_list.do", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public String list( 
		@RequestParam(value = "p_name", defaultValue = "") String p_name,	
		@RequestParam(value = "page", defaultValue = "1") int nowPage,
		Model model) throws Exception{
		
		request.setCharacterEncoding("utf-8");
		
		// �˻����� �� ������ ���� ��ü
		String pageMenu = "";
		
		int start = (nowPage-1) * MyProduct.Product.BLOCK_LIST + 1;
		int display = MyProduct.Product.BLOCK_LIST;
		//����¡ ó���� ���� ��ü �˻� ���� ã��
		int rowTotal = 0;
		
		String clientID = "Agnln2mMFnjsK4Wa3o7D"; 
		String clientSecret = "ZWFfNy1ILS"; 
		
		try {
			p_name = URLEncoder.encode(p_name, "utf-8");
			String urlStr = String.format("https://openapi.naver.com/v1/search/shop.json?query=%s&start=%d&display=%d",
					         p_name,start,display
					);
		
		Map < String,String > requestHeaders = new HashMap<>(); 
	
		requestHeaders.put("X-Naver-Client-Id", clientID); 
		requestHeaders.put("X-Naver-Client-Secret", clientSecret); 
		
		String responseBody = get(urlStr, requestHeaders); 
		
		JSONParser parser = new JSONParser(); 
		JSONObject obj = (JSONObject)parser.parse(responseBody); 
		JSONArray item = (JSONArray)obj.get("items"); 
		
		try {
			//rowTotal = Integer.parseInt(obj.get("total").toString());
			//������ �����;����� total ���� 
			rowTotal = 100;
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		List < CampProductVo > list = new ArrayList<CampProductVo>(); 
		List < BmkGoodsVo > list2 = new ArrayList<BmkGoodsVo>(); 
		
		for (int i = 0; i < item.size(); i++) {
			CampProductVo vo = new CampProductVo(); 
			BmkGoodsVo vo2 = new BmkGoodsVo();
			 
			JSONObject tmp = (JSONObject)item.get(i); 
			
			String g_category = (String)tmp.get("category3");
			String g_name  = (String)tmp.get("title");
			String g_image = (String)tmp.get("image");
			int g_price=0;
				try {
					g_price = Integer.parseInt((String)tmp.get("lprice"));
				} catch (Exception e) {
					// TODO: handle exception
				}
			String g_link = (String)tmp.get("link");
			String g_idx = (String)tmp.get("productId");
			
			//�˻��� g_idx�� ������ DB���̺� ������ ����
			String table_idx =  campproduct_dao.selectlist(g_idx);
			
			vo.setG_category(g_category);
			vo.setG_name(g_name);
			vo.setG_image(g_image);
			vo.setG_price(g_price);
			vo.setG_link(g_link);
			vo.setG_idx(g_idx);
		
			list.add(vo);
			
			vo2.setG_category(g_category);
			vo2.setG_name(g_name);
			vo2.setG_image(g_image);
			vo2.setG_price(g_price);
			vo2.setG_link(g_link);
			
			list2.add(vo2);
			
			// API �����Ϳ� ���̺����� ��
			// ���̺� �����Ͱ� ���������� null return �Ǳ⿡ Objects.equals �� ��
			if(Objects.equals(g_idx, table_idx)) {
				//System.out.println("���ȣ��");
				
			}else{
				//System.out.println("����ȣ��");
				int res = campproduct_dao.insert(vo);
				
			}

			p_name = URLDecoder.decode(p_name, "utf-8");
			
			 pageMenu = Paging.getGoodsPaging( 
					                      p_name, 
					                      nowPage,
					 					  rowTotal,
					 					  MyProduct.Product.BLOCK_LIST,
					 					  MyProduct.Product.BLOCK_PAGE );
			 model.addAttribute("pageMenu", pageMenu);
			
		}//end-for

		model.addAttribute("list",list);
		model.addAttribute("list2",list2);
		
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "goods/camp_product_list";
	}
	
	
	
	///////////get,connect,readbody�� ���̹� ���� ���� �޼ҵ�, ��������� �ʿ�////////////////////////////////////////////////////
	
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // ���� ȣ��
                return readBody(con.getInputStream());
            } else { // ���� �߻�
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API ��û�� ���� ����", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL�� �߸��Ǿ����ϴ�. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("������ �����߽��ϴ�. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        
    	InputStreamReader streamReader=null;
		try {
			streamReader = new InputStreamReader(body,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API ������ �дµ� �����߽��ϴ�.", e);
        }
    }
	
	
	
}
