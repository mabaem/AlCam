/*

create sequence seq_place_p_idx

create table place
(
	p_idx		varchar2(500) 		   ,		--��ҹ�ȣ
	p_name		varchar2(400) not null ,		--��Ҹ�
	p_addr	    varchar2(400) not null ,		--�ּ�
	p_tel		varchar2(100) not null ,		--��ȭ��ȣ
	p_filename	varchar2(1000)		   		--�̹���

)

--�⺻Ű
alter table place
	add constraint pk_place_idx primary key(p_idx);

select * from place


select p_idx from place where p_idx=2966

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