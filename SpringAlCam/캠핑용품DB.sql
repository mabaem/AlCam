/*

create sequence seq_goods_g_idx

create table goods
(
	g_idx					  int 		   ,		--용품번호
	g_name			varchar2(100) not null ,		--용품명
	g_price					  int not null ,		--가격
	g_category	    varchar2(200) not null ,		--카테고리
	g_image			varchar2(200) 		   ,		--이미지
	g_link			varchar2(200)					--링크
	
)

--기본키
alter table goods
	add constraint pk_goods_idx primary key(g_idx);

select * from goods



















*/