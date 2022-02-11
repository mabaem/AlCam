/*
--���̺����
--drop table recommend_place



 
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
   		use_yn   char(1) default 'y',   --�������(y or n)
   		readhit	 int      default 0,    --��ȸ��
   		m_idx               int,     	--ȸ����ȣ
   		m_name	varchar2(200),			--�ۼ����̸�
   		p_name	varchar2(200),			--����̸�
   		p_addr	varchar2(200)			--����ּ�
   )
   
   --�⺻Ű
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;


   --�ܷ�Ű
   alter table recommend_place
      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;


	
	--���õ�����
	insert into recommend_place values
    (
   		seq_recommend_place_idx.nextVal,
   		'����ķ����',	--����_�����õ����
   		'��õ�մϴ�',	--����_�����õ����
   		'abc.jpg',	--����_�����õ���ϸ�
   		'127.0.0.1',--����_�����õip
   		sysdate,	--�ۼ�����
   		sysdate,	--��������
   		default,	--�������
   		default,	--��ȸ��
   		1,			--����_�����õm_idx
   		'�ϱ浿',		--����_�����õm_name
   		'����ķ����',	--����_�����õp_name
   		'�����'		--����_�����õp_addr 		
    );
    
	insert into recommend_place values
    (
   		seq_recommend_place_idx.nextVal,
   		'����ķ����',	--����_�����õ����
   		'����',	--����_�����õ����
   		'abcdef.jpg',	--����_�����õ���ϸ�
   		'127.0.0.2',--����_�����õip
   		sysdate,	--�ۼ�����
   		sysdate,	--��������
   		default,	--�������
   		default,	--��ȸ��
   		1,			--����_�����õm_idx
   		'�ϱ浿',		--����_�����õm_name
   		'����ķ����',	--����_�����õp_name
   		'�����'		--����_�����õp_addr 	
    );

commit

                                                                                              
select * from recommend_place
	  
	  

select * from membertb
select * from place






	       
	       
	--������� ������Ʈ(����üũ)
	update board set b_use_yn = 'y'
	


--��ȸ���� ����Ʈ�� 10�� ��ȸ
select * from (select * from recommend_place order by readhit desc) where rownum <= 10;









*/