
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

select *
from employee;
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

--TRIM : 앞뒤의 공백을 제거
select '      Oracle mania     ' as 원본
, trim ('      Oracle mania     ') as 공백제거
from dual;

--1.덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상ㅇ을 계산한 후 사원이름, 급여 ,인상된 급여를 출력하세요.
select ename 사원이름,salary 급여, salary+300 "인상된 급여"
from employee;

--2.사원의 이름,급여,연간 총 수입이 많은 것 부터 작은순으로 출력 하시오. 연간 총 수입은 월급에 12를 곱한 후 $100의 상여금을 더해서 계산 하시오.
select ename 사원이름,salary 급여, salary*12+100 "연간 총 수입"
from employee
order by (salary*12+100) desc;

--3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은 것 부터 작은 순으로 출력하세요.
select ename 사원이름,salary 급여
from employee;

--4.사원 번호가 7788인 사원의 이름과 부서번호를 출력하세요.
select ename 사원이름,dno 부서번호
from employee
where eno = 7788;

--5.급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하세요.
select ename 사원이름,salary 급여
from employee
where salary < 2000 or salary > 3000;

--6.1981년 2월 20일부터 81년 5월 1일 사이에 입사한 사원의 이름 담당업무,입사일을 출력하시오
select ename 사원이름,job 담당업무,hiredate 입사일
from employee
where hiredate between '81/02/20' and '81/05/01';

--7.부서번호가 20및 30에 속한 사원의 이름과 ㅜㅂ서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오.
select ename 사원이름,dno 부서번호
from employee
where dno between 20 and 30
order by ename desc;

--8.사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요.
select ename 사원이름,salary 급여,dno 부서번호
from employee
where salary between 2000 and 3000
order by ename asc;

--9.181년도 입사한 사원의 이름과 입사일을 출력하시오(like연산자와 와일드 카드 사용:_,%)
select ename 사원이름,hiredate 입사일
from employee
where hiredate like '81%';

--10.관리자가 없는 사원의 이름과 담당업무를 출력하세요
select ename 사원이름, job 담당업무
from employee
where manager is null;

--11.커밋션을 받을 수 있는 자격이 되는 사원의 이름,급여,커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하라.
select ename 사원이름,salary 급여, commission
from employee
where commission is not null
order by commission desc;

--12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
select ename 사원이름
from employee
where instr(ename,'R') = 3;

--13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename 사원이름
from employee
where (instr(ename,'A') != 0) and (instr(ename,'E') != 0);

--14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서
--    급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select ename 사원이름, job 담당업무, salary 급여
from employee
where (job = 'CLERK' or job = 'SALESMAN') and ( salary != 1600 or salary != 1300 or salary != 950 ); 

--15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.
select ename 사원이름, salary 급여, commission
from employee
where commission >= 500;


/*
ROUND : 특정 자릿수에서 반올림.
    --양수일때 : 소숫점을 기준으로 오른쪽으로 이동해서 그 뒷자리에서 반올림 < == 주의
    --음수일때 : 소숫점을 기준으로 왼쪽으로 이동하고 그 자리에서 반올림.
        --정수를 반올림. 그 뒤는 모두 버림.
TRUNC : 특정 자릿수에서 잘라냄.
MOD : 입력받은 수를 나누고 나머지 값만 반환
*/

select 98.7654 as 원본,
round(98.7654),
round(98.7654,2),
round(98.7654,-1),
round(98.7654,-2),
round(98.7654,-3),
round(98.7654,4)
from dual;


select 12345.789 as 원본,
round(12345.789),
round(12345.789,-3),
round(12345.789,3)
from dual;

-- TRUNC : 잘라서 버림.   0으로 바꿔버림.
select 98.7654 as 원본,
    trunc(98.7654),
    trunc(98.7654,2),
    trunc(98.7654,-1)
from dual;

--eno (사원번호) 가 짝수인 사원만 출력
select eno, ename
from employee
where mod (eno,2) = 0;

/*
날짜 함수
    sysdate: 현재 시스템의 날짜와 시간을 출력
    months_between : 두 날짜 사이의 개월 수를 출력
    add_montth : 특정 날짜에 개월수를 더할때
    next_day : 특정날짜에서 최초로 도래하는 인자로 받은 요일
    last_day : 달의 마지막 날짜를 반환
    round : 날짜를 반올림 , 15일 이상은 반올림, 15일 민만은 버림.
    trunc : 날짜를 버림

*/
--sysdate : 현재 날짜를 출력
select sysdate
from dual;

select sysdate -1 as "어제 날짜", sysdate as "오늘 날짜"
from dual;

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate +1 as 내일날짜
from dual;

select hiredate as 입사날짜, hiredate -1, hiredate + 10
from employee;


