package myutil;
/*
        nowPage:����������
        rowTotal:��ü�����Ͱ���
        blockList:���������� �Խù���
        blockPage:��ȭ�鿡 ��Ÿ�� ������ �޴���
 */
public class Paging {
	
	public static String getPaging(String pageURL,int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*��ü��������*/,
            startPage/*������������ȣ*/,
            endPage;/*��������������ȣ*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //��� ��Ȳ�� �Ǵ��Ͽ� HTML�ڵ带 ������ ��
		
		
		isPrevPage=isNextPage=false;
		//�Էµ� ��ü �ڿ��� ���� ��ü ������ ���� ���Ѵ�..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList != 0)totalPage++;
		

		//���� �߸��� ����� ���������� ���Ͽ� ���� ������ ���� ��ü ������ ����
		//���� ��� ������ ���������� ���� ��ü ������ ������ ����
		if(nowPage > totalPage)nowPage = totalPage;
		

		//���� �������� ������ �������� ����.
		startPage = ((nowPage-1)/blockPage)*blockPage  +  1;
		endPage = startPage + blockPage - 1; //
				
		
		//������ ������ ���� ��ü������������ ũ�� ������������ ���� ����
		if(endPage > totalPage)endPage = totalPage;
		
		//�������������� ��ü���������� ���� ��� ���� ����¡�� ������ �� �ֵ���
		//boolean�� ������ ���� ����
		if(endPage < totalPage) isNextPage = true;
		//������������ ���� 1���� ������ ��������¡ ������ �� �ֵ��� ������
		if(startPage > 1)isPrevPage = true;
		
		//HTML�ڵ带 ������ StringBuffer����=>�ڵ����
		sb = new StringBuffer();
//-----�׷�������ó�� ���� --------------------------------------------------------------------------------------------		
		
		sb.append("<ul class='pagination'>");
		
		if(isPrevPage){
			
			sb.append(String.format("<li class='page-item previous'><a href='\"%s\"?page=%d'>����</a></li>", pageURL, (startPage-1)));

			//sb.append(String.format("<a href =\'%s\'?page=\'%d\'>��</a>", pageURL, (startPage-1)));
		}
		else
			sb.append("<li class='page-item previous disabled'><a href='#'>����</a></li>");
			//sb.append("��");
		
//------������ ��� ��� -------------------------------------------------------------------------------------------------
		//sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //���� �ִ� ������
				
				sb.append("<li class='active'><a href='#'>"+ i +"</a></li>");
				/*
				sb.append("&nbsp;<b><font color='red'>");
				sb.append("<span class='page_box'>");
				sb.append(i);
				sb.append("</span>");
				sb.append("</font></b>");
				*/
			}
			else{//���� �������� �ƴϸ�
				
				sb.append(String.format("<li><a href='"+pageURL+"?page="+i+"'>"));
				sb.append(i+"</a></li>");
				/*
				sb.append("&nbsp;<a href='"+pageURL+"?page=");
				sb.append(i);
				sb.append("'>");
				sb.append("<span class='page_box'>");
				sb.append(i);
				sb.append("</span>");
				sb.append("</a>");
				*/
			}
		}// end for
		
		//sb.append("&nbsp;|");
		
