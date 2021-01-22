--==============================
-- kh 계정
--==============================
show user;

--table sample 생성
create table sample(
    id number
);

--현재 계정의 소유 테이블 목록 조회
select * from tab;

--사원테이블
select * from employee;
--부서테이블
select * from department;
--직급테이블
select * from job;
--지역테이블
select * from location;
--국가테이블
select * from nation;
--급여등급테이블
select * from sal_grade;

--용어정리
--표(table=entity=relation - 데이터를  보관하는 객체) 은 
--열((column=field=attribute(속성) - 세로, 데이터가 담길 형식)
--행(row=record=tuple - 가로, 실제 데이터) 으로 이루어져있다.
--도메인 domain 하나의 컬럼에 취할수 있는 값의 그룹(범위) - 도메인이 Y/N뿐이면 2가지의 도메인만 가질수 있다고 말할수 있음 남/녀뿐이면 마찬가지 2가지 도메인만 가진거임

--테이블 명세
--컬럼명      널여부     자료형
describe employee; --둘중하나 사용
desc employee; --둘중하나 사용

--=====================================
--DATA TYPE
--=====================================
--컬럼에 지정해서 값을 제한적으로 허용
--1. 문자형 varchar2 | char
--2. 숫자형 number
--3. 날짜시간형 date | timestamp
--4. LOB

--=====================================
--문자형
--=====================================
--고정형 char(byte) : 최대 2000byte까지 넣을수 있음
--예를들어 char(10) 'korea' 영소문자는 글자당 1byte이므로 실제크기 5byte. but 고정형이라 10byte로 저장됨
--                        '안녕' 한글은 글자당 3byte(11g XE)이므로 실제크기 6byte. but 고정형이라 10byte로 저장됨.
--가변형 varchar2(byte) : 최대 4000byte까지 넣을수 있음
--예를들어 varchar2(10) 'korea' 영소문자는 글자당 1byte이므로 실제크기 5byte. 가변형이니 5byte로 저장됨
--                             '안녕' 한글은 글자당 3byte(11g XE)이므로 실제크기 6byte. 가변형이니 5byte로 저장됨.
-- 고정형, 가변형 모두 지정한 크기 이상의 값은 추가할 수 없다.

-- 가변형 long : 최대 2GB
-- LOB타입의(Large Objejct) 중의 CLOB(Character Large Object)는 단일컬럼 최대 4GB까지 지원

create table tb_datatype( --테이블 만드는 방법
-- 컬럼명 자료형 널여부 기본값순으로 만들어주면됨
    a char(10),
    b varchar2(10)
);
--테이블 조회
--select * from tb_datatype; --여기서 *는 모든 컬럼을 의미한다.
select a, b --컬럼명을 골라주고
from tb_datatype; --어디테이블 불러올건지 적어주면됨

--데이터추가 : 한행을 추가
insert into tb_datatype
values('hello', 'hello');

insert into tb_datatype
values('안녕', '안녕');

insert into tb_datatype
values('12345', '12345'); --얘도 문자이기때문에 1byte를 차지함

insert into tb_datatype
values('에브리바디', '안녕'); -- 오류 보고 - ORA-12899: value too large for column "KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10) / 컬럼의 사이즈보다 큰 데이터가 들어왔다(10까지만 들어갈수있는데 15를 넣으려고하니까)

--데이터 변경(insert, update, delete)되는 경우, 메모리(램)상에서 먼저처리된다.
--commit을 통해 실제 데이터베이스에 적용해야 한다. insert하고 select해서 조회할때 조회된다고해서 실제 database에 반영된게 아님 commit해줘야함.
commit;

--lengthb(컬럼명):number - 저장된 데이터의 실제크기를 리턴
select a, lengthb(a), b, lengthb(b)
from tb_datatype;

--=====================================
-- 숫자형
--=====================================
-- 정수, 실수를 구분치 않는다.
-- number(p, s)
-- p : 표현가능한 전체 자릿수
-- s : p 중 소수점이하 자리수
/*
값 1234.567
------------------------------------
number                   1234.567
number(7)                1235(자동 반올림처리됨)
number(7,1)              1234.6(자동 반올림처리됨)
number(7,-2)             1200(자동 반올림처리됨)
*/

create table tb_datatype_number(
    a number,
    b number(7),
    c number(7,1),
    d number(7,-2)
);

select * from tb_datatype_number;

--지정한 크기보다 큰 숫자는 오류 보고 - ORA-01438: value larger than specified precision allowed for this column 유발
--insert into tb_datatype_number
--values(1234567890.123, 1234567.567, 12345678.5678, 1234.567); -- 12345678.5678는 7자리가 넘어가므로 ORA-01438 , 1234567.567는 s로 인해 반올림되서 다버려지고 7자리남아서 오류발생안됨

insert into tb_datatype_number
values(1234.567, 1234.567, 1234.567, 1234.567);

commit;
--마지막 commit시점 이후 변경사항은 취소된다. --변경내역에 대한 취소 --이미 커밋한건 돌릴수없음
rollback; 

--=====================================
-- 날짜시간형
--=====================================
-- date 년월일시분초 표현가능
-- timestamp 년월일시분초 + 밀리초, 지역대까지도 저장가능

create table tb_datatype_date(
     a date,
     b timestamp
);

--to _char 날짜/숫자를 ()안의 형식으로 문자열표현 (a, 'yyyy/mm/dd hh24:mi:ss') a를 년/월/일/24시/분/초의 형식으로 표현해라!
select to_char(a, 'yyyy/mm/dd hh24:mi:ss'),b from tb_datatype_date;

insert into tb_datatype_date
values(sysdate, systimestamp);

--날짜형 +/- 숫자(1=하루)) = 날짜형
select to_char(a, 'yyyy/mm/dd hh24:mi:ss'),
         to_char(a + 1, 'yyyy/mm/dd hh24:mi:ss'),
         to_char(a - 1, 'yyyy/mm/dd hh24:mi:ss'),
         b 
