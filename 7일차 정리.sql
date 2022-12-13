/*
View,Index 
*/

show user;
--View 의 정보를 저장하는 데이터 사전
select * from user_views;
--Index 정보를 저장하는 데이터 사전
select * from user_indexes; 

/* VIEW : 가상의 테이블, 데이터가 저장되어있지 않다.
        -- 실제 테이블의 값을 select 하는 코드만 들어가 있다.
        -- 목적 : 1.보안을 위해서 사용하는 경우 : 실제 테이블의 특정 컬럼을 숨겨서 처리.
                2. 편의성을 위해서 사용하는 경우 : 복잡한 구문을 View로 만들어서 처리.
                    JOIN 구문, 복잡한 구문,
*/

--View 실습을 위한 샘플 테이블 생성
create table emp100
as
select * from employee;

select * from emp100;

-- VIEW 생성 : 1.보안을 위해서 사용하는 경우
    -- view 는 실제 테이블의 주로 select 구문을 저장하고 있다.
    -- view 는 가상의 테이블, 데이터를 저장 하고 있지 않다.
    -- 실제 테이블의 실행 코드만 들어가 있다.
   

--grant dba to C##HR; => 뷰를 만들수 있는 권한을 부여.[부여하고 껏다가 켜야함]
--보안을 위해서 생성한 VIEW : 실제 테이블의 특정 컬럼을 출력 하지 않을 수 있다
create view V_emp
as
select eno,ename,salary from employee;


--View 를 실행 : select * from 뷰명

select * from V_emp;

--View 정보를 담은 데이터 사전.
select * from user_views;

--View 의 내용을 수정 : 오라클에서는 alter view가 없다.
                        --create or replace view 구문을 사용
alter view V_emp as
select eno,ename,dno from employee;

create or replace view V_emp
as
select * from employee;
------------------------------
drop view V_emp;

--View 삭제
drop view V_emp02;

--2. 편의성을 위해 view를 사용함. : 복잡한 JOIN 구문을 VIEW 로 생성하고
        --VIEW 를 Select 하면 된다.
-- 사원이름, 상사이름
create view V_emp02 --바로 출력하는 쿼리 : self 조인을 사용해서
as
select e.ename 사원이름,m.ename 상사이름
from employee e,employee m
where e.manager = m.eno;

--view 실행
select * from V_emp02;

--사원명, 월급, 부서번호, 부서명, 부서위치를 출력하는 view를 생성 : v_emp_dept
create view v_emp_dept
as
select ename,salary,d.dno,dname,loc
from employee e ,department d
where e.dno = d.dno;

--뷰 실행
select * from v_emp_dept;

/*
    뷰의 처리 과정
        -- view 는 가상의 테이블이고 값을 가지고 있지 않다. (select , Join)
        -- 실행 쿼리만 가지고 있다. (select)
        
        1. user_views 의 데이터 사전에서 뷰이름에 대한 쿼리를 조회
        2. 접속한 계정이 실제 테이블에 접근할 수 있는 권한이 있는지 확인.
        3. 각 테이블에 권한이 있으면 쿼리를 실행.
        4. 검색 (값을 가지고 온다.)
        5. 출력
*/

-- View 를 사용해서 값을 넣을 수 있다.
    --view 에는 값이 저장되지 않고 코드만 저장됨.
    --값은 실제 테이블에 저장됨.
    --실제 테이블의 제약 조건에 따라서 값이 저장될 수도 있고 안될 수도 있다.
    
select * from emp100; --테이블을 복사했기 때문에 제약 조건이 모두 빠져있다.

-- 테이블의 제약 조건을 확인 하는 데이터 사전
select * from user_constraints
where table_name in ('EMP100');

--view 생성
create or replace view v_emp10
as
select eno,ename,salary from emp100;

-- 뷰를 출력
select * from v_emp10;

--view 에 값 넣기 : <== 실제 테이블에 저장됨.
insert into v_emp10
values( 8888,'KOREAN',6000);
commit;

select * from emp100;

--veiw 에 값을 저장시 실제 테이블에 저장이 되면서 실제 테이블에 제약 조건에 따라서
-- 값이 들어갈 수도 있고 안들어갈수도 있다.

--view 를 사용해서 값을 삭제
delete v_emp10
where eno=8888; -- 실제 테이블의 래코드값 삭제.   
commit;

-- alter table 을 사용해서 hiredate 컬럼에 NOT NULL 제약 조건을 추가
        -- not null, default 수정할 때는 modify
