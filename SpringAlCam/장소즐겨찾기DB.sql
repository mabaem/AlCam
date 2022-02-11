/*

create sequence seq_bookmark_bmk_place_p_idx

create table bookmark_place
(
	bmk_p_idx				  int,		--장소즐겨찾기번호
	m_idx					  int,		--회원번호	
	p_idx					  int		--장소번호
)

--기본키
alter table bookmark_place
	add constraint pk_bookmark_place_idx primary key(bmk_p_idx);

--외래키
alter table bookmark_place
      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
                                     references  membertb(m_idx)
                                          on delete cascade ;
	                                          
alter table bookmark_place
      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
                                         references place(p_idx)
                                          on delete cascade ;
                                          
--Join을 통해서 View 생성
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

-- 북마크 샘플데이터(캠핑장 및 멤버 데이터 있어야 함)                  m_idx   p_idx 
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      1)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      2)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      3)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      4)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      5)
insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      6)


--캠핑장 샘플데이터
insert into place values
(
	seq_place_p_idx.nextVal,
	'난지캠핑장',
	'서울시',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'둘째캠핑장',
	'제주도',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'셋째캠핑장',
	'부산시',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'넷째캠핑장',
	'부산시',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'다섯째캠핑장',
	'부산시',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);

insert into place values
(
	seq_place_p_idx.nextVal,
	'여섯째캠핑장',
	'부산시',
	'02-123-1234',
	'default_img.png',
	'100',
	'100'	
);



--테이블, 뷰, 시퀀스 삭제
drop table    bookmark_place
drop view     bmk_place_view
drop sequence seq_bookmark_bmk_place_p_idx

select nvl(count(*),0) from bmk_place_view where m_idx=1

select * from
		(
			select
				rank() over(order by bmk_p_idx asc) as no,
				p.*
			from (select * from bmk_place_view where m_idx=1) p
		)
where no between 1 and 3


*/