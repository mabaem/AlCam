/*

 
   create sequence seq_notice_n_idx
   
   --���̺�
   create table notice
   (
   		n_idx  			    int,				--�������ױ۹�ȣ
   		n_subject  varchar2(200)  not null,		--����
   		n_content  varchar2(2000) not null,		--����
   		n_regdate 	 	    date,				--�ۼ���¥
   		n_modifydate	    date,				--������¥
   		n_filename varchar2(200) ,				--���ϸ�
   		n_readhit	   		int,       			 --��ȸ��
   		m_idx               int    				--ȸ����ȣ
   		
   )
   
   //�⺻Ű
   alter table notice
      add constraint  pk_notice_idx primary key(n_idx) ;


	//�ܷ�Ű
	   alter table notice
	      add constraint  fk_notice_m_idx foreign key(m_idx)
	                                      references  membertb(m_idx) ;
	                                          
	   
	                                                                                              
	  select * from notice




















*/