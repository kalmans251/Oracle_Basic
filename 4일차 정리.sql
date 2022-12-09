
/*
SQL (Structured Query Language ) : 구조화된 질의 언어 , (시퀄)
        
        select 컬럼
        from 테이블명,뷰명
        where 조건
        group by 그룹핑할 컬럼명
        having 나온결과에 대한 조건
        order by 정렬할 컬럼
        
    DDL ( Data Definition Language ): 데이터 정의 언어 ,객체를 생성, 수정, 삭제
            객체(Object) ==> Table, 테이블을 쉽게 조작하기 위한 객체들 ==> [View, Function, Index, Store Procedure, Triger, USER,....]
        CREATE(생성) , ALTER (수정) , DROP (삭제)
        RENAME(객체이름변경), TRUNCATE(레코드 삭제)
    
    DML ( Data Manipulation Language ): 데이터 조작 언어, 레코드를 생성,수정,삭제
        INSERT (생성), UPDATE(수정), DELETE(삭제)
        -- 트랜잭션을 발생시킴. commit (DB에 영구저장), rollback(원래 상태로 되돌림))
        
    DCL ( Data Control Language ): 데이터 제어 언어, 계정을 생성,계정에 권한을 부여, 삭제 할때 사용.
        GRANT (권한을 부여), REVOKE (권한을 취소할때)
        
        
    DQL ( Data Query Language ) : 데이터 질의 언어 (출력) : SELECT
    TCL ( Transaction Control Language) : 트랜잭션 제어 언어
        BEGIN TRANSACTION    <==== 트랜잭션 시작 ( INSERT, UPDATE, DELETE <== DML )
    
        COMMIT     <=== 트랜잭션을 종료 ( DataBase 에 영구저장 )
        ROLLBACK   <=== 트랜잭션을 종료 ( 원래 상태로 되돌림, 트랜잭션 시작 상태로 되돌림 )
        SAVEPOINT (트랜잭션 내의 임시 저장시점 설정)  <===  
*/

--테이블 생성 (Create Table)

create Table dept (             --생성할 테이블 명.
    dno number(2) not null,     --컬럼명 자료형. NULL 허용 여부
    dname varchar2(4) not null, 
    loc varchar2(13) null
    );

-- 테이블 구조 확인
desc dept;

