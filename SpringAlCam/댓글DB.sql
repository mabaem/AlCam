/*
 --�Ϸù�ȣ 
   create sequence seq_commenttb_c_idx
   
   --���̺�
   create table commenttb
   (
   		c_idx  				  int,		--��۹�ȣ
   		c_content  varchar2(2000),		--����
   		c_ip	   varchar2(200),		--������
   		c_regdate  date,				--�������
   		m_idx				  int,		--ȸ����ȣ
   		m_id	   varchar2(100),       --ȸ�����̵�
   		m_name	   varchar2(100),		--ȸ���� 	
   		m_filename varchar2(200),		--ȸ������
   		idx                 int      	--�Խñ۹�ȣ
   )
   
   //�⺻Ű
   alter table commenttb
      add constraint  pk_commenttb_c_idx primary key(c_idx) ;


	//�ܷ�Ű
	   alter table commenttb
	      add constraint  fk_commenttb_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) 
	                                          
	   alter table commenttb
	      add constraint  fk_commenttb_b_idx foreign key(idx)
	                                          references recommend_place(idx) ; 
	                                                                                              
	  select * from commenttb

























*/