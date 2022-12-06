

create table MYTTBL (
ID varchar(10),
PASS varchar(10) );


insert into TABLE1 values('1','1234');
commit;

SELECT ID FROM TABLE1;


-- 한줄 주석 : 프로그램에서 해석 되지 않는 영역
/*
여러줄 주석


*/

-- 1. HR 계정 생성 : 12 버전 부터 계정을 생성시 계정명 앞에 C##을 붙여야 한다.
-- HR : 계정명 , 암호 : 1234
create user C##HR identified by 1234 ;

create user C##HR identified by 1234;

--2. HR 계정의 권한 부여 : 
--  connect : 원격에서 DB에 접속 할 수 있는 권한.
--  resource: 객체(resource)를 생성, 수정, 삭제.
grant connect, resource to C##HR;

--3 . 테이블 스페이스 권한 부여.
  -- USER 의 테이블 스페이스의 사용량을 무제한 사용할 수 있도록 권한 부여
alter user C##HR quota unlimited on users;

--4. 유저 삭제
drop user C##HR;

--5. 유저 출력
show user;

select * from tab;

