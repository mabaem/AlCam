/*

 
   create sequence seq_notice_n_idx
   
   --테이블
   create table notice
   (
   		n_idx  			    int,				--공지사항글번호
   		n_subject  varchar2(200)  not null,		--제목
   		n_content  varchar2(2000) not null,		--내용
   		n_regdate 	 	    date,				--작성날짜
   		n_modifydate	    date,				--수정날짜
   		n_filename varchar2(200) ,				--파일명
   		n_readhit	   		int,       			 --조회수
   		m_idx               int    				--회원번호
   		
   )
   
   //기본키
   alter table notice
      add constraint  pk_notice_idx primary key(n_idx) ;


	//외래키
	   alter table notice
	      add constraint  fk_notice_m_idx foreign key(m_idx)
	                                      references  membertb(m_idx) ;
	                                          
	   
	                                                                                              
	  select * from notice




















*/