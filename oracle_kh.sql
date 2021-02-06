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

--테이블 명세(describe)
--컬럼명      널여부     자료형

--1. 컬럼명
--대소문자 구분이 없음
--(empid, empId, EMPID 모두 다 같음.. -> Camel-Casing도 의미가 없음
--> 그래서 언더스코어를 이용해서 단어구분
-- -> emp_id, EMP_ID)
--2. 널여부
-- 값이 없을 수 있으면 null (선택, 생략가능),
-- 값이 없을 수 없으면 not null(꼭 기입해야함, 필수)
--like 회원가입's 필수, 선택 표시
--3. 자료형(해당크기)
-- 자료형 종류 : 날짜형, 숫자형, 문자형

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
--임의의 값(literal), 123, '안녕' 쓰면 없는 컬럼인데 표시해줌
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

--=====================================
-- DQL2
--=====================================
--=====================================
-- GROUP BY
--=====================================
--지정컬럼기준으로 세부적인 그룹핑이 가능하다.
--group by구문 없이는 전체를 하나의 그룹으로 취급한다.
--group by 절에 명시한 컬럼만 select절에 사용가능하다.

select sum(salary)
from employee; -- salary 전체를 하나의 그룹으로 취급하여 값 출력시킴

select dept_code, sum(salary)
from employee
group by dept_code; -- group by를 써서 그룹취급시켜서 부서별로 salary 값 출력시킴

select emp_name, dept_code, salary
from employee
order by dept_code; -- 조회해보면 부서를 그룹별로 묶어서 위쪽결과대로 출력시켜준걸 확인할 수 있음

select --emp_name,  -- 그룹함수가 아닌 컬럼은 group by 절에 명시한 컬럼만 select절에 사용가능하다. ORA-00979: not a GROUP BY expression 
dept_code, sum(salary) -- group by에는 없지만 salary는 그룹함수안에서 쓰였기 때문에 사용가능
from employee
group by dept_code; 

select dept_code, sum(salary)
from employee
group by dept_code; --일반컬럼 | 가공컬럼이 가능

select job_code, trunc(avg(salary),1) --가공컬럼이 사용되었는데 돌려보면 가공컬럼이 가능하다는거 확인 가능
from employee
group by job_code 
order by job_code; 

--부서코드별 사원수 조회
select nvl(dept_code, 'intern'), count(dept_code), count(*)
from employee
group by dept_code
order by dept_code; -- count(*)로 해주는게 좋음 왜냐면 count(dept_code)하면 null값을 빼고 집계해줘서 돌려보면 결과가 다른걸 확인할수 있다.

--부서코드별 사원수, 급여평균, 급여합계 조회
select nvl(dept_code, 'intern') 부서코드, count(*) 사원수, trunc(avg(salary),1) 급여평균, sum(salary) 급여합계
from employee
group by dept_code
order by dept_code; --내가한 ver.

select nvl(dept_code, 'intern') 부서코드, count(*) 사원수, to_char(trunc(avg(salary),1), 'fmL9,999,999,999.0') 급여평균, to_char(sum(salary),'fmL9,999,999,999') 급여합계
from employee
group by dept_code
order by dept_code; --강사님 ver. 포매팅까지 해준 결과 good!

--성별 인원수, 평균급여 조회 
select decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender, count(*) count
from employee
group by decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여'); --성별의 컬럼이 없으므로 가상컬럼으로 만들어서 진행시키면됨, 단 group by에서 그룹지어준 그대로 select쪽에 가져다가 써야함. group by에서 묶고 select에서 가져다가 gender라는 가상컬럼을 만들어준것

--성별 인원수, 평균급여 조회 
select decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender, count(*) count, to_char(trunc(avg(salary),1), 'fmL9,999,999,999.0') 급여평균
from employee
group by decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여');

--직급코드 J1을 제외하고, 입사년도별 인원수를 조회
select extract(year from hire_date) yyyy, count(*) count
from employee
where job_code != 'J1' -- != 대신에 <>를 써도됨
group by extract(year from hire_date)
order by yyyy;

--두개 이상의 컬럼으로 그룹핑 가능
select nvl(dept_code, '인턴'), job_code, count(*)
from employee
group by dept_code, job_code --부서내의 직급이 어떻게되는가 / 부서별로 먼저묶고 그안에 같은 직급끼리 몇명있는지 묶어서 찾아준거임
order by 1,2; --첫번째 컬럼(nvl(dept_code, '인턴'))을 기준으로 먼저 정렬시키고 두번째 컬럼(job_code)을 정렬기준으로 삼아서 정렬시켜라

--부서별 성별 인원수 조회
select nvl(dept_code,'인턴') 부서, decode(substr(emp_no,8,1), '1', '남', '3', '남', '여') 성별, count(*)
from employee
group by dept_code, decode(substr(emp_no,8,1), '1', '남', '3', '남', '여')
order by 1,2;

--=====================================
-- HAVING
--=====================================
--group by 이후 조건절

--부서별 평균 급여가 3,000,000원 이상인 부서만 평균급여와 함께 조회(부서별 평균 급여를 group by한 이후 조건을 걸었음), 그룹함수는 where절에서 못씀
select dept_code, trunc(avg(salary)) avg
from employee
group by dept_code
having avg(salary) >= 3000000
order by 1;

--직급별 인원수가 3명이상인 직급 조회
select job_code, count(*)
from employee
group by job_code
having count(*) >= 3
order by job_code;

--관리하는 사원이 2명이상인 manager의 아이디와 관리하는 사원수 조회 / 매니져 아이디가 없는 사원은 빼야함(아직 관리하는 사람이없다는것)
select manager_id 매니져아이디, count(*) 관리하는사원수
from employee
where manager_id is not null
group by manager_id
having count(*)>=2
order by 1; --방법1

select manager_id 매니져아이디, count(*) 관리하는사원수
from employee
group by manager_id
having count(manager_id)>=2 --count를 *(전체)로 해주지않고 manager_id로 해주면 null값인 애들은 이단계에서 이미 count가 안되므로 where절에 따로 조건을 걸어주지않아도 된다.
order by 1; --방법2
--having은 여기까지임

--=====================================
-- rollup | cube(col1, col2...) 특별한 함수
--=====================================
--group by절에서 사용하는 함수
--그룹핑 결과에 대해 소계를 제공

--rollup 지정컬럼에 대해 단방향 소계 제공
--cube 지정컬럼에 대해 양방향 소계 제공
--지정컬럼이 하나인 경우, rollup/cube의 결과는 같다. 두개이상부터 차이가남

select dept_code, count(*)
from employee
group by dept_code;

select dept_code, count(*)
from employee
group by rollup(dept_code) --위에서 한것에 대한 소계를 만들어줌. null이라는 행이 하나가 더생김 기존에 있던 null은 인턴을 가리키는 null이고, 방금생긴건 소계를 가리키는 null임
order by 1;

select dept_code, count(*)
from employee
group by cube(dept_code) --지정컬럼이 하나이므로, rollup/cube의 결과가 같다. 
order by 1;

--grouping()
--실제데이터(0을리턴함)  | 집계데이터(1을리턴함) 컬럼을 구분하는 함수

--cf)참고
--select nvl(dept_code,'인턴'), count(*)
--from employee
--group by rollup(dept_code)
--order by 1; -- null이 꼴보기 싫어서 nvl처리해주고 돌려보면 소계를 가리키는 null도 인턴으로 바꿔버림 / 이러면안됨

select dept_code, grouping(dept_code), count(*)
from employee
group by rollup(dept_code)
order by 1;

select decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), 1, '합계') dept_code, 
--grouping(dept_code), 
count(*)
from employee
group by rollup(dept_code)
order by 1; --이렇게 해줘야 널을 분리해서 각각 인턴과 합계로 이름을 바꿔줄수 있음

--두개이상의 컬럼을 rollup | cube에 전달하는 경우
--cf)
--select dept_code, job_code, count(*)
--from employee
--group by dept_code, job_code
--order by 1,2; --위에서 했던 부서별로 그룹핑해주고 직급별로 그룹핑해준내용

-----------------------------------------rollup----------------------------------------------
select dept_code, job_code, count(*)
from employee
group by rollup(dept_code, job_code) --부서별 소계를 내줌
order by 1,2; 

select dept_code, decode(grouping(job_code), 0, job_code, '소계') job_code, count(*)
from employee
group by rollup(dept_code, job_code)
order by 1,2; --소계를 의미하는 null값 없애줌

select decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), '합계') dept_code, decode(grouping(job_code), 0, job_code, '소계') job_code, count(*)
from employee
group by rollup(dept_code, job_code)
order by 1,2; --인턴을 의미하는 null값까지 없애주고 합계의 null까지 없애준 최종 ver
-----------------------------------------rollup----------------------------------------------

--======================구분선==========================--

------------------------------------------cube-----------------------------------------------
select dept_code, job_code, count(*)
from employee
group by cube(dept_code, job_code)
order by 1,2; --rollup을 cube로 바꿔줌. rollup 때보다 뭐가 많아진걸 알수있음 22~28행이 생김. 소계가 추가로 생긴것

select decode(grouping(dept_code), 0, nvl(dept_code, 'intern'), '소계') dept_code, job_code, count(*)
from employee
group by cube(dept_code, job_code)
order by 1,2; --인턴과 소계 null값을 이름지어줌

select decode(grouping(dept_code), 0, nvl(dept_code, 'intern'), '소계') dept_code, decode(grouping(job_code), 0 , job_code, '소계') job_code, count(*)
from employee
group by cube(dept_code, job_code)
order by 1,2; --두번째 컬럼으로 그루핑해줬을때의 소계 null값을 이름지어줌
------------------------------------------cube-----------------------------------------------

/*
전부배움 순서까지 복습필수

select (5)
from (1)
where (2)
group by (3)
having (4)
order by (6)

*/


--relation 만들기
--가로방향 합치기 JOIN 행 + 행
--세로방향 합치기 UNION 열 + 열


--=====================================
-- JOIN
--=====================================
--두개 이상의 테이블을 연결해서 하나의 가상테이블(relation)을 생성
--기준컬럼을 가지고 행을 연결한다.

--송종기 사원의 부서명을 조회 
select dept_code 
from employee
where emp_name = '송종기'; --D9이 나옴

select dept_title
from department
where dept_id = 'D9'; --위에서 한 과정으로 D9을 이용해서 총무부라는걸 알아냄

