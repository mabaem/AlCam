/*

create sequence seq_bookmark_goods_bmk_g_idx

create table bookmark_goods
(
	bmk_g_idx				  int,		--��ǰ���ã���ȣ
	m_idx					  int,		--ȸ����ȣ	
	p_idx					  int		--��ҹ�ȣ
	
)

--�⺻Ű
alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

//�ܷ�Ű
	   alter table bookmark_goods
	      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table bookmark_goods
	      add constraint  fk_bookmark_goods_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 

select * from bookmark_goods



















*/