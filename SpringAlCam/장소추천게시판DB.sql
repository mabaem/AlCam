/*

 
   create sequence seq_recommend_place_idx
   
   --���̺�
   create table recommend_place
   (
   		idx  			    int,		--�Խñ۹�ȣ
   		subject  varchar2(200) not null,--����
   		content  varchar2(2000)not null,--����
   		filename varchar2(200) ,		--���ϸ�
   		ip	  	 varchar2(200) ,		--������
   		regdate 	 	   date,		--�ۼ���¥
   		modifydate		   date,		--������¥
   		readhit	   			int,        --��ȸ��
   		m_idx               int,     	--ȸ����ȣ
   		p_idx               int	    	--��ҹ�ȣ
   )
   
   //�⺻Ű
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;


	//�ܷ�Ű
	   alter table recommend_place
	      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table recommend_place
	      add constraint  fk_recommend_place_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 
	                                                                                              
	  select * from recommend_place




















*/