

create table MYTTBL (
ID varchar(10),
PASS varchar(10) );


insert into TABLE1 values('1','1234');
commit;

SELECT ID FROM TABLE1;


-- ���� �ּ� : ���α׷����� �ؼ� ���� �ʴ� ����
/*
������ �ּ�


*/

-- 1. HR ���� ���� : 12 ���� ���� ������ ������ ������ �տ� C##�� �ٿ��� �Ѵ�.
-- HR : ������ , ��ȣ : 1234
create user C##HR identified by 1234 ;

create user C##HR identified by 1234;

--2. HR ������ ���� �ο� : 
--  connect : ���ݿ��� DB�� ���� �� �� �ִ� ����.
--  resource: ��ü(resource)�� ����, ����, ����.
grant connect, resource to C##HR;

--3 . ���̺� �����̽� ���� �ο�.
  -- USER �� ���̺� �����̽��� ��뷮�� ������ ����� �� �ֵ��� ���� �ο�
alter user C##HR quota unlimited on users;

--4. ���� ����
drop user C##HR;

--5. ���� ���
show user;

select * from tab;

