--   employee ���̺��� �۾�

select *
from employee;

--<����1> �÷� �˸��(��Ī) , commission(���ʽ� �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�, �Ի糯¥ �� ���.
select eno �����ȣ, ename ����̸�,hiredate �Ի糯¥
from employee
where commission is null;

--<����2> dno(�μ���ȣ) �� 20�̰� �Ի� ��¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���.
select ename ����̸�,job ��å,hiredate �Ի糯¥
from employee
where dno = 20 and hiredate > '81/04/01';

--<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ� , ��ü ������ ���
select eno �����ȣ, ename ����̸�,salary ����,commission ���ʽ�, (salary*12) + nvl(commission,0) ����
from employee;

--<����4> commission �� null�� �ƴ� ������� �̸��� ���
select ename ����̸�
from employee
where commission is not null;

--<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
select ename ����̸�,job ��å
from employee
where job = 'MANAGER' and eno = 7698;

--<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥ �μ���ȣ, ������ ���.
select ename ����̸�,hiredate �Ի糯¥,dno �μ���ȣ,salary ����
from employee
where salary >= 1500 and dno = 20;

--<����7> �Ի糯¥�� 81�� 4�� �̻��̰� 81�� 12�� ���ϱ����� ����̸��� �Ի糯¥�� ���.
select ename ����̸�,hiredate �Ի糯¥
from employee
where hiredate >= '81/04/01' and hiredate <= '81/12/31';

--<����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���.
select ename ����̸�
from employee
where job = 'SALESMAN' and salary >= 1500 and dno =30;

--<����9> ������ 1500 �����̸鼭 �μ� ��ȣ�� 20���� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
select ename ����̸�,salary ����, dno �μ���ȣ
from employee
where salary <= 1500 and dno != 20;

--<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ���.
select dno �μ���ȣ, ename ����̸�,job ��å
from employee
where eno = 7788 or eno = 7782;

