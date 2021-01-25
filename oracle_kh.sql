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

--1. 단일행 함수 : 각행마다 반복 호출되어서 호출된 수만큼 결과를 리턴함
--      a. 문자처리함수
--      b. 숫자처리함수
--      c. 날짜처리함수
--      d. 형변환함수
--      e. 기타함수
--2. 그룹함수 : 여러행을 grouping(그룹핑)한후, 그룹당 하나의 결과를 리턴함.

--=====================================
-- 단일행 함수
--=====================================

--=====================================
-- a. 문자처리함수
--=====================================

--length(col):number
--문자열의 길이를 리턴
select emp_name, length(emp_name) --emp_name(사원이름)의 길이를 보여줌
from employee;
--where절에서도 사용가능
select emp_name, email
from employee
where length(email) > 15; --email의 길이가 15이상인 이메일을 보여줌

--lengthb(col)
--값의 byte수 리턴
select emp_name, lengthb(emp_name), email, lengthb(email) --emp_name(사원이름)의 길이, byte수, email의 길이, byte수를 보여줌
from employee;

--instr(string, search[, position[, occurence]]) /대괄호는 생략가능하다는 뜻임
--string에서 search가 위치한 index를 반환
--ORACLE에서는 1-BASED INDEX. 인덱스가 1부터 시작하니 주의
select instr('kh정보교육원 국가정보원 정보문화사', '정보'), --3을 반환함. string에서 search가 위치한 index를 반환한다고했으니 3이 가리키는건 3번째 인덱스에 위치한걸 알려주는거임
         instr('kh정보교육원 국가정보원 정보문화사', '안녕'), --0을 반환함. JAVA는 찾는값이 없으면 -1을 리턴하는데 ORACLE은 찾는값이 없을때 0을 리턴함.
         instr('kh정보교육원 국가정보원 정보문화사', '정보', 5), --11을 반환함. index 5번위치부터 값을 찾기 시작했으니 11번째 index가 search가 찾는 '정보'가 있는 첫위치라 11번째 인덱스에 위치한걸 가리키는것임
         instr('kh정보교육원 국가정보원 정보문화사', '정보', 1, 3), --15을 반환함. index 1번위치부터 값을 찾기 시작했으나 search가 찾는 '정보'가 있는 3번째 인덱스 위치를 물어봤기 때문에 15번째 인덱스에 위치한 '정보'가 search가 찾는 3번째 '정보'라는걸 알려줌
         instr('kh정보교육원 국가정보원 정보문화사', '정보', -1) --11을 반환함. startPosition이 음수면 뒤에서부터 검색하는거임. 위에예제는 앞에서부터 몇번째부터 값을 찾아올지였는데 음수를 써서 뒤에서부터도 검색이가능함
from dual;

--email컬럼값중 '@'의 위치는? (이메일, 인덱스)
select email, instr(email,'@')
from employee;

--substr(string, startIndex[, length])
--string에서 startIndex부터 length개수만큼 잘라내어 리턴
--length 생략시에는 문자열 끝까지 반환

select substr('show me the money', 6, 2), --6번째 인덱스 문자부터 2개만큼 잘라서 보여줘라! 공백도 인덱스 자리차지함/ me
         substr('show me the money', 6), --6번째 인덱스 문자부터 끝까지 잘라서 보여줘라! 공백도 인덱스 자리차지함/ me the money
         substr('show me the money', -5, 3) --뒤에서 5번째 인덱스 문자부터 3개만큼 잘라서 보여줘라! / mon
from dual;

--@실습문제 : 사원명에서 성(1글자로 가정)만 중복없이 사전순으로 출력
select distinct substr(emp_name, 1, 1) 성
from employee
order by 1;

-- lpad|rpad(string, byte[, padding_char])
-- byte수의 공간에 string을 대입하고, 남은 공간은 padding_char를 왼쪽|오른쪽에 채울것
-- padding char는 생략시 공백문자가 나옴

select lpad(email, 20, '#'), --20바이트 공간에 email을 대입하고, 남는 공간은 #으로 왼쪽에 채울것
         rpad(email, 20, '#'), --20바이트 공간에 email을 대입하고, 남는 공간은 #으로 오른쪽에 채울것
         lpad(email, 20), --20바이트 공간에 email을 대입하고, 남는 공간은 공백으로 왼쪽에 채울것
         '[' || lpad(email, 20) || ']', --20바이트 공간에 email을 대입하고, 남는 공간은 []안에 공백으로 왼쪽에 채울것
         '[' || rpad(email, 20) || ']' --20바이트 공간에 email을 대입하고, 남는 공간은 []안에 공백으로 오른쪽에 채울것
