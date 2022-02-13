/*

create sequence seq_place_p_idx

create table place
(
	p_idx		varchar2(500) 		   ,		--장소번호
	p_name		varchar2(400) not null ,		--장소명
	p_addr	    varchar2(400) not null ,		--주소
	p_tel		varchar2(100) not null ,		--전화번호
	p_filename	varchar2(1000)		   		--이미지

)

--기본키
alter table place
	add constraint pk_place_idx primary key(p_idx);

select * from place


select p_idx from place where p_idx=2966

--샘플데이터
insert into place values
(
	seq_place_p_idx.nextVal,
	'난지캠핑장',
	'서울시',
	'02-123-1234',
	'abc.jpg',
	'100',
	'100'	
);

commit







*/