--==============================

-- CHUN 계정

--==============================

-- 학과테이블
select * from tb_department; 

-- 학생테이블
select * from tb_student;

-- 과목테이블
select * from tb_class;

-- 교수테이블
select * from tb_professor;

-- 교수과목테이블
select * from tb_class_professor;

-- 점수등급테이블
select * from tb_grade;

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

--@실습문제 6 :

--@실습문제 7 :

--@실습문제 8 :

--@실습문제 9 :

--@실습문제 10 :