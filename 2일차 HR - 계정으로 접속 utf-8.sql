
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

--보너스가 없는 사원들만 출력하되 이름을 내림 차순으로 정렬해서 출력

select ename 이름, nvl(commission,0) 보너스
from employee
where commission is null   -- 보너스가 없는 사원
order by ename desc;

--부서번호 (DNO) 가 20이고 사원과 월급이 1500 이상인 사원을 출력하되 월급이 많은 순으로 내림차순
select ename 사원이름, salary 월급
from employee
where dno = 20 and salary >= 1500
order by salary desc;

-- 여러 컬럼을 정렬 할 경우 : < 게시판, 질문 답변형 게시판 >
        --처음의 컬럼을 모두 정렬 후 , 같은 값이 존재할 경우 그 컬럼을 뒤에서 정렬.
select *
from employee;



select dno, manager,ename
from employee
order by dno,manager,ename;   -- dno 를 정렬하고 dno 정렬 묶음을 기준으로 manager 컬럼을 정렬 그다음 나머지 묶음에서 ename을 정렬.
                  --중복되는 항목에 대해서만 정리함.
                  
-- manager asc 정렬 후 , ename 컬럼을 asc 
select manager, ename
from employee
order by manager desc , ename desc ;

-- 부서별로 월급이 많은 사용자를 출력

select ename,dno,salary
from employee
order by dno desc, salary desc;

--보너스 별로 월급이 많은 순으로 출력.
select ename , commission , salary
from employee
order by commission desc ,salary desc;

select * from employee;

-- 직책별로 입사일이 빠른 순으로 출력
select eno 번호,ename 이름,dno 직책,hiredate 입사일
from employee
order by dno,hiredate;

--중복 제거후 출력 : distinct : 중복을 제거할 컬럼 앞에 넣는 키
            -- select
            
select distinct job -- 다른 컬럼을 집어넣으면 중복제거 안됨. 
from employee
order by job;

---회사에 존재하는 부서 : 중복을 제거후 출력.
select distinct dno
from employee
order by dno;

-- 직속 상관 (manager) 을 중복 제거후 출력
select distinct manager
from employee
order by manager;

--오라클에서 기본 제공해 주는 함수
--1. 문자처리 함수
--2. 숫자 함수
--3. 날짜 함수
--4. 변환 함수
--5. 일반 함수


--1. 문자 함수
/*
Lower : 소문자로 변환
upper : 대문자로 변환
Initcap : 첫 글자만 대문자로, 나머지는 소문자로 변환
*/

select 'Oracle mania'
, UPPER('Oracle mania') as 대문자
, LOWER ('Oracle mania') as 소문자
, INITCAP ('Oracle mania') as "첫자만 대문자"
from dual;    -- 가상의 테이블

select *
from employee;

--값을 가져올때는 대소문자를 구별함.
select * from employee
where ename = UPPER('smith');

/*
    글자의 길이를 출력 해 주는 함수
    LENGTH : 글자수를 반환 (한글 1byte 로 처리)
    LENGTHB : 글자수를 반환 (한글 2byte 로 처리) [오라클 버전에 따라 3byte로도 처리]
*/

select length ('Oracle mania')  -- 12 byte : 12자
    ,lengthb ('오라클 매니아')     -- 7 byte : 7자
from dual;

/*
CONCAT : 문자열을 연결 함수
SUBSTR : 문자를 잘라주는 함수 (한글 1byte)
SUBSTRB: 문자를 잘라주는 함수 (한글 3byte)
INSTR : 특정 문자의 위치값을 반환 (한글 1byte)
INSTRB : 특정 문자의 위치값을 반환 (한글 3byte)
LPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽) 
RPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
TRIM : 공백을 제거
*/

select ename 이름,length(ename) 글자수, length(job) 글자수
from employee;

--concat
select 'Oracle','mania',
 concat('Oracle','mania')
 from dual;
--
select substr('Oracle mania',4,3) -- 4번째 자리에서 3자리를 잘라온다.
    ,substrb('Oracle mania',4,3)
from dual;
--
select substr('오라클 매니아',4,3) -- 한글을 1바이트로 계산
    ,substrb('오라클 매니아',4,3) -- 한글을 3바이트로 계산
from dual;
--
select ename, substr(ename,3,3) as "잘라온 값"
from employee;
--

--instr 해당 문자가 존재하는 위치를 출력
select 'Oracle mania',
    instr('Oracle mania', 'a',4) -- 4는 검색시작 위치
from dual;

select ename,
    instr(ename,'K')
from employee;

--LPAD
select salary,LPAD (salary,10,'*') -- salary 컬럼의 값을 10자리로 표현 비어있는 공백(왼쪽에 리터럴 위치)
from employee;

--RPAD
select salary,RPAD (salary,10,'*') -- salary 컬럼의 값을 10자리로 표현 비어있는 공백(오른쪽에 리터럴 위치)
from employee;