from employee;

--@실습문제 : 남자사원만 사번, 사원명, 주민번호, 연봉 조회
--주민번호 뒤 6자리는 ****** 숨김처리할 것.
select emp_id, emp_name, substr(emp_no,1,8) || '******', (salary + (salary + nvl(bonus ,0))) * 12 --방법 1
from employee
where substr(emp_no, 8, 1) in ('1', '3'); 

select emp_id, emp_name, rpad(substr(emp_no,1,8), 14, '*'), (salary + (salary + nvl(bonus ,0))) * 12 --방법 2 
from employee
where substr(emp_no, 8, 1) in ('1', '3');

--=====================================
-- b. 문자처리함수
--=====================================

--mod(피젯수, 젯수)
--나머지 함수, 나머지 연산자%가 없다. 몫을구하는 함수는 없음
select mod(10,2), --결과 : 0
         mod(10,3), --결과 : 1
         mod(10,4) --결과 : 2
from dual;

--입사년도가 짝수인 사원 조회
select emp_name, extract(year from hire_date) year -- extract: 날짜함수 : 연도추출
from employee
--where mod(year,2) = 0 -- ORA-00904: "YEAR": invalid identifier where가 select보다 늦게 실행되므로 year라는 별칭으로 값을 가져올수없음
where mod(extract(year from hire_date), 2) = 0
order by year;

--ceil(number)
--소수점기준으로 올림.
select ceil(123.456),
         ceil(123.456 * 100) / 100 --부동소수점 방식으로 처리
from dual;

--floor(number)
--소수점기준으로 버림
select floor(456.789),
         floor(456.789 * 10) / 10
from dual;

--round(number[, position])
--position기준(아무것도 안넣으면 기본값은 0임 - 소수점기준0번째자리에서 반올림 / 1일때는 소수점첫째자리 2일때는 소수점둘째자리)으로 반올림처리
select round(234.567), -- 235
         round(234.567,1), -- 234.6
         round(234.567,2), -- 234.57
         round(234.567, -1), --230
         round(235.567, -1) --240
from dual;

--trunc(number[, position])
--버림 / floor와 기능은 갖지만 position기준으로 버릴수 있어서 더 자주 사용함
select trunc(123.567), -- 123
         trunc(123.567, 1), -- 123.5
         trunc(123.567, 2), -- 123.56
         trunc(123.567, -1) -- 120
from dual;

--=====================================
-- c. 날짜처리함수
--=====================================
--날짜형 + 숫자 = 날짜형
--날짜형 - 날짜형 = 숫자

--add_months(date, number)
--date기준으로 몇달(number) 전후의 날짜형을 리턴
select sysdate, -- 21/01/25
         add_months(sysdate ,1), -- 21/02/25
         add_months(sysdate, -1), -- 20/12/25
         add_months(sysdate + 5, 1) -- 21/02/28 / 1월25일 +5를 해주면 1월 30일인데, 여기서 add_months해서 1달후를 구하면 2월 30일이 없기때문에 그냥 말일을 가리켜버림 3월 2일 이런식으로 되는게 아님
from dual;

--months_between(미래, 과거)
--두 날짜형의 개월수 차이를 리턴한다.
select sysdate,
         to_date('2021/07/08'), -- to_date : 문자를 날짜형으로 변환시켜주는 함수
         months_between(to_date('2021/07/08'), sysdate),
         trunc(months_between(to_date('2021/07/08'), sysdate), 0) 두날짜개월수차이
from dual;

--이름, 입사일, 근무개월수(n개월), 근무개월수(n년 m개월) 조회
select emp_name, 
         hire_date, 
         trunc(months_between(sysdate, hire_date),0) || '개월' 근무개월수 , 
         floor(trunc(months_between(sysdate, hire_date),0)/12) || '년' || floor(mod(months_between(sysdate, hire_date), 12)) || '개월' 근무개월수
from employee;

--extract(year | month | day | hour | minute | secont from date) : number
--날짜형 데이터에서 특정필드만 숫자형으로 리턴
select extract(year from sysdate) yyyy, 
         extract(month from sysdate) mm, --범주 1~12, 자바는 0부터 시작하지만 오라클은 1부터 시작
         extract(day from sysdate) dd,