//-----�׷�������ó�� ���� ----------------------------------------------------------------------------------------------
		if(isNextPage){
			
			sb.append(String.format("<li class='page-item next'><a href='"+pageURL+"?page="+(endPage+1)+"'>����</a></li>"));

			/*
			sb.append("<a href='"+pageURL+"?page=");
			sb.append(endPage+1);
			sb.append("'>��</a>");
			*/
		}
		else
			sb.append("<li class='page-item next disabled'><a href='#'>����</a></li>");
			//sb.append("��");
		
		sb.append("</ul>");
		
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}//end-getPaging()
//---------------------------------------------------------------------------------------------------------------------	
public static String getPlacePaging(String text_search,int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*��ü��������*/,
            startPage/*������������ȣ*/,
            endPage;/*��������������ȣ*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //��� ��Ȳ�� �Ǵ��Ͽ� HTML�ڵ带 ������ ��
		
		
		isPrevPage=isNextPage=false;
		//�Էµ� ��ü �ڿ��� ���� ��ü ������ ���� ���Ѵ�..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList != 0)totalPage++;
		

		//���� �߸��� ����� ���������� ���Ͽ� ���� ������ ���� ��ü ������ ����
		//���� ��� ������ ���������� ���� ��ü ������ ������ ����
		if(nowPage > totalPage)nowPage = totalPage;
		

		//���� �������� ������ �������� ����.
		startPage = ((nowPage-1)/blockPage)*blockPage  +  1;
		endPage = startPage + blockPage - 1; //
				
		
		//������ ������ ���� ��ü������������ ũ�� ������������ ���� ����
		if(endPage > totalPage)endPage = totalPage;
		
		//�������������� ��ü���������� ���� ��� ���� ����¡�� ������ �� �ֵ���
		//boolean�� ������ ���� ����
		if(endPage < totalPage) isNextPage = true;
		//������������ ���� 1���� ������ ��������¡ ������ �� �ֵ��� ������
		if(startPage > 1)isPrevPage = true;
		
		//HTML�ڵ带 ������ StringBuffer����=>�ڵ����
		sb = new StringBuffer();
//-----�׷�������ó�� ���� --------------------------------------------------------------------------------------------		
		
		sb.append("<ul class='pagination'>");
		
		if(isPrevPage){
			System.out.printf("����¡�κ� %s",text_search);
			sb.append(String.format("<li class='page-item previous'><a href='#'  onclick='search_place(\"%s\",%d);'>����</a></li>", text_search, (startPage-1)));
			//sb.append(String.format("<a href ='#' onclick='search_place(\"%s\",%d);'>��</a>", text_search, (startPage-1)));
		}
		else
			sb.append("<li class='page-item previous disabled'><a href='#'>����</a></li>");
		
//------������ ��� ��� -------------------------------------------------------------------------------------------------
		
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //���� �ִ� ������
				
				sb.append("<li class='active'><a href='#'>"+ i +"</a></li>");
				
			}
			else{//���� �������� �ƴϸ�
				
				sb.append(String.format("<li><a href='#' onclick='search_place(\"%s\",%d);' >", text_search, i));
				sb.append(i+"</a></li>");	
				/*
				sb.append(String.format("&nbsp;<a href ='#' onclick='search_place(\"%s\",%d);'>", text_search, i));
				sb.append("<span class='page_box'>");
				sb.append(i);
				sb.append("</span>");
				sb.append("</a>");
				*/
			}
		}// end for
		
//-----�׷�������ó�� ���� ----------------------------------------------------------------------------------------------
		if(isNextPage){
			
			sb.append(String.format("<li class='page-item next'><a href='#' onclick='search_place(\"%s\",%d);'>����</a></li>", text_search, (endPage+1)));
			
			//sb.append(String.format("<a href ='#' onclick='search_place(\"%s\",%d);'>��</a>", text_search, (endPage+1)));
		}
		else
			sb.append("<li class='page-item next disabled'><a href='#'>����</a></li>");

		sb.append("</ul>");
		
//---------------------------------------------------------------------------------------------------------------------	    
		return sb.toString();
	}//end-getPlacePaging()	
	
//---------------------------------------------------------------------------------------------------------------------	
	//ķ�ο�ǰ ������ ����
	public static String getGoodsPaging(String p_name, int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*��ü��������*/,
            startPage/*������������ȣ*/,
            endPage;/*��������������ȣ*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //��� ��Ȳ�� �Ǵ��Ͽ� HTML�ڵ带 ������ ��
		
		
		isPrevPage=isNextPage=false;
		//�Էµ� ��ü �ڿ��� ���� ��ü ������ ���� ���Ѵ�..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList != 0)totalPage++;
		

		//���� �߸��� ����� ���������� ���Ͽ� ���� ������ ���� ��ü ������ ����
		//���� ��� ������ ���������� ���� ��ü ������ ������ ����
		if(nowPage > totalPage)nowPage = totalPage;
		

		//���� �������� ������ �������� ����.
		startPage = ((nowPage-1)/blockPage)*blockPage  +  1;
		endPage = startPage + blockPage - 1; //
				
		
		//������ ������ ���� ��ü������������ ũ�� ������������ ���� ����
		if(endPage > totalPage)endPage = totalPage;
		
		//�������������� ��ü���������� ���� ��� ���� ����¡�� ������ �� �ֵ���
		//boolean�� ������ ���� ����
		if(endPage < totalPage) isNextPage = true;
		//������������ ���� 1���� ������ ��������¡ ������ �� �ֵ��� ������
		if(startPage > 1)isPrevPage = true;
		
		//HTML�ڵ带 ������ StringBuffer����=>�ڵ����
		sb = new StringBuffer();
		
//-----�׷�������ó�� ���� --------------------------------------------------------------------------------------------		
		
		sb.append("<ul class='pagination'>");
		
		if(isPrevPage){
			
			sb.append(String.format("<li class='page-item previous'><a href='#'  onclick='search_product(\"%s\",%d);'>����</a></li>", p_name, (startPage-1)));
			
			//sb.append(String.format("<a href ='#' onclick='search_product(\"%s\",%d);'>��</a>", p_name, (startPage-1)));
			//sb.append("<a href ='#' onclick='search_product(" + p_name + "," +(startPage-1)  +");'>��</a>");
		}
		else
			sb.append("<li class='page-item previous disabled'><a href='#'>����</a></li>");
			//sb.append("��");
		
//------������ ��� ��� -------------------------------------------------------------------------------------------------
		//sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //���� �ִ� ������
				
				sb.append("<li class='active'><a href='#'>"+ i +"</a></li>");
				/*
				sb.append("&nbsp;<b><font color='black'>");
				sb.append("<span class='page_box'>");
				sb.append(i);
				sb.append("</span>");
				sb.append("</font></b>");
				*/
			}
			else{//���� �������� �ƴϸ�
				
				sb.append(String.format("<li><a href='#' onclick='search_product(\"%s\",%d);' >", p_name, i));
				sb.append(i+"</a></li>");
				
				//sb.append("&nbsp;<a href ='#' onclick='search_product(" + p_name + "," + i  +");'>");
				/*sb.append(String.format("&nbsp;<a href ='#' onclick='search_product(\"%s\",%d);'>", p_name, i));
				sb.append("<span class='page_box'>");
				sb.append(i);
				sb.append("</span>");
				sb.append("</a>");*/
			}
		}// end for
		
		//sb.append("&nbsp;|");
		
