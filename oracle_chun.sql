--==============================

-- CHUN 계정

--==============================

-- 학과테이블
select * from tb_department; 

-- 학생테이블
select * from tb_student;

-- 과목테이블
select * from tb_class;
wwwwwwwwww
-- 교수테이블
select * from tb_professor;

-- 교수과목테이블
select * from tb_class_professor;

-- 점수등급테이블
select * from tb_grade;

/*
2021.01.26 실습문제(1~10)
*/
--@실습문제 1 : 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열" 으로 표시하도록 한다.
select department_name "학과 명", category 계열
from tb_department;

--@실습문제 2 : 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
select department_name || '의 정원은 ' || capacity || '명 입니다.' as "학과별 정원"
from tb_department;

--@실습문제 3 : "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
select *
from tb_student
where absence_yn = 'Y' and department_no = '001' and substr(student_ssn,8,1) = '2';

--@실습문제 4 : 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성하시오.
select student_name
from tb_student
where student_no in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--@실습문제 5 : 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
select department_name, category
from tb_department
where capacity >= 20 and capacity<=30
order by department_name asc;

--@실습문제 6 : 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
select professor_name
from tb_professor
where department_no is null;

--@실습문제 7 : 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다. 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오
select department_no
from tb_student
where department_no is null;

--@실습문제 8 : 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오.
select class_no
from tb_class
where preattending_class_no is not null;

--@실습문제 9 : 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
select distinct category
from tb_department
order by category asc;

--@실습문제 10 : 02 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
select student_no, student_name, student_ssn
from tb_student
where absence_yn = 'N' and substr(entrance_date,1,2) = '02' and substr(student_address,1,2) = '전주';

/*
2021.01.27 실습문제1(11~14)
*/
--@실습문제 11 : 학과테이블에서 계열별 정원의 평균을 조회(정원 내림차순 정렬) 
select category, trunc(avg(capacity),0) capacity
from tb_department
group by category
order by capacity desc;

--@실습문제 12 : 휴학생을 제외하고, 학과별로 학생수를 조회(학과별 인원수 내림차순) --내림차순 : 큰수부터 작은수로
select department_no 학과, count(*) 학과별인원수
from tb_student
where absence_yn = 'N' -- y는 휴학생임 n으로 조건걸어줄경우 휴학생제외하고 재학생만 보여줘라! 라는 뜻임
group by department_no
order by count(*) desc;

--@실습문제 13 : 과목별 지정된 교수가 2명이상인 과목번호와 교수인원수를 조회(교수인원수 내림차순)
select class_no 과목번호, count(*) 교수인원수
from tb_class_professor
group by class_no
having count(*) >= 2
order by 2 desc;

--@실습문제 14 : 학과별로 과목을 구분했을때, 과목구분이 "전공선택"에 한하여 과목수가 10개 이상인 행의 학과번호, 과목구분(class_type), 과목수를 조회(전공선택만 조회 & 과목수 내림차순)
select department_no 학과번호, class_type 과목구분, count(*) 과목수
from tb_class
where class_type = '전공선택'
group by department_no, class_type
having count(*) >=10
order by count(*) desc; -- count(*)가 3번째 column이므로 order by 3 desc 이렇게 써도됨

/*
2021.01.27 실습문제2(1~15)
*/
--@실습문제 1 : 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
select student_no 학번, student_name 이름, to_char(entrance_date, 'yyyy-mm-dd') 입학년도
from tb_student
where department_no = '002'
order by entrance_date asc;

--@실습문제 2 : 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
select professor_name, professor_ssn
from tb_professor
where length(professor_name) != 3;

--@실습문제 3 : 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
select professor_name 교수이름 , to_number(extract(year from sysdate)) - to_number('19'||substr(professor_ssn,1,2)) 나이
from tb_professor
where substr(professor_ssn,8,1)='1'
order by 2; 

--@실습문제 4 : 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름" 이 찍히도록 한다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
select substr(professor_name,2) 이름
from tb_professor;

--@실습문제 5 : 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 이때, 19 살에 입학하면 재수를 하지 않은 것으로 간주한다.
select student_no, student_name, student_ssn, entrance_date, ((to_number(extract(year from sysdate)) - to_number('19'||substr(student_ssn,1,2))) - (to_number(extract(year from sysdate) - extract(year from entrance_date))+1))
from tb_student
where ((to_number(extract(year from sysdate)) - to_number('19'||substr(student_ssn,1,2))) 
                                         -- (2021년         -             1994년) = 나이구하기(만 27살) 
- (to_number(extract(year from sysdate) - extract(year from entrance_date))+1))
                                         -- (2021년         -          2013학번) = 현재나이에서 뺄값(8)