--join
select *
from employee E join department D --여기서 E와 D는 테이블 별칭임
on E.dept_code = D.dept_id; --join을 써서 E.dept_code 와 D.dept_id가 같으면 테이블 합쳐라 엄밀히말하면 같은 행을 찾아서 같은행끼리 붙인거임
--컬럼명이 두 테이블에 유일하다면 별칭을 생략할 수도 있음(이 case는 밑쪽에 테이블정리 읽어보기-1227줄), but 되도록이면 별칭을 써주기

select * from employee;
select * from department;

select D.dept_title --부서를 찾아라
from employee E join department D 
on E.dept_code = D.dept_id
where E.emp_name = '송종기'; --송종기가 있는 // join을 이용해서 한 테이블에서 바로 총무부라는걸 찾아냈음

--join 종류
--1. EQUI-JOIN | 동등조인 | 동등비교조건(=)에 의한 조인 
   --기존 컬럼 값이 같으면 합쳐라
   --대부분의 JOIN이 EQUI-JOIN을 사용
--2. NON-EQUI JOIN | 동등비교조건이 아닌(between...and..., in, not in, !=, like) 조인
   -- =이 아니면 다 NON-EQUI JOIN에 해당함

--join 문법
--1. ANSI 표준문법 : 모든 DBMS 공통문법 join 키워드 사용
--2. Vendor별 문법 : DBMS별로 지원하는 문법. 오라클전용문법도 있음
        --다른 DBMS program에서 사용할 수 없음
        --오라클 전용문법 ,(콤마) 키워드 사용


--=====================================
-- 테이블별칭 정리
--=====================================
--employee테이블의 job_code와 job테이블의 job_code가 연결되어 있음
select * from employee;
select * from job;

--별칭을 뺀다면 테이블명을 그대로 적어줌     
--why? 따로 부를 이름이 없기 때문
select *
from employee join job
    on employee.job_code = job.job_code;

--Error : "column ambiguously defined" 컬럼이 모호하게 정의되어있다.
--어디에 있는 job_code인지 모르기 때문
select emp_name, job_code, job_name
from employee join job
    on employee.job_code = job.job_code;

--테이블명을 반드시 명시해줘야함(emp_name은 employee에만 존재, job_name은 job에만 존재하는 컬럼인걸 알지만, job_code는 두 테이블 모두에 존재하기때문 - 이 때 job의 job_code를 가져오든, employee의 job_code를 가져오든 상관없다. 값이 같기때문)
select emp_name, job.job_code, job_name 
from employee join job
    on employee.job_code = job.job_code;

--but 테이블명을 일일이 써주기란 번거로움 -> 별칭 사용(대소문자 구분하지 않음, 알파벳이 아닌 EMPL, JB 이런식으로 써도 됨)
select E.emp_name, J.job_code, J.job_name --컬럼명이 두 테이블에 유일하다면 별칭을 생략할 수도 있음(job_code는 안되지만 emp_name, job_name는 E.emp_name에서 E.빼버리고 J.job_name에서 J.빼버리고 별칭없이 emp_name, job_name이렇게만 써도됨), but 되도록이면 별칭을 써주기
from employee E join job J
    on E.job_code = J.job_code; 

--기준컬럼명이 좌우테이블에서 동일하다면, on 대신 using 사용가능(on과 달리, ()안에 사용할 기준컬럼명을 담아주면된다.)
select *
from employee join job
    on employee.job_code = job.job_code; --on Ver. 16열

select *
from employee E join job J
    using(job_code); --using Ver. 15열
--출력 : using에 사용하는 컬럼이 맨 앞컬럼으로 빼내면서, 중복된 것을 한번만 출력해줌
    
--using을 사용한 경우는 E.jobcode, J.jobcode와 같은 해당컬럼에 별칭을 사용할 수 없다
--why? 공통된 것을 하나로 합쳐서 한번만 출력하기 때문
--ORA-25154: column part of USING clause cannot have qualifier
select E.emp_name,
             job_code, --별칭 사용불가
             J.job_name
from employee E join job J --from에서 별칭을 만들었으면 테이블명 직접쓰지말고 별칭으로 쓸것(E.emp_name ok, employee.emp_name X)
    using(job_code);


--equi-join 종류
/*
. inner join 교집합 (두 테이블의 공통된 부분만 추려냄)

. outer join 합집합
    - left outer join 좌측테이블 기준 합집합
    - right outer join 우측테이블 기준 합집합
    - full outer join 양테이블 기준 합집합

. cross join
    두테이블간의 조인할 수 있는 최대 경우의 수를 표현
    (행과 행이 만날 수 있는 모든 경우를 보여줌)

. self join
    같은 테이블의 조인

. multiple join
    3개 이상의 테이블을 조인
*/

--=====================================
-- INNER JOIN
--=====================================
--A (inner) join B
--교집합
--1. 기준컬럼값이 null인 경우, 결과집합에서 제외
--2. 기준컬럼값이 상대테이블에 존재하지 않는 경우, 결과집합에서 제외

--1. employee에서 dept_code가 null인 행 제외 : 부서가 없는 인턴사원2행(하동운, 이오리) 제외
select *
from employee E join department D
    on E.dept_code = D.dept_id; 
    --22(null인 2개의 행 제외)
    
--2. department에서 dept_id가 D3, D4, D7인 행은 제외(employee테이블 dept_code컬럼값에 D3, D4, D7값이 없기때문)
select distinct D.dept_id
from employee E join department D
   on E.dept_code = D.dept_id;
   --6

select *
from employee E join job J
    on E.job_code = J.job_code;
   --24
   --제외된것 없음


--Oracle Ver. 
select *
from employee E, department D
where E.dept_code = D.dept_id;
--22

select *
from employee E, department D
where E.dept_code = D.dept_id and E.dept_code = 'D5';
--6

select *
from employee E, job J
where E.job_code = J.job_code;
--24


--=====================================
-- OUTER JOIN
--=====================================
--1. left (outer) join
--좌측테이블 기준
--좌측테이블 모든 행이 포함, 우측테이블에는 on조건절에 만족하는 행만 포함.

select *
from employee E left outer join department D
   on E.dept_code = D.dept_id; --인턴사원2행(하동운, 이오리)은 포함되었지만 해당하는 값이 없어 null로 채워져있는걸 볼수있다. 
--24 = 22(교집합,inner) + 2(left)


--Oracle Ver.
--기준테이블의 반대편 컬럼에 (+)를 추가
select *
from employee E, department D
where E.dept_code = D.dept_id;
--22행나오는 inner join이랑 같은결과나옴
select *
from employee E, department D
where E.dept_code = D.dept_id(+);
--24행 나옴
   
   
--2. right (outer) join
--우측테이블 기준
--우측테이블 모든 행이 포함, 좌측테이블에는 on조건절에 만족하는 행만 포함.
select *
from employee E right outer join department D
   on E.dept_code = D.dept_id; --부서3행(D3, D4, d7)은 포함되었지만 해당하는 값이 없어 null로 채워져있는걸 볼수있다. 
--25 = 22(교집합,inner) + 3(right)


--Oracle Ver.
--기준테이블의 반대편 컬럼에 (+)를 추가
select *
from employee E, department D 
where E.dept_code(+) = D.dept_id;
--25


--3. full (outer) join
--완전 조인. 거의 안쓰나 이런게 있다 정도는 알아둘것
--좌우테이블 모두 포함
select *
from employee E full outer join department D
   on E.dept_code = D.dept_id;
--27 = 22(교집합,inner) + 2(left) + 3(right) 


--Oracle Ver.은 full join을 지원하지 않는다. 잘안쓰여서


--사원명/부서명 조회시
--부서지정이 안된 사원은 제외 : inner join
--부서지정이 안된 사원도 포함 : left join
--사원배정이 안된 부서도 포함 : right join
--여기까지 하고 chun계정가서 잠깐 강의하고옴, chun sql파일가서 inner, left outer, right outer 예제를 보면서 추가공부 하고 다음진도 공부할것


--=====================================
-- CROSS JOIN -이런게 가능하다정도로 알아두고 쓸일이없음
--=====================================
--상호조인
--on조건절 없이, 좌측테이블의 행과 우측테이블의 행이 연결될 수 있는 모든 경우의 수를 포함한 결과집합.
--Cartesian's Product(cf. sum 합 product 곱)

--사용법
select *
from employee E cross join department D;
--216 = 24 * 9

--거의 안쓰지만 일반 컬럼, 그룹함수 결과를 함께 조회 할때는 사용함
select emp_name, salary, avg(salary) from employee; -- ORA-00937: not a single-group group function / 이렇게 사용 불가
select trunc(avg(salary)) from employee; -- 이렇게는 사용 가능

select *
from employee E cross join (select trunc(avg(salary)) avg
                                       from employee) A; -- 위에서 구한 select trunc(avg(salary)) from employee를 하나의 테이블로 취급해서 employee 테이블과 cross join시켜버림
--24 = 24 * 1

select emp_name, salary, avg
from employee E cross join (select trunc(avg(salary)) avg
                                       from employee) A; --일반 컬럼과 그룹함수 결과 같이 보는게 가능해짐
                                        
select emp_name, salary, avg, salary - avg avg와의차이
from employee E cross join (select trunc(avg(salary)) avg 
                                       from employee) A; --평균급여보다 내가 얼마나 덜, 더 받는지 구할수도 있게됨


--Oracle Ver.
select *
from employee E, department D; --where절을 안써주면 됨

                                        
--=====================================
-- SELF JOIN
--=====================================
--조인시 같은 테이블을 좌/우측 테이블로 사용
--별칭 무조건 필요함. 컬럼명이 겹치니까 구별해주기 위해서

--사번, 사원명, 관리자사번, 관리자명 조회
select *
from employee E1 join employee E2
    on E1.manager_id = E2.emp_id;

select E1.emp_id, E1.emp_name, E1.manager_id, E2.emp_id, E2.emp_name -- SELF JOIN select절에 별칭 잘 구분해서 컬럼명 적어주기, 자기 자신테이블과 합친거라 컬럼명이 겹치니까!! 참고로 E1.manager_id, E2.emp_id 조회값은 같을것임. 결과보라고 select에 넣어준것이고 둘중하나 빼도된다.
from employee E1 join employee E2
    on E1.manager_id = E2.emp_id;
    
    
--Oracle Ver.
select E1.emp_id, E1.emp_name, E2.emp_id, E2.emp_name
from employee E1, employee E2
where E1.manager_id = E2.emp_id;
    

--=====================================
-- MULTIPLE JOIN 
--=====================================
--다중조인
--한번에 좌우 두 테이블씩 조인하여 3개이상의 테이블을 연결함

