/*

create sequence seq_place_p_idx

create table place
(
	p_idx				  int 		   ,		--��ҹ�ȣ
	p_name		varchar2(100) not null ,		--��Ҹ�
	p_addr	    varchar2(200) not null ,		--�ּ�
	p_tel		varchar2(100) not null ,		--��ȭ��ȣ
	p_filename	varchar2(200)		   ,		--�̹���
	p_x			varchar2(200) 		   ,		--����
	p_y			varchar2(200) 					--�浵

)

--�⺻Ű
alter table place
	add constraint pk_place_idx primary key(p_idx);

select * from place


--���õ�����
insert into place values
(
	seq_place_p_idx.nextVal,
	'����ķ����',
	'�����',
	'02-123-1234',
	'abc.jpg',
	'100',
	'100'	
);

commit







*/