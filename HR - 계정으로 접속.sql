
--1. HR �������� ���� Ȯ�� : resource : ���̺� ����, ����, ����.
show user;

--2. ���̺� ����,   ; <== �����ݷ� ������ �ϳ��� ��ɾ ó���Ǵ� ���
create table myTbl2 (
id varchar2(20),
pass varchar2(20)
);




--3. ���̺� �� �ֱ�: commit (�����϶�)
insert into myTbl2 values ( '1' , '1234' );
commit;    -- DB�� ���������� �����϶�. (Insert , Update , Delete �������� ���)


--4. ���̺��� ���� ����ϱ�
select * from myTbl2;

--5. ���̺� ���� �ϱ�
drop table myTbl2;

--���� ������ Oracle ���� Ȯ��
select * from v$version;

--������ DataBase �� �����ϴ� ��� ���̺� ����
select * from tab;