/*

create sequence seq_bookmark_bmk_goods_g_idx

create table bookmark_goods
(
	bmk_g_idx				  int,		         --��ǰ���ã���ȣ
	bmk_g_cnt                 int  not null,     --����
	m_idx					  int,		         --ȸ����ȣ	
	g_idx					  varchar2(400)		 --��ǰ��ȣ
)

select * from bookmark_goods
select * from goods

--�⺻Ű
alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

--�ܷ�Ű
alter table bookmark_goods
      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
                                     references  membertb(m_idx) 
                                     on delete cascade ;
	                                            
alter table bookmark_goods
      add constraint  fk_bookmark_goods_g_idx foreign key(g_idx)
                                         references goods(g_idx) 
                                         on delete cascade ; 

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
from goods g inner join  bookmark_goods b on g.g_idx = b.g_idx  

commit

-- �ϸ�ũ ���õ�����(ķ�ο�ǰ �� ��� ������ �־�� ��)          			   bmk_g_cnt 	m_idx   g_idx 
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      1)
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      2)
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      3)

--ķ�ο�ǰ ���õ�����
insert into goods values
(
	1,
	'������ƮX2020',
	50000,
	'��Ʈ,ħ��',
	'default_img.png',
	'www.naver.com'
);

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


--���̺�, ��, ������ ����
drop table    bookmark_goods
drop table    goods
drop table    membertb
drop view     bmk_goods_view
drop sequence seq_bookmark_bmk_goods_g_idx

delete from goods where g_category='����ǰ'

delete from bookmark_goods where bmk_g_idx=1
select * from bookmark_goods

--��ٱ��� ��ǰ�� �Ѱ�
select sum(amount) from bmk_goods_view;
select nvl(sum(amount),0) from bmk_goods_view where m_idx=1

*/