--모든 테이블 출력 하기

select * from tab;


--테이블 구조 확인하기
   -- select : 출력하기
   /*
   select 컬럼명. 
   from 테이블이름
   
   */
--1. employee 테이블의 모든 컬럼을 출력하라.
    -- 근로자 (고용자) 에 대한 정보를 저장
select * 
from employee;

--2. department 테이블의 모든 컬럼을 출력
   -- 부서에 대한 정보를 저장하는 테이블.
select *
from department;

-- 3. salgrade 의 모든 컬럼을 출력
    -- 판매 순위를 저장하는 테이블.
select *
from salgrade;


-- ====================================================================
-- 각 테이블의 각각의 컬럼 정보
-- 1. employee 테이블

select *
from employee;

/*
  ENO : 사원 번호 컬럼
  ENAME : 사원 이름
  JOP : 직책
  MANAGER : 상관
  HIREDATE : 입사일
  SALARY : 월급
  COMMISSION : 보너스
  DNO : 부서
  
*/


--2. 부서 정보를 저장하는 테이블
select * from department;

/*
 DNO : 부서번호
 DNAME : 부서이름
 LOC : 부서위치
*/

--3. 판매 순위를 저장하는 테이블
select * from salgrade;
/*
GRADE : 월급의 순위
LOSAL : 제일 낮은 월급
HISAL : 제일 높은 월급
*/

---------------------------------------
-- select : 출력하라.
select *
from employee;

-- 특정 컬럼만 출력 하기
select eno
from employee;

-- 특정 컬럼 여러개 출력하기 ( 하나의 컬럼이 끝날 경우 , 구별

select ename
from employee;

select eno, ename, salary
from employee;

select eno,ename,job,manager,hiredate,salary,commission,dno,eno
from employee;

-- 테이블 구조 확인하기
Describe employee;
desc employee;

-- 컬럼을 별칭으로 출력하기
select eno as 사원번호, ename 사원명 , job as 직책
from employee;

desc employee;
select eno 사원번호 , ename 사원명 , job 직책, manager 사수번호, hiredate 고용일자, salary 월급, commission 보너스, dno 부서번호
from employee;


-- 조건을 사용하여 출력하기 : where
select *
from employee
where eno = 7499;     -- 조건을 사용해서 출력 할 경우 , eno 컬럼의 값이 7499 출력

desc employee;  -- < == employee 테이블의 구조를 확인

-- 값을 출력시 : number 데이터 타입의 값은 ' ' 없이 출력
-- number 이외의 데이터 타입은  ' ' : char , varchar , date

select *
from employee
where job = 'MANAGER';

select *
from employee
where dno = 20;

-- <문제> 

-- salary (월급) 2000만원 이상인 사용자만 출력.
select eno 사원번호, ename 사원이름 ,salary 월급
from employee
where salary >= 2000;

-- 이름이 clark 인 사용자의 월급만 출력
select eno 사원번호, ename 사원이름 ,salary 월급
from employee
where ename = 'CLARK';

-- 사원 번호 (ENO) 7788 인 이름과 입사날짜를 출력.
select eno 사원번호, ename 사원이름 , hiredate 입사날짜
from employee
where eno = 7788;


---- select 문의 전체 구조 -------------
--위에서 아래로 순서대로 위치해야 한다.

--select [select distinct] 컬럼명 : * (모든컬럼), 중복된 값 제거 select  [select distinct]
--from   -- 테이블명 , 뷰이름
--where  -- 조건
--group by  -- 컬럼명 : 특정 컬럼의 동일한 값을 그룹핑
--Having    -- group by에서 나온 결과를 조건을 처리
--Order by  -- 정렬해서 출력 할 컬럼, asc : 어쎈딩 내림차순 정령, decs : 디센딩 오름차순

select distinct dno  -- dno 하나의 컬럼만 사용해야한다. 두개사용하면 이상함.
from employee;

select *
from employee;

-- 컬럼에 연산을 적용 : 컬럼명이 없어짐, alias(별칭) 해서 출력
select eno 사원번호,ename 이름,salary as 월급 ,salary*12 as 연봉 ,commission 보너스
from employee;


-- 전체 연봉 구하기 : 월급 * 12 + commission = 전체 연금
-- null 컬럼과 연산을 하게되면 null 이 나오게 된다.
select eno,ename,salary,commission, salary*12 as 연봉, (salary*12)+commission as 전체연봉
from employee;

-- 전체 연봉을 계산할때 null 들어간 컬럼을 0으로 변경 후 연산을 적용해야 한다.
     -- nvl 함수 : null이 들어간 컬럼을 다른 값으로 변환 해서 처리 nvl(commission,0) 커미션 컬럼의 null 값을 0으로 바꾸는 명령어.

select eno,ename,salary,commission, salary*12 as 연봉, (salary*12)+nvl(commission,0) as 전체연봉
from employee;

-- null 이 들어간 컬럼을 출력 하기 < == 주의

select *
from employee
where commission is null; -- null을 검색할때는 is 를 사용해야한다. = 이퀄 사용하면 안됨.


select *
from employee
where commission is not null;

-- where 조건에서 and, or 사용 하기.

-- 부서번호가 20번인 모든 컬럼 출력.
select *
from employee
where dno = 20 or dno = 30;

select *
from employee
where salary <= 1500 and dno = 20;

-- job (직책) manager 이면서 월급이 2000 이상인 사용자만 출력 ,
select *
from employee
where job = 'MANAGER' and salary >= 2000;



--   employee 테이블에서 작업
--<문제1> 컬럼 알리어스(별칭) , commission(보너스 컬럼의 null 인 값만 출력하되 사원번호, 사원이름, 입사날짜 를 출력.
--<문제2> dno(부서번호) 가 20이고 입사 날짜가 81년 4월 이후 사원의 이름과 직책과 입사날짜를 출력.
--<문제3> 연봉을 계산해서 사원번호, 사원이름, 월급, 보너스 , 전체 연봉을 출력
--<문제4> commission 이 null이 아닌 사용자의 이름만 출력
--<문제5> manager (직급상사) 7698 인 사원이름과 직책을 출력.
--<문제6> 월급이 1500 이상이고 부서가 20인 사원의 사원이름과 입사날짜 부서번호, 월급을 출력.
--<문제7> 입사날짜가 81년 4월 이상이고 81년 12월 말일까지인 사원이름과 입사날짜를 출력.
--<문제8> 직책(job) salesman 이면서 연봉이 2000 이상이면서 부서번호가 20인 사원명을 출력.
--<문제9> 월급이 1500 이하이면서 부서 번호가 20번이 아닌 사원이름과, 월급과, 부서번호를 출력
--<문제10> 사원번호(eno) 가 7788, 7782 인 부서번호와 이름과 직책을 출력.


















