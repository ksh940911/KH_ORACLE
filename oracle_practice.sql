--==============================

-- FOR PRACTICE

--==============================

--@실습문제 1 : tbl_escape_watch 테이블에서 description 컬럼에 99.99% 라는 글자가 들어있는 행만 추출하세요.
	create table tbl_escape_watch(
		watchname   varchar2(40)
		,description    varchar2(200)
	);
	--drop table tbl_escape_watch;
	insert into tbl_escape_watch values('금시계', '순금 99.99% 함유 고급시계');
	insert into tbl_escape_watch values('은시계', '고객 만족도 99.99점를 획득한 고급시계');
	commit;
	select * from tbl_escape_watch;
--정답
    select description
    from tbl_escape_watch
    where description like '%99.99\%%' escape '\';
    
--@실습문제 2 : 파일경로를 제외하고 파일명만 아래와 같이 출력하세요.
/*
출력결과 :
---------------------------
파일번호          파일명
---------------------------
1             salesinfo.xls
2             music.mp3
3             resume.hwp
---------------------------
*/ 
	create table tbl_files
	(fileno number(3)
	,filepath varchar2(500)
	);

	insert into tbl_files values(1, 'c:\abc\deft\salesinfo.xls');
	insert into tbl_files values(2, 'c:\music.mp3');
	insert into tbl_files values(3, 'c:\documents\resume.hwp');

	commit;

	select * 
	from tbl_files;
--정답
    select rpad(fileno,1) 파일번호, substr(filepath, (instr(filepath,'\',-1)+1)) 파일명
    from tbl_files;
    
    select instr(filepath,'\',-1) --substr돌릴때 filepath에서 자르기 시작할 인덱스 넘버 찾기. 근데 찾고나서 \를 출력하고 싶지않으니 +1을 해주면 \를 빼고 출력할수있음
    from tbl_files;

    
    
    
    