from tb_datatype_date;

--날짜형 - 날짜형 = 숫자(1=하루)
select sysdate - a --0.00895일 차이남 pm 08:27기준
from tb_datatype_date;

--to_date 문자열을 날짜형으로 변환 함수
select to_date('2021/01/23') - a
from tb_datatype_date;

--dual 가상테이블 / 가상테이블에서 '오늘날짜+1(내일) - 오늘날짜'하면 몇이 나올까 해보고싶어서 테이블 안만들고 가상테이블위에서 돌려본거임 내일에서 오늘빼면 1나옴
select (sysdate + 1) - sysdate
from dual;

--=====================================
-- DQL
--=====================================
-- Data Query Language 데이터 조회(검색)을 위한 언어
-- select문
-- 쿼리 조회결과를 ResultSet(결과집합)라고 하며, 0행이상을 포함한다. 조회결과가 없을수도 있음

-- from절에 조회하고자 하는 테이블을 명시
-- where절에 의해서 특정행을 filtering(필터링) 가능.
-- select 절에 의해서 컬럼을 filtering(필터링) 또는 추가가능
-- order by절에 의해서 행을 정렬할 수 있다.

/*
구조

select 컬럼명 (5) 필수
from 테이블명 (1) 필수, oracle이 첫번째로 처리 - 우리도 첫번째로 작성하는 습관을 들여 oracle과 순서 맞추는 습관을 들여야함.
where 조건절 (2) 선택
group by 그룹기준컬럼 (3) 선택
having 그룹조건절 (4) 선택
order by 정렬기준컬럼 (6) 선택

*/

select *
from employee
where dept_code = 'D9' -- 데이터는 대소문자 구분
order by emp_name asc; -- 오름차순 cf) desc 내림차순

