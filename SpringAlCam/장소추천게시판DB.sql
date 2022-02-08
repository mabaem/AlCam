/*

 
   create sequence seq_recommend_place_idx
   
   --테이블
   create table recommend_place
   (
   		idx  			    int,		--게시글번호
   		subject  varchar2(200) not null,--제목
   		content  varchar2(2000)not null,--내용
   		filename varchar2(200) ,		--파일명
   		ip	  	 varchar2(200) ,		--아이피
   		regdate 	 	   date,		--작성날짜
   		modifydate		   date,		--수정날짜
   		readhit	   			int,        --조회수
   		m_idx               int,     	--회원번호
   		p_idx               int	    	--장소번호
   )
   
   //기본키
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;


	//외래키
	   alter table recommend_place
	      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table recommend_place
	      add constraint  fk_recommend_place_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 
	                                                                                              
	  select * from recommend_place




















*/