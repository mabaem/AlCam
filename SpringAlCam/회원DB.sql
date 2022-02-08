/*


--일련번호 관리객체
create sequence seq_membertb_m_idx

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
)

--기본키
alter table membertb
	add constraint pk_membertb_idx primary key(m_idx);

--unique
alter table membertb
	add constraint unique_membertb_id unique(m_id);


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
select * from membertb

commit


*/