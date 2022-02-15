/*
 
 	<가나다 순 배열>
 	[시퀀스,테이블 생성 -> 제약 키 설정 -> view 생성 -> sample데이터]
 
	create sequence seq_notice_n_idx;
	
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
   );

	create sequence seq_commenttb_c_idx;
	
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
   );

	create sequence seq_bookmark_bmk_goods_g_idx;

	create table bookmark_goods
	(
		bmk_g_idx				  int,		         --용품즐겨찾기번호
		bmk_g_cnt                 int  not null,     --수량
		m_idx					  int,		         --회원번호	
		g_idx					  varchar2(400)		 --용품번호
	);

	create sequence seq_bookmark_bmk_place_p_idx;

	create table bookmark_place
	(
		bmk_p_idx				  int,		--장소즐겨찾기번호
		m_idx					  int,		--회원번호	
		p_idx			varchar2(500)		--장소번호
	);
	
	 create sequence seq_recommend_place_idx;

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
   		p_name	varchar2(200),			--장소이름
   		p_addr	varchar2(200)			--장소주소
   );

	create table goods
	(
		g_idx			varchar2(400)		   ,		--용품번호
		g_name			varchar2(400) not null ,		--용품명
		g_price					  int not null ,		--가격
		g_category	    varchar2(200) not null ,		--카테고리
		g_image			varchar2(200) 		   ,		--이미지
		g_link			varchar2(200)					--링크
		
	);

	create sequence seq_place_p_idx;

	create table place
	(
		p_idx		varchar2(500)		   ,		--장소번호
		p_name		varchar2(500) not null ,		--장소명
		p_addr	    varchar2(200) not null ,		--주소
		p_tel		varchar2(100) not null ,		--전화번호
		p_filename	varchar2(1000)		   			--이미지

	
	);
	
	--일련번호 관리객체
	create sequence seq_membertb_m_idx;
	
	create table membertb
	(
		m_idx							int ,		--일련번호
	 	m_name		 varchar2(100) not null , 		--이름
		m_id		 varchar2(100) not null , 		--아이디
		m_pwd		 varchar2(100) not null ,		--비밀번호
		m_byear		 int not null ,					--생년
		m_bmonth	 int not null ,					--생월
		m_bday		 int not null ,					--생일
		m_gender	 varchar2(100) not null ,		--성별
		m_tel		 varchar2(100) not null ,		--전화
		m_addr		 varchar2(200) not null ,		--주소
		m_zipcode    varchar2(100),                 --우편번호
		m_email		 varchar2(100) not null ,		--이메일
		m_grade 	 varchar2(100) ,				--회원구분
		m_filename	 varchar2(200) ,				--회원사진
		m_regdate	 date 							--가입일자
	);

-----------------------------------------------------------------------
	//기본키, 외래키 순 
	
	--기본키
   alter table notice
      add constraint  pk_notice_idx primary key(n_idx) ;

	--기본키
   alter table commenttb
      add constraint  pk_commenttb_c_idx primary key(c_idx) ;

	
	--기본키
	alter table bookmark_goods
	add constraint pk_bookmark_goods_idx primary key(bmk_g_idx);

	--기본키
	alter table bookmark_place
		add constraint pk_bookmark_place_idx primary key(bmk_p_idx);
	
	--기본키
   alter table recommend_place
      add constraint  pk_recommend_place_idx primary key(idx) ;
      
      --기본키
	alter table goods
		add constraint pk_goods_idx primary key(g_idx);
	
	--기본키
	alter table place
		add constraint pk_place_idx primary key(p_idx);
		
	--기본키
	alter table membertb
		add constraint pk_membertb_idx primary key(m_idx);
	
	--unique
	alter table membertb
		add constraint unique_membertb_id unique(m_id);

	--외래키
	alter table notice
	  add constraint  fk_notice_m_idx foreign key(m_idx)
	                                      references  membertb(m_idx) ;

	--외래키
	   alter table commenttb
	      add constraint  fk_commenttb_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
	                                          
	   alter table commenttb
	      add constraint  fk_commenttb_b_idx foreign key(idx)
	                                          references recommend_place(idx) ; 
	
	--외래키
	alter table bookmark_goods
	      add constraint  fk_bookmark_goods_m_idx foreign key(m_idx)
	                                     references  membertb(m_idx) 
	                                     on delete cascade ;
		                                            
	alter table bookmark_goods
	      add constraint  fk_bookmark_goods_g_idx foreign key(g_idx)
	                                         references goods(g_idx) 
	                                         on delete cascade ; 
	
	--외래키
	alter table bookmark_place
	      add constraint  fk_bookmark_place_m_idx foreign key(m_idx)
	                                     references  membertb(m_idx)
	                                          on delete cascade ;
		                                          
	alter table bookmark_place
	      add constraint  fk_bookmark_place_p_idx foreign key(p_idx)
	                                         references place(p_idx)
	                                          on delete cascade ;
	
   --외래키
   alter table recommend_place
      add constraint  fk_recommend_place_m_idx foreign key(m_idx)
	                                          references  membertb(m_idx) ;
   
	
------------------------------------------------------------------------	

	
		--Join을 통해서 View 생성
	create or replace view bmk_goods_view
	as
		select
		   g.g_idx as g_idx,
		   bmk_g_idx, 
		   g_name,
		   g_price,
		   g_category,
		   g_image,
		   g_link,
		   bmk_g_cnt,
		   bmk_g_cnt* g_price as amount,
		   m_idx
	from goods g inner join  bookmark_goods b on g.g_idx = b.g_idx  ;

	--Join을 통해서 View 생성
	create or replace view bmk_place_view
	as
		select
		   p.p_idx as p_idx,
		   bmk_p_idx, 
		   p_name,
		   p_addr,
		   p_tel,
		   p_filename,
		   m_idx
	from place p inner join  bookmark_place b on p.p_idx = b.p_idx  ; 


-----------------------------------------------------------------------



	--sample data(샘플입니다)
	insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '일길동',
                             'one',
                             '1234',
                             '1980',
                             '1',
                             '31',
                             '남자',
                             '010-222-1111',
                             '서울시 관악구 시흥대로',
                             '12345',
                             'javaspring@naver.com',
                             '일반',
                             'file3',
                             sysdate
                            );
                            
	insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '이길동',
                             'two',
                             '1234',
                             '1988',
                             '1',
                             '3',
                             '여자',
                             '010-222-1111',
                             '서울시 관악구 석천빌딩',
                             '12345',
                             'javaspring@gmail.com',
                             '일반',
                             'file3',
                            sysdate
                            );

	--캠핑용품 샘플데이터
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'차박텐트X2020',
		50000,
		'텐트,침낭',
		'default_img.png',
		'www.naver.com'
	);
	
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'차박텐트X2021',
		70000,
		'텐트,침낭',
		'default_img.png',
		'www.naver.com'
	);
	
	insert into goods values
	(
		seq_goods_g_idx.nextVal,
		'차박텐트X2022',
		120000,
		'텐트,침낭',
		'default_img.png',
		'www.naver.com'
	);
	
	--캠핑장 샘플데이터
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'난지캠핑장',
		'서울시',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);
	
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'둘째캠핑장',
		'제주도',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);
	
	insert into place values
	(
		seq_place_p_idx.nextVal,
		'셋째캠핑장',
		'부산시',
		'02-123-1234',
		'default_img.png',
		'100',
		'100'	
	);


		-- 북마크 샘플데이터(캠핑용품 및 멤버 데이터 있어야 함)          			   bmk_g_cnt 	m_idx   g_idx 
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      1);
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      2);
	insert into bookmark_goods values(seq_bookmark_bmk_goods_g_idx.nextVal, 1,      1,      3);

	-- 북마크 샘플데이터(캠핑장 및 멤버 데이터 있어야 함)                  m_idx   p_idx 
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      1);
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      2);
	insert into bookmark_place values(seq_bookmark_bmk_place_p_idx.nextVal,  1,      3);

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
	
	--샘플데이터
	insert into place values
	(
		12930,
		'난지캠핑장',
		'서울시',
		'02-123-1234',
		'abc.jpg'
	);
	
	
	--멤버 샘플데이터
update membertb set m_filename='sample' where m_idx=4

insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '라이언',
                             'lion',
                             'lion1234',
                             '2022',
                             '1',
                             '1',
                             '남자',
                             '01012345678',
                             '서울 관악구 시흥대로 552',
                             '08768',
                             'javaspring@naver.com',
                             '일반',
                             'sample',
                             sysdate
);

insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '어피치',
                             'peach',
                             'peach1234',
                             '2022',
                             '1',
                             '1',
                             '여자',
                             '01012345678',
                             '서울 관악구 시흥대로 552',
                             '08768',
                             'javaspring@naver.com',
                             '일반',
                             'sample',
                             sysdate
);


insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '관리자'
                             'admin',
                             '1234',
                             '2022',
                             '1',
                             '1',
                             '남자',
                             '01012345678',
                             '서울 관악구 시흥대로 552',
                             '08768',
                             'javaspring@naver.com',
                             '관리자',
                             'sample',
                             sysdate
);

	

commit

*/