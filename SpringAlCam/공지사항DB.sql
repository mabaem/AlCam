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
   		n_readhit	int default 0,       		 --조회수
   		n_use_yn char(1)	default 'y',		--사용유무(y or n)
   		m_idx               int  ,  			--회원번호
   		m_name		varchar2(200) 				--작성자명
   )
   
   //기본키
   alter table notice
      add constraint  pk_notice_idx primary key(n_idx) ;


	//외래키
	   alter table notice
	      add constraint  fk_notice_m_idx foreign key(m_idx)
	                                      references  membertb(m_idx) ;
	                                          
	   
	                                                                                              
	  select * from notice





--select * from (select * from notice order by n_regdate asc) where <![CDATA[rownum <= 10]]>
--select * from (select * from notice order by n_regdate asc) where rownum <= 10














*/