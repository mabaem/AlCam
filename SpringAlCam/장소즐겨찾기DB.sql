/*

create sequence seq_bookmark_bmk_place_p_idx

create table bookmark_place
(
	bmk_p_idx				  int,		--������ã���ȣ
	m_idx					  int,		--ȸ����ȣ	
	p_idx					  int		--��ҹ�ȣ
)

--�⺻Ű
alter table bookmark_place
	add constraint pk_bookmark_place_idx primary key(bmk_p_idx);

--�ܷ�Ű
alter table bookmark_place
      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
                                     references  membertb(m_idx)
                                          on delete cascade ;
	                                          
alter table bookmark_place
      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
                                         references place(p_idx)
                                          on delete cascade ;
                                          
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
from place p inner join  bookmark_place b on p.p_idx = b.p_idx                                           
         
commit                                                                           

select * from place
select * from membertb

select * from bookmark_place
select * from bmk_place_view;

-- �ϸ�ũ ���õ�����(ķ���� �� ��� ������ �־�� ��)                  m_idx   p_idx 
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      1)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      2)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      3)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      4)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      5)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      6)


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

insert into place values
(
	seq_place_p_idx.nextVal,
	'�ټ�°ķ����',
	'�λ��',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'����°ķ����',
	'�λ��',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);



--���̺�, ��, ������ ����
drop table    bookmark_place
drop view     bmk_place_view
drop sequence seq_bookmark_bmk_place_p_idx


*/