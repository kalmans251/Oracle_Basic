--��� ���̺� ��� �ϱ�

select * from tab;


--���̺� ���� Ȯ���ϱ�
   -- select : ����ϱ�
   /*
   select �÷���. 
   from ���̺��̸�
   
   */
--1. employee ���̺��� ��� �÷��� ����϶�.
    -- �ٷ��� (�����) �� ���� ������ ����
select * 
from employee;

--2. department ���̺��� ��� �÷��� ���
   -- �μ��� ���� ������ �����ϴ� ���̺�.
select *
from department;

-- 3. salgrade �� ��� �÷��� ���
    -- �Ǹ� ������ �����ϴ� ���̺�.
select *
from salgrade;


-- ====================================================================
-- �� ���̺��� ������ �÷� ����
-- 1. employee ���̺�

select *
from employee;

/*
  ENO : ��� ��ȣ �÷�
  ENAME : ��� �̸�
  JOP : ��å
  MANAGER : ���
  HIREDATE : �Ի���
  SALARY : ����
  COMMISSION : ���ʽ�
  DNO : �μ�
  
*/


--2. �μ� ������ �����ϴ� ���̺�
select * from department;

/*
 DNO : �μ���ȣ
 DNAME : �μ��̸�
 LOC : �μ���ġ
*/

--3. �Ǹ� ������ �����ϴ� ���̺�
select * from salgrade;
/*
GRADE : ������ ����
LOSAL : ���� ���� ����
HISAL : ���� ���� ����
*/

---------------------------------------
-- select : ����϶�.
select *
from employee;

-- Ư�� �÷��� ��� �ϱ�
select eno
from employee;

-- Ư�� �÷� ������ ����ϱ� ( �ϳ��� �÷��� ���� ��� , ����

select ename
from employee;

select eno, ename, salary
from employee;

select eno,ename,job,manager,hiredate,salary,commission,dno,eno
from employee;

-- ���̺� ���� Ȯ���ϱ�
Describe employee;
desc employee;

-- �÷��� ��Ī���� ����ϱ�
select eno as �����ȣ, ename ����� , job as ��å
from employee;

desc employee;
select eno �����ȣ , ename ����� , job ��å, manager �����ȣ, hiredate �������, salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;


-- ������ ����Ͽ� ����ϱ� : where
select *
from employee
where eno = 7499;     -- ������ ����ؼ� ��� �� ��� , eno �÷��� ���� 7499 ���

desc employee;  -- < == employee ���̺��� ������ Ȯ��

-- ���� ��½� : number ������ Ÿ���� ���� ' ' ���� ���
-- number �̿��� ������ Ÿ����  ' ' : char , varchar , date

select *
from employee
where job = 'MANAGER';

select *
from employee
where dno = 20;

-- <����> 

-- salary (����) 2000���� �̻��� ����ڸ� ���.
select eno �����ȣ, ename ����̸� ,salary ����
from employee
where salary >= 2000;

-- �̸��� clark �� ������� ���޸� ���
select eno �����ȣ, ename ����̸� ,salary ����
from employee
where ename = 'CLARK';

-- ��� ��ȣ (ENO) 7788 �� �̸��� �Ի糯¥�� ���.
select eno �����ȣ, ename ����̸� , hiredate �Ի糯¥
from employee
where eno = 7788;


---- select ���� ��ü ���� -------------
--������ �Ʒ��� ������� ��ġ�ؾ� �Ѵ�.

--select [select distinct] �÷��� : * (����÷�), �ߺ��� �� ���� select  [select distinct]
--from   -- ���̺�� , ���̸�
--where  -- ����
--group by  -- �÷��� : Ư�� �÷��� ������ ���� �׷���
--Having    -- group by���� ���� ����� ������ ó��
--Order by  -- �����ؼ� ��� �� �÷�, asc : ���� �������� ����, decs : �𼾵� ��������

select distinct dno  -- dno �ϳ��� �÷��� ����ؾ��Ѵ�. �ΰ�����ϸ� �̻���.
from employee;

select *
from employee;

-- �÷��� ������ ���� : �÷����� ������, alias(��Ī) �ؼ� ���
select eno �����ȣ,ename �̸�,salary as ���� ,salary*12 as ���� ,commission ���ʽ�
from employee;


-- ��ü ���� ���ϱ� : ���� * 12 + commission = ��ü ����
-- null �÷��� ������ �ϰԵǸ� null �� ������ �ȴ�.
select eno,ename,salary,commission, salary*12 as ����, (salary*12)+commission as ��ü����
from employee;

-- ��ü ������ ����Ҷ� null �� �÷��� 0���� ���� �� ������ �����ؾ� �Ѵ�.
     -- nvl �Լ� : null�� �� �÷��� �ٸ� ������ ��ȯ �ؼ� ó�� nvl(commission,0) Ŀ�̼� �÷��� null ���� 0���� �ٲٴ� ��ɾ�.

select eno,ename,salary,commission, salary*12 as ����, (salary*12)+nvl(commission,0) as ��ü����
from employee;

-- null �� �� �÷��� ��� �ϱ� < == ����

select *
from employee
where commission is null; -- null�� �˻��Ҷ��� is �� ����ؾ��Ѵ�. = ���� ����ϸ� �ȵ�.


select *
from employee
where commission is not null;

-- where ���ǿ��� and, or ��� �ϱ�.

-- �μ���ȣ�� 20���� ��� �÷� ���.
select *
from employee
where dno = 20 or dno = 30;

select *
from employee
where salary <= 1500 and dno = 20;

-- job (��å) manager �̸鼭 ������ 2000 �̻��� ����ڸ� ��� ,
select *
from employee
where job = 'MANAGER' and salary >= 2000;



--   employee ���̺��� �۾�
--<����1> �÷� �˸��(��Ī) , commission(���ʽ� �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�, �Ի糯¥ �� ���.
--<����2> dno(�μ���ȣ) �� 20�̰� �Ի� ��¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���.
--<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ� , ��ü ������ ���
--<����4> commission �� null�� �ƴ� ������� �̸��� ���
--<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
--<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥ �μ���ȣ, ������ ���.
--<����7> �Ի糯¥�� 81�� 4�� �̻��̰� 81�� 12�� ���ϱ����� ����̸��� �Ի糯¥�� ���.
--<����8> ��å(job) salesman �̸鼭 ������ 2000 �̻��̸鼭 �μ���ȣ�� 20�� ������� ���.
--<����9> ������ 1500 �����̸鼭 �μ� ��ȣ�� 20���� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
--<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ���.


















