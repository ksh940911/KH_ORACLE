--==========================
-- system 관리자 계정
--==========================

--한줄주석
/*
구문주석(여러줄 주석)
*/

show user;

--현재 등록된 사용자목록 조회
--블럭잡아서 ctrl+enter하면 블럭잡은 부분만 실행됨
--실행하는 것은 한번씩 사용하고 날리는 것
--명령어 전달 -> 결과받아오기 -> 끝
/*
sys = 슈퍼관리자(db생성, 삭제권한 있음)
system = 일반관리자(db생성, 삭제권한 없음, but 거의 모든 작업할수있음)
알맞은 권한을 갖고있는 사용자로 작업하는게 좋음
*/
select * 
from dba_users;

/*
sql문은 대소문자를 구분하지 않는다. 
블락지정후 alt + ' : 대소문자전환 단축키
단! 사용자계정의 비밀번호, 테이블내의 데이터는 대소문자 구분한다.
*/
SELECT *
FROM DBA_USERS;

--관리자는 일반사용자를 생성 할 수 있다.
create user kh
identified by kh  --비밀번호(대소문자 구분)

create user kh_practice
identified by kh_practice
default tablespace users; --데이터가 저장될 영역 system | users --한번 만들고 나면, 또 실행할 수 없음

--사용자 삭제
--drop user kh;
--테이블은 무조건 소유주가 있음, 주인없는 테이블 존재불가
--사용자를 삭제하면, 안에 있는 table들을 모두 삭제하는 것!
--그러면 각 테이블 안의 데이터들이 다 날아감! 주의!

--접속권한 create session이 포함된 role(권한묶음) connect 부여
grant connect to kh;

--테이블등 객체 생성권한이 포함된 role resource 부여
grant resource to kh;

--테이블 생성권한만 부여
grant create table to kh;

--한번에 부여하기
grant connect, resource to kh;

--chun계정 생성
create user chun
identified by chun
default tablespace users;

--connet, resource를 부여
grant connect, resource to chun;
grant connect, resource to kh_practice;

-- role(권한 묶음)에 포함된 권한 확인
-- DataDictionary db의 각 객체에 대한 메타정보를 확인할 수 있는 read-only 테이블
select *
from dba_sys_privs
where grantee in ('CONNECT', 'RESOURCE');

--******************************************여기 다시보기

