/*

create sequence seq_bookmark_place_bmk_p_idx

create table bookmark_place
(
	bmk_p_idx				  int,		--������ã���ȣ
	m_idx					  int,		--ȸ����ȣ	
	p_idx					  int		--��ҹ�ȣ
	
)

--�⺻Ű
alter table bookmark_place
	add constraint pk_bookmark_place_idx primary key(bmk_p_idx);

//�ܷ�Ű
	   alter table bookmark_place
	      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table bookmark_place
	      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 

select * from bookmark_place



















*/