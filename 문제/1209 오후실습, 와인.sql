create table grade_pt_rade( --3페이지
mem_grade varchar2(20) not null constraint mem_grade3_pk primary key,
grade_pt_rate number(3,2)
);
-- 회원등급pk , 등급별 마일리지율

insert into grade_pt_rade
values ('DIAMOND',0.05);
insert into grade_pt_rade
values ('GOLD',0.04);
insert into grade_pt_rade
values ('SILVER',0.03);
insert into grade_pt_rade
values ('BRONZE',0.02);
insert into grade_pt_rade
values ('STONE',0.1);

commit;

create table today ( --4 페이지
today_code varchar2(6) not null constraint today_code4_pk primary key,
today_sens_value number(3),
today_intell_value number(3),
today_phy_value number(3)
); -- 오늘의 와인코드pk, 감성지수,지성지수,신체지수

insert into today
values ('1111',100,100,100);
insert into today
values ('2222',200,200,200);
insert into today
values ('3333',300,300,300);
insert into today
values ('4444',400,400,400);
insert into today
values ('5555',500,500,500);

commit;

create table nation( --5 페이지
nation_code varchar2(26) constraint nation_code_pk primary key,
nation_name varchar2(50) not null
); -- 국가 코드 pk, 국가 이름 nn

insert into nation
values ('82','대한민국');
insert into nation
values ('36','프랑스');
insert into nation
values ('45','브라질');
insert into nation
values ('85','포르투갈');
insert into nation
values ('24','가나');

commit;

create table theme ( --7페이지
theme_code varchar2(6) constraint theme_code_pk primary key,
theme_name varchar2(50) not null
); -- 테마코드 pk, 테마이름 nn

insert into theme
values ('1234','테마이름1');
insert into theme
values ('2345','테마이름1');
insert into theme
values ('3456','테마이름1');
insert into theme
values ('4567','테마이름1');
insert into theme
values ('5678','테마이름1');

commit;

create table manager( --9페이지
manager_id varchar2(30) constraint manager_id_pk primary key,
manager_pwd varchar2(20) not null,
manager_tel varchar2(20)
); -- 아이디pk, 비밀번호, 전화번호

insert into manager
values ('himedia1','24352','010-1425-3421');
insert into manager
values ('himedia2','35264','010-7428-3671');
insert into manager
values ('himedia3','22457','010-8565-45271');
insert into manager
values ('himedia4','54682','010-2545-7851');
insert into manager
values ('himedia5','98724','010-9476-4681');

commit;


create table wine_type( --10페이지
wine_type_code varchar2(6) constraint wine_type_code_pk primary key,
wine_type_name varchar2(50)
); -- 종류코드, 와인종류이름

insert into wine_type
values ('2424','와인종류1');
insert into wine_type
values ('3434','와인종류2');
insert into wine_type
values ('4444','와인종류3');
insert into wine_type
values ('5454','와인종류4');
insert into wine_type
values ('6464','와인종류5');

commit;

create table member( --2페이지
mem_id varchar2(6) constraint mem_id_pk primary key,
mem_grade varchar2(20),
constraint mem_grade foreign key (mem_grade) references grade_pt_rade(mem_grade),
mem_pw varchar(20) not null,
mem_birth date default sysdate not null,
mem_tel varchar2(20),
mem_pt varchar2(10) default 0 not null
)-- 아아디 pk, 회원등급 fk, 비밀번호,생년월일,전화번호,마일리지

insert into member
values ('bono02','GOLD','35214','96/08/11','010-3415-2341','마일1');
insert into member
values ('bono03','SILVER','55451','94/02/01','010-3415-2341','마일2');
insert into member
values ('bono04','STONE','7214','93/01/17','010-3415-2341','마일3');
insert into member
values ('bono05','BRONZE','87214','95/06/30','010-3415-2341','마일4');
insert into member
values ('bono06','DIAMOND','96214','98/02/21','010-3415-2341','마일5');

commit;

create table wine( --6 페이지
wine_code varchar2(26) constraint wine_code primary key,
wine_name varchar2(100) not null,
wine_url blob,
nation_code varchar2(6),
constraint natnion_code_fk FOREIGN key (nation_code) references nation(nation_code),
wine_type_code varchar2(6),
constraint wine_type_code_fk FOREIGN key (wine_type_code) references wine_type(wine_type_code),
wine_sugar_code number(2),
wine_price number(15) default 0 not null,
wine_vintage date,
theme_code varchar2(6),
constraint theme_code_fk foreign key (theme_code) references theme(theme_code),
today_code varchar2(6),
constraint today_code_fk foreign key (today_code) references today(today_code)
);-- 와인코드pk,와인이름,와인사진저장,국가코드fk,종류코드fk,당도별,가격,생산년도,테마코드fk,오늘의와인코드fk

insert into wine
values ('4321','와인1','24351','82','2424',23,10000,'50/03/02','1234','1111');
insert into wine
values ('5432','와인2','23415','85','3434',34,20000,'80/03/02','2345','2222');
insert into wine
values ('6543','와인3','24351','36','4444',45,30000,'60/03/02','3456','3333');
insert into wine
values ('7654','와인4','523421','45','5454',24,40000,'70/06/02','4567','4444');
insert into wine
values ('8765','와인5','234512','24','6464',35,50000,'40/03/02','5678','5555');

commit;

create table sale( --1페이지
sale_date date default sysdate constraint slae_date_pk primary key,
wine_code varchar2(6) not null,
constraint wine_code_fk foreign key (wine_code) references wine(wine_code),
mem_id varchar2(30) not null,
constraint mem_id_fk foreign key (mem_id) references member(mem_id),
sale_amount varchar2(5) default 0 not null,
sale_price varchar2(6) default 0 not null,
slae_tot_price varchar2(15) default 0 not null
); -- 판매날짜pk , 와인코드fk,아이디fk,판매수량,판매단가,판매가격

insert into sale
values ('22/07/13','4321','bono03',43,2000,60000);
insert into sale
values ('22/07/14','5432','bono02',3,6000,40000);
insert into sale
values ('22/07/18','6543','bono04',23,4000,30000);
insert into sale
values ('22/07/19','7654','bono05',13,5000,20000);
insert into sale
values ('22/07/20','8765','bono06',35,1000,10000);

commit;

create table stock_managerment(
stock_code varchar2(6) constraint stock_code_pk primary key,
wine_code varchar2(6),
constraint stock_man_wine_code_fk foreign key (wine_code) references wine(wine_code),
manager_id varchar2(30),
constraint stock_man_id_fk foreign key (manager_id) references manager(manager_id),
ware_date date default sysdate not null,
stock_amout number(5) default 0 not null
); --재고코드pk,와인코드fk,아이디fk, 입고일,재고량

insert into stock_managerment
values ('1122','4321','himedia1','22/12/5',3232);
insert into stock_managerment
values ('2233','5432','himedia2','22/12/4',482);
insert into stock_managerment
values ('3344','6543','himedia3','22/12/6',582);
insert into stock_managerment
values ('4455','7654','himedia4','22/12/8',662);
insert into stock_managerment
values ('5566','8765','himedia5','22/12/7',212);

commit;