alter table emp100
modify hiredate constraints emp100_hiredate_nn not null;

-- 테이블에 제약 조건 위배로 view 에서 값을 넣을때 오류가 발생

select * from v_emp10;

--
insert into v_emp10
values(9999,'KENDY',7000);

-- view 를 사용해서 insert, update ,delete 할때 실제 테이블의 제약 조건에 따라 달라진다.

/*
    뷰:
        1. 단순뷰 ( Simple View ) : 하나의 테이블로 생성된 view
        2. 복합뷰 ( Complex View ) : 두개 이상의 테이블로 생성된 view
            --뷰 내에서는 DISTINC, 그룹함수(SUM, AVG, MAX, MIN) , Group By
                , ROWNUM 을 사용하지 못한다.
                -- 단, 그룹함수를 사용 할 경우 반드시 별칭 이름을 사용하면 사용할 수 있다.
*/

-- ROWNUM : 레코드의 숫자를 출력 해줌. ROW 의 넘버를 출력.
    -- MS-SQL , MYSQL : Top n

-- 출력중에 10개만 출력 해라 <<=== 레코드가 많을때 조건을 사용해서 출력

select rownum,eno,ename,salary
from employee
where rownum <= 10;

-- 중복 된 값을 제거 : 직급의 종류
select distinct job from employee;

-- view 내부에 rownum 컬럼 때문에 오류 발생
create or replace view v_emp30
as
select rownum,eno,ename from emp100;
-- rownum을 별칭을 부여하면 사용가능.
create or replace view v_emp30
as
select rownum 행번호,eno,ename from emp100;

drop view v_emp30;

--view 내부에 Distinct 를 사용 잘 생성됨 <Oracle 21C 버전에서 잘 생성됨>
create or replace view v_emp31
as
select distinct job from emp100;

--View 내부에서 그룹 함수를 사용했을때 : SUM,AVG,MAX,MIN ,COUNT(*)
create or replace view v_emp32
as
select sum(salary) ,round (avg(salary)),max(salary),min(salary)
from emp100;

create or replace view v_emp32
as
select dno,sum(salary) 부서별합계,round (avg(salary)) 부서벌평균,max(salary) 부서별최대,min(salary) 부서별최소
from emp100
group by dno;

/*
    view  생성시 홉션 사용
        -force 옵션: 기존 테이블 생성유무에 상관없이 뷰를 생성
        -noforce 옵션: 반드시 기존 테이블이 존재해야 만 생성 <<기본값>>
*/

create or replace view v_emp34
as
select * from emp101; --emp101번 데이터는 존재하지 않으므로 view 생성시 오류;

--force 옵션을 사용해서 해당 테이블이 존재하지 않더라도 강제로 생성
    --해당 테이블은 나중에 만들 수 있다.
    
create or replace force view v_emp34
as
select * from emp101;

select * from user_views;

--view 생성이후에 테이블 생성.
create table emp101
as
select * from employee;

select * from v_emp34;

--------------------------------------------------------
/*
    index (인덱스, 색인) : 테이블의 컬럼에 검색을 빠르게 하기 위해 컬럼에 index를 생성.
        -- select 를 빠르게 하기 위해서 사용
        -- 테이블 스캔 :검색할 내용을 첫 레코드 부터 마지막 레코드까지 순차적으로 검색.
            -- 검색할 내용을 찾기 위해서 책의 첫장부터 마지막장 까지 검색.
            index 가 생성되어있지 않는 컬럼의 내용을 검색 할때는 테이블 스캔을 한다.
        -- index 정보를 사용한 ,스캔 :     <== 검색이 빠르다.
            -- index를 사용해서 정보를 검색
            -- 책의 색인,목차(index)
            
    자주 검색에서 사용되는 컬럼은 index를 생성해서 검색을 빠르게 한다.
        where 절에서 사용되는 컬럼.
        JOIN 시 ON 절에서 사용되는 컬럼.
        
        테이블의 Primary Key, Unique 컬럼은 자동으로 Index 가 생성됨
        
        테이블의 index 정보를 출력하는 데이터 사전
        select * from user_indexes
            where table_name in ('EMPLOYEE','DEPARTMENT');
        select * from user_columns
             where table_name in ('EMPLOYEE','DEPARTMENT');
        select * from user_ind_cloumns;
             where table_name in ('EMPLOYEE','DEPARTMENT');
*/
-- ename 컬럼은 index가 생성되지 않아서 테이블 스캔을 한다.
select * from employee
where ename = 'KING';