--송종기사원의 사원명, 부서명, 지역명 조회
--각테이블에서 연결시킬 기준컬럼 찾기
select * from employee; --E.dept_code
select * from department; --D.dept_id, D.location_id
select * from location; --L.local_code

select E.emp_name, D.dept_title, L.local_name
from employee E
    join department D
        on E.dept_code = D.dept_id
    join location L
        on D.location_id = L.local_code
where E.emp_name = '송종기'; --employee와 department 테이블 연결후 location 테이블 연결한 뒤 송종기 사원의 사원명, 부서명, 지역명 한번에 검색, 여기서 주의할점은 연결순서임. employee와 location은 연결시킬수 있는 공통컬럼이 없어서 employee와 department를 먼저 연결시킨후 차례로 연결시켜야한다!!!!
--조인하는 순서를 잘 고려할 것

--사원들의 사원명, 부서명, 지역명 조회(인턴제외)
select E.emp_name, D.dept_title, L.local_name
from employee E
    join department D
        on E.dept_code = D.dept_id
    join location L
        on D.location_id = L.local_code; --22행이 나오는데, 원래 전체행은 24행임(인턴사원들 빠졌음)

--사원들의 사원명, 부서명, 지역명 조회(인턴포함)
--select E.emp_name, D.dept_title, L.local_name
--from employee E
--    left join department D
--        on E.dept_code = D.dept_id
--    join location L
--        on D.location_id = L.local_code; --인턴들 데이터에 포함시키려면 left join을 쓰면 되는데 employee와 department합칠때만 left join 써주니까 데이터누락되어 22행만 나옴    

select E.emp_name, D.dept_title, L.local_name
from employee E
    left join department D
        on E.dept_code = D.dept_id
    left join location L
        on D.location_id = L.local_code; --left join을 써주려면 끝까지 left join을 써줘야 원래 의도했던대로 데이터누락없이 인턴들까지 데이터에 포함되어 24행이 잘나온다! location테이블과 합칠때 그냥 join을 쓸경우 합치는 기준컬럼의 값이 null이라서 또 제외되기 때문!

--사원들의 사원명, 부서명, 지역명, 직급명 조회
select *
from job; --직급명을 구하기 위한 테이블, job_code를 join시 기준컬럼으로 사용해서 job_name(직급명)을 가져오면 될듯

select E.emp_name, D.dept_title, L.local_name, J.job_name
from employee E
    join Job J --job테이블은 employee테이블과 합칠때 J1~7까지 누락되는 행이 없기 때문에 left join을 굳이 안써줘도 되고 employee테이블과 먼저 합쳐지든 다른테이블과 합쳐지고 온후에 합쳐지든 위치가 상관없다. 어쨋든 job_code를 employee테이블의 job_code와 연결시키면 되기때문!
        on E.job_code = J.job_code
    left join department D
        on E.dept_code = D.dept_id
    left join location L
        on D.location_id = L.local_code; 

select E.emp_name, D.dept_title, L.local_name, J.job_name
from employee E
    left join department D
        on E.dept_code = D.dept_id
    left join location L
        on D.location_id = L.local_code
    join Job J
        on E.job_code = J.job_code; --employee테이블이 다른테이블과 합쳐지고 난후에 합쳐져도 상관없다.


--Oracle Ver.
select *
from employee E, department D, location L, job J
where E.dept_code = D.dept_id
    and D.location_id = L.local_code
    and E.job_code = J.job_code; --oracle문법에서는 조인하는 순서가 1도 안중요함. 그냥 계속 나열하면됨 
    --22
select E.emp_name, D.dept_title, L.local_name, J.job_name
from employee E, department D, location L, job J
where E.dept_code = D.dept_id(+)
    and D.location_id = L.local_code(+)
    and E.job_code = J.job_code;
    --24


--직급이 대리, 과장이면서 ASIA지역에 근무하는 사원 조회
--사번, 이름, 직급명, 부서명, 급여, 근무지역, 국가
--select할 컬럼명 : emp_id, emp_name, job_name, dept_title, salary, local_name, national_name

select *
from employee; --사번, 이름, 급여 emp_id, emp_name, salary 추출 / 다른테이블과 붙일때 필요한 기준컬럼 : job_code, dept_code

select *
from department; --부서명 dept_title 추출 / 다른테이블과 붙일때 필요한 기준컬럼 : dept_id, location_id

select * 
from location; --근무지역 local_name 추출 / 다른테이블과 붙일때 필요한 기준컬럼 : local_code, national_code

select * 
from nation; --국가 national_name 추출 / 다른테이블과 붙일때 필요한 기준컬럼 : national_code

select *
from job; --직급명 job_name 추출 / 다른테이블과 붙일때 필요한 기준컬럼 : job_code

select E.emp_id, E.emp_name, J.job_name, D.dept_title, E.salary, L.local_name, N.national_name
from employee E
    join job J
        on E.job_code = J.job_code
    join department D
        on E.dept_code = D.dept_id
    join location L
        on D.location_id = L.local_code
    join nation N
        on L.national_code = N.national_code
where J.job_name in ('대리', '과장') and L.local_name like 'ASIA%';


--Oracle Ver.
select E.emp_id, E.emp_name, J.job_name, D.dept_title, E.salary, L.local_name, N.national_name
from employee E, job J, department D, location L, nation N
where E.job_code = J.job_code and E.dept_code = D.dept_id and D.location_id = L.local_code and L.national_code = N.national_code 
         and J.job_name in('대리', '과장') and L.local_name like 'ASIA%';
    
    
--=====================================
-- NON-EQUI JOIN
--=====================================
--employee, sal_grade테이블을 조인
--employee테이블의 sal_level컬럼이 없다고 가정.
--employee.salary컬럼과 sal_grade.min_sal | sal_grade.max_sal을 비교해서 join

select * from employee;
select * from sal_grade;

select *
from employee E
    join sal_grade S
        on E.salary between S.min_sal and S.max_sal; --E테이블의 Salary컬럼값이 S테이블의 min_sal컬럼값~max_sal컬럼값에 포함되면 붙여라
          
select *
from employee E
    join department D
        on E.dept_code != D.dept_id --조인조건절에 따라 한 행에 여러행이 연결된 결과를 얻을수 있다.
order by E.emp_id, D.dept_id;


--=====================================
-- SET OPERATOR
--=====================================
--집합 연산자. entity를 컬럼수가 동일하다는 조건하에 상하로 연결한 것.

--select절의 컬럼수가 동일.
--컬럼별 자료형이 상호호환 가능해야 한다. 문자형(char, varchar2)끼리는 괜찮음, but 날짜형 + 문자형은 ERROR 안괜찮음.
--컬럼명이 다른 경우, 첫번째 entity의 컬럼명을 결과집합에 반영
--order by은 마지막 entity에서 딱 한번만 사용가능

--union (합집합)
--union all (합집합)
--intersect (교집합)
--minus (차집합)
/*
A = {1, 3, 2, 5}
B = {2, 4, 6}

A union B => {1, 2, 3, 4, 5, 6} 중복제거, 첫번째컬럼 기준 오름차순 정렬
A union all B => {1, 3, 2, 5,  2, 4, 6} A와 B를 합친값, 정렬없음
A intersect B => {2} A와 B전부 갖고있는값들만, 첫번째컬럼 기준 오름차순 정렬
A minus B => {1, 3, 5} A에서 B가 갖고있는 값을 빼주고남은 값만, 첫번째컬럼 기준 오름차순 정렬
*/

--=====================================
-- UNION | UNION ALL
--=====================================
--A : D5부서원의 사번, 사원명, 부서코드, 급여
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'; --6행 출력

--B : 급여가 300만이 넘는 사원조회(사번, 사원명, 부서코드, 급여)
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000; --9행 출력 

--A UNION B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
--order by salary -- 마지막 entity에서만 사용가능
union
select emp_id, emp_name, dept_code, salary -- 여기서 salary를 없애면 ORA-01789: query block has incorrect number of result columns뜸/ 순서를 dept_code, salary, emp_id, emp_name 이렇게 바꾸면 ORA-01790: expression must have same datatype as corresponding expression뜸
from employee
where salary > 3000000 --중복(심봉선,대북혼)제거, 정렬 후 13행 출력
order by dept_code; -- order by 마지막 entity에서 사용함

--A UNION ALL B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
union all
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000; --중복제거, 정렬없이 A, B를 붙여서 15행 출력

--=====================================
-- INTERSECT | MINUS
--=====================================
--A INTERSECT B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
intersect
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000; --A와 B둘다 갖고 있는것만 2행 출력

--A MINUS B
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'
minus
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000; --A에서 B가 가진 값을 뺀후 4행 출력

--B MINUS A
select emp_id, emp_name, dept_code, salary
from employee
where salary > 3000000
minus
select emp_id, emp_name, dept_code, salary
from employee
where dept_code = 'D5'; --B에서 A가 가진 값을 뺀후 7행 출력


--=====================================
-- SUB QUERY
--=====================================
--하나의 sql문(main-query)안에 종속된 또다른 sql문(sub-query)
--존재하지 않는 값, 조건에 근거한 검색등을 실행할 때. 한번에 기존컬럼으로 원하는값을 못뽑을때(계산 등을 통해 값계산이후 뽑는게 가능할때 등등)

--반드시 소괄호로 묶어서 처리할 것.
--sub-query내에는 order by문법지원 안함.
--연산자 오른쪽에서 사용할 것. ex) where col = ()

--기존에 배웠던 내용으로 self join을 활용해서
--노옹철사원의 관리자 이름을 조회
select E1.emp_id, E1.emp_name, E1.manager_id, E2.emp_name
from employee E1
    join employee E2
        on E1. manager_id = E2.emp_id
where E1.emp_name = '노옹철';

--위의 과정을 풀어서 보면 두번의 과정을 거침
--1. 노옹철사원행의 manager_id 조회
select manager_id
from employee
where emp_name = '노옹철';
--2. emp_id가 조회한 manager_id와 동일한 행의 emp_name을 조회
select emp_name
from employee
where emp_id = '201';

--SUB QUERY 맛보기(단일행 단일컬럼 서브쿼리)
select emp_name
from employee
where emp_id = (select manager_id
                        from employee
                        where emp_name = '노옹철');
                         
