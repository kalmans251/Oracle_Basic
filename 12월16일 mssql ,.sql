-- 한줄 주석 
/*
   여러줄 주석 
*/


-- DataBase 생성 
create database myDB ; 

-- DataBase 삭제    : 해당 DB에 접속된 상태에서는 DB삭제 불가능 
drop database myDB; 


--해당 DataBase 로 접속 
use myDB; 

--tempdb 로 이동 
use tempdb; 


-- 테이블 생성 및 삭제 
create table test1 (
	a int not null primary key,   -- 정수를 넣는 자료형 
	b varchar (10)  null ,
	c char(10) null 
	); 

select * from test1; 

drop table test1; 

-- 값 insert  : MSSQL, MYSQL(MariaDB) 는 자동 커밋 트랜잭션 ,
-- commit을 명시하지 않아도 자동으로 커밋된다. (DML : Insert, Update, Delete) 
insert into test1 ( a, b, c) 
values ( 1,'aaa', 'bbb'); 

-- 명시적으로 트랜잭션을 시작 하면 트랜잭션을 완료해야 한다. 
begin transaction 
insert into test1 ( a, b, c) 
values ( 2,'ccc', 'ddd'); 

select * from test1; 

rollback; 

----------------------------------------------------------
-- Sample 테이블 생성 

DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;


-- 부서 테이블 생성 
	-- NUMBER : 오라클의 자료형, 정수, 실수 
	-- int    : 정수 (MS_SQL, MYSQL)
	-- float  : 실수 (MS_SQL, MYSQL) 

	-- VARCHAR2 : Oracle 
	-- VARCHAR  : MSSQL, MYSQL 

CREATE TABLE DEPARTMENT (
	DNO INT CONSTRAINT PK_DEPTMENT_DNO PRIMARY KEY,
    DNAME VARCHAR(14),
	LOC   VARCHAR(13) 
	) ;


CREATE TABLE EMPLOYEE (
	 ENO INT CONSTRAINT PK_EMPLOYEE_ENO PRIMARY KEY,
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  INT,
	 HIREDATE DATE,
	 SALARY FLOAT,
	 COMMISSION FLOAT,
	 DNO INT CONSTRAINT FK_EMPLOYEE_DNO FOREIGN KEY REFERENCES DEPARTMENT(DNO)
	 );


CREATE TABLE SALGRADE
        (GRADE INT,
	 LOSAL INT,
	 HISAL INT );

--- 값 insert 

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

-- select * from department ; 


-- MSSQL에서는 to_date() 함수가 없다. convert 할수로 날짜 자료형을 변환 
 -- select * from employee; 

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,'19801217',800,NULL,20);


INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,'19810220',1600,300,30);


INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,'19810222',1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,'19810402',2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,'19810928',1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,'19810501',2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,'19810609',2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,'19870713',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,'19811117',5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,'19810908',1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,'19870713',1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,'19811203',950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,'19811203',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,'19820123',1300,NULL,10);





INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

--commit; 

select * from department; 
select * from employee; 
select * from salgrade; 

-- 테이블의 정보 출력 :  desc 테이블명 <== Oracle , Mysql, MariaDB 
sp_help [DEPARTMENT]; 
sp_help [EMPLOYEE]; 
sp_help [SALGRADE]; 

-- select 

/*
select 컬럼명 
from 테이블명 or 뷰명
where 조건
group by 컬럼
having 조건(group by 결과에 대한 조건) 
order by 컬럼명    <== 정렬 
*/ 

select eno as 사원번호, ename 사원명, salary 월급 
from employee
where salary > 2000  and eno in (7788, 7839) 

-- 집계함수도 동일 (sum , avg, max, min, count) 

--부서별 월급의 합계, 평균, 최대값, 최소값, 그룹핑수 
select sum(salary) 합계, avg(salary) 평균, max(salary) 최대값, 
	min(salary) 최소값 , count(*) 그룹핑된수, dno 부서번호
from employee
group by dno 
having avg(salary) > 2000

-- insert , update, delete , truncate table  : Oracle, MySQL, MSSQL 모두 동일하다. 

-- 테이블 복사 : <== 오라클과 구문이 다르다. 
	-- 제약 조건은 복사 되지 않는다. 

-- department 테이블의 모든 컬럼과 모든 레코드를 복사 
select * into dept_copy     -- dept_copy : 복사할 테이블
from department ;			-- department : 복사할 원본 테이블 

select * from dept_copy;

-- employee 테이블의 특정 컬럼과 특정 레코드만 복사 . 
select eno, ename, salary,dno into emp_copy
from employee
where dno = 10 ; 

