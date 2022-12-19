

create table x(
a int identity(1,1) not null primary key,
b int
);



create database myDB3;

--<실습> user2 계정을 생성 후 myDB2 만 접속 후 테이블 생성. 값 insert , update, delete ,drop table.


insert into x
values (3);

select * from x;