> 19
--27-8 = 19(만나이) -> 재수안하고 입학했는지 여부, 19이면 재수안한거 20이면 재수 21이면 삼수...
order by student_no; 
--내 접근방식 ********************||추후 question이후 보강예정||**************************--
select student_no, student_name
from tb_student
where extract(year from entrance_date) - ('19'||substr(student_ssn,1,2)) > 19;

--@실습문제 6 : 2020 년 크리스마스는 무슨 요일인가?
select to_char(to_date('2020/12/25'), 'day') 크리스마스는
from dual;

--@실습문제 7 : TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까? 또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까?
select to_char(to_date('99/10/11','YY/MM/DD'), 'yyyy"년" mm"월" dd"일"'), to_char(to_date('49/10/11','YY/MM/DD'),'yyyy"년" mm"월" dd"일"'), to_char(to_date('99/10/11','RR/MM/DD'),'yyyy"년" mm"월" dd"일"'), to_char(to_date('49/10/11','RR/MM/DD'),'yyyy"년" mm"월" dd"일"')
from dual;

--@실습문제 8 : 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
select student_no, student_name
from tb_student
where substr(student_no,1,1) !='A';

--@실습문제 9 :  학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 자리까지맊 표시한다.
select round(avg(point),1) 평점
from tb_grade
where student_no = 'A517178';

--@실습문제 10 : 

select *
from tb_grade;

--@실습문제 11 : 

select *
from tb_grade;

--@실습문제 12 : 

select *
from tb_grade;

--@실습문제 13 : 

select *
from tb_grade;

--@실습문제 14 : 

select *
from tb_grade;

--@실습문제 15 : 

select *
from tb_grade;

/*
2021.01.28 실습문제1(1~5) 직접 풀어보기
*/
--@실습문제 1 : 학번, 학생명, 학과명 조회
-- 학과 지정이 안된 학생은 존재하지 않는다.
select S.student_no, S.student_name, D.department_name
from tb_student S
    inner join tb_department D
        on S.department_no = D.department_no;
        
select count(*)
from tb_student
where department_no is null;

--@실습문제 2 : 수업번호, 수업명, 교수번호, 교수명 조회
select C.class_no, C.class_name, P.professor_no, P.professor_name
from tb_class_professor CP
    join tb_class C
        on CP.class_no = C.class_no
    join tb_professor P
        on P.professor_no = CP.professor_no;


--@실습문제 3 : 송박선 학생의 모든 학기 과목별 점수를 조회(학기, 학번, 학생명, 수업명, 점수)
select G.term_no, student_no, S.student_name, C.class_name, G.point
from tb_grade G
    join tb_student S
        using(student_no)
    join tb_class C
        using(class_no)
where S.student_name = '송박선';

--@실습문제 4 : 학생별 전체 평점(소수점이하 첫째자리 버림) 조회 (학번, 학생명, 평점)
--같은 학생이 여러학기에 걸쳐 같은 과목을 이수한 데이터 있으나, 전체 평점으로 계산함.
select student_no, student_name, trunc(avg(point), 1) avg
from tb_grade G
    join tb_student S
        using(student_no)
group by student_no, student_name;

--@실습문제 5 : 교수번호, 교수명, 담당학생명수 조회
-- 단, 5명 이상을 담당하는 교수만 출력
select P.professor_no, P.professor_name, count(*) cnt
from tb_student S
    join tb_professor P
        on S.coach_professor_no = P.professor_no
group by P.professor_no, P.professor_name
having count(*) >= 5
order by cnt desc;


--==============================
-- 강의 21.01.28
--==============================

--@ 강의중 예제문제: 학번/학생명/담당교수명 조회
--1.두 테이블의 기준컬럼 찾기
--2.on조건절에 해당되지 않는 데이터파악

select * from tb_student; -- coach_professor_no
select * from tb_professor; -- professor_no

--담당교수, 담당하가생이 배정되지 않은 학생 제외 : inner 579
--담당교수가 배정되지 않은 학생 포함 : left 588 = 579 + 9
--담당학생이 없는 교수 포함 : right 580 = 579 + 10 

select student_no, student_name, professor_name
from tb_student S join tb_professor P
    on S.coach_professor_no = P.professor_no;
    
select count(*)
from tb_student S join tb_professor P
    on S.coach_professor_no = P.professor_no;

--1. 교수배정을 받지 않은 학생 조회 -- 9
select count(*)
from tb_student
where coach_professor_no is null;

--2. 담당학생이 한명도 없는 교수 조회 -1
--전체 교수 수 -- 114
select count(*)
from tb_professor;

--중복 없는 담당교수 수 -- 113
select count(distinct coach_professor_no)
from tb_student;
