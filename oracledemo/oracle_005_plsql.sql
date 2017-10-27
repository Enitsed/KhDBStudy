/*
PL/SQL은 Oracle's Procedural Language extension to SQL의 약자이다.
PL/SQL은 SQL에 없는 변수선언, 비교처리(if), 반복문처리(loop, while, for)
등을 제공하고 있다.

PL/SQL은 기본적으로 블록(Block)구조를 가지고 있다.
블록의 기본적인 구성은 declare(선언부) ~ executable(실행부) ~ exception(예외처리부)이다.

PL/SQL BLOCK기본 구성
 Declare(선언부) : 모든 변수나 상수를 선언하는 부분이다.
 Executable(실행부) : 제어문, 반복문, 함수정의 등의 로직을 기술한다.
 Exception(예외처리부) : 실행 도중 에러 실행시 해결하는 문장들을 기술한다.

PL/SQL블록구조에서 선언부와 예외처리부는 생략이 가능하지만 실행부는 생략할 수 없다.

PL/SQL 프로그램의 작성방법
 PL/SQL 블록 내에서는 한 문장을 종료할때마다 세미콜론(;)을 사용한다.
 END뒤에 ;을 사용하여 하나의 블록이 끝났다는 것을 명시합니다.
 PL/SQL 블록은 편집기를 통해 파일로 작성 할 수 도 있고, 프롬프트에서 바로 작성할 수도 있다.
 SQL*PLUS 환경에서는 Delclare나 Begin이라는 키워드로 PL/SQL블록이 시작하는 것을 알 수 있다.
 단일행 주석은 --이고 여러행 주석은  /* */이다.
 쿼리문을 수행하기 위해서 /가 반드시 입력되어야 하며,  PL/SQL 블록은 행에 /가 있으면 종결된 것으로 간주한다.
 
 PL/SQL문 내에서 SQL문장 사용하기
 PL/SQL 블록에서도 SQL문을 사용하여 데이터베이스 테이블의 데이터를 검색하고 수정할 수 있다.
 PL/SQL은 DML(데이터 조작어) 및 트랜잭션 제어 명령을 지원한다.
 PL/SQL블록에서 DML문과 TCL(commit, rollback)문을 사용할 경우 주의사항
 - END 키워드는 트랜잭션으 끝이 아니라 PL/SQL블록의 끝을 나타낸다.
 - PL/SQL은 DDL(데이터 정의어)문을 직접 지원하지 않는다.
 - DDL은 동적 SQL문이다. 동적 SQL문은 런타임에 문자열로 작성되며 파라미터의 위치 표시자를 포함할 수 있다.
   따라서 동적 SQL을 사용하면 PL/SQL에서 DDL문을 실행할 수 있다.
 - PL/SQL은 GRANT 또는 REVOKE와 같은 DCL(데이터 제어어)문을 직접 지원하지 않는다. 그러나 동적 SQL을
   사용하여 DCL문을 실행할 수 있다.
 */

PL/SQL은 기본적으로 처리된 PL/SQL문장의 결과를 화면에 출력하지 않는다. 그래서 결과를 화면에 출력하기 위해서는 화면 출력기능을 활성화 시켜야 한다.
sql> SET SERVEROUTPUT ON; (프롬프트로 실행할때 사용한다.)

declare
 -- 데이터 베이스에서 수행된 결과값을 저장할 변수는 선언한다.
 vno number(20);
 vname varchar2(20);
begin
 -- 데이터베이스에서 수행된 결과를 into 키워드 다음에 있는 변수에 저장한다.
 select salary,first_name into vno, vname
 from employees
 where employee_id=100;
 -- 두변수에 저장된 값을 화면에 출력한다.
 DBMS_OUTPUT.put_line(vno || '	' || vname);
end;
/ -- 실행

사용자에게 값을 입력받아서 변수에 할당 할때는 '&(앰퍼샌드)'기호를 사용한다.
declare
 -- 데이터 베이스에서 수행된 결과값을 저장할 변수는 선언한다.
 vno number(20);
 vname varchar2(20);
begin
 -- 데이터베이스에서 수행된 결과를 into 키워드 다음에 있는 변수에 저장한다.
 select salary,first_name into vno, vname
 from employees
 -- '&	' 로 입력받을 변수를 선언한다.
 where employee_id=&employee_id;
 -- 두변수에 저장된 값을 화면에 출력한다.
 DBMS_OUTPUT.put_line(vno || '	' || vname);
end;
 -- 작성된 PL/SQL 블록을 실행시킨다.
/

sql>edit c:/testsql/puttest -- 메모장에 쿼리 작성
begin
dbms_output.put('aaa');
dbms_output.new_line();
dbms_output.put('bbb');
dbms_output.new_line();
end;
/

sql>@c:/testsql/puttest -- 메모장으로 작성한 쿼리문 실행

PL/SQL내에서의 DML문장 사용하기
INSERT, UPDATE, DELETE, MERGE 문장을 이용하여 PL/SQL 블록 내에서 데이터를 변경할 수 있다.

sql>create table emp_test(
	no number,
	name varchar2(20));
	
sql>create sequence emp_test_seq start
	with 1 nocache nocycle;

sql>begin
	insert into emp_test
	values(emp_test_seq.nextval,'aaa');
end;
/

sql>commit;

sql>select * from emp_test;