-- 테이블에 값 넣기 (INSERT INTO 테이블명 (명시할 컬럼명) values (넣을값);
    -- BEGIN TRANSACTION <== 트랜 잭션이 자동 시작.
begin transaction; -- 명시적으로 트랜잭션 시작.
insert into dept (dno,dname,loc) 
values (10,'ACCO','SEOUL'); --commit 하기 전엔 메모리(RAM)에만 위치.

rollback;  --메모리에 위치한것을 초기화,트랜잭션 시작 시점으로 되돌림.
commit;    --메모리 위치한 것을 DB에 영구 저장.

--데이터 검색 하기
select * from dept;


/*트랜잭션 (TRANSACTION) : 작업(일)을 처리하는 최소 단위
    --DML (Insert, Update, Delete 문을 사용하면 자동으로 트랜잭션이 시작됨.
    --트랜잭션을 종료하지 않으면 외부에서 다른 사용자가 접근을 못함(LOCK).
    --트랜잭션 종료 2가지방법==> 커밋을하던지 롤백을 하던지. (commit,rollback)
        --commit : DB에 영구 저장
        --rollback : 원래 상태로 되돌림
    --트랜잭션의 4가지 특징
        --원자성(Atomiciy) : 여러 구문을 하나의 작업 단위로 처리
        --일관성(Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가져야 한다.
        --독립성(Isolation) : 하나의 트랜잭션이 처리되기 전까지는 다른 트랜잭션과 격리
        --지속성(Durability) : commit 된 트랜잭션은 DB에 영구적으로 저장됨.
*/

select * from dept;

--컬럼명을 생략시 값넣기, 모든 컬럼에 값을 넣어줘야 한다.[not null 컬럼은 값이 안들어가면 안된다.]
insert into dept (dno,loc,dname)
values (20,'BUSAN','SALE');

desc dept;

insert into dept
values (30,'abc','Taegu');

select * from dept;

insert into dept (dno,dname)
values (30,'abc');

commit;

--회원 정보를 저장하는 테이블 생성
create table member(
    id varchar2(50) not null primary key,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    phone varchar2(30) null,
    age number(3) not null,
    weight number(5,2) not null
    );

rollback;
/* 제약 조건 : 데이터의 무결성을 확보 하기 위해서 테이블의 컬럼에 부여.
        - 무결성 : 오류없는 데이터, 원하는 데이터
    --not null
    --Foreign key
    -- Primary Key : 테이블에서 하나만 존재 할 수 있다.
        --primary key 가 적용된 컬럼은 중복된 값을 넣을 수 있다.
        -- 데이터를 수정 할때, 삭제시 조건을 사용하는 컬럼.
        -- 인덱스가 자동으로 생성된다. <== 검색을 빠르게 할 때 사용된다.
        -- Null을 넣을 수 없다.
        
    --Unique : 중복된 값을 넣을 수 없다. 테이블에서 여러번 넣을 수 있다.
        -- NULL을 넣을 수 있다. 1 번만 넣을 수 있다.
        -- 인덱스가 자동으로 생성된다. <== 검색을 빠르게 함.
    -- check : 값을 넣을때 체크해서 값을 넣는다.
    -- NOT NULL : 컬럼에 NULL을 넣을 수 없다.
*/

show user;
select * from user_constraints;  --현재 접속한 계정에서 생성된 객체의 모든 제약 조건을 확인.

-- 원하는 테이블의 제약 조건 확인.
select * from user_constraints
where table_name = 'EMPLOYEE';

desc member;

insert into member (id,pass,addr,phone,age,weight)
values ('cccc','1234','서울 종로구','010-1111-1111',20,50.55);

rollback;

select *
from member;

--null 허용 컬럼에 null 넣기
desc member;

insert into member
values ('dddd' , '1234',null,null,30,103.42);

commit;

insert into member(pass,age,weight,id)  -- not null은 반드시 넣어줘야 한다.
values ('1234',40,88.888,'eee');

-- 수정 (UPDATE) <<== 반드시 where 절을 사용해서 수정해야 한다.
    -- where 절에 사용되는 컬럼은 중복되지 않는 컬럼을 사용해서 수정 : primary key, Unique
    
    /*
    update 테이블명
    set 컬럼명=바꿀값, 컬럼명=바꿀값
    where 조건
    */
    
select * from member;

update member
set phone = '010-2222-2222',age=55, weight=90.55
where id = 'bbbb';

commit;
rollback;

update member
set age = age +1;

--update 시 중복되지 않는 컬럼을 조건을 준 경우
update member
set phone = '010-3333-3333',age = 80
where id = 'eee';

commit;

--delete : 반드시 where 조건을 사용해야 한다.
    --중복되지 않는 컬럼을 조건에 적용 : primary key, unique
select * from member;
rollback;

delete member
where id = 'cccc'

-- 테이블 복사 ( EMP )
create table emp as select * from employee;

-- 복사된 테이블
select * from emp;

/*
1. 3개 레코드 삽입 , 모든 값 입력 , null 이 허용된 컬럼 null 넣기.
2. update 를 사용해서 데이터 수정 , scott 의 보너스 500으로 수정
   영업사원의 보너스 300 만원으로 수정,
   ward 의 부서를 10번으로 수정
   allen의 manager를 7839, 월급을 1800, 입사일 22/01/01로 수정
3. delete : eno 7782 와 ,eno 7698 을 삭제

*/
desc emp;
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

/* Unique 제약 조건 : 중복된 데이터를 넣을 수 없다.
    -NULL 을 넣을 수 있다. 1번만 넣을 수 있다.
    -테이블에 특정 컬럼에 여러번 넣을 수 있다.
    -인덱스를 자동으로 생성한다. <== 검색을 아주 빠르게 함.
    -JOIN 시 ON 절, WHERE 조건 
*/

create table customer1(
id varchar(20) not null primary key,  --  primary key는 무조건 not null
pass varchar(20) not null Unique, -- 중복되지 않는 컬럼
name varchar(20) null unique,    -- null 허용, 테이블에 여러번 넣을 수 있다.
phone varchar(20) null unique,
addr varchar(20) null
);

desc customer1;

insert into customer1( id,pass,name,phone,addr)
values ('aaa','1234','홍길동','010-1111-1111','서울종로');

select * from customer1;

-- 제약 조건 확인하기
select * from user_constraints
where table_name = 'CUSTOMER1';

/* check 제약 조건 : 값을 컬럼에 넣을때 체크해서 값을 넣는다.
*/

-- 테이블 생성시 제약조건의 이름을 부여 하면서 테이블 생성
-- 제약조건 이름 생성 규칙 : 테이블이름_컬럼명_제약조건유형

create table emp3 (
    eno number(4) constraint emp3_eno_PK primary key,
    ename varchar2(10) ,
    salary number(7,2) constraint emp3_salary_CK check (salary > 0)
    );
    
    
--emp3 테이블에 할당된 제약 조건 확인 하기.
select * from user_constraints
where table_name = 'EMP3';

insert into emp3 (eno,ename,salary)
values (1111,'smith',4);

create table emp4 (
    eno number(4) constraint emp4_eno_PK primary key,
    ename varchar2(10) ,
    salary number(7,2) constraint emp4_salary_CK check (salary > 0),
    dno number(2) constraints emp4_dno_CK check (dno in (10,20,30,40))
    );
    
select * from user_constraints
where table_name='EMP4';

insert into emp4
values (3333,'scott',300,20);

select * from emp4;
commit;

select * from user_constraints
where table_name = 'EMP4';

/* FOREIGN KEY (참조키) : 다른테이블(부모) 의 primary key, Unique  컬럼을 참조해서 값을 할당
*/

select * from employee;   -- dno : FOREIGN 키 (department의 dno를 참조하도록 설정.) department의 값이 외의 값은 들어가지 않는다.

select * from department; -- 부모 테이블 , dno 

insert into employee
values (8888,'aaaa','aaaa',7788,'22/12/08',6000,null,40);

select * from employee;

rollback;

-- 부모테이블 생성 : Foreign key 가 참조하는 컬럼은 Primary key, Unique 키 컬럼을 참조함.
create table ParentTbl (
name varchar2(20),
age number(3) constraint ParentTbl_age_CK check(age>0 and age < 200),
gender varchar2(2) constraint ParentTbl_gender check (gender in ('M','W')),
infono number constraint ParentTbl_infono_PK primary key
);
create table ChildTbl (
    id varchar2(40) constraint ChildTbl_id_PK primary key,
    pw varchar2(40),
    infono number ,
    constraint ChildTbl_infono_FK foreign key(infono) references ParentTbl(infono)
);
-- 부모 테이블에 값 넣기
insert into ParentTbl values ('홍길동',30,'M',1);
insert into ParentTbl values ('김똘똘',20,'M',2);
insert into ParentTbl values ('원빈',25,'M',3);
insert into ParentTbl values ('홍길순',40,'W',4);
select * from ParentTbl;
commit;
rollback;

-- 자식 테이블에 값 넣기
insert into ChildTbl values ('aaa','1234',1);
insert into ChildTbl values ('bbb','1234',2);
insert into ChildTbl values ('ccc','1234',2);
insert into ChildTbl values ('ddd','1234',4);

select * from ChildTbl;

/*
    default : 컬럼의 값을 넣지 않을때 default 로 설정된 값이 기본적으로 들어간다.
        --제약 조건은 아니어서 제약 조건이름을 할당할 수 없다.
*/

create table emp5(
    eno number(4) constraint emp5_eno_PK primary key,
    ename varchar2(10),
    salary number(7,2) default 1000 -- 값을 넣지 않으면 defualt로 설정된 값이 들어감.
    );

insert into emp5 (eno,ename)
values (1111,'aaaa');
insert into emp5 (eno,ename,salary)
values (2222,'aaaa',5000);

select * from emp5;
commit;

--테이블 삭제
drop table member;