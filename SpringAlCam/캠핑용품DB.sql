/*

create table goods
(
	g_idx			varchar2(400)		   ,		--용품번호
	g_name			varchar2(400) not null ,		--용품명
	g_price					  int not null ,		--가격
	g_category	    varchar2(200) not null ,		--카테고리
	g_image			varchar2(200) 		   ,		--이미지
	g_link			varchar2(200)					--링크
	
)

--기본키
alter table goods
	add constraint pk_goods_idx primary key(g_idx);


select * from goods

select * from goods where g_idx=5

delete from goods where g_idx between 1 and 147

drop sequence seq_goods_g_idx

select * from bookmark_goods

select * from bmk_goods_view where m_idx=1


*/