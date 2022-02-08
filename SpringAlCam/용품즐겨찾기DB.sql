/*

create sequence seq_bookmark_goods_bmk_g_idx

create table bookmark_goods
(
	bmk_g_idx				  int,		--용품즐겨찾기번호
	m_idx					  int,		--회원번호	
	p_idx					  int		--장소번호
	
)

--기본키
alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

//외래키
	   alter table bookmark_goods
	      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table bookmark_goods
	      add constraint  fk_bookmark_goods_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 

select * from bookmark_goods



















*/