-- 1. job테이블에서 job_name 컬럼정보만 출력
select job_name
from job;
-- 2. department테이블에서 모든 컬럼정보를 출력
select *
from department;
-- 3. employee테이블에서 이름, 이메일, 전화번호, 입사일을 출력
select EMP_NAME, EMAIL, PHONE, HIRE_DATE
from employee;
-- 4. employee테이블에서 급여가 2,500,000원 이상인 사원의 이름과 급여를 출력
select EMP_NAME, SALARY
from employee
where SALARY >= 2500000;
-- 5. employee테이블에서 급여가 3,500,000원 이상이면서, 직급코드가 'J3'인 사원을 조회 (&&나 || 사용불가, and or 만 사용가능)
select *
from employee
where SALARY >= 3500000 and JOB_CODE='J3';
-- 6. employee테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력
select *
from employee
where QUIT_YN='N'
order by EMP_NAME asc; --기본값이 오름차순이라 asc빼줘도 값은 똑같이 나옴 /ascending(기본값) | descending

--=====================================
-- SELECT
--=====================================
--table의 존재하는 컬럼
--가상컬럼(산술연산) salary * 12는 없는 컬럼인데 산술연산해서 만들어줌
--임의의 값(literal), 123,'안녕'쓰면 없는 컬럼인데 표시해줌
--각 컬럼은 별칭(alias)를 가질 수 있다. as ""안에 넣어주면 컬럼명이 아닌 별칭으로 표시해줌, as와 "(쌍따옴표)"는 생략가능
select emp_name as "사원명", phone, salary, salary * 12, 123, '안녕'
from employee;

--실급여 : salary + (salary + bonus)
select emp_name,
         salary,
         bonus,
         salary + (salary * bonus) 실급여 --bonus가 null값인 경우도 있음
from employee; 

--null값과는 산술연산 할수 없다. 그 결과는 무조건 null이다. bonus가 null인사람은 실급여가 null이 되버림;;
--null % 1(X) 나머지 연산자는 사용불가
select null + 1,
         null - 1,
         null * 1,
         null / 1
from dual; --1행짜리 가상테이블

--nvl(col, null일때 값) null처리 함수
--col의 값이 null이 아니면, col값 리턴
--col의 값이 null이면, null일때 값을 리턴
select bonus, nvl(bonus, 0) null처리후
from employee;

select emp_name,
         salary,
         bonus,
         salary + (salary * nvl(bonus,0)) 실급여
from employee; 

--distinct 중복제거용 키워드
--select절에 단 한번 사용가능하다. select뒤에 쓰면됨
--예를들어 직급코드를 중복없이 출력하고 싶을때
select distinct job_code
from employee;

select distinct job_code, dept_code --여러 컬럼 사용시 (job_code, dept_code)이렇게 컬럼을 묶어서 고유의 값으로 취급하기때문에 2개의 값이 중복된 것만 제거해서 보여줌, 각각의 중복을 제거해주지않음 두개가 동시에 중복일때!
from employee;

--문자 연결연산자 || 266번째줄 select '안녕' || '하세요' || 123 와같이 쓰면됨
-- + 는 산술연산만 가능하다. 문자를 못붙여줌 오류뜸 --ORA-01722: invalid number 01722. 00000 -  "invalid number" *Cause:    The specified number was invalid. *Action:   Specify a valid number.
--select '안녕' + '하세요'
--from dual;
select '안녕' || '하세요' || 123 
from dual;

select emp_name || '(' ||phone|| ')' --()를 붙여준거임 안에 번호넣게 선동일(01099546325) 이런식으로 나옴
from employee;

--=====================================
-- WHERE
--=====================================
--테이블의 모든 행 중 결과집합에 포함될 행을 필터링한다.
--특정행에 대해 true(포함) | false(제외) 결과를 리턴한다.

/*
    =                   같은가
    != ^= <>        다른가
    > < >= <=
    between .. and ..    범위연산
    like, not like          문자패턴연산
    is null, is not null    null여부검사
    in, not in               값목록에 포함여부
    
    and                 그리고
    or                   또는
    not                 제시한 조건 반전
*/
--부서코드가 D6인 사원 조회
select *
from employee
where dept_code = 'D6';

--급여가 2,000,000원보다 많은 사원 조회
select emp_name, salary
from employee
where salary > 2000000;

