--1. 3개 레코드 삽입 , 모든 값 입력 , null 이 허용된 컬럼 null 넣기.
insert into emp(eno,ename,job,manager,hiredate,salary,commission,dno)
values (1234,'김동준','코더',4325,'22/3/4',1000,100,10);     

insert into emp  --이름만입력 나머지는 null
values (null,'김동준',null,null,null,null,null,null);

insert into emp(ename) --이름만입력 나머지는 null
values ('김동준1');

--2.
update emp   --scott 의 보너스 500으로 수정
set commission = 500
where ename = 'SCOTT';

update emp --영업사원의 보너스 300 만원으로 수정,
set commission = 300
where job = 'SALESMAN';

update emp --ward 의 부서를 10번으로 수정
set dno = 10
where ename = 'WARD';

update emp --allen의 manager를 7839, 월급을 1800, 입사일 22/01/01로 수정
set manager = 7839,salary =1800, hiredate=to_date(220101,'YY/MM/DD')
where ename = 'ALLEN';

--3. delete : eno 7782 와 ,eno 7698 을 삭제
delete emp
where eno in (7782,7698);

commit;
rollback;

