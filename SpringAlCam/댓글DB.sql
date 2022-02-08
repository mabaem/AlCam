/*
 --일련번호 
   create sequence seq_commenttb_c_idx
   
   --테이블
   create table commenttb
   (
   		c_idx  				  int,		--댓글번호
   		c_content  varchar2(2000),		--내용
   		c_ip	   varchar2(200),		--아이피
   		c_regdate  date,				--등록일자
   		m_idx				  int,		--회원번호
   		m_id	   varchar2(100),       --회원아이디
   		m_name	   varchar2(100),		--회원명 	
   		m_filename varchar2(200),		--회원사진
   		idx                 int      	--게시글번호
   )
   
   //기본키
   alter table commenttb
      add constraint  pk_commenttb_c_idx primary key(c_idx) ;


	//외래키
	   alter table commenttb
	      add constraint  fk_commenttb_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) 
	                                          
	   alter table commenttb
	      add constraint  fk_commenttb_b_idx foreign key(idx)
	                                          references recommend_place(idx) ; 
	                                                                                              
	  select * from commenttb

























*/