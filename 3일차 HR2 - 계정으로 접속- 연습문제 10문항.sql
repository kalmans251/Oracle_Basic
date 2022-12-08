--1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select ename,substr(hiredate,1,5) as "입사 년도와 달"
from employee;

--2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename
from employee
where substr(hiredate,4,2)='04';

--3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename,manager
from employee
where mod(manager,2)=1;

--3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select ename,salary
from employee
where mod(salary,3)=0;

--4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오.
select ename,to_char(hiredate, 'YY MON DD DY')
from employee;

--5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오.
select trunc(sysdate-to_date(20220101,'YYYYMMDD')) as 올해지난일수
from dual;

--5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc(sysdate - to_date(19960811,'YYYYMMDD')) as 생존일수
from dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc(months_between(sysdate,to_date(19960811,'YYYYMMDD'))) 생존개월수
from dual;

--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename, nvl(manager,0)
from employee;

--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALYST' 사원은 200 , 'SALESMAN' 사원은 180,
--   'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select ename,salary,job,decode(job,'ANALYST',salary+200
                        ,'SALESMAN',salary+180
                        ,'MANAGER', salary+150
                        ,'CLERK',salary+100
                        ,salary
                        ) as "직급인상상여금"
from employee;

--8.   사원번호,
--      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
--     이름, 
--       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"
select rpad(substr(eno,1,2),length(eno),'*')
from employee;

--9.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******-
--	dual 테이블 사용
select '801210-1231456' 원본주민번호
,rpad(substr('801210-1231456',1,8),length('801210-1231456'),'*') 가려진번호 
,'010-1253-4256' 원본전화번호
,rpad(substr('010-1253-4256',1,6),length('010-1253-4256'),'*')
from dual;

--10. 사원번호, 사원명, 직속상관, 
--	[직속상관의 사원번호가 없을 경우 : 0000
--	 직속상관의 사원번호가  앞 2자리가 75일 경우 : 5555
--	직속상관의 사원번호가  앞 2자리가 76일 경우 : 6666
--	직속상관의 사원번호가  앞 2자리가 77일 경우 : 7777
--	직속상관의 사원번호가  앞 2자리가 78일 경우 : 8888
--	그외는 그대로 출력. ] 
select eno , ename , case when manager is null then 0000
                    when substr(manager,1,2) = 75 then 5555
                    when substr(manager,1,2) = 76 then 6666
                    when substr(manager,1,2) = 77 then 7777
                    when substr(manager,1,4) = 78 then 8888
                    else manager
                    end 직속상관수정번호
from employee;



---

/*
 그룹함수 : 동일한 값에 대해서 그룹핑 해서 처리하는 함수
        group by 절에 특정 컬럼을 정의 할 경우 , 해당 컬럼의 동일한 값을 그룹핑해서 연산 처리
        
        
집계함수 : 연산을 처리하는 함수
        -sum : 합계를 구하는 함수
        -avg : 평균을 구하는 함수
        -max : 최대값을 출력
        -min : 최소값을 출력
        -count : 레코드수 (한 라인의 값이 저장된), Row (행)
        
        select 컬럼명
        from 테이블이름
        where 조건   < === 테이블에서 원하는 조건을 가지고 올때
        group by 그룹핑할 컬럼
        having   group by를 사용해서 나온 결과에서 조건을 처리
        order by 정렬
*/

select  sum(salary) 합계, round(avg(salary),2) 평균,
        max(salary) as 최대월급,min(salary) 최소월급
from employee;

-- 집계 함수는 null을 0으로 자동으로 처리해서 연산.
select commission
from employee;

select SUM(commission), AVG(commission), MAX(commission), MIN(commission)
from employee;

--count 함수 : 레코드수, row(행) 수,
    -- NULL 은 카운트 되지 않는다.
    
    
select count(eno)  -- 레코드의 수.
from employee;

select manager
from employee;

-- NULL은 카운트 되지 않는다.
select count(manager)
from employee;

--보너스를 받는 사원수
select commission
from employee;

select count (commission)
from employee;
--특정 컬럼을 cout 함수를 사용하면 전체 레코드 수를 부정확하게 
   --not null 정의된 컬럼을 카운트 해야 정확하다.
   
desc employee;
-- eno 의 not null은 null값이 들어가지 안는다는것.

select count(eno)
from employee;

--테이블의 전체 레코드 수를 출력시 : not null 지정된 컬럼이나, * 를 사용해서 count 해야 한다.
select count(eno) from employee;
select count (*) from employee;

--부서의 갯수
select count(distinct dno) 부서갯수, max(eno)
from employee;

-- 부서별로 급여의 합계, 평균, 최대값, 최소값 구하기 : group by <=== 컬럼에 동일한 값을 그룹핑 해서 처리
select * from employee
order by dno asc;

select sum(salary) 부서별월급합계, avg(salary) 부서별월급평균,
    max(salary) 부서별최대월급, min(salary) 부서별최소월급
from employee
group by dno   -- dno 컬럼의 동일한 값을 그룹핑
order by dno;

-- 직책별로 월급의 합계, 평균, 최대값 ,최소값을 출력.

select sum(salary) 직책월급합계, round(avg(salary) ) 직책별월급평균,
    max(salary) 직책별최대월급, min(salary) 직책별최소월급, job
from employee
group by job
order by job;

select *
from employee
where job = 'ANALYST';

--group by 에서 나온 결과를 조건으로 처리해서 출력 : having <조건>
select sum(salary) 직책월급합계, round( avg(salary)) 직책별월급평균,
    max(salary) 직책별최대월급, min(salary) 직책별최소월급, job
