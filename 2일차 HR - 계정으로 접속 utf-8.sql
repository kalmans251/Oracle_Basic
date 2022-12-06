
-- 계정으로 접속한 ㅜ리
show user;

--현재 접속 한 계정에서 모든 테이블 출력
select * from tab;

-- 각 테이블의 구조 확인 : 컬럼 (자료형)
desc employee;
desc department;
desc salgrade;

-- 테이블의 각 컬럼에 저장된 값을 출력
select *
from employee;