/*

create sequence seq_goods_g_idx

create table goods
(
	g_idx					  int 		   ,		--��ǰ��ȣ
	g_name			varchar2(100) not null ,		--��ǰ��
	g_price					  int not null ,		--����
	g_category	    varchar2(200) not null ,		--ī�װ�
	g_image			varchar2(200) 		   ,		--�̹���
	g_link			varchar2(200)					--��ũ
	
)

--�⺻Ű
alter table goods
	add constraint pk_goods_idx primary key(g_idx);

select * from goods



















*/