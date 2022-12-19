-- 데이터 베이스 생성, 사용, 삭제

create database mydb2;

show databases;

use mydb2;

create table test1(
	a int not null primary key,
    b char(5) null,
    c varchar(10)
    );
    
insert into test1 values (1,'a','b');

--  트랜잭션 시작
start transaction;
insert into test1 values (3,'a','b');
rollback;
commit;

-- -------------------------------

-- 한라인 주석

/*
	여러 라인 주석
*/

create table userTbl (
userID char(8) not null ,
constraint pk_usertlb_userid primary key(userID)
);

create table userTbl (		-- <회원테이블>--
	userID char(8) NOT NULL ,
    constraint PK_USERTBL_USERID Primary Key(userID) ,	-- 사용자 ID
	name nvarchar(10) NOT NULL ,	-- 이름 
	birthYear int NOT NULL,			-- 생일의 년도  , int : 4byte 
	addr nchar(3) NOT NULL,			-- 주소 (경기, 서울, 경남  3자리까지만 입력 ) 
	mobile1 char(3) ,				-- 핸드폰 (010, ) 
	mobile2 char(8),				-- 핸드폰 뒷자리 8자리
	height smallint,				-- 키   , smallint : 2byte 
	mDate date						-- 날짜 (회원가입일)
	);
create table buyTbl (
	num int auto_increment primary key,
	userID char(8) NOT NULL
    ,constraint FK_BUYTBL_USERID Foreign Key(userID) References userTbl(userID) , 
	prodName char(6) NOT NULL, 
	groupName char(4) , 
	price int NOT NULL, 
	amount smallint NOT NULL 
	); 

create table buyTbl(	-- 구매테이블
	num int  NOT NULL ,
		constraint PK_BUYTBL_NUM primary key(num),
	userID char(8) not null,
		constraint FK_USERTBL_USERID foreign key(userID) references userTbl(userID),
	prodName nchar(6) not null,
	groupName nchar(4) ,
    price int not null,
	amount smallint not null
	);


drop table buyTbl;

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


INSERT INTO buyTbl VALUES(1,'KBS', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES(2,'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(3,'JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES(4,'BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl VALUES(5,'KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl VALUES(6,'BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl VALUES(7,'SSK', '책' , '서적', 15, 5);
INSERT INTO buyTbl VALUES(8,'EJW', '책' , '서적', 15, 2);
INSERT INTO buyTbl VALUES(9,'EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl VALUES(10,'BBK', '운동화', NULL , 30, 2);
INSERT INTO buyTbl VALUES(11,'EJW', '책' , '서적', 15, 1);
INSERT INTO buyTbl VALUES(12,'BBK', '운동화', NULL , 30, 2);

select * from userTbl;
select * from buyTbl;


select name 이름, birthYear 생일, prodname 구매품, price 가격, amount 수량
from userTbl u inner join buyTbl b
on u.userID = b.userID;

select prodname 구매품, sum(price) 가격
from userTbl u inner join buyTbl b
on u.userID = b.userID
group by prodname;

select name 이름, sum(price)
from userTbl u inner join buyTbl b
on u.userID = b.userID
group by name
having sum(price) >= all(select sum(price)
from userTbl u inner join buyTbl b
on u.userID = b.userID group by name);