/*

리턴값의 결과에 따른 SUB-QUERY 분류
1. 단일행 단일컬럼 서브쿼리 (1행 1열)
2. 다중행 단일컬럼 서브쿼리 (여러행 1열)
3. 다중열 서브쿼리(단일행/다중행)

4. 상관 서브쿼리 <-----> 일반서브쿼리
5. 스칼라 서브쿼리 (select절 사용)

6. inline-view (from절 사용)

*/

--=====================================
-- 단일행 단일컬럼 서브쿼리
--=====================================
--서브쿼리 조회결과가 1행1열인 경우(맛보기에서 조회결과가 '201'로 1행1열이었음)

--(전체평균급여)보다 많은 급여를 받는 사원 조회
--select emp_name, salary
--from employee
--where salary > (전체평균급여); --이런로직으로 풀면될듯

select avg(salary) 
from employee; --전체평균급여 구하는방법임. 이걸 저위의 괄호안에 넣으면 됨

select emp_name, salary
from employee
where salary > (select avg(salary) 
                     from employee);
                     
select emp_name, salary, trunc((select avg(salary) from employee)) avg --그룹함수는 SELECT절에 쓸수 없지만 SUB-QUERY에 담으면 SELECT절에서 독립적으로 사용가능
from employee
where salary > (select avg(salary) 
                     from employee); --깔끔하게 정리
                     
--윤은해 사원과 같은 급여를 받는 사원 조회(사번, 이름, 급여)
select emp_id, emp_name, salary
from employee
where salary = (select salary from employee where emp_name = '윤은해') and emp_name != '윤은해'; --같은급여를 받는 사원중에 본인(윤은해)는 빼주기
                     
--D1, D2부서원 중에 D5부서의 평균급여보다 많은 급여를 받는 사원 조회(부서코드, 사번, 사원명, 급 여)
--select dept_code, emp_no, emp_name, salary
--from employee
--where dept_code in('D1', 'D2') and salary > (D5부서의 평균급여); --이런로직으로 풀면될듯

select avg(salary)
from employee
where dept_code = 'D5'; --D5부서의 평균급여

select dept_code, emp_no, emp_name, salary
from employee
where dept_code in('D1', 'D2') and salary > (select avg(salary)
                                                           from employee
                                                           where dept_code = 'D5');
                                           
--=====================================
-- 다중행 단일컬럼 서브쿼리
--=====================================         
--연산자 in | not in | any | all | exists 와 함께 사용가능한 서브쿼리

--송종기, 하이유 사원이 속한 부서원 조회
select dept_code
from employee
where emp_name in ('송종기', '하이유'); --'D9', 'D5' 두행이 나오는 결과를 출력

select emp_name, dept_code
from employee
where dept_code in (select dept_code
                            from employee
                            where emp_name in ('송종기', '하이유')); --'D9', 'D5'의 DEPT_CODE를 가지는 부서원 출력
                            
--차태연, 전지연사원의 급여등급(sal_level)과 같은 사원 조회(사원명, 직급명, 급여등급 조회)
select emp_name, J.job_name, sal_level
from employee
    join job J
        using(job_code)
where sal_level in (select sal_level
                         from employee
                         where emp_name in ('차태연', '전지연')) and emp_name not in ('차태연', '전지연'); --차태연, 전지연사원의 급여등급은 S4, S5임. 이들과 같은 부서원을 조회하면서 이들의 이름은 빼줄것
                         
--직급명(job.job_name)이 대표, 부사장이 아닌 사원조회(사번, 사원명, 직급코드) -메인쿼리랑 서브쿼리랑 다른테이블이지만 같은 컬럼(job_code)을 이용해서 조회한 케이스
select emp_id, emp_name, job_code
from employee E
where E.job_code not in (select job_code
                                  from job
                                  where job_name in ('대표', '부사장')); --job테이블을 굳이 join하지 않고, employee테이블에 있는 job_code를 써서 조회하게끔 서브쿼리안에서 job테이블의 job_code를 뽑아서 다중행 단일컬럼으로 제공
                                  
--ASIA1지역에 근무하는 사원 조회(사원명, 부서코드)                                  
--location.local_name : ASIA1 -> 로직1
select local_code
from location
where local_name = 'ASIA1'; --L1
--department.location_id --- location.local_code -> 로직2
select dept_id
from department
where location_id = 'L1'; --D1, D2, D3, D4, D9
--employee.dept_code --- department.dept_id -> 로직3
select *
from employee
where dept_code in('D1','D2','D3','D4','D9');

select emp_name, dept_code
from employee
where dept_code in (select dept_id
                            from department
                            where location_id = (select local_code
                                                        from location
                                                        where local_name = 'ASIA1'));
                                                   
--===================================== 
-- 다중열 서브쿼리
--=====================================                                                            
--서브쿼리에 리턴된 컬럼이 여러개인 경우

--리턴된 행이 하나인 경우
--(퇴사한 사원과 (같은 부서), (같은 직급))의 사원 조회 (사원명, 부서코드, 직급코드)

select dept_code, job_code
from employee
where quit_yn = 'Y';

--나눠서 할 경우
/*
select emp_name, dept_code, job_code
from employee
where dept_code = ('D8') --서브쿼리1
    and job_code = ('J6'); --서브쿼리2
*/
select emp_name, dept_code, job_code
from employee
where dept_code = (select dept_code
                            from employee
                            where quit_yn = 'Y')
    and job_code = (select job_code
                           from employee
                           where quit_yn = 'Y');

--두개를 합쳐서 할 경우
select emp_name, dept_code, job_code
from employee 
where (dept_code, job_code) = (select dept_code, job_code
                                           from employee
                                           where quit_yn = 'Y');
--메인 쿼리와 서브쿼리의 짝을 맞춰서 합칠 수도 있음
--컬럼명과 상관없이 나오는 컬럼에 들어있는 값을 가지고 판단함

--manager가 존재하지 않는 사원과 같은 부서코드, 직급코드를 가진 사원 조회
select emp_name, dept_code, job_code
from employee
where(dept_code, job_code) in (select dept_code, job_code --in 연산자는 다중행 다중컬럼 처리 가능. in()안의 내용 블락잡아서 ctrl+enter때려보면 다중행 다중컬럼값이 나오는걸 볼수있다.
                                          from employee
                                          where manager_id is null); --8명이 조회됨
--여러행을 처리할 수 있는 구조를 만들어주기(=이 아닌,in 사용)
--but 아직 null예외처리가 되지 않은 코드
--null이 중간에 껴있어서 동등비교 연산을 하지 못함. 그래서 서브쿼리의 null값은 메인쿼리에서 조건에 맞는 검색결과를 뽑으려 매칭할때 반영되지않아서 빠짐
                                          
select emp_name, dept_code, job_code
from employee
where(nvl(dept_code, 'D0'), job_code) in (select nvl(dept_code, 'D0'), job_code
                                          from employee
                                          where manager_id is null); --10명이 조회됨. nvl함수를 이용하여 null값을 'D0'으로 바꿔서 포함시켜주기
                                          
--부서별 최대급여를 받는 사원 조회(사원명, 부서코드, 급여)
select dept_code, max(salary)
from employee
group by dept_code;

select emp_name, dept_code, salary
from employee
where(dept_code, salary) in (select dept_code, max(salary)
                                     from employee
                                     group by dept_code)
order by dept_code; --잘나온것 같지만, 부서코드가 null인 사원의 부서 최대급여가 빠짐

select emp_name, nvl(dept_code, '부서없음'), salary
from employee
where (nvl(dept_code,'인턴임시부서'), salary) in (select nvl(dept_code,'인턴임시부서'), max(salary) --부서코드가 null인 부서를 '인턴임시부서'으로 바꿔서 조회값에 포함시켜주기
                                                         from employee
                                                         group by dept_code)
order by dept_code nulls last; 


--=====================================
-- 상관 서브쿼리(상호연관 서브쿼리)
--===================================== 
--메인쿼리와 서브쿼리 간의 관계
--메인쿼리의 값을 서브쿼리에 전달하고, 서브쿼리 수행후 결과를 다시 메인쿼리에 반환
--동등비교 성립 X

--직급별 평균급여보다 많은 급여를 받는 사원 조회
select job_code, avg(salary) avg
from employee
group by job_code; --직급별 평균급여

--join으로 처리(방법1)
select *
from employee E
    join (select job_code, avg(salary) avg
           from employee
           group by job_code) EA
           using(job_code) -- on E.job_code = EA.job_code로 바꿔써도됨
where E.salary > EA.avg
order by job_code;

--상관서브쿼리로 처리(방법2)
--select *
--from employee E
--where salary > (직급별 평균급여);

select *
from employee E
where salary > (select avg(salary)
                     from employee
                     where job_code = 'J2'); --각행마다 비교해야 할 것이 다르기 때문에 고정값을 넣어주면 안됨     
                     

select emp_name, job_code, salary
from employee E --메인쿼리 테이블 별칭이 반드시 필요
where salary > (select avg(salary)
                     from employee
                     where job_code = E.job_code); --메인쿼리에서 온 값임을 명시해줌, 메인쿼리의 컬럼의 값과 서브쿼리의 컬럼의 값을 비교함

--부서별 평균급여보다 적은 급여를 받는 사원 조회(인턴포함)
select emp_name, nvl(dept_code,'부서없음'), salary
from employee E
where salary < (select avg(salary)
                     from employee
                     where nvl(dept_code, 1) = nvl(E.dept_code, 1));

--exists 연산자
--exists(서브쿼리) sub-query에 행이 존재하면 참, 행이 존재하지 않으면 거짓
select * 
from employee
where 1 = 1; --참일때는 다나옴 - true 결과행이 존재한다.

select * 
from employee
where 1 = 0; --거짓일때는 아무것도 안나옴 - false 결과행이 존재하지 않는다.

select *
from employee
where exists(select * 
                 from employee
                 where 1 = 1); -- true 결과행이 존재하는 subquery : exists true - 다나옴
 
select *
from employee
where exists(select * 
                 from employee
                 where 1 = 0); -- false 결과행이 존재하지 않는 subquery : exists false - 아무것도 안나옴

--관리하는 직원이 한명이라도 존재하는 관리자사원 조회! --200, 201, 204, 207, 211, 214
select emp_id, emp_name
from employee E
where exists(select * 
                 from employee
                 where manager_id = E.emp_id);
                 
select emp_id, emp_name
from employee E
where exists(select 1 
                 from employee
                 where manager_id = E.emp_id); --서브쿼리에 select절에 *이 아닌 1이나 아무거나 와도 잘나옴. 결과행이 존재하는지만 중요하기때문에!
                 
