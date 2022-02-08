/*


--�Ϸù�ȣ ������ü
create sequence seq_membertb_m_idx

create table membertb
(
	m_idx							int ,		--�Ϸù�ȣ
 	m_name		 varchar2(100) not null , 		--�̸�
	m_id		 varchar2(100) not null , 		--���̵�
	m_pwd		 varchar2(100) not null ,		--��й�ȣ
	m_byear		 int not null ,					--����
	m_bmonth	 int not null ,					--����
	m_bday		 int not null ,					--����
	m_gender	 varchar2(100) not null ,		--����
	m_tel		 varchar2(100) not null ,		--��ȭ
	m_addr		 varchar2(200) not null ,		--�ּ�
	m_zipcode    varchar2(100),                 --�����ȣ
	m_email		 varchar2(100) not null ,		--�̸���
	m_grade 	 varchar2(100) ,				--ȸ������
	m_filename	 varchar2(200) ,				--ȸ������
	m_regdate	 date 							--��������
)

--�⺻Ű
alter table membertb
	add constraint pk_membertb_idx primary key(m_idx);

--unique
alter table membertb
	add constraint unique_membertb_id unique(m_id);


--sample data(�����Դϴ�)
insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '�ϱ浿',
                             'one',
                             '1234',
                             '1980',
                             '1',
                             '31',
                             '����',
                             '010-222-1111',
                             '����� ���Ǳ� ������',
                             '12345',
                             'javaspring@naver.com',
                             '�Ϲ�',
                             'file3',
                             sysdate
                            );
                            
insert  into membertb  values( (select nvl(max(m_idx),0) + 1 from membertb),
                             '�̱浿',
                             'two',
                             '1234',
                             '1988',
                             '1',
                             '3',
                             '����',
                             '010-222-1111',
                             '����� ���Ǳ� ��õ����',
                             '12345',
                             'javaspring@gmail.com',
                             '�Ϲ�',
                             'file3',
                            sysdate
                            );
select * from membertb

commit


*/