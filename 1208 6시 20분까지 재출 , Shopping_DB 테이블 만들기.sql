create table tb_zipcode (
zipcode varchar2(7) CONSTRAINT PK_tb_zipcode_zipcode not null primary key,
sido varchar2(30),
gugum varchar2(30),
dong varchar2(30),
bungi varchar2(30)
);

insert into tb_zipcode values ('1111','시흥시',null,'정왕동','373번지');
insert into tb_zipcode values ('2222','서울시',null,'낙월동','34번지');
insert into tb_zipcode values ('3333','뉴욕시',null,'어딘가','25번지');
insert into tb_zipcode values ('4444','인천시',null,'어디죠','13번지');
insert into tb_zipcode values ('5555','광주시',null,'몰라요','254번지');

commit;
select * from tb_zipcode;

create table products (
product_code varchar2(20) CONSTRAINT PK_products_product_code not null primary key,
product_name varchar2(100),
product_kind char(1),
product_price1 varchar2(10),
product_price2 varchar2(10),
product_content varchar2(1000),
product_image varchar2(50),
sizeSt varchar2(5),
sizeEt varchar2(5),
product_quantity varchar2(5),
useyn char(1),
indate date
);

insert into products values ('23','양말','H','400원','1300원','발을따듯하게','양말사진','SS','XXL','586','Y','20/04/02');
insert into products values ('24','장갑','H','800원','2000원','손을따듯하게','장갑사진','SS','XXL','281','Y','20/03/07');
insert into products values ('25','귀마개','H','800원','2400원','귀를따듯하게','귀마개사진','SS','XXL','632','Y','20/07/01');
insert into products values ('26','마스크','H','500원','1800원','얼굴을따듯하게','마스크사진','SS','XXL','559','Y','20/06/04');
insert into products values ('27','패딩','H','40000원','13000원','몸을따듯하게','패딩사진','SS','XXL','327','Y','20/11/02');

commit;
select * from products;

create table member (
id varchar2(20) constraint PK_member_id not null primary key,
pwd varchar(20),
name varchar2(50),
zipcode varchar2(7),
address varchar2(20),
tel varchar2(13),
indate date default sysdate,
constraint FK_member_id_tb_zipcode foreign key(zipcode) references tb_zipcode(zipcode)
);

insert into member (id,pwd,name,zipcode,address,tel) values ('1122','45293','홍길동','2222','서울어딘가','010-1342-5621');
insert into member (id,pwd,name,zipcode,address,tel) values ('2233','25843','강감찬','1111','경기도어딘가','010-7532-4582');
insert into member (id,pwd,name,zipcode,address,tel) values ('3344','79683','김철수','3333','뉴욕어딘가','010-8261-5845');
insert into member (id,pwd,name,zipcode,address,tel) values ('4455','28784','김영미','5555','광주어딘가','010-3468-7584');
insert into member (id,pwd,name,zipcode,address,tel) values ('5566','99856','이순신','4444','인천어딘가','010-1462-9851');

commit;
select * from member;

create table orders(
o_seq number(10) constraint PK_orders_o_seq not null primary key,
product_code varchar2(20),
id varchar2(16),
product_size varchar2(5),
quantity varchar2(5),
result char(1),
indate date,
constraint FK_orders_product_code_products foreign key(product_code) references products(product_code),
constraint FK_orders_id_member foreign key(id) references member(id)
);

insert into orders values (4512,'24','3344','L','2','N','22/12/07');
insert into orders values (8856,'26','1122','M','1','N','22/12/07');
insert into orders values (7841,'23','4455','S','1','Y','22/12/03');
insert into orders values (1645,'27','5566','XL','1','N','22/12/07');
insert into orders values (9784,'25','2233','XXL','1','Y','22/12/01');

commit;
select * from orders;



select * from member;
select * from tb_zipcode;
select * from orders;
select * from products;