--내 emp_id값이 누군가의 manager_id로 사용된다면, 나는 관리자!
select *
from employee
where manager_id = '200';

select *
from employee
where manager_id = '201';

select *
from employee
where manager_id = '204';
--내 emp_id값이 누군가의 manager_id로 사용되지 않는다면, 나는 관리자가 아님!
select *
from employee
where manager_id = '202';

select *
from employee
where manager_id = '203';

--부서테이블에서 실제 사원이 존재하는 부서만 조회(부서코드, 부서명)
select dept_id, dept_title
from department D
where exists(select *
                 from employee
                 where dept_code = D.dept_id);                 
                 
select *
from department D; --D1~D9가 있음

select *
from employee
where dept_code = 'D1'; --3명의 사원있음

select *
from employee
where dept_code = 'D2'; --4명의 사원있음

select *
from employee
where dept_code = 'D3'; --사원없음

--부서테이블에서 실제 사원이 존재하지 않는 부서만 조회(부서코드, 부서명)
--not exists(sub-query) : sub-query의 결과행이 존재하지 않으면 true, sub-query의 결과행이 존재하면 false
select dept_id, dept_title
from department D
where not exists(select *
                 from employee
                 where dept_code = D.dept_id); --sub-query의 결과행이 존재하지 않으면 true - D3, D4, D7이 해당함
                 
--최대/최소값 구하기(not exists)
--가장 많은 급여를 받는 사원을 조회
--가장 많은 급여를 받는다 -> 본인보다 많이 받는 사원이 존재하지 않는다.
select emp_name, salary
from employee E
where not exists(select *
                       from employee
                       where salary > E.salary);
                       
--=====================================
-- SCALA SUBQUERY
--===================================== 
--서브쿼리의 실행결과가 1(단일행 단일컬럼)인 select절에 사용된 상관서브쿼리, 값이 딱하나라는것

--관리자이름 조회
--select emp_name, (서브쿼리) manager_name
--from employee E; 이렇게 풀예정

select emp_name, (select emp_name
                         from employee
                         where emp_id = E.manager_id) manager_name
from employee E;

select emp_name, nvl((select emp_name
                         from employee
                         where emp_id = E.manager_id), ' ') manager_name
from employee E; --null값 없애준 버젼

--사원명, 부서명, 직급명 조회
select emp_name,(select dept_title
                        from department
                        where E.dept_code = dept_id) dept_title,
                        (select job_name
                        from job
                        where E.job_code = job_code) job_name
from employee E;       

select emp_name,nvl((select dept_title
                        from department
                        where E.dept_code = dept_id), '부서없음') dept_title,
                        (select job_name
                        from job
                        where E.job_code = job_code) job_name
from employee E; --null값 없애준 버젼
 
                    
--=====================================
-- INLINE VIEW
--===================================== 
--from절에 사용된 subquery. 가상테이블
--마치 원래 있던 테이블인것처럼 from절에서 만들어서 사용
--cross join에서 사용했던 것도 inline view이다.

--여사원의 사번, 사원명 조회
select emp_id, emp_name
from employee
where decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') = '여';

--여사원의 사번, 사원명, 성별 조회
select emp_id, emp_name, decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
from employee
where decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') = '여';

--사번, 사원명, 성별 조회 - INLINE VIEW VER.
select emp_id, emp_name, gender --from절 ()안에 있는 가상테이블에서 가져다 쓸수 있는 컬럼만 select절에 쓸수 있음 emp_id, emp_name, gender
from (select emp_id, emp_name, decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
        from employee)
where gender = '여';    

--30~50세 사이의 여사원 조회(사번, 이름, 부서명, 나이, 성별)
select *
from (select emp_id 사번, emp_name 이름, dept_code 부서명, (extract(year from sysdate) - to_number('19'||substr(emp_no,1,2))) 나이, decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') 성별
        from employee)
where 성별 = '여' and 나이 between 30 and 50; --내가 푼 버젼

select *
from (select emp_id, emp_name, (select dept_title
                                             from department d
                                             where e.dept_code = d.dept_id) 부서명, extract(year from sysdate)-case when substr(emp_no, 8 ,1 ) in('1', '2') then substr(emp_no,1,2)+1901 else substr(emp_no,1,2)+2001 end 나이, decode(substr(emp_no, 8,1),'1','남','3','남','여') gender
                                             from employeee)
where gender = '여' and 나이 between 30 and 50; --윤수형 버젼

select *
from (select emp_id, emp_name, nvl((select dept_title 
                                                 from department 
                                                 where dept_id = E.dept_code), '인턴') dept_title,  extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age, decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
                                                 from employee E) 
where gender = '여' and age between 30 and 50; --강사님 버젼


--=====================================
-- 고급 쿼리
--===================================== 
--=====================================
-- 1. TOP-N 분석
--===================================== 
--급여를 많이 받는 TOP-5, 입사일이 가장 최근인 TOP-10 조회 등등
--TOP-N이 될수도 있고, BOTTOM-N이 될수도 있음
--줄을세우고 잘라냄

--급여를 많이 받는순으로 정렬
select emp_name, salary
from employee
order by salary desc;
--ORDER BY절을 사용 -> 정렬에 따라 줄을 세울수는 있으나, 몇개만 잘라낼수 없음

--rownum | rowid
--rownum : 테이블에 레코드 추가시 1부터 1씩 증가하면서 부여된 일련번호. 부여된 번호는 변경불가
--rowid : 테이블 특정 레코드에 접근하기 위한 논리적 주소값. not 실제 주소값, but 특정 레코드에 접근하기 위한 임의의 문자열 like java's hashcode
select rownum, rowid, E.*
from employee E
order by salary desc; --정렬이 바뀌어도 rownum이 변경되지 않음

--rownum이 새로 부여되는 경우
--1.inlineview 생성시 row num은 새로 부여된다.
select rownum, E.*
from(select rownum old, emp_name, salary
       from employee
       order by salary desc) E;
--2. where절 사용시 row num은 새로 부여된다.
select rownum, E.*
from employee E
where dept_code = 'D5';

/*
order by는 이미 select에서 정해진다음 정렬이라 rownum이 변하지 않음
where절은 where에서 추려진 다음 select rownum하는거라 rownum이 변함
inline view는 정렬까지 테이블을 만들어놓고 거기에 select rownum하는거라 rownum이 변함
*/

--급여를 많이 받는 TOP-5 조회
select rownum, E.*
from(select emp_name, salary
       from employee
       order by salary desc) E
where rownum between 1 and 5;

--입사일이 가장 빠른 TOP-10 사원 조회
select *
from(select emp_name, hire_date
       from employee
       order by hire_date asc) E
where rownum between 1 and 10;

--입사일이 가장 최근(나중)인 TOP-10 조회
select *
from(select emp_name, hire_date
       from employee
       order by hire_date desc) E
where rownum between 1 and 10;

--입사일이 빠른 순서로 6-10번째 사원 조회
--select *
--from(select emp_name, hire_date
--       from employee
--       order by hire_date asc) E
--where rownum between 6 and 10; --위에꺼 가져다가 where절만 6 and 10으로 바꾼다고 안됨. 
--rownum은 where절이 시작하면서 부여되고, where절이 끝나면 모든행에 대해 부여가 끝난다. offset(건너뛰는것)이 있다면, 정상적으로 가져올 수 없다. inlineview를 한계층 더 사용해야 한다.

select E.*
from (select rownum rnum, E.*
        from(select emp_name, hire_date
               from employee
               order by hire_date asc) E) E
where rnum between 6 and 10;

--직급이 대리인 사원중에 연봉 TOP-3 조회(순위, 이름, 연봉)
select rownum, E.*
from (select emp_name, (salary + (salary * nvl(bonus, 0))) * 12 annual_salary
        from employee
        where job_code = (select job_code
                                  from job
                                  where job_name = '대리')
        order by annual_salary desc) E
where rownum between 1 and 3;     

--직급이 대리인 사원중에 연봉 4-6순위 조회(순위, 이름, 연봉)
select E.*
from (select rownum rnum, E.*
        from (select emp_name, (salary + (salary * nvl(bonus, 0))) * 12 annual_salary
                from employee
                where job_code = (select job_code
                                          from job
                                          where job_name = '대리')
                order by annual_salary desc) E ) E
where rnum between 4 and 6;

--부서별 평균급여 TOP-3 조회(순위, 부서명, 평균급여)
select rownum, E.*
from (
        select dept_code,
                    trunc(avg(salary)) avg
        from employee
        group by dept_code
        order by avg desc
        ) E
where rownum between 1 and 3;

--부서별 평균급여 4-6순위 조회(순위, 부서명, 평균급여)
select E.*
from (
        select rownum rnum, E.*
        from (
                select --nvl(dept_code, '인턴') dept_code,
                            nvl((
                                    select dept_title 
                                    from department D 
                                    where dept_id = E.dept_code
                                  ), '인턴') dept_title, 
                            trunc(avg(salary)) avg
                from employee E
                group by dept_code
                order by avg desc
                ) E
         ) E
where rnum between 4 and 6;

/*
select E.*
from (
            select rownum rnum, E.*
            from (
                        <<정렬된 ResultSet>>
                    ) E
            ) E        
where rnum between 시작 and 끝;
*/


--with구문
--inlineview서브쿼리에 별칭을 지정해서 재사용하게 함.
with emp_hire_date_asc
as(select emp_name, hire_date
   from employee
   order by hire_date asc)
select E.*
from (select rownum rnum, E.*
        from emp_hire_date_asc E) E
where rnum between 6 and 10;        

--=====================================
-- 2. WINDOW FUNCTION
--===================================== 
--행과 행간의 관계를 쉽게 정의하기 위한 표준함수
--1. 순위함수
--2. 집계함수
--3. 분석함수

/*
window_function(args) over ([partition by절][order by절][windowing절])

. args : 윈도우함수 인자 0 ~ n개 지정
. partition by절 : 그룹핑 기준 컬럼
. order by절 : 정렬기준 컬럼
. windowing절 : 처리할 행의 범위를 지정.
*/

--1. 순위함수
--1-1. rank() over() : 순위를 지정
select emp_name, salary, rank() over(order by salary desc) rank
from employee; --20등이 2명이라 21등이없고 22등이 그다음순위로 나옴

--1-2. dense_rank() over() : 빠진 숫자 없이 순위를 지정
select emp_name, salary, dense_rank() over(order by salary desc) rank
from employee; --20등이 2명이지만 그 다음순위를 22등이아닌 21등으로 나오게함

