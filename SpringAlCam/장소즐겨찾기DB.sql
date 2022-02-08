/*

create sequence seq_bookmark_place_bmk_p_idx

create table bookmark_place
(
	bmk_p_idx				  int,		--장소즐겨찾기번호
	m_idx					  int,		--회원번호	
	p_idx					  int		--장소번호
	
)

--기본키
alter table bookmark_place
	add constraint pk_bookmark_place_idx primary key(bmk_p_idx);

//외래키
	   alter table bookmark_place
	      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table bookmark_place
	      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 

select * from bookmark_place



















*/