--       extract(hour from sysdate) hh -- ORA-30076: invalid extract field for extract source /시분초 구할때는 아래와 같이 timestamp로 변환작업을 한번 해줘야함
         extract(hour from cast(sysdate as timestamp)) hh,
         extract(minute from cast(sysdate as timestamp)) mi,
         extract(second from cast(sysdate as timestamp)) ss
         -- 2021	1	25	16	50	47
from dual;

--trunc(date)
--시분초 정보를 제외한 년월일 정보만 리턴
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') date1, -- 2021/01/25 16:49:31
         to_char(trunc(sysdate), 'yyyy/mm/dd hh24:mi:ss') date2 -- 2021/01/25 00:00:00
from dual;

--=====================================
-- d. 형변환함수(문자형, 숫자형, 날짜형끼리 변환시켜줌)
--=====================================
/*
               to_char        to_date
            ----------->    ----------->                
    number          string          date
            <----------     <----------                
            to_number       to_char

*/

--to_char(date | number[, format])

select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') now,
         to_char(sysdate, 'yyyy/mm/dd hh:mi:ss am') now1,
         to_char(sysdate, 'yyyy/mm/dd(dy) hh:mi:ss am') now2, -- dy는 ex)월,화... 만나옴
         to_char(sysdate, 'yyyy/mm/dd(day) hh:mi:ss am') now3, -- day는 ex)월요일,화요일... 요일까지나옴
         to_char(sysdate, 'fmyyyy/mm/dd(day) hh:mi:ss am') now4, --형식문자로 인한 앞글자 0을 제거
--       to_char(sysdate, 'yyyy년 mm월 dd일') now4 --ORA-01821: date format not recognized
         to_char(sysdate, 'yyyy"년" mm"월" dd"일"') now5 --인식하지 못할때는 ""로 감싸주면 잘인식함
from dual;

select to_char(1234567, '9,999,999,999') won, 
         to_char(1234567, 'fm9,999,999,999') won1, --fm은 공백또는0제거
         to_char(1234567, 'fmL9,999,999,999') won2,--L은 지역화폐
--       to_char(1234567, 'fmL9,999') -- ################이렇게 나옴. 포멧타입이 포멧타입에 적용하려는 문자보자 범위가 작을경우 이런식으로 잘못출력함 더 크게 만들어줘야함
         to_char(123.4, '9999.99') won3, --소수점이상의 빈자리는 공란, 소수점이하 빈자리는 0처리
         to_char(123.4, 'fm9999.99') won3_1, --0과 공백제거됨
         to_char(123.4, '0000.00') won4, --빈자리는 0처리
         to_char(123.4, 'fm0000.00') won4_1 --공백제거됨
from dual;

--이름, 급여(3자리 콤마), 입사일(1990-9-3(화))을 조회
select emp_name 이름, to_char(salary, 'fmL9,999,999,999') 급여, to_char(hire_date, 'fmyyyy-mm-dd(dy)') 입사일
from employee;

--to_number(string, format)
--select to_number('1,234,567') -- ORA-01722: invalid number
--select to_number('1,234,567') + 100, --ORA-01722: invalid number
select to_number('1,234,567', '9,999,999'),
         to_number('1,234,567', '9,999,999') + 100,
         to_number('￦3,000', 'L9,999') + 100 -- \표시 ㄹ한자로찍어야함
from dual;

--자동형변환 지원
select '1000' + 100, -- 1100 / 오라클이 숫자로 자동형변환해서 계산해줌
         '99' + '1', -- 100 / 오라클이 숫자로 자동형변환해서 계산해줌
         '99' || '1' -- 991 / 오라클이 문자로 자동형변환(인식)해서 글짜를 붙여줌
from dual;

--to_date(string, format)
--string이 작성된 형식문자  format으로 전달
select to_date('2020/09/11', 'yyyy/mm/dd'),  --날짜형으로 변환된거임  
         to_date('2020/09/11', 'yyyy/mm/dd') + 1 -- +1 을해주면 하루지난날짜가 나옴
from dual;

--'2021/07/08 21:50:00'를 2시간 후의 날짜정보를 yyyy/mm/dd hh24:mi:ss형식으로 출력
select to_char(to_date('2021/07/08 21:50:00', 'yyyy/mm/dd hh24:mi:ss') + (2/24) , 'yyyy/mm/dd hh24:mi:ss') 결과
from dual;

