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
   		use_yn   char(1) default 'y',   --사용유무(y or n)
   		readhit	 int      default 0,    --조회수
   		m_idx               int,     	--회원번호
   		m_name	varchar2(200),			--작성자이름
   		p_idx               int,    	--장소번호
   		p_name	varchar2(200),			--장소이름
   		p_addr	varchar2(200)			--장소주소
   )
   
   --기본키
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;


   --외래키
   alter table recommend_place
      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
   alter table recommend_place
      add constraint  fk_recommend_place_p_idx foreign key(p_idx)
	                                          references place(p_idx) ; 
	       

	
	--샘플데이터
	insert into recommend_place values
    (
   		seq_recommend_place_idx.nextVal,
   		'난지캠핑장',	--샘플_장소추천제목
   		'추천합니다',	--샘플_장소추천내용
   		'abc.jpg',	--샘플_장소추천파일명
   		'127.0.0.1',--샘플_장소추천ip
   		sysdate,	--작성일자
   		sysdate,	--수정일자
   		default,	--사용유무
   		default,	--조회수
   		1,			--샘플_장소추천m_idx
   		'일길동',		--샘플_장소추천m_name
   		1,			--샘플_장소추천p_idx
   		'난지캠핑장',	--샘플_장소추천p_name
   		'서울시'		--샘플_장소추천p_addr 		
    );
    
	insert into recommend_place values
    (
   		seq_recommend_place_idx.nextVal,
   		'오토캠핑장',	--샘플_장소추천제목
   		'강추',	--샘플_장소추천내용
   		'abcdef.jpg',	--샘플_장소추천파일명
   		'127.0.0.2',--샘플_장소추천ip
   		sysdate,	--작성일자
   		sysdate,	--수정일자
   		default,	--사용유무
   		default,	--조회수
   		1,			--샘플_장소추천m_idx
   		'일길동',		--샘플_장소추천m_name
   		1,			--샘플_장소추천p_idx
   		'난지캠핑장',	--샘플_장소추천p_name
   		'서울시'		--샘플_장소추천p_addr 	
    );

commit

                                                                                              
	select * from recommend_place
	  
	  

select * from membertb
select * from place




--테이블삭제
drop table recommend_place

	       
	       
	--사용유무 업데이트(삭제체크)
	update board set b_use_yn = 'y'
	


--조회수별 베스트글 10건 조회
select * from (select * from recommend_place order by readhit desc) where rownum <= 10;









*/