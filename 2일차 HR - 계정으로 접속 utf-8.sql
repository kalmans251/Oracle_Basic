
-- 계정으로 접속한 ㅜ리
show user;

--현재 접속 한 계정에서 모든 테이블 출력
select * from tab;

-- 각 테이블의 구조 확인 : 컬럼 (자료형)
desc employee;
desc department;
desc salgrade;

-- 테이블의 각 컬럼에 저장된 값을 출력
select *
from employee;

--컬럼을 여러번 출력, 연산, 별칭 : 컬럼을 종결하는 것은 컴마 ,
select ename 사원명 ,salary 월급 , salary*12 "연 봉"
from employee;

--전체 연봉을 출력 : null 값을 처리, nvl(commission,0)
select ename 이름 ,salary*12+nvl(commission,0) 총연봉
from employee;

select * from employee;

    -- IN 연산자를 사용하지 않고, commission (보너스) : 300, 500 , 1400
    
select *
from employee
where commission = 300 or commission = 500 or commission = 1400;

-- IN 연산자를 사용
select *
from employee
where commission in (300,500,1400);

-- Between A and B    : A와 B 사이의 값을 출력
-- 입사월이 81년 1월 1일부터 81년 12월 31일 까지

select *
from employee
where hiredate between '81/01/01' and '81/12/31';

-- Like : 컬럼의 값을 검색해서 출력 할 때 사용.
       -- _ : 한글자가 어떤값이 와도 상관없음. [언더바]
       -- % : 모든 글자를 대체
-- 이름이 A 로 시작되는 모든 사원을 출력
select ename
from employee
where ename like 'A%';  --A로 시작되는 모든 값.

-- 한글자가 어떤 글자가 와도 상관없다.
select ename
from employee
where ename like '%LL%';


--
select ename
from employee
where ename like '_A%'; -- 두번째에 A 들어간 모든 값.

--job 컬럼의 MAN 이 들어간 사원
select *
from employee
where job like '%MAN%';

--정렬해서 출력하기 : order by 정렬 할 컬럼, 정렬방식  <== select 절에서 제일 마지막에 온다.
    --asc : 어센딩. 내림차순 작은값 -> 큰값,  A ==> Z
    --desc : 디센딩, 오름차순 큰값-> 작은값,  Z ==> A
    
SELECT * 
from employee
order by ename ; -- 어센딩은 생략되어있다. desc 은 명시해야한다.

SELECT * 
from employee
order by ename desc;

-- hiredat (입사날짜를 기준으로 정렬)
select *
from employee
order by hiredate desc;

--eno (사원 번호) 를 기준으로 내림차순으로 정리
select *
from employee
order by eno desc;

-- 조건을 적용해서 나온 결과를 정렬해서 출력 하기.


-- 81 년 입사한 사원만 출력하되 월급이 많은 순으로 출력하기
select ename,salary
from employee
where hiredate like '81%'
order by salary desc;

select ename,salary
from employee
where hiredate between '81/01/01' and '81/12/31'
order by salary desc;