--그룹핑에 따른 순위 지정가능
select emp_name, dept_code, salary, rank() over(partition by dept_code order by salary desc) rank_by_dept
from employee;

--TOP-N분석에도 활용할수 있음
select E.*
from(select emp_name, dept_code, salary, rank() over(partition by dept_code order by salary desc) rank_by_dept
       from employee) E
where rank_by_dept between 1 and 3;       

--2. 집계함수
--2-1. sum() over() : 일반 컬럼과 같이 사용할 수 있다.
--select emp_name, sum(salary)
--from employee; --일반컬럼과 같이 사용불가
select emp_name, sum(salary) over()
from employee; --일반 컬럼과 같이 사용가능

select emp_name, salary, dept_code, sum(salary) over() "전체사원급여합계", sum(salary) over(partition by dept_code) "부서별 급여합계", sum(salary) over(partition by dept_code order by salary) "부서별 급여누계_급여"
from employee;

--2-2. avg() over() : 일반 컬럼과 같이 사용할 수 있다.
select emp_name, dept_code, salary, trunc(avg(salary) over(partition by dept_code)) "부서별 평균 급여"
from employee;

--2-3. count() over() : 일반 컬럼과 같이 사용할 수 있다.
select emp_name, dept_code, count(*) over(partition by dept_code) cnt_by_dept
from employee;

--3. 분석함수는 안배움


--=====================================
-- DML
--===================================== 
-- Data Manipulation language 데이터 조작어
-- CRUD(Create, Read or Retrieve, Update, Delete) 테이블 행에 대한 명령어
-- insert 행추가
-- update 행수정
-- delete 행삭제
-- select (DQL)

--=====================================
-- INSERT
--===================================== 
-- 1. insert into 테이블 values(컬럼1값, 컬럼2값, ...) 모든 컬럼을 빠짐없이 순서대로 작성해야 함
-- 2. insert into 테이블 (컬럼1, 컬럼2, ...) values(컬럼1값, 컬럼2값, ...) 컬럼은 생략가능, 컬럼순서도 자유롭다. but, not null컬럼이면서, 기본값이 없다면 생략이 불가하다.

create table dml_sample(id number, nick_name varchar2(100) default '홍길동', name varchar2(100) not null, enroll_date date default sysdate not null);

select * from dml_sample; --dml_sample 조회

--타입1
insert into dml_sample values (100, default, '신사임당', default);

--insert into dml_sample values (100, default, '신사임당'); -- SQL 오류: ORA-00947: not enough values

--insert into dml_sample values (100, default, '신사임당', default, 'ㅋㅋ');-- SQL 오류: ORA-00913: too many values

--타입2
insert into dml_sample (id, nick_name, name, enroll_date) values(200, '제임스', '이황', sysdate);

insert into dml_sample (name, enroll_date) values('세종', sysdate);--nullable한 컬럼은 생략가능하다. 기본값이 있다면, 기본값이 적용된다.

--not null이면서 기본값이 지정안된 경우 생략할 수 없다.
--insert into dml_sample (id, enroll_date) values(300, sysdate);-- ORA-01400: cannot insert NULL into ("KH"."DML_SAMPLE"."NAME")

insert into dml_sample (name) values('윤봉길');

--서브쿼리를 이용한 insert

create table emp_copy 
as
select * 
from employee
where 1 = 2; -- 테이블 구조만 복사해서 테이블을 생성

select * 
from emp_copy;

insert into emp_copy (select * 
                              from employee);
rollback;       

insert into emp_copy(emp_id, emp_name, emp_no, job_code, sal_level)(select emp_id, emp_name, emp_no, job_code, sal_level
                                                                                              from employee);
                                                                                              
--emp_copy데이터 추가
select * 
from emp_copy;

--기본값 확인 data_default
select *
from user_tab_cols
where table_name = 'EMP_COPY';

--기본값 추가
alter table emp_copy
modify quit_yn default 'N'
modify hire_date default sysdate;

