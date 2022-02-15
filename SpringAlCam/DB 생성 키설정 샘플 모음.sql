/*
 
 	<������ �� �迭>
 	[������,���̺� ���� -> ���� Ű ���� -> view ���� -> sample������]
 
	create sequence seq_notice_n_idx;
	
	 --���̺�
   create table notice
   (
   		n_idx  			    int,				--�������ױ۹�ȣ
   		n_subject  varchar2(200)  not null,		--����
   		n_content  varchar2(2000) not null,		--����
   		n_regdate 	 	    date,				--�ۼ���¥
   		n_modifydate	    date,				--������¥
   		n_filename varchar2(200) ,				--���ϸ�
   		n_readhit	int default 0,       		 --��ȸ��
   		n_use_yn char(1)	default 'y',		--�������(y or n)
   		m_idx               int  ,  			--ȸ����ȣ
   		m_name		varchar2(200) 				--�ۼ��ڸ�
   );

	create sequence seq_commenttb_c_idx;
	
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
   );

	create sequence seq_bookmark_bmk_goods_g_idx;

	create table bookmark_goods
	(
		bmk_g_idx				  int,		         --��ǰ���ã���ȣ
		bmk_g_cnt                 int  not null,     --����
		m_idx					  int,		         --ȸ����ȣ	
		g_idx					  varchar2(400)		 --��ǰ��ȣ
	);

	create sequence seq_bookmark_bmk_place_p_idx;

	create table bookmark_place
	(
		bmk_p_idx				  int,		--������ã���ȣ
		m_idx					  int,		--ȸ����ȣ	
		p_idx			varchar2(500)		--��ҹ�ȣ
	);
	
	 create sequence seq_recommend_place_idx;

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
   );

	create table goods
	(
		g_idx			varchar2(400)		   ,		--��ǰ��ȣ
		g_name			varchar2(400) not null ,		--��ǰ��
		g_price					  int not null ,		--����
		g_category	    varchar2(200) not null ,		--ī�װ�
		g_image			varchar2(200) 		   ,		--�̹���
		g_link			varchar2(200)					--��ũ
		
	);

	create sequence seq_place_p_idx;

	create table place
	(
		p_idx		varchar2(500)		   ,		--��ҹ�ȣ
		p_name		varchar2(500) not null ,		--��Ҹ�
		p_addr	    varchar2(200) not null ,		--�ּ�
		p_tel		varchar2(100) not null ,		--��ȭ��ȣ
		p_filename	varchar2(1000)		   			--�̹���

	
	);
	
	--�Ϸù�ȣ ������ü
	create sequence seq_membertb_m_idx;
	
	create table membertb
	(
		m_idx							int ,		--�Ϸù�ȣ
	 	m_name		 varchar2(100) not null , 		--�̸�
		m_id		 varchar2(100) not null , 		--���̵�
		m_pwd		 varchar2(100) not null ,		--��й�ȣ
		m_byear		 int not null ,					--����
		m_bmonth	 int not null ,					--����
		m_bday		 int not null ,					--����
		m_gender	 varchar2(100) not null ,		--����
		m_tel		 varchar2(100) not null ,		--��ȭ
		m_addr		 varchar2(200) not null ,		--�ּ�
		m_zipcode    varchar2(100),                 --�����ȣ
		m_email		 varchar2(100) not null ,		--�̸���
		m_grade 	 varchar2(100) ,				--ȸ������
		m_filename	 varchar2(200) ,				--ȸ������
		m_regdate	 date 							--��������
	);

-----------------------------------------------------------------------
	//�⺻Ű, �ܷ�Ű �� 
	
	--�⺻Ű
   alter table notice
      add constraint  pk_notice_idx primary key(n_idx) ;

	--�⺻Ű
   alter table commenttb
      add constraint  pk_commenttb_c_idx primary key(c_idx) ;

	
	--�⺻Ű
	alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

	--�⺻Ű
	alter table bookmark_place
		add constraint pk_bookmark_place_idx primary key(bmk_p_idx);
	
	--�⺻Ű
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;
      
      --�⺻Ű
	alter table goods
		add constraint pk_goods_idx primary key(g_idx);
	
	--�⺻Ű
	alter table place
		add constraint pk_place_idx primary key(p_idx);
		
	--�⺻Ű
	alter table membertb
		add constraint pk_membertb_idx primary key(m_idx);
	
	--unique
	alter table membertb
		add constraint unique_membertb_id unique(m_id);

	--�ܷ�Ű
	alter table notice
	  add constraint  fk_notice_m_idx foreign key(m_idx)
	                                      references  membertb(m_idx) ;

	--�ܷ�Ű
	   alter table commenttb
	      add constraint  fk_commenttb_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table commenttb
	      add constraint  fk_commenttb_b_idx foreign key(idx)
	                                          references recommend_place(idx) ; 
	
	--�ܷ�Ű
	alter table bookmark_goods
	      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
	                                     references  membertb(m_idx) 
	                                     on delete cascade ;
		                                            
	alter table bookmark_goods
	      add constraint  fk_bookmark_goods_g_idx foreign key(g_idx)
	                                         references goods(g_idx) 
	                                         on delete cascade ; 
	
	--�ܷ�Ű
	alter table bookmark_place
	      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
	                                     references  membertb(m_idx)
	                                          on delete cascade ;
		                                          
	alter table bookmark_place
	      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
	                                         references place(p_idx)
	                                          on delete cascade ;
	
   --�ܷ�Ű
   alter table recommend_place
      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
   
	
------------------------------------------------------------------------	

	
		--Join�� ���ؼ� View ����
	create or replace view bmk_goods_view
	as
		select
		   g.g_idx as g_idx,
		   bmk_g_idx, 
		   g_name,
		   g_price,
		   g_category,
		   g_image,
		   g_link,
		   bmk_g_cnt,
		   bmk_g_cnt* g_price as amount,
		   m_idx
	from goods g inner join  bookmark_goods b on g.g_idx = b.g_idx  ;

	--Join�� ���ؼ� View ����
	create or replace view bmk_place_view
	as
		select
		   p.p_idx as p_idx,
		   bmk_p_idx, 
		   p_name,
		   p_addr,
		   p_tel,
		   p_filename,
		   m_idx
	from place p inner join  bookmark_place b on p.p_idx = b.p_idx  ; 


-----------------------------------------------------------------------



	--sample data(�����Դϴ�)
	insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '�ϱ浿',
                             'one',
                             '1234',
                             '1980',
                             '1',
                             '31',
                             '����',
                             '010-222-1111',
                             '����� ���Ǳ� ������',
                             '12345',
                             'javaspring@naver.com',
                             '�Ϲ�',
                             'file3',
                             sysdate
                            );
                            
	insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '�̱浿',
                             'two',
                             '1234',
                             '1988',
                             '1',
                             '3',
                             '����',
                             '010-222-1111',
                             '����� ���Ǳ� ��õ����',
                             '12345',
                             'javaspring@gmail.com',
                             '�Ϲ�',
                             'file3',
                            sysdate
                            );

	--ķ�ο�ǰ ���õ�����
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'������ƮX2020',
		50000,
		'��Ʈ,ħ��',
		'default_img.png',
		'www.naver.com'
	);
	
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'������ƮX2021',
		70000,
		'��Ʈ,ħ��',
		'default_img.png',
		'www.naver.com'
	);
	
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'������ƮX2022',
		120000,
		'��Ʈ,ħ��',
		'default_img.png',
		'www.naver.com'
	);
	
	--ķ���� ���õ�����
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'����ķ����',
		'�����',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);
	
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'��°ķ����',
		'���ֵ�',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);
	
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'��°ķ����',
		'�λ��',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);


		-- �ϸ�ũ ���õ�����(ķ�ο�ǰ �� ��� ������ �־�� ��)          			   bmk_g_cnt 	m_idx   g_idx 
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      1);
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      2);
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      3);

	-- �ϸ�ũ ���õ�����(ķ���� �� ��� ������ �־�� ��)                  m_idx   p_idx 
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      1);
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      2);
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      3);

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
   		1,			--����_�����õp_idx
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
   		1,			--����_�����õp_idx
   		'����ķ����',	--����_�����õp_name
   		'�����'		--����_�����õp_addr 	
    );
	
	--���õ�����
	insert into place values
	(
		12930,
		'����ķ����',
		'�����',
		'02-123-1234',
		'abc.jpg'
	);
	
	
	--��� ���õ�����
update membertb set m_filename='sample' where m_idx=4

insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '���̾�',
                             'lion',
                             'lion1234',
                             '2022',
                             '1',
                             '1',
                             '����',
                             '01012345678',
                             '���� ���Ǳ� ������ 552',
                             '08768',
                             'javaspring@naver.com',
                             '�Ϲ�',
                             'sample',
                             sysdate
);

insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '����ġ',
                             'peach',
                             'peach1234',
                             '2022',
                             '1',
                             '1',
                             '����',
                             '01012345678',
                             '���� ���Ǳ� ������ 552',
                             '08768',
                             'javaspring@naver.com',
                             '�Ϲ�',
                             'sample',
                             sysdate
);


insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '������'
                             'admin',
                             '1234',
                             '2022',
                             '1',
                             '1',
                             '����',
                             '01012345678',
                             '���� ���Ǳ� ������ 552',
                             '08768',
                             'javaspring@naver.com',
                             '������',
                             'sample',
                             sysdate
);

	

commit

*/