select * from emp_copy; 


----------------------------------------------
-- ANSI JOIN   (INNER JOIN) 

-- 사원번호, 사원명, 월급, 부서번호, 부서명, 부서위치  : employee, department 이너조인 
select eno, ename, salary, e.dno, dname, loc
from employee e JOIN department d
on e.dno = d.dno ; 

-- ANSI SELF JOIN 
-- 사원이름에대한 상사이름을 SELF 조인으로 출력 (13)
select e.ename , m.ename 
from employee e JOIN employee m 
on e.manager = m.eno 


-- ANSI SELF JOIN 후  상사가 없는 사원까지 출력 ( 14개 출력 )
select e.ename , m.ename 
from employee e Left JOIN employee m 
on e.manager = m.eno 


---------------------------------------------------------------------------
create table userTbl(	--회원
	userID char(8) not null constraint PK_USERTBL_USERID primary key, --사용자 아이디
	name nvarchar(10) not null , --사용자 이름 
	birthYear int not null,		 --사용자 생일년도
	addr nchar(3) not null,		 -- 주소 (경기, 서울, 경남 3자리까지만 입력)
	mobile1 char(3) ,			 -- 핸드폰 ( 010 )
	mobile2 char(8),			 -- 핸드폰 ( 1111-1111 , 2222-2222)
	height smallint,			 -- 사용자 키 - smalint : 2byte
	mDate date					 -- 회원가입일 
	);

create table buyTbl(	--구매테이블
	num int identlty not null constraint PK_BUYTBL_NUM primary key,
	userID char(8) not null constraint FK_USERTBL_USERID foreign key references userTbl(userID),
	prodName nchar(6) not null,
	groupName nchar(4) ,
	amount smallint not null
	);
drop table buyTbl;
-- 값 넣기
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011','1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011','2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019','3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011','4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL ,NULL , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016','6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL ,NULL , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011','8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018','9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010','0000000', 176, '2013-5-5');
GO
INSERT INTO buyTbl VALUES('KBS', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES('JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES('BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl VALUES('KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl VALUES('BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl VALUES('SSK', '책' , '서적', 15, 5);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 2);
INSERT INTO buyTbl VALUES('EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES('EJW', '책' , '서적', 15, 1);
INSERT INTO buyTbl VALUES('BBK', '운동화', NULL , 30, 2);
GO
select * from userTbl
select * from buyTbl

sp_help [BUYTBL]

-- IDENTITY : 초기값 : 1 , 증가값 : 1 씩 자동 증가 컬럼
	-- INT : 정수형 데이터 타입으로 지정 . NOT NULL
	-- 일반적으로 primary key <== index 가 자동으로 생성되고 검색을 빠르게
	-- IDENTITY  키가 들어있는 컬럼은 값을 넣으면 안됨

	/*
	char		: MSSQL : 한글 자를 2byte
	nchar		: MSSQL : 한글의 글자수 만큼 입력되도록 처리

	varchar		
	ncarchar
	*/

create table testTbl(
	a char(4)   ,		--한글 2자 : 4byte - 자릿수를 알 수 있는 경우 사용(성능이 빠름)
	b nchar(4)  ,		--한글 4자 : 8byte - 자릿수를 알 수 없는 경우 사용(char보다 느림)
	c varchar(6)  ,		--한글 3자 : 6byte - 자릿수를 알 수 있는 경우 사용(성능이 빠름)
	d nvarchar(6)  		--한글 6자 : 12byte - 자릿수를 알 수 없는 경우 사용(varchar보다 느림)
	);

select * from testTbl;
drop table testTbl;

insert into testTbl ( b)
values ('한글두자');



SET IDENTITY_INSERT buyTbl ON
SET IDENTITY_INSERT buyTbl OFF



-- 1. join을 사용해서 userID 이름 주소 구매물품 물춤종루 가격을 출력
select u.userID, u.name 이름, u.addr 주소 , b.prodName 구매물품, b.groupName 물품종류, b.price 가격
from userTbl u, buyTbl b

--2. 구매물품종류를 그룹핑해서 가격의 합계 평균을 구하시오
select sum(price) 합계, avg(price) 평균
from userTbl u, buyTbl b

--3. 주소별로 물품 구매 갯수를 출력
select u.addr 주소 ,sum(amount) 구매
from userTbl u, buyTbl b
group by addr

--4. 구매 이력이 없는 사용자를 출력
select u.userID , u.name 이름
from userTbl u left join buyTbl b
on u.userID = b.userID
where amount is null