-- 입사 일에서 현재 까지의 근무일수 구하기
select round((sysdate - hiredate)) as "총 근무일수"
from employee;

select round((sysdate - hiredate),2) as "총 근무일수"
from employee;

--특정 날짜에서 월(Month)를 기준으로 버리기, 월은 출력 하되 날짜는 모두 버림, 01
select trunc((sysdate - hiredate)) as "총 근무일수"
from employee;

--특정 날짜에서 월(Month)를 기준으로 반올림 하기, 15일 이상은 반올림, 15일 이하는 버림.
select hiredate as 원본, trunc (hiredate, 'MONTH')
from employee;

--month_between(date1,date2) : 두 날짜사이의 개월수를 출력


-- 입사일에서 현재까지 몇개월간 근무 했는지 출력.
select ename, hiredate , months_between( sysdate, hiredate) as 근무개월수
from employee;

--add_month (date1,개월수) : date1에 개월수를 더해서 출력

--입사후 6개월이 지난 시점을 출력
select hiredate,add_month ( hiredate, 6)
from employee;

-- 입사후 100일이 지난 시점의 날짜.
select hiredate, hiredate + 100 as "입사후 100일시점"
from employee;

--next_day (date,요일) : date 의 도래하는 요일을 출력
-- 오늘 날짜에서 도래하는 토요일의 날짜는 몇일 인지 출력.
select sysdate, next_day(sysdate,'토요일')
from dual;

--last_day(date) : date 에 월의 마지막 날짜를 출력
select hiredate, last_day (hiredate) as 월의마지막날짜
from employee;

/* 형 변환 함수 <== 중요함
 TO_CHAR : 날짜형 숫자형을 문자형으로 변환하는 함수.
 TO_DATE : 문자형을 날짜형으로 변환하는 함수.
 TO_NUMBER : 문자형을 숫자로 변환하는 함수
*/

--TO_CHAR ( date, 'YYYYMMDD') : 날짜 형식을 'YYYYMMDD' 형식으로 출력시 char 타입으로 변환해서 출력.
  --YYYY : 년도
  --MM  : 월
  --DD  : 일
  
  --DAY : 요일의 자세한 정보
  --DY  : 요일

select ename, hiredate, to_char(hiredate,'YYYYMMDD')
    ,to_char(hiredate, 'YYYY--MM--DD DY')
    ,to_char(hiredate, 'YYYY--MM--DD DY HH:MI:SS')
from employee;

-- 현재 시스템의 오늘 날짜를 출력하되 시간:분:초 요일까지 출력
select to_char(sysdate, 'YYY--MM--DD DY HH:MI:SS')
from dual;


/* to_char : 숫자를 char 형식으로 변환
   0: 자릿수를 나타내고 자릿수가 맞지 않으면 0으로 채움.
   9: 자릿수를 나타내고 자릿수가 맞지 않으면 빈칸으로 채움.
   L: 각 지역의 통화 기호를 출력
   . : 소숫점으로 표현
   , : 천단위 구분자
   */
   
--salary : NUMBER(숫자) ===> char (문자)
desc employee;

select ename, salary, to_char(salary,'L999,999'), to_char(salary,'L0000,0000')
from employee;

--to_date ( 'char', 'format') : char (문자) ==> 날짜형식으로 변환.
--to_date (number , 'format') : 숫자를 ==> 날짜형식으로 변환.

select sysdate, sysdate - to_date(20000101 , 'YYYYMMDD')
from dual;


--두 포멧 방식이 맞지 않아서 오류 발생.
select sysdate,
    sysdate - '2000년01월01일'   --날짜 - 문자  < == 두 타입을 맞추어야 한다.
from dual;

select sysdate,
    sysdate - to_date('2000-01-01','YYYY-MM-DD')   --날짜 - 문자  < == 두 타입을 맞추어야 한다.
from dual;

-- 2000년 1월 1일 부터 2022년 2우러 10일까지 지난 날짜 계산하기
-- '02/10/22'  22년 2월 10일
select sysdate,
sysdate - to_date('02/10/22','MM/DD/YY')
from dual;

select sysdate - to_date(20000101,'YYYYMMDD')
from dual;

--employee 테이블에서 81년 2월 22일 입사한 사원을 검색하는데 
    -- '02-22-1981' 문자열 포멧을 data형식으로 변환해서 검색
select ename 사원이름,to_date(hiredate,'YYYY-MM-DD') 입사일
from employee
where hiredate = to_date('02-22-1981','MM-DD-YYYY');

--2000년 12월 25일 부터 오늘까지 총 몇달이 지났는지 출력, 소숫점이하는 모두 잘라내기. sysdate

select trunc(months_between(sysdate,to_date('2000/12/25','YYYY/MM/DD')))
from dual;