select * from user_indexes
where table_name in ('EMPLOYEE','DEPARTMENT');

select * from user_ind_columns
where table_name in ('EMPLOYEE','DEPARTMENT');

select * from user_ind_columns
where table_name in ('TBL1','TBL2','EMPLOYEE','DEPARTMENT');
--index 자동 생성되는 컬럼 : Primary key, Unique 컬럼은 자동으로 index 생성됨
create table tbl1 (
 a number(4) constraint tbl1_a_pk primary key,
 b number(4),
 c number(4)
 );
create table tbl2 (
 a number(4) constraint tbl2_a_pk primary key,
 b number(4) constraint tbl2_b_uk unique,
 c number(4) constraint tbl2_c_uk unique
 );
 
 commit;
 
 --특정 컬럼에 index 부여하기, where 절, JOIN 시 ON 절에서 사용되는 컬럼.
 select * from employee;
 
 -- employee 테이블의 ename 컬럼은 검색을 자주 사용한다. 레코드가 10만개 존재한다.
    -- 컬럼에 index를 생성하면 컬럼의 값을 가지고 index페이지를 생성한다.
    -- 부하가 굉장히 많이 걸리는 작업이다. 야간에 index를 생성해야 한다.
    
    -- DBA 과정에서 전문적으로 다룬다.
        --index 는 DBMS 를 잘 이해하고 잘 생성해야 한다.
        --index 는 잘못 만들면 오히려 성능이 떨어진다.
        --주기적으로 index 정보를 업데이트 해야 한다. ( insert, update, delete )
                -- rebuild


--index 가 테이블의 어떤 컬럼에 index가 생성되었는지 확인
select * from user_ind_columns
where table_name = 'EMPLOYEE';

-- employee 테이블의 ename 컬럼에 index 생성
create index idx_employee_ename
on employee(ename);

select * from user_indexes
where table_name ='EMPLOYEE';

select * from user_indexes
where table_name = 'EMPLOYEE';
 
/* index 는 생성후 지속적인 관리가 필요함.
    employee 테이블의 ename 컬럼에 index를 생성함. (
     -- ename 컬럼에 insert , update , delete가 빈번하게 일어날 경우 index 페이지가 조각난다.
     -- 주기적으로 rebuild 해줘야 한다. (index 페이지를 업데이트해야 한다)
*/

--생성된 index 정보를 새로이 업데이트
alter index idx_employee_ename rebuild;  -- ename 컬럼의 수정된 정보를 index 페이지에 새로이 업데이트.
 
 
select * from employee;
 -- employee 테이블에서 job 컬럼을 빈번하게 검색.
 
create index idx_employee_job
on employee(job);

--employee 테이블의 job 컬럼이 빈번하게 (update, delete, insert)
        --주기적으로 수정될 경우 업데이트가 필요함. : 1주, 1달 ~~~
        --레코드가 적을 때는 생성할 필요가 없다. 10만건 이상이되면 테이블 스캔으로 검색하는데
            --시간이 오래 걸릴 경우 index 생성의 필요성이 있다.
alter index idx_employee_job rebuild;

--인덱스 정보 출력 
select * from user_ind_columns
where table_name = 'EMPLOYEE';
 
--생성된 index 삭제
drop index idx_employee_ename;
drop index idx_employee_job;


/* ERD (Entity Relationship Diagram): 데이터 베이스 모델링, 설계도
    --테이블과 테이블의 관계
        -- ER-WIN : 전 세계적으로 제일 많이 사용한 모델링 툴
        
  모델링                                                   |   Oracle
  ======================================================================
  1. 요구사항 분석 ==> 2. 논리적 모델링 ==> 3. 물리적 모델링 ==> 4. 구현
  
  1.요구 사항 분석 : 업무 파악 , 고객의 협의, 프로잭트의 범위를 지정.(비용, 기간) <=== 
        테이블 , 각 테이블의 속성 , 테이블과 테이블의 관계
        
         DB 설계 ====> APP을 개발
         
  2. 논리적 모델링
        엔티티 (논리적 모델링): 테이블 (물리적 모델링)
        속성 (논리적 모델링) : 컬럼 (물리적 모델링)
        관계 : 1:1 관계, 1:다, 다:다.
  3. 물리적 모델링 (영문으로, 테이블명, 컬럼명, 컬럼의 자료형을 적용, 테이블간의 관계)
  
  4. 구현 (Oracle) <== 물리적 모델링을 기반으로 테이블 생성
*/
 