--날짜형 크기비교 가능
--과거 < 미래
select emp_name, hire_date
from employee
where hire_date < '2000/01/01'; --날짜형식의 문자열은 날짜형으로 형변환

--20년이상 근무한 사원 조회 
--날짜형 - 날짜형 = 숫자(1=하루)
--날짜형 - 숫자(1=하루) = 날짜형
select quit_yn, hire_date, emp_name
from employee
where quit_yn='N' and sysdate - hire_date >= 365 * 20; --sysdate 대신에 to_date('2021/01/22')이런식으로 원하는 날짜기준으로도 구해줄수 있다.

--부서코드가 D6이거나 D9인 사원 조회
select emp_name, dept_code
from employee
where dept_code = 'D6' or dept_code = 'D9';

--범위 연산
--급여가 200만원이상 400만원 이하인 사원 조회(사원명, 급여)
select emp_name, salary
from employee
where salary >= 2000000 and salary <=4000000; --방법1

select emp_name, salary
from employee
where salary between 2000000 and 4000000; --방법2 between은 경계값 포함 between and 사이의 범위설정값(2000000,4000000)도 포함시킴, 이상이하와 같다고 보면됨

--입사일이 1990/01/01 ~ 2001/01/01 인 사원조회(사원명, 입사일)
select emp_name, hire_date
from employee
where hire_date >= '1990/01/01' and HIRE_DATE <= '2001/01/01' and quit_yn = 'N'; --방법1

select emp_name, hire_date
from employee
where hire_date between to_date('1990/01/01') and to_date('2001/01/01') and quit_yn = 'N'; --방법2 to_date는 생략해도 됨 HIRE_DATE between '1990/01/01' and '2001/01/01' 이렇게 ㅇ.ㅇ

--like, not like
--문자열 패턴 비교 연산

--wildcard : 패턴 의미를 가지는 특수문자
-- _(언더스코어) : 아무문자 1개
-- %(퍼센트) : 아무문자 0개 이상
select emp_name
from employee
where emp_name like '전%'; --전으로 시작, 0개이상의 문자가 존재하는가 / 전만있어도 나옴 ex) 전, 전X, 전XX, 전XXX.... 전으로 시작하는건 다 나옴 but X전,XX전 이런건 안나옴

select emp_name
from employee
where emp_name like '전__'; --전으로 시작, 1+1개의 문자가 존재하는가(언더스코어2개썼으므로) / ex) 전XX만 나옴 but 전, 전X, 전XXX.... 안나옴 X전,XX전 이런것도 안나옴

--이름에 가운데글자가 '옹'인 사원 조회. 단, 이름은 3글자이다.
select emp_name
from employee
where emp_name like '_옹_';

--이름에 '이'가 들어가는 사원 조회.
select emp_name
from employee
where emp_name like '%이%';

--email컬럼값의 '_' 이전 글자가 3글자인 이메일을 조회
select email
from employee
--where EMAIL like '____%'; --4글자 이후 0개이상의 문자열 뒤따르는가 -> 문자열이 4글자이상인가? 그래서 _(언더스코어)앞에 3글자만 오는 문자열만 뽑고싶을땐 이렇게 쓰면 안됨 escape처리해서 _를 문자로보게 해야함 \n \t이런거랑 비슷함
where email like '___\_%' escape '\'; --escaping 문자등록 escape뒤에 오는'\'는 _(언더스코어)를 문자로 쓸수있게 탈출시켜줌 꼭 \가 아니고 다른문자로 써도됨 where email like '___#_' escape '#'; 이런것도 된다는 뜻. 데이터에 존재하지 않는 escape문자를 써야함 -> 데이터에 #,\가 있어서는 안된다는 뜻

--in, not in 값목록에 포함여부
--부서코드가 D6 or D8인 사원 조회
select emp_name, dept_code
from employee
where dept_code = 'D6' or dept_code = 'D8'; --기존방법

select emp_name, dept_code
from employee
where dept_code in ('D6', 'D8'); --in을 쓴 방법, 'D6' or 'D8'이 있는 애들을 보여줘라! 개수제한 없이 값 나열