--현재시각 기준 1일 2시간 3분 4초후의 날짜 정보를 yyyy/mm/dd hh24:mi:ss형식으로 출력
--1시간 : 1 / 24
--1분 : 1 / (24 * 60)
--1초 : 1 / (24 * 60 * 60)
select to_char(sysdate + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)), 'yyyy/mm/dd hh24:mi:ss') 결과
from dual;

--기간타입
--to_yminterval('yy-mm')
--interval year to month : 년월 기간
--to_dsinterval('dd hh24:mi:ss')
--interval date to second : 일시분초 기간

--1년 2개월 3일 4시간 5분 6초후의 시간을 알고싶을때 조회하는법
select to_char(add_months(sysdate, 14) + 3 + (4/24) + (5/(24*60)) + (6/(24*60*60)), 'yyyy/mm/dd hh24:mi:ss') result --방법1
from dual;

select to_char(add_months(sysdate, 14) + 3 + (4/24) + (5/ 24 / 60) + (6/24/60/60), 'yyyy/mm/dd hh24:mi:ss') result --방법2
from dual;

select to_char(sysdate + to_yminterval('01-02') + to_dsinterval('3 04:05:06'), 'yyyy/mm/dd hh24:mi:ss') result --방법3
from dual;

--numtodsinterval(diff, unit)
--numtoyminterval(diff, unit)
--diff : 날짜차이
--unit(원하는 단위) : year | month | day | hour | minute | second
select to_date('20210708', 'yyyymmdd'),
         to_date('20210708', 'yyyymmdd') - sysdate,
         numtodsinterval(to_date('20210708', 'yyyymmdd') - sysdate, 'day'),
         extract(day from numtodsinterval(to_date('20210708', 'yyyymmdd') - sysdate, 'day')) 날짜차이
from dual;

--=====================================
-- e. 기타함수
--=====================================

--null 처리 함수
--nvl(col, nullvalue) / 이미배웠음

--nvl2(col, notnullvalue, nullvalue)
--col값이 null이 아니면 두번째인자를 리턴, null이면 세번째인자를 리턴

select emp_name, bonus, 
         nvl(bonus, 0) nvl1, --null일경우 0을리턴
         nvl2(bonus, '있음', '없음') nvl2 --null이 아닐경우 '있음'리턴, null일경우 '없음'리턴
from employee;

--선택함수1
--decode(expr, 값1, 결과값1, 값2, 결과값2, ...[, 기본값])
select emp_name, emp_no,
         decode(substr(emp_no, 8, 1), '1', '남', '2', '여', '3', '남 ', '4', '여') gender, --값에 따른 결과값을 전부 만들어준 경우
         decode(substr(emp_no, 8, 1), '1', '남', '3', '남 ', '여') gender --기본값을 여자로 설정하고 남자일경우만 결과값 만들어준 경우
from employee;

--직급코드에 따라서 J1-대표, J2/J3-임원, 나머지는 평사원으로 출력(사원명, 직급코드, 직위)
select emp_name, job_code, decode(job_code, 'J1', '대표', 'J2', '임원', 'J3', '임원', '평사원') 직위
from employee;

--where절에도 사용가능
--여사원만 조회
select emp_name, emp_no,
         decode(substr(emp_no, 8, 1), '1', '남', '3', '남 ', '여') gender
from employee
where decode(substr(emp_no, 8, 1), '1', '남', '3', '남 ', '여') = '여';

--선택함수2
--case
/*
type1(decode와 유사) 
※ ,(쉼표)로 구분해주지 않음!!!! 그리고 end로 마무리해줄것!!!!

case 표현식
    when 값1 then 결과1
    when 값2 then 결과2
    ...
    [else 기본값]
    end
*/
select emp_no,
         case substr(emp_no, 8, 1) --표현식
            when '1' then '남'
            when '3' then '남'
            else '여'
            end gender
from employee;

/*
type2

case 
    when 조건식1 then 결과1
    when 조건식2 then 결과2
    ...
    [else 기본값]
    end
*/
select emp_no,
         case --방법1, 표현식없음 when에 직접 넣어줌
            when substr(emp_no, 8, 1) = '1' then '남'
            when substr(emp_no, 8, 1) = '3' then '남'
            else '여'
            end gender,
         case --방법2
            when substr(emp_no, 8, 1) in ('1', '3') then '남'
            else '여'
            end gender_1,
         case --방법3
            when substr(emp_no, 8, 1) = '1' or substr(emp_no, 8, 1) ='3' then '남'
            else '여'
            end gender_2
from employee;

