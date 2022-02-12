/*

create sequence seq_bookmark_bmk_goods_g_idx

create table bookmark_goods
(
	bmk_g_idx				  int,		         --용품즐겨찾기번호
	bmk_g_cnt                 int  not null,     --수량
	m_idx					  int,		         --회원번호	
	g_idx					  int		         --용품번호
)

--기본키
alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

--외래키
alter table bookmark_goods
      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
                                     references  membertb(m_idx) 
                                     on delete cascade ;
	                                          
alter table bookmark_goods
      add constraint  fk_bookmark_goods_g_idx foreign key(g_idx)
                                         references goods(g_idx) 
                                         on delete cascade ; 

--Join을 통해서 View 생성
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

select * from goods
select * from membertb

select * from bookmark_goods
select * from bmk_goods_view;

-- 북마크 샘플데이터(캠핑용품 및 멤버 데이터 있어야 함)             bmk_g_cnt m_idx   g_idx 
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      1)
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      2)
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      3)
insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      4)

--캠핑용품 샘플데이터
insert into goods values
(
	seq_goods_g_idx.nextVal,
	'차박텐트X2020',
	50000,
	'텐트,침낭',
	'default_img.png',
	'www.naver.com'
);

insert into goods values
(
	seq_goods_g_idx.nextVal,
	'차박텐트X2021',
	70000,
	'텐트,침낭',
	'default_img.png',
	'www.naver.com'
);

insert into goods values
(
	seq_goods_g_idx.nextVal,
	'차박텐트X2022',
	120000,
	'텐트,침낭',
	'default_img.png',
	'www.naver.com'
);

insert into goods values
(
	seq_goods_g_idx.nextVal,
	'차박텐트X2023',
	120000,
	'텐트,침낭',
	'default_img.png',
	'www.naver.com'
);


--테이블, 뷰, 시퀀스 삭제
drop table    bookmark_goods
drop view     bmk_goods_view
drop sequence seq_bookmark_bmk_goods_g_idx

--장바구니 상품의 총계
select sum(amount) from bmk_goods_view;
select nvl(sum(amount),0) from bmk_goods_view where m_idx=1


*/