--in, not in 값목록에 포함여부
--부서코드가 !(D6 and D8)인 사원 조회
select emp_name, dept_code
from employee
where dept_code != 'D6' and dept_code != 'D8'; --기존방법

select emp_name, dept_code
from employee
where dept_code not in ('D6', 'D8'); --not in을 쓴 방법, 'D6' and 'D8'이 없는 애들을 보여줘라!

--인턴사원 조회(부서가 없어서 null로 되있는 애들) -> null값으로 검색해도 안나옴 is null을 써줘야함
--null값은 산술연산, 비교연산 모두 불가능하다.
--select emp_name, dept_code
--from employee
--where dept_code = null;

--is null, is not null : null 비교연산
--인턴사원 조회(부서가 없어서 null로 되있는 애들)
select emp_name, dept_code
from employee
where dept_code is null;

--인턴사원이 아닌애들 조회
select emp_name, dept_code
from employee
where dept_code is not null;

--D6, D8부서원이 아닌 사원조회(인턴사원 포함(부서가 null인애들))
select emp_name, dept_code
from employee
where dept_code not in ('D6', 'D8') or dept_code is null;

--D6, D8부서원이 아닌 사원조회(인턴사원 포함(부서가 null인애들))
--nvl버젼
select emp_name, nvl(dept_code,'인턴') dept_code --null을 인턴으로 만들어주고싶을때!
from employee
where nvl(dept_code,0) not in ('D6', 'D8');

--=====================================
-- ORDER BY
--=====================================
--select구문 중 가장 마지막에 처리
--지정한 컬럼 기준으로 결과집합을 정렬해서 보여준다.

-- 기본정렬기준 asc (<-> desc)
-- number 0 -> 10...
-- string ㄱ -> ㅎ, a -> z
-- date 과거 -> 미래

-- null값 위치를 결정가능 : nulls first | nulls last
-- asc 오름차순(기본값)
-- desc 내림차순
-- 복수개의 컬럼 차례로 정렬가능

select emp_id, emp_name, dept_code, job_code, hire_date --null은 안정해주면 기본정렬(asc)시에 맨나중에 나온다. desc시에는 맨먼저 나옴
from employee
order by dept_code;

select emp_id, emp_name, dept_code, job_code, hire_date --null위치 정해주기 기본정렬(asc)시에 맨먼저 나오게하고 싶을때
from employee
order by dept_code nulls first;

select emp_id, emp_name, dept_code, job_code, hire_date --null위치 정해주기 desc시에 맨나중에 나오게하고 싶을때
from employee
order by dept_code desc nulls last;

-- alias 사용가능 / 이름지어주고 그 이름으로 정렬기준삼음. 원래는 emp_name이렇게 되야되는데 별칭으로 정렬시키기!
select emp_id 사번, emp_name 사원명
from employee
order by 사원명;

--cf) alias 사용할경우 실행순서 고려해서 select보다 먼저 실행되는곳에서는 별칭으로 명령 못시킴!
--select emp_id 사번, emp_name 사원명 , dept_code 부서코드
--from employee
--where  부서코드 = 'D9' // select에서 별칭생기기전에 where가 먼저 실행되기때문에 부서코드 ='D9'라는 조건을 못찾음 그래서 에러발생!
--order by 사원명;

--1부터 시작하는 컬럼순서 사용가능(근데 비추 중간에 데이터 변경시 문제생김) / ORACLE은 JAVA와 다르게 INDEX NUMBER가 0이아닌 1부터시작한다는 특징이있음!!!!
select *
from employee
order by 9 desc;

--=====================================
-- BUILT-IN FUNCTION
--=====================================
--일련의 실행 코드 작성해두고 호출해서 사용함
--반드시 하나의 리턴값을 가짐

--1. 단일행 함수
--      a. 문자처리함수
--      b. 숫자처리함수
--      c. 날짜처리함수
--      d. 형변환함수
--      e. 기타함수
--2. 그룹함수