--직급코드에 따라서 J1-대표, J2/J3-임원, 나머지는 평사원으로 출력(사원명, 직급코드, 직위)
select emp_name, 
         case job_code
            when 'J1' then '대표' 
            when 'J2' then '임원'
            when 'J3' then '임원'
            else '평사원'
            end 직위, --type1 방법
        emp_name,
         case 
            when job_code = 'J1' then '대표' 
            when job_code in ('J2','J3') then '임원'
            else '평사원'
            end 직위 --type2 방법
from employee;

--=====================================
-- 그룹함수(GROUP FUNCTION)
--=====================================
--여러행을 그룹핑하고, 그룹당 하나의 결과를 리턴하는 함수
--모든 행을 하나의 그룹, 또는 group by를 통해서 세부그룹지정이 가능하다.

select * 
from employee;

--sum(col)
select sum(salary) --74576240 / 단일컬럼에서 모든행을 하나의 그룹으로 만들고 결과를 그룹당 하나로 리턴함(모든 샐러리컬럼을 더해서 하나의 결과값으로 뱉음)
from employee;

--select emp_name, sum(salary) from employee;
--ORA-00937: not a single-group group function
--그룹함수의 결과와 일반컬름을 동시에 조회할 수 없다.

select sum(salary), sum(bonus) --null인 컬럼은 제외하고 누계처리 / 그룹함수들의 결과는 동시에 조회가능
from employee;

select sum(salary), 
         sum(bonus),
         sum(salary + (salary * nvl(bonus, 0))) --가공된 컬럼도 그룹함수 가능
from employee;

--avg(col)
--평균
select avg(salary)
from employee; --평균월급 3107343.33333333333333333333333333333333

--평균(반올림처리.ver)
select round(avg(salary), 0) avg --평균월급 3107343
from employee;

--평균(원화표시&반올림처리.ver)
select round(avg(salary), 1) avg,
         to_char(round(avg(salary), 1), 'FML9,999,999,999') avg_ --평균월급 ￦3,107,343
from employee;

--부서코드가 D5인 부서원의 평균급여 조회
select to_char(round(avg(salary), 1), 'FML9,999,999,999') D5부서원평균월급 --평균월급 ￦2,626,667
from employee
where dept_code = 'D5';

--남자사원의 평균급여 조회
select to_char(round(avg(salary), 1), 'FML9,999,999,999') 남자사원평균월급 --평균월급 ￦3,317,333
from employee
where decode(substr(emp_no, 8, 1), '1', '남', '3', '남 ', '여') = '남';
                  
select to_char(round(avg(salary), 1), 'FML9,999,999,999') 남자사원평균월급 --평균월급 ￦3,317,333
from employee
where substr(emp_no, 8, 1) in('1', '3');

--count(col)
--null이 아닌 컬럼의 개수
-- * 모든 컬럼, 즉 하나의 행을 의미
select count(*)
from employee;

select count(*), count(bonus) --9나옴 / bonus컬럼이 null이 아닌 행의 수
from employee;

select count(*), count(bonus), count(dept_code) --22나옴 / dept_code컬럼이 null이 아닌 행의 수
from employee;

--보너스를 받는 사원수 조회
select count(*) || '명' 보너스받는사원수
from employee
where bonus is not null; -- 방법1

select bonus,
        case
            when bonus is not null then 1
            when bonus is null then 0
            end
from employee; --보너스 받는사람은 1, 아닌사람은 0 다 더하면 보너스를 받는 사원수를 구할수 있음

--가상컬럼의 합을 구해서 처리
select sum(
        case
            when bonus is not null then 1
            when bonus is null then 0 --얘는 생략가능함 왜냐면 0으로 안정해주면 null이기때문에 sum이 더할때 null을 빼고 더해서 결과 똑같이 나옴. 궁금하면 이줄 주석처리해보고 똑같이나오나 보시오 ㄱㄱ
            end) 보너스받는사원수
from employee; -- 방법2

--사원이 속한 부서 총수(중복없음)
select count(distinct dept_code)
from employee; --********************************************여기 다시보기

--max(col) | min(col)
--숫자, 날짜(min:과거 -> max:미래), 문자(min:ㄱ -> max:ㅎ)
select max(salary) , min(salary) from employee; --숫자(최고월급,최소월급)
select max(hire_date), min(hire_date) from employee; --날짜(마지막입사,최초입사)
select max(emp_name), min(emp_name) from employee; --문자(사전순 ㅎ쪽에 가까운사람이름, 사전순 ㄱ쪽에 가까운사람이름)






