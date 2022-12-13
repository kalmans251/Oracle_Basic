--테이블 조인 문제 - 06    : 완료 시간 : 6: 20 
--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오.
select 'SCOTT 사원의 부서번호는'||e.dno ||'부서의 이름은'|| dname
from employee e,department d
where e.dno = d.dno and ename = 'SCOTT';

--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
select ename || '   소속부서 '|| dname ||'   '|| loc || ' 지역'
from employee e INNER JOIN department d
on e.dno = d.dno;

--3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 
--모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 


--4. NATURAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select ename,dname,loc
from employee e natural join department d;

--5. EQUI 조인과 WildCard ( _ , %)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename,dname
from employee e,department d
where e.dno = d.dno and ename like ('%A%');

--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename,job,dno,dname
from employee natural join department
where loc = 'NEW YORK';

--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
-- 	각 열(컬럼)에 별칭값을 한글로 넣으시오. 
select e.ename 사원이름, m.ename 관리자이름,m.eno 관리자번호 
from employee e inner join employee m
on e.manager = m.eno;

--8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
select e.eno 사원번호,e.ename 사원이름,m.ename 관리자이름
from employee e inner join employee m
on e.manager = m.eno(+)
order by e.eno desc;

--9. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
--   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
select  e.ename 이름,d.dno 부서번호,d.ename 동료
from employee e inner join employee d
on e.dno = d.dno;

--10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select e.ename,e.hiredate,m.ename,m.hiredate
from employee e inner join employee m
on e.dno = m.dno and e.ename = 'WARD' and e.hiredate < m.hiredate;

--11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
--   단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
select e.ename 사원이름,e.hiredate 사원입사일,m.ename 관리자이름,m.hiredate 관리자입사일
from employee e inner join employee m
on e.manager = m.eno and  m.hiredate > e.hiredate;

--<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

--1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
select '사원번호가 7788인 사원과 담당 업무가 같은 사원 = '|| ename||' 업무 = '||job
from employee
where job = (select job from employee where eno = 7788);

--2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select '사원번호가 7499인 사원보다 급여 많은 사원 표시 [사원이름],[담당업무]= ['||ename||'],['||job||']'
from employee
where salary > (select salary from employee where eno=7499);
--3. 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select '최소급여 받는 사원이름 ='||ename||'  담당업무 ='||job||'  급여='||salary
from employee
where salary = (select min(salary) from employee);

--4. 평균 급여가 적은 사원의 담당 업무를 찾아 직급과 평균 급여를 표시하시오.
--select '평균 급여가 적은 사원의 담당 업무,직급,평균급여'

--5. 각 부서의 초소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select '각부서 최소급여 받는 사원이름 ='||ename||'  담당업무 ='||job||'  급여='||salary || '부서번호 ='|| dno
from employee
where salary in (select min(salary) from employee group by dno);

--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select '담당 업무가 분석가 인 사원보다 급여가 적으면서 분석가가 아닌 사원들을 표시'||'  사원번호= '||eno||'  이름= '||ename||'  담당업무 ='||job||'  급여='||salary
from employee
where salary < all(select salary from employee where job = 'ANALYST') and job != 'ANALYST';

--7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select ename
from employee
where eno not in (select nvl(manager,0) from employee group by manager);

--8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select ename
from employee
where eno in (select manager from employee);

--9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename,hiredate
from employee
where dno in (select dno from employee where ename = 'BLAKE');

--10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno,ename,salary
from employee
where salary > (select avg(salary) from employee)
order by salary asc;

--11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno,ename
from employee
where dno in (select dno from employee where ename like ('%K%'));

--12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select ename,d.dno,job
from employee e,department d
where e.dno = d.dno and d.loc = 'DALLAS';

--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename,salary
from employee
where manager in (select eno from employee where ename='KING' );

--14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
select eno,ename,d.dno,job
from employee e,department d
where e.dno = d.dno and d.dname ='RESEARCH';

--15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno,ename,salary
from employee
where salary > (select avg(salary) from employee) and dno in (select dno from employee where ename like ('%M%'));

--16. 평균 급여가 가장 적은 업무를 찾으시오. 
select job,salary
from employee
where salary = (select min(salary) from employee);

--17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select d.dname,e.ename
from employee e,department d
where e.dno=d.dno and e.dno in (select e.dno from employee e,department d where e.dno=d.dno and e.job ='MANAGER' ) and job != 'MANAGER';
