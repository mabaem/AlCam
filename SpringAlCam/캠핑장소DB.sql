/*

create sequence seq_place_p_idx

create table place
(
	p_idx				  int 		   ,		--장소번호
	p_name		varchar2(100) not null ,		--장소명
	p_addr	    varchar2(200) not null ,		--주소
	p_tel		varchar2(100) not null ,		--전화번호
	p_filename	varchar2(200)		   ,		--이미지
	p_x			varchar2(200) 		   ,		--위도
	p_y			varchar2(200) 					--경도

)

--기본키
alter table place
	add constraint pk_place_idx primary key(p_idx);

select * from place


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