from employee
group by job        --dno 컬럼의 동일한 값을 그룹핑
having round( avg(salary) ) >= 2000  --group by를 사용해서 나온 결과에 대한 조건 처리.
order by job;

--having 절에서 별칭이름을 사용할 경우 오류발생

select sum(salary) 직책월급합계, round( avg(salary)) 직책별월급평균,
    max(salary) 직책별최대월급, min(salary) 직책별최소월급, job
from employee
group by job        --dno 컬럼의 동일한 값을 그룹핑
having 직책별월급평균
>= 2000  --group by를 사용해서 나온 결과에 대한 조건 처리.
order by job;

-- where : 테이블의 값을 조건을 주어서 가지고 올때 사용.
-- having : group by 를 사용해서 나온 결과를 조건을 출력


--20번부서는 제외하고 부서별 합계, 평균, 최대값,, 최소값을 구하되 부서별 최소 월급이 1000만원이상인 것만 출력.

select sum(salary) 합계,trunc(avg(salary),2) 평균 ,max(salary) 최대 ,min(salary) 최소
from employee
group by dno
having dno != 20 and min(salary) > 1000;

select sum(salary) 합계,trunc(avg(salary),2) 평균 ,max(salary) 최대 ,min(salary) 최소
from employee
where dno not in (20) --20번 부서는 빼고 <<== 조건을 사용해서 언하는 값만 테이블에서 가져온 후
group by dno
having min(salary) > 1000;  -- group by 로 나온 결과에서 조건을 처리할때.

--두 컬럼 이상을 그룹핑하기 : 두 컬럼 모두 동일할때 그룹핑 처리됨.
select dno,job
from employee
order by dno,job;


-- count(*) 를 사용하면 중복된 레코드가 몇개인지 확인 가능.
select sum(salary),round(avg(salary)),max(salary),min(salary),dno,job,count(*)
from employee
group by dno,job --두 컬럼에 걸쳐서 동일한 것을 그룹핑한다.
order by dno,job;

-- group by 를 사용하면서 select 절에 출력할 컬럼
    -- 집계함수 (sum,avg,max,min) , count(*) ,
    
-- Rollup : 마지막라인에 전체 합계, 전체 평균을 추가적으로 출력 : group by 절에서 사용됨.
select sum(salary) , round(avg(salary)), max(salary), min(salary),dno,count(*)
from employee
group by dno
order by dno desc;

-- rollup 사용 : 그룹핑한 집게함수 도 출력, 마지막 라인에 전체에 대한 집계 함수도 같이 출력됨.

--cube : 부서별 합계와 평균을 출력후 마지막 라인에 전체 합계 평균 출력됨.
select sum(salary), round(avg(salary)), max(salary),min(salary),dno,count(*)
from employee
group by cube(dno)
order by dno asc;

/*  
    서브 쿼리(Sub Query) : Select 문 내에 Select 문이 들어 있는 쿼리
*/

--ename이 SCOTT 인 사원과 동일한 부서의 사원을 출력
select * from employee;
    --sub query를 사용하지 않고 출력
        --1. SCOTT의 부서를 확인
        select ename, job from employee where ename = 'SCOTT';
        --2. SCOTT의 부서와 동일한 부서를 조건을 사용해서 출력.
        select ename,job from employee where job = 'ANALYST';







--sub query를 사용해서 한 라인에서 출력
select ename, job 
from employee 
where job = (select job from employee where ename='SCOTT' );

-- SMITH 와 동일한 직책의 사원들을 sub query 를 사용해서 출력
select ename
from employee
where job = (select job from employee where ename = 'SMITH');

-- SCOTT 보다 월급이 많은 사용자 , 서브쿼리한 결과 값이 단일 값으로 출력되어야 한다.
select ename ,salary
from employee
where salary > (select salary from employee where ename = 'SCOTT');

-- SCOTT 과 동일한 부서에 근무하는 사원들 출력 하기.
select ename
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- 최소급여를 받는 사원의 이름, 담당 업무 , 급여 출력 하기.
select ename,job,salary
from employee
where salary = (select min(salary) from employee);

--Scott 과 동일한 부서에 근무하는 사원들 출력 하기.
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');


-- 최소 급여를 받는 사원의 이름, 담당 업무, 급여 출력 하기.
select ename,salary 
from employee
where salary = (select min(salary) from employee);

-- 각 부서의 최소 급여가 30 번 부서(dno)의 최소 급여보다 큰 부서를 출력
-- 각 부서의 최소급여를 구함.
-- 30 부서의 최소급여 보다 큰 부서를 출력.

select dno,min(salary),count(*)
from employee
group by dno
having min(salary) > ( select min(salary) from employee where dno = 30 )   -- 30번 부서의 최소급여를 
order by dno;


/*
    sub query 에서 단일 값이 아니라 여러개의 값이 출력될 경우 : IN 연산자를 사용
    
    
*/

-- 각 부서별로 최소 급여를 받는 사원의 사원번호와 이름을 출력.

select eno 사원번호, ename 사원명 , salary 월급, dno 부서번호
from employee
where salary in ( 
        select min(salary) 
        from employee
        group by dno
);       -- sub query : 부서별로 최소 월급을 출력

-- ALL 연산자 : Sub Query 에서 반환하는 모든 값을 비교.
/*
    ' > all' : 최대값 보다 큼을 나타냄.
    ' < all' : 최소값 보다 작음을 나타냄
*/
-- 직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
select * from employee
order by job asc;

select eno, ename, job , salary
from employee
where salary < all ( select salary from employee where job='SALESMAN' )
                and job <> 'SALESMAN' ;


-- 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무 분석가가 아닌 사원들을 표시하시오.

select ename,job,salary
from employee
where salary < all(select salary from employee where job ='ANALYST') and
 job not in 'ANALYST';