--insert into emp_copy (emp_id, emp_name, emp_no, email, phone, dept_code, job_code, sal_level, salary 강사공유로 복붙하기

--insert all을 이용한 여러테이블에 동시에 데이터 추가
--서브쿼리를 이용해서 2개이상의 테이블에 동시에 데이터를 추가한다. 조건부 추가도 가능하다.
--입사일 관리 테이블
create table emp_hire_date
as
select emp_id, emp_name, hire_date
from employee
where 1 = 2;

--매니져 관리 테이블
create table emp_manager
as
select emp_id, emp_name, manager_id, emp_name manager_name
from employee
where 1 = 2; --false를 만들어서 컬럼명은 가져오되 컬렴값은 가져오지 않겠다! 다시보기로 정확히 알아보기

select * from emp_hire_date;
select * from emp_manager;

--manager_name을 null로 변경
alter table emp_manager
modify manager_name null;

-- from테이블과 to테이블의 컬럼명이 같아야한다.
insert all
into emp_hire_date values(emp_id, emp_name, hire_date)
into emp_manager values(emp_id, emp_name, manager_id, manager_name)
select E.*, (select emp_name from employee where emp_id = E.manager_id) manager_name
from employee E;

--insert all을 이용한 여러행 한번에 추가하기
--오라클은 다음 문법을 지원하지 않는다.
--insert into dml_sample values(1, '치킨', '홍길동'), (2, '고구마, '장발장'), (3, '베베', '유관순'); -- 이런문법은 없음 SQL 오류: ORA-00933: SQL command not properly ended

insert all 
into dml_sample values(1, '치킨', '홍길동', default) 
into dml_sample values(2, '고구마', '장발장', default) 
into dml_sample values(3, '베베', '유관순', default)
select * from dual; --더미 쿼리


--=====================================
-- UPDATE
--===================================== 
--update실행후에 행의 수에는 변화가 없다.
--0행, 1행이상을 동시에 수정한다.   
--dml 처리된 행의 수를 반환
--drop table emp_copy;
create table emp_copy
as
select *
from employee;

select * from emp_copy;

update emp_copy
set dept_code = 'D7', job_code = 'J3' --emp_id가 '202'인 데이터'D9', 'J2'를 'D7', 'J3'으로 바꿔줌
where emp_id = '202'; --1 행 이(가) 업데이트되었습니다.
--where emp_id = '2002'; 0개 행 이(가) 업데이트되었습니다.

--commit; --메모리상 변경내역을 실제파일에 저장, 커밋하면 롤백해도 안돌아가짐
rollback; --마지막 커밋시점으로 돌리기, 다시 'D9', 'J2'로 돌아감

update emp_copy
set salary = salary + 500000 --다만 +=, -=같은 복합대입연산자는 사용불가
where dept_code = 'D5'; --D5부서원의 salary를 50만원 추가해주기!

--서브쿼리를 이용한 update
--방명수 사원의 급여를 유재식사원과 동일하게 수정해라(1380000->3400000)
update emp_copy
set salary = (select salary from emp_copy where emp_name = '유재식')
where emp_name = '방명수';

--임시환 사원의 직급을 과장(J5), 부서를 해외영업3부(D7)로 수정하세요.
--emp_copy
update emp_copy
set job_code = (select job_code from job where job_name = '과장'), dept_code = (select dept_id from department where dept_title = '해외영업3부')
where emp_name = '임시환';

--commit; --단축키 : f11
--rollback; --단축키 : f12


--=====================================
-- DELETE
--===================================== 
select * from emp_copy;

delete from emp_copy
where emp_id = '211'; --211번 전형돈 사원을 삭제시켜라, || 주의사항!! where절을 안쓰고 delete from emp_copy에서 실행시키면 24개행 다날라감!! 웬만하면 where절을 반드시 쓰고 delete update같은거는 주석처리해놓기 f5로 전체실행시켰을때 큰일나는수가 있음
rollback;


--=====================================
-- TRUNCATE
--===================================== 
--테이블의 행을 자르는 명령.
--DDL 명령어. 자동커밋함. 되돌릴수 없다!!
--before image생성 작업이 없(임시저장같은게 없다는것)으므로, 실행속도가 빠름

truncate table emp_copy; --Table EMP_COPY이(가) 잘렸습니다.

select * from emp_copy; --컬럼명 빼고 데이터 다 날라갓음. 롤백 아무리 해봐도 돌아오지않음

insert into emp_copy(select * from employee); --다시 데이터 넣어주기


--=====================================
-- DDL
--===================================== 
--Data Definition Language 데이터 정의어
--데이터베이스 객체를 생성/수정/삭제할 수 있는 명령어 모음
--create
--alter
--drop
--truncate

--객체 종류(우리가 앞으로 배울것들)
--table, view, sequence, index, package, procedure, function, trigger, synonym, scheduler, user...


--주석 comment
--테이블, 컬럼에 대한 주석을 달 수 있다. (필수)
select *
from user_tab_comments; --테이블의 설명 조회가능

select *
from user_col_comments
where table_name = 'EMPLOYEE'; --EMPLOYEE의 컬럼에 대한 설명 조회가능

select *
from user_col_comments
where table_name = 'DEPARTMENT'; --DEPARTMENT의 컬럼에 대한 설명 조회가능

select *
from user_col_comments
where table_name = 'TBL_FILES';
desc tbl_files;

--테이블 주석
comment on table tbl_files is '파일경로테이블';

--컬럼 주석
comment on column tbl_files.fileno is '파일 고유번호';
comment on column tbl_files.filepath is '파일 경로';

--수정/삭제 명령은 없다. 
--수정은 덮어쓰면됨 삭제는 .... is ''; '(작은따옴표)안에 아무것도 안채우면 null과 동일하게 봐서 삭제시킨 효과발생

--=====================================
-- 제약조건 CONSTRAINT
--===================================== 
--테이블 생성 수정시 컬럼값에 대한 제약조건 설정할 수 있다.
--데이터에 대한 무결성 INTEGRITY을 보장하기 위한 것
--무결성은 데이터를 정확하고, 일관되게 유지하는것

/*
. not null : null을 허용하지 않음. 필수값
. unique : 중복값을 허용하지 않음.
. primary key : not null + unique 레코드(행)에대한 식별자로써, 테이블당 1개 허용
. foreign key : 외래키, 데이터 참조무결성 보장. 부모테이블의 데이터만 허용
. check : 저장가능한 값의 범위/조건을 제한

일절 허용하지 않음. 49개컬럼은 들어가고 1개컬럼은 안들어가고 이런게 아님. 아예 reject거절됨
*/

--제약 조건 확인
--user_constraints(컬럼명이 없음)
--user_cons_columns

select *
from user_constraints
where table_name = 'EMPLOYEE';

--C check | not null : search_condition까지 확인해야 check인지 not null인지 알수있다.
--U unique
--P primary key
--R foreign key

--제약조건 검색
select *
from user_cons_columns
where table_name = 'EMPLOYEE';

--제약조건 검색
select constraint_name, uc.table_name, ucc.column_name, uc.constraint_type, uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'EMPLOYEE';        

--=====================================
-- NOT NULL
--===================================== 
--필수입력 컬럼에 not null 제약조건을 지정한다.
--default값 다음에 컬럼레벨에 작성한다.
--보통 제약조건명을 지정하지 않는다.
create table tb_cons_nn (
    id varchar2(20) not null, --컬럼레벨
    name varchar2(100)); --테이블레벨
    
insert into tb_cons_nn values(null, '홍길동'); --ORA-01400: cannot insert NULL into ("KH"."TB_CONS_NN"."ID")
insert into tb_cons_nn values('honggd', '홍길동');

select * from tb_cons_nn;
update tb_cons_nn
set id = ''
where id = 'honggd'; --ORA-01407: cannot update ("KH"."TB_CONS_NN"."ID") to NULL

--=====================================
-- UNIQUE
--===================================== 
--이메일, 주민번호, 닉네임 (전화번호는 최근에는 안넣음)
--전화번호는 UQ 사용하지 말것. 번호바꿨는데 나중에 이번호 GET한 사람이 회원가입하려고 할때 가입이 안되는 상황발생!
--중복 허용하지 않음
create table tb_cons_uq(
    no number not null, 
    email varchar2(50), --테이블레벨
    constraint uq_email unique(email));
    
insert into tb_cons_uq values(1, 'abc@naver.com');
insert into tb_cons_uq values(2, '가나다@naver.com');
--insert into tb_cons_uq values(3, 'abc@naver.com'); --ORA-00001: unique constraint (KH.UQ_EMAIL) violated
insert into tb_cons_uq values(4, null); --널값은 허용한다.

select * from tb_cons_uq;


--=====================================
-- PRIMARY KEY
--===================================== 
--레코드(행) 식별자
--not null + unique기능을 가지고 있으며, 테이블당 한개만 설정 가능

create table tb_cons_pk(
    id varchar2(50), 
    name varchar2(100) not null,
    email varchar2(200),
    constraint pk_id primary key(id),
    constraint uq_email2 unique(email)
);

insert into tb_cons_pk
values('honggd', '홍길동', 'hgd@google.com');

insert into tb_cons_pk
values(null, '홍길동', 'hgd@google.com'); --ORA-01400: cannot insert NULL into ("KH"."TB_CONS_PK"."ID")

select * from tb_cons_pk; --ORA-00001: unique constraint (KH.PK_ID) violated


select constraint_name, uc.table_name, ucc.column_name, uc.constraint_type, uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'TB_CONS_PK';

--복합 기본키(주키 | primark key | pk)
--여러컬럼을 조합해서 하나의 PK로 사용.
--사용된 컬럼 하나라도 NULL이여서는 안된다.
create table tb_order_pk (
    user_id varchar2(50),
    order_date date,
    amount number default 1 not null,
    constraint pk_user_id_order_date primary key(user_id, order_date)
);

insert into tb_order_pk
values('honggd', sysdate, 3); --데이터 계속 삽입됨. 초단위로 엄청빠르게 삽입시도하지않는이상 ORA-00001: unique constraint (KH.PK_USER_ID_ORDER_DATE) violated 이런 에러코드 뜨지않음

insert into tb_order_pk
values(null, sysdate, 3); --ORA-01400: cannot insert NULL into ("KH"."TB_ORDER_PK"."USER_ID")

select user_id, to_char(order_date, 'yyyy/mm/dd hh24:mi:ss') order_date, amount
from tb_order_pk;


--=====================================
-- FOREIGN KEY
--===================================== 
--참조무결성을 유지하기 위한 조건
--참조하고 있는 부모테이블의 지정 컬럼값 중에서만 값을 취할 수 있게 하는 것
--참조하고 있는 부모테이블의 지정컬럼은 PK, UQ제약조건이 걸려있어야 한다.
--department.dept_id(부모테이블) <-------------- employee.dept_code(자식테이블)
--자식테이블의 컬럼에 외래키(foreign key) 제약조건을 지정

create table shop_member(
    member_id varchar2(20),
    member_name varchar2(30) not null,
    constraint pk_shop_member_id primary key(member_id)
);

select constraint_name, uc.table_name, ucc.column_name, uc.constraint_type, uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'TB_CONS_PK';


insert into shop_member values('honggd', '홍길동');
insert into shop_member values('sinsa', '신사임당');
insert into shop_member values('sejong', '세종대왕');

select * from shop_member;

create table shop_buy (
    buy_no number,
    member_id varchar2(20),
    product_id varchar2(50),
    buy_date date default sysdate,
    constraints pk_shop_buy_no primary key(buy_no),
    constraints fk_shop_buy_member_id foreign key(member_id) references shop_member(member_id)
);

--drop table shop_buy;
create table shop_buy (
    buy_no number,
    member_id varchar2(20),
    product_id varchar2(50),
    buy_date date default sysdate,
    constraints pk_shop_buy_no primary key(buy_no),
    constraints fk_shop_buy_member_id foreign key(member_id) references shop_member(member_id) on delete set null
);

--drop table shop_buy;
create table shop_buy (
    buy_no number,
    member_id varchar2(20),
    product_id varchar2(50),
    buy_date date default sysdate,
    constraints pk_shop_buy_no primary key(buy_no),
    constraints fk_shop_buy_member_id foreign key(member_id) references shop_member(member_id) on delete cascade
);

insert into shop_buy
values(1, 'honggd', 'soccer_shoes', default);

insert into shop_buy
values(2, 'sinsa', 'bascketball_shoes', default);

insert into shop_buy
values(3, 'k12345', 'football_shoes', default); --ORA-02291: integrity constraint (KH.FK_SHOP_BUY_MEMBER_ID) violated - parent key not found

select * from shop_buy;

--fk기준으로 join -> relation
--구매번호 회원아이디 회원이름 구매물품아이디 구매시각
select B.buy_no, member_id, M.member_name, B.product_id, B.buy_date
from shop_member M
    join shop_buy B
        using(member_id);

--데이터베이스의 정규화(Normalization)
--데이터를 굳이 나눠서 관리하는 이유 : 이상현상 방지(anormaly), 데이터가 2000개라고 했을때 1개 오류시에 2000개를 다 바꿔줘야 하지만 나눠서 관리할경우 손볼 양이 확 줄어듬. 오류난 쪽만 손보면되니까!
select *
from employee;

select *
from department;

--삭제옵션
--on delete restricted : 기본값, 참조하는 자식행이 있는 경우, 부모행 삭제불가 / 자식행을 먼저 삭제후, 부모행을 삭제해야함
--on delete set null : 부무행 삭제시 자식컬럼은 null로 변경
--on delete cascade : 부모행 삭제시 자식행 삭제
--delete from shop_member
--where member_id = 'honggd'; --ORA-02292: integrity constraint (KH.FK_SHOP_BUY_MEMBER_ID) violated - child record found --부모행 삭제불가

delete from shop_buy
where member_id = 'honggd'; --자식행 먼저삭제
delete from shop_member
where member_id = 'honggd'; --부모행 삭제

select * from shop_member; --잘지워짐
select * from shop_buy; --잘지워짐

--식별관계 | 비식별관계
--식별관계 : 참조하고 있는 부모컬럼값을 다시 PK로 사용하는 경우. 부모행 - 자식행사이에 1:1 관계가 만들어짐 (중복불가)
--비식별관계 : 참조하고 있는 부모컬럼값을 PK로 사용하지 않는 경우. 부모행 - 자식행사이에 1:N 관계가 만들어짐. 여러행에서 참조가 가능(중복가능)

create table shop_nickname(
    member_id varchar2(20),
    nickname varchar2(100),
    constraint fk_member_id foreign key(member_id) references shop_member(member_id),
    constraint pk_member_id primary key(member_id)
);

insert into shop_nickname
values('sinsa', '신솨112');

select *
from shop_nickname;


--=====================================
-- CHECK
--===================================== 
--해당 컬럼의 값의 범위를 지정.
--null 입력 가능

create table tb_cons_ck(
    gender char(1),
    num number,
    constraint ck_gender check(gender in ('M', 'F')),
    constraint ck_num check(num between 0 and 100)
);

insert into tb_cons_ck values('M', 50);
insert into tb_cons_ck values('F', 100);
insert into tb_cons_ck values('m', 50); --ORA-02290: check constraint (KH.CK_GENDER) violated / 대소문자 구분하니까 m은 M이나 F가 아니라서 안됨
insert into tb_cons_ck values('M', 1000); --ORA-02290: check constraint (KH.CK_NUM) violated / 1000은 0~100사이 숫자가 아니라서 안됨


---------------------------------------------
-- CREATE
---------------------------------------------
--subquery를 이용한 create는 not null제약조건을 제외한 모든 제약조건, 기본값등을 제거한다.

create table emp_bck
as
select * from employee;

select * from emp_bck;


--제약조건 검색
select constraint_name,
            uc.table_name,
            ucc.column_name,
            uc.constraint_type,
            uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'EMP_BCK';

--기본값 확인
select *
from user_tab_cols
where table_name = 'EMP_BCK';



-----------------------------------------
-- ALTER
-----------------------------------------
--table관련 alter문은 컬럼, 제약조건에 대해 수정이 가능
/*
서브명령어

-add 컬럼, 제약조건 추가
-modify 컬럼 (자료형, 기본값) 변경(제약조건 변경불가)
-rename 컬럼명, 제약조건명 변경
-drop 컬럼, 제약조건 삭제

*/

create table tb_alter (
    no number
);

--add 컬럼
--맨 마지막 컬럼으로 추가
alter table tb_alter 
add name varchar2(100) not null;

describe tb_alter; -- desc

--add 제약조건 
--not null제약조건은 추가가 아닌 수정(modify)으로 처리
alter table tb_alter
add constraints pk_tb_alter_no primary key(no);

----제약조건 검색
select constraint_name,
            uc.table_name,
            ucc.column_name,
            uc.constraint_type,
            uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'TB_ALTER';


--modify 컬럼
--자료형, 기본값, null여부 변경가능
--문자열에서 호환가능타입으로 변경가능(char --- varchar2)
alter table tb_alter
modify name varchar2(500) default '홍길동' null;

desc tb_alter;

--행이 있다면, 변경하는데 제한이 있다.
--존재하는 값보다는 작은 크기로 변경불가.
--null값이 있는 컬럼을 not null로 변경불가.

--modify 제약조건은 불가능.
--제약조건은 이름 변경외에 변경불가
--해당 제약조건 삭제후 재생성할 것.


--rename 컬럼
alter table tb_alter
rename column no to num; 

desc tb_alter;

--rename 제약조건
--제약조건 검색
select constraint_name,
            uc.table_name,
            ucc.column_name,
            uc.constraint_type,
            uc.search_condition
from user_constraints uc
    join user_cons_columns ucc
        using(constraint_name)
where uc.table_name = 'TB_ALTER';

alter table tb_alter 
rename constraint PK_TB_ALTER_NO to pk_tb_alter_num;

--drop 컬럼
desc tb_alter;

alter table tb_alter
drop column name;

--drop 제약조건
alter table tb_alter
drop constraint pk_tb_alter_num;


--테이블 이름 변경
alter table tb_alter 
rename to tb_alter_new;

rename tb_alter_new to tb_alter_all_new;

select * from tb_alter_all_new;


-----------------------------------------------
-- DROP
-----------------------------------------------
--데이터베이스 객체(table, user, view등) 삭제
drop table tb_alter_all_new;



--==============================================
-- DCL
--==============================================
-- Data Control Language 
-- 권한 부여/회수 관련 명령어 :  grant / revoke
-- TCL Transaction Control Language를 포함한다. - commit / rollback / savepoint

--system관리자계정 시작!

--qwerty계정 생성 : 
create user qwerty
identified by qwerty
default tablespace users;

--접속 권한 부여
--create session권한 또는 connect롤을 부여
grant connect to qwerty;
grant create session to qwerty;

--객체 생성권한 부여
--create table, create index.... 권한을 일일이 부여
--resource롤
grant resource to qwerty;

--system관리자계정 끝!

--권한, 롤을 조회
select *
from user_sys_privs; --권한

select *
from user_role_privs; --롤

select *
from role_sys_privs; --부여받은 롤에 포함된 권한


--커피테이블 생성
create table tb_coffee (
    cname varchar2(100),
    price number,
    brand varchar2(100),
    constraint pk_tb_coffee_cname primary key(cname)
);

insert into tb_coffee
values('maxim', 2000, '동서식품');
insert into tb_coffee
values('kanu', 3000, '동서식품');
insert into tb_coffee
values('nescafe', 2500, '네슬레');

select * from tb_coffee;
commit;

--qwerty계정에게 열람 권한 부여
grant select on tb_coffee to qwerty;

--수정권한 부여
grant insert, update, delete on tb_coffee to qwerty;

--수정권한 회수
revoke insert, update, delete on tb_coffee from qwerty;
revoke select on tb_coffee from qwerty;


--========================================
-- DATABASE OBJECT 1
--========================================
--DB의 효율적으로 관리하고, 작동하게 하는 단위
select distinct object_type
from all_objects;

-------------------------------------------
-- DATA DICTIONARY
-------------------------------------------
--일반사용자 관리자로부터 열람권한을 얻어 사용하는 정보조회테이블
--읽기전용.
--객체 관련 작업을 하면 자동으로 그 내용이 반영.

--1. user_xxx : 사용자가 소유한 객체에 대한 정보
--2. all_xxx : user_xxx를 포함. 다른 사용자로부터 사용권한을 부여받은 객체에 대한 정보
--3. dba_xxx : 관리자전용. 모든 사용자의 모든 객체에 대한 정보


--이용가능한 모든 dd 조회
select * from dict; --dictionary

--*****************************************
-- user_xxx
--*****************************************
--xxx는 객체이름 복수형을 사용한다.

--user_tables

select * from user_tables;
select * from tabs; -- 동의어(synonym) 

--user_sys_privs : 권한
--user_role_privs : 롤(권한묶음)
--role_sys_privs : 사용자가 가진 롤에 포함된 모든 권한
select * from user_sys_privs;
select * from user_role_privs;
select * from role_sys_privs;

--user_sequences
select * from user_sequences;
--user_views
select * from user_views;
--user_indexes
select * from user_indexes;
--user_constraints
select * from user_constraints;

--*****************************************
-- all_xxx
--*****************************************
--현재계정이 소유하거나 사용권한을 부여받은 객체 조회

--all_tables
select * from all_tables;

--all_indexes
select * from all_indexes;

--*****************************************
-- dba_xxx
--*****************************************
select * from dba_tables;--ORA-00942: table or view does not exist 일반사용자 접근 금지

--특정사용자의 테이블 조회
select * 
from dba_tables
where owner in ('KH', 'QWERTY');

--특정사용자의 권한 조회
select *
from dba_sys_privs
where grantee = 'KH';

select *
from dba_role_privs
where grantee = 'KH';

--테이블 관련 권한 확인
select *
from dba_tab_privs
where owner = 'KH';

--관리자가 kh.tb_coffee 읽기 권한을 qwerty에게 부여
grant select, insert, update, delete on kh.tb_coffee to qwerty;


-----------------------------------------------
-- STORED VIEW
-----------------------------------------------
-- 저장뷰.
-- inlineview는 일회성이었지만, 이를 객체로 저장해서 재사용이 가능.
-- 가상테이블처럼 사용하지만, 실제로 데이터를 가지고 있는 것은 아니다.
-- 실제 테이블과 링크개념.

-- 뷰객체를 이용해서 제한적인 데이터만 다른 사용자에게 제공하는 것이 가능하다.
--create view 권한을 부여 받아야한다.

create view view_emp
as
select emp_id, 
            emp_name,
            substr(emp_no, 1, 8) || '******' emp_no,
            email,
            phone
from employee;

--테이블처럼 사용
select * from view_emp;

select * 
from (
        select emp_id, 
                emp_name,
                substr(emp_no, 1, 8) || '******' emp_no,
                email,
                phone
        from employee
);

--dd에서 조회
select * from user_views;

--타사용자에게 선별적인 데이터를 제공
grant select on kh.view_emp to qwerty;


--view특징
--1. 실제 컬럼뿐 아니라 가공된 컬럼 사용가능
--2. join을 사용하는 view 가능
--3. or replace 옵션 사용가능
--4. with read only 옵션

create or replace view view_emp
as
select emp_id, 
            emp_name,
            substr(emp_no, 1, 8) || '******' emp_no,
            email,
            phone, 
            nvl(dept_title, '인턴') dept_title
from employee E 
    left join department D
        on E.dept_code = D.dept_id
with read only;


--성별, 나이등 복잡한 연산이 필요한 컬럼을 미리 view지정해두면 편리하다.
create or replace view view_employee_all
as
select E.*,
            decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') gender
from employee E;

select *
from view_employee_all
where gender = '여';


-----------------------------------------
-- SEQUENCE
-----------------------------------------
--정수값을 순차적으로 자동생성하는 객체. 채번기
/*

create sequence 시퀀스명

start with 시작값 --------------기본값 1
increment by 증가값 -----------기본값 1 
maxvalue 최대값 | nomaxvalue ---기본값은 nomaxvalue. 
                                                       최대값에 도달하면, 다시 시작값(cycle) 혹은 에러유발(nocycle)
minvalue 최소값 | nominvalue  ---기본값은 nominvalue
                                                        최소값에 도달하면, 다시 시작값(cycle) 혹은 에러유발(nocycle)
cycle | nocycle---------------순환여부. 기본값 nocycle
cache 캐싱개수 | nocache    ------기본값 cache 20. 시퀀스객체로 부터 20개씩 가져와서 메모리에서 채번.
                                                        오류가 발생하여, 숫자를 건너뛸수도 있다.

*/

create table tb_names (
    no number,
    name varchar2(100) not null,
    constraints pk_tb_names_no primary key(no)
);

create sequence seq_tb_names_no
start with 1000
increment by 1
nomaxvalue
nominvalue
nocycle
cache 20;

insert into tb_names 
values(seq_tb_names_no.nextval, '홍길동');

select * from tb_names;

select seq_tb_names_no.nextval, 
            seq_tb_names_no.currval
from dual;

--DD에서 조회
select * from user_sequences;

--복합문자열에 시퀀스 사용하기
--주문번호 kh-20210205-1001
create table tb_order(
    order_id varchar2(50),
    cnt number,
    constraints pk_tb_order_id primary key(order_id)
);

create sequence  seq_order_id;

insert into tb_order
values('kh-' || to_char(sysdate, 'yyyymmdd') || '-' || to_char(seq_order_id.nextval, 'FM0000'), 100);

select * from tb_order;

--alter문을 통해 시작값 start with값은 절대 변경할 수 없다. 
--그때 시퀀스객체 삭제후 재생성할 것.
alter sequence seq_order_id increment by 10;



----------------------------------------------
-- INDEX
----------------------------------------------
--색인.
--sql문 처리 속도 향상을 위해 컬럼에 대해 생성하는 객체
--key: 컬럼값, value: 레코드논리적주소값 rowid
--저장하는 데이터에 대한 별도의 공간이 필요함.

--장점 : 
--검색속도가 빨라지고, 시스템 부하를 줄여서 성능향상

--단점:
--인덱스를 위한 추가저장공간이 필요.
--인덱스를 생성/수정하는 데 별도의 시간이 소요됨.

--단순조회 업무보다 변경작업(insert/update/delete)가 많다면 index생성을 주의해야 한다.

--인덱스로 사용하면 좋은 컬럼
--1. 선택도 selectivity가 좋은 컬럼. 중복데이터가 적은 컬럼.
-- id | 주민번호 | email | 전화번호 > 이름 > 부서코드 >>>>>>>>> 성별
-- pk | uq제약조건이 사용된 컬럼은 자동으로 인덱스를 생성함 -- 삭제하려면 제약조건을 삭제해야함.

--2. where절에 자주 사용되어지는 경우, 조인기준컬럼인 경
--3. 입력된 데이터의 변경이 적은 컬럼.

select *
from user_indexes
where table_name = 'EMPLOYEE';

--job_code 인덱스가 없는 컬럼
select *
from employee
where job_code = 'J1'; --table full scan

--emp_id 인덱스가 있는 컬럼
select *
from employee
where emp_id = '201'; --unique scan -> by index rowid

--emp_name 조회
select *
from employee
where emp_name = '송종기';

--emp_name컬럼으로 인덱스 생성
create index idx_employee_emp_name
on employee(emp_name);