//-----�׷�������ó�� ���� ----------------------------------------------------------------------------------------------
		if(isNextPage){
			//String.format("<a href ='#' onclick='comment_list(%d));'>��</a>", endPage+1)
			//sb.append("<a href ='#' onclick='search_product(" + p_name +  ","+ (endPage+1)  +");'>��</a>");
			//sb.append(String.format("<a href ='#' onclick='search_product(\"%s\",%d);'>��</a>", p_name, (endPage+1)));
			
			sb.append(String.format("<li class='page-item next'><a href='#' onclick='search_product(\"%s\",%d);'>����</a></li>", p_name, (endPage+1)));

			
		}
		else
			sb.append("<li class='page-item next disabled'><a href='#'>����</a></li>");
			//sb.append("��");
		
		
		sb.append("</ul>");
		
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}//end-getGoodsPaging()
	
	
	
	
	
//---------------------------------------------------------------------------------------------------------------------	    
	
	//����¡ �˻���������
	//notice, rplace
	public static String getPaging(String pageURL,String search_filter,int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*��ü��������*/,
            startPage/*������������ȣ*/,
            endPage;/*��������������ȣ*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //��� ��Ȳ�� �Ǵ��Ͽ� HTML�ڵ带 ������ ��
		
		
		isPrevPage=isNextPage=false;
		//�Էµ� ��ü �ڿ��� ���� ��ü ������ ���� ���Ѵ�..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList != 0)totalPage++;
		

		//���� �߸��� ����� ���������� ���Ͽ� ���� ������ ���� ��ü ������ ����
		//���� ��� ������ ���������� ���� ��ü ������ ������ ����
		if(nowPage > totalPage)nowPage = totalPage;
		

		//���� �������� ������ �������� ����.
		startPage = ((nowPage-1)/blockPage)*blockPage  +  1;
		endPage = startPage + blockPage - 1; //
				
		
		//������ ������ ���� ��ü������������ ũ�� ������������ ���� ����
		if(endPage > totalPage)endPage = totalPage;
		
		//�������������� ��ü���������� ���� ��� ���� ����¡�� ������ �� �ֵ���
		//boolean�� ������ ���� ����
		if(endPage < totalPage) isNextPage = true;
		//������������ ���� 1���� ������ ��������¡ ������ �� �ֵ��� ������
		if(startPage > 1) isPrevPage = true;
		
		//HTML�ڵ带 ������ StringBuffer����=>�ڵ����
		sb = new StringBuffer();
		
//-----�׷�������ó�� ���� --------------------------------------------------------------------------------------------		
		sb.append("<ul class='pagination'>");
		
		
		if(isPrevPage){
			sb.append("<li class='page-item previous'><a href='"+pageURL+"?page="+(startPage-1)+"&"+search_filter+"'>����</a></li>");
			
			
		}
		else {
			
			sb.append("<li class='page-item previous disabled'><a href='#'>����</a></li>");

		}
		
		
//------������ ��� ��� -------------------------------------------------------------------------------------------------
	
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //���� �ִ� ������
				
				
				sb.append("<li class='active'><a href='#'>"+ i +"</a></li>");
				
			}
			else{//���� �������� �ƴϸ�
				sb.append("<li><a href='"+ pageURL +"?page="+ i +"&"+ search_filter +"'>"+ i +"</a></li>");
				
			}
		}// end for
		
		
		
		
//-----�׷�������ó�� ���� ----------------------------------------------------------------------------------------------
		

		if(isNextPage){
			
			sb.append("<li class='page-item next'><a href='"+pageURL+"?page="+(endPage+1)+"&"+search_filter+"'>����</a></li>");
			
		}
		else {
			sb.append("<li class='page-item next disabled'><a href='#'>����</a></li>");

		}
		
		sb.append("</ul>");
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}//end-getPaging()
	
	
	
	
	
}