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


사용자로부터 변수에 저장할 값을 입력받는다.
verify
 - verify가 켜져 있으면(on) 치환변수를 값으로 대체하기 전후의 치환 변수 값을 표시한다.
 - verify가 꺼져 있으면(off) 치환변수를 값으로 대체하기 전후의 치환 변수 값을 표시 하지 않는다.
 
현재 verify 상태를 검색한다.
SQL> show verify

verify 상태가 on 일때 실행결과이다.
SQL> declare
	v_no number := '&no';
	v_name varchar2(20) := '&name';
	begin
	insert into emp_test
	values(v_no, v_name);
	end;
	/

no의 값을 입력하십시오: 200
구   2:         v_no number := '&no';
신   2:         v_no number := '200';
name의 값을 입력하십시오: bbb
구   3:         v_name varchar2(20) := '&name';
신   3:         v_name varchar2(20) := 'bbb';

PL/SQL 처리가 정상적으로 완료되었습니다.

verify상태를 off로 설정한다.
SQL> set verify off

현재 verify상태를 검색한다.
SQL> show verify

SQL> declare
	v_no number := '&no';
	v_name varchar2(20) := '&name';
	begin
	insert into emp_test
	values(v_no, v_name);
	end;
	/

no의 값을 입력하십시오: 300
name의 값을 입력하십시오: ccc


PL/SQL에서 update쿼리를 수행한다.
SQL> begin
	update emp_test
	set name = 'abc'
	where no = 1;
end;
/

SQL> select * from emp_test;


PL/SQL에서 delete쿼리를 수행한다.
SQL> begin
	delete from emp_test
	where no = 1;
	end;
	/

SQL> select * from emp_test;


merge를 수행하기 전에 emp_test2 테이블을 수행한다.
SQL> create table emp_test2(
	no number,
	first varchar2(20),
	last varchar2(20));
	
merge를 수행하기 전에 emp_test2테이블에 데이터를 삽입한다.
SQL> begin
	insert into emp_test2
	values(500, 'baba', 'ko');
	end;
	/
	
SQL> begin
	insert into emp_test2
	values(300, 'chacha', 'pu');
	end;
	/
	
	
SQL> select * from emp_test2;

emp_test2테이블에 emp_test테이블을 병합한다.
SQL> begin
	merge into emp_test2 e2
	using emp_test e1
	on(e1.no = e2.no)
		when matched then
		update set
			e2.first = e1.name
		when not matched then
		insert values(e1.no, e1.name, null);
	end;
	/

	
-----------------------------------------------------------

  PL/SQL변수
  PL/SQL변수	- 단순변수 - 스칼라변수
			- 참조변수 - %TYPE변수
					- %ROWTYPE변수

               -  LOB
               - 복합변수 - RECORD TYPE
                        - TABLE TYPE

  비 PL/SQL변수 - BIND변수


단순변수(SCALAR변수와 Reference변수)
 SCALAR변수 : 단일 값을 가지는 변수의 데이터 형을 직접 지정해주는 변수이다.
 Reference변수 : 변수의 데이터 형을 다른 컬럼에서 참조 후 지정하는 방식이다.
    - %type변수 : 특정 컬럼의 데이터형으로 선언한다.
    - %rowtype변수 : 여러 컬럼을 한꺼번에 저장할 변수로 선언한다.
    
Scalar 변수를 활용한 예제
SQL> declare
	num number := 10;
	name varchar2(20) := 'hong';
	hire date default sysdate;
	begin
		dbms_output.put_line(num || '	' || name || '	' || hire);
	end;
    /


Reference변수 중 %TYPE변수를 활용한 예제
SQL> declare
	num employees.employee_id%type;
	name employees.first_name%type;
	hire employees.hire_date%type;
	begin
		select employee_id, first_name, hire_date
		into num, name, hire
		from employees
		where employee_id = 100;
		dbms_output.put_line(num || '	' || name || '	' || hire);
	end;
	/


Reference변수 중 %TYPE변수를 활용한 예제
SQL> declare
	emp employees%rowtype;
	begin
		select *
		into emp
		from employees
		where employee_id = 100;
		dbms_output.put_line(emp.employee_id || '	' || emp.first_name || '	' || emp.hire_date);
	end;
	/

%type 변수를 사용하여 employees, departments 테이블을 조인하여 employee_id=100 인 사람의 정보를 4개의 변수에 넣은 후
employee_id, first_name, department_id, department_name을 가져오는 쿼리를 작성하시오.
<< 실행결과 >>
100 Steven 90 Exucutive

SQL> declare
	id employees.employee_id%type;
	name employees.first_name%type;
	department_id departments.department_id%type;
	department_name departments.department_name%type;
	begin 
		select e.employee_id, e.first_name, d.department_id, d.department_name
		into id, name, department_id, department_name
		from employees e, departments d
		where e.department_id = d.department_id and e.employee_id = 100;
		dbms_output.put_line(id || '	' || name || '	' || department_id || '	' || department_name);
	end;
/

두개의 데이터를 입력받아서 합을 구하는 쿼리를 작성하시오.
<<실행 결과>>
Enter value for no1: 10
old 2: v_no1 number : =&no1;
new 2: v_no1 number : =10;
Enter value for no2: 20
old 3: v_no2 number : =&no2;
new 3: v_no2 number : =20;
30

SQL> declare
	v_no1 number := '&no1';
	v_no2 number := '&no2';
	v_sum number;
	begin
		v_sum := v_no1 + v_no2;
		dbms_output.put_line(v_sum);
	end;
	/

복합변수는 변수 하나 안에 여러가지 다른 유형의 데이터를 포함할 수 있다.
복합변수는 Record type변수와 Table Type(컬렉션 타입)변수로 나눌 수 있다.
Record Type변수 내부는 여러가지 유형의 데이터 형태로 정의한다.
Table Type변수는 한가지 유형의 데이터 형태가 정의된다.
주로 동일한 데이터 타입의 여러건의 데이터를 저장하고 싶을 경우 Table Type(컬렉션 타입)을 사용하고
다른 유형의 데이터 타입을 사용할 경우 레코드 타입의 변수를 사용한다.

record type변수를 활용한 예제
SQL> declare
	-- Record Type을 정의한다.
	type emp_record_type is record
	(
		emp_id employees.employee_id%type,
		emp_name employees.first_name%type,
		emp_salary employees.salary%type,
		emp_hire employees.hire_date%type
	);
	-- Record Type의 변수를 선언한다.
	v_emp emp_record_type;
	BEGIN
		select employee_id, first_name, salary, hire_date
		into v_emp
		from employees
		where employee_id = 100;
		
		dbms_output.put_line(v_emp.emp_id || '	' || v_emp.emp_name || '	' || v_emp.emp_salary || '	' || v_emp.emp_hire);
	END;
	/


record type 변수를 활용하여 부서번호가 30번인 부서의 부서번호와 부서명과 도시명을 record type변수에 저장한 후 출력하시오.
(단, record type데이터 타입명은 dept_record_type으로 한다.)
<< 실행결과 >>
30	Purchasing	Seattle

SQL> declare
	type dept_record_type is record
	(
		dept_id departments.department_id%type,
		dept_name departments.department_name%type,
		city locations.city%type
	);
	v_dept dept_record_type;
	begin
		select d.department_id, d.department_name, l.city
		into v_dept
		from departments d, locations l
		where d.location_id = l.location_id and d.department_id = 30;
		
		dbms_output.put_line(v_dept.dept_id || '	' || v_dept.dept_name || '	' || v_dept.city);
	end;
	/
	
record type 변수를 활용하여 employees 테이블을 사용하여 사용자로부터 사원번호를 입력 받은 후 employee_id, first_name, hire_date, salary를 출력하시오.
(단, record type데이터 타입명은 sawon_record_type으로 한다.)
<< 실행결과 >>
emp_id의 값을 입력하십시오: 100
구   4:                 emp_id employees.employee_id%type := '&emp_id',
신   4:                 emp_id employees.employee_id%type := '100',
100     Steven  87/06/17        24000

PL/SQL 처리가 정상적으로 완료되었습니다.


SQL> declare
	type sawon_record_type is record
	(
		emp_id employees.employee_id%type,
		first_name employees.first_name%type,
		hire_date employees.hire_date%type,
		salary employees.salary%type
	);
	sawon sawon_record_type;
	v_input employees.employee_id%type := '&v_input';
	begin
		select employee_id, first_name, hire_date, salary
		into sawon
		from employees
		where employee_id = v_input;
		dbms_output.put_line('사원번호 : ' || sawon.emp_id );
		dbms_output.put_line('사원명 : ' || sawon.first_name );
		dbms_output.put_line('입사일 : ' || sawon.hire_date);
		dbms_output.put_line('연봉 : ' || sawon.salary );
	end;
	/

복합변수의 Table Type변수
	Table Type 변수는 Record Type과 같이 여러가지 유형의 데이터 칼럼을 가질 수도 있다.
	TABLE 타입은 TABLE을 색인 하는데 사용되는 BINARY_INTEGER 데이터 타입의 Primary Key와
	TABLE 요소를 저장하는 Scalar 데이터 타입의 두 가지 구성요소를 갖고 있어야 합니다.
[형식]
TYPE [type명] IS TABLE OF
column_type or variable%TYPE or 테이블명.컬럼명%TYPE
INDEX BY BINARY_INTEGER;

SQL> declare
	t_name varchar2(20);
	
	type tbl_emp_name is table of
	employees.first_name%type
	index by binary_integer;
	
	v_name tbl_emp_name;
	i binary_integer := 0;
	
	begin 
		select first_name into t_name
		from employees
		where employee_id = 100;
		
		v_name(i) := t_name;
		dbms_output.put_line(v_name(i));
	end;
	/
	
for 반복문을 사용하여 변수에 여러 건의 데이터를 입력하는 방법이다.
SQL> declare
	type name_table_type is table of
	employees.first_name%type
	index by binary_integer;
	v_name name_table_type;
	num binary_integer := 0;
	begin
		for i in(select first_name from employees) loop
			num := num+1;
			v_name(num) := i.first_name;
		end loop;
		for j in 1..num loop
		dbms_output.put_line(v_name(j));
		end loop;
	end;
	/

SQL> declare
	type name_table_type is table of employees%rowtype
	index by binary_integer;
	v_list name_table_type;
	num binary_integer := 0;
	begin
		for itemList in(select * from employees) loop
			num := num+1;
			v_list(num).employee_id := itemList.employee_id;
			v_list(num).first_name := itemList.first_name;
			v_list(num).salary := itemList.salary;
		end loop;
		for j in 1..num loop
			dbms_output.put_line(v_list(j).employee_id || '	' || v_list(j).first_name || '	' ||v_list(j).salary);
		end loop;
	end;
	/

	
	
SQL> declare
	type name_table_rec is record(
	--v_id employees.employee_id%type
	v_id number,
	--v_name employees.first_name%type
	v_name varchar2(20),
	--v_salary employees.salary%type
	v_salary number
	);
type name_table_type is table of name_table_rec
index by binary_integer;

v_list name_table_type;
num binary_integer := 0;
begin
	for itemList in(select employee_id, first_name, salary from employees) loop
		num := num+1;
		v_list(num).v_id := itemList.employee_id;
		v_list(num).v_name := itemList.first_name;
		v_list(num).v_salary := itemList.salary;
	end loop;
	for j in 1..num loop
		dbms_output.put_line(v_list(j).v_id || '	' || v_list(j).v_name || '	' ||v_list(j).v_salary);
	end loop;
end;
/

비 PL/SQL변수(바인드 변수)
바인드 변수는 호스트 환경에서 생성되어 데이터를 저장하므로 호스트 변수라 한다.
Variable키워드를 사용하여 생성되며 SQL문과 PL/SQL블록에서 사용된다.
print키워드를 사용해서 바인드변수에 저장된 값을 출력한다.

-- 바인드 변수로 사용할 변수를 사용한다.
SQL> variable v_bind number;

SQL> begin
	select salary into :v_bind
	from employees
	where employee_id = 100;
	end;
	/

-- 바인드 변수에 담긴 값을 출력한다.

SQL> print v_bind;

    V_BIND
----------
     24000

/*pl_sql문을 편집/수정 하기위해서 edit 명령문을 실행한다.
SQL> edit c:/testsql/sample

c:드라이브 testsql 폴더에 저장된 파일
SQL> @c:/testsql/sample
 */


PL/SQL 제어문
 : 조건문은 if문과 case문이 있다.
   반복문은 case loop문과 while문이 있다.
if~then~end if

IF condition THEN
      statements;
END if;

sql> edit c:/testsql/if01

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vdeptno employees.department_id%type;
	vdname varchar2(20);
	
	begin
		select employee_id, first_name, department_id
		into vempno, vname, vdeptno
		from employees
		where employee_id = 200;
		
		if vdeptno = 10 then
		vdname := 'ACCOUNT';
		end if;
		
		if vdeptno = 20 then
		vdname := 'RESEARCH';
		end if;
		
		if vdeptno = 30 then
		vdname := 'SALES';
		end if;
		
		if vdeptno = 40 then
		vdname := 'OPERATIONS';
		end if;
		
		dbms_output.put_line(vempno || '	' || vname || '	' || vdeptno || '	' || vdname);
	end;
	/

SQL> @c:/testsql/if01
200     Jennifer        10      ACCOUNT

PL/SQL 처리가 정상적으로 완료되었습니다.



sql> edit c:/testsql/if02

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vcomm employees.commission_pct%type;
	vsalary number(10, 2);
	
	begin
		select employee_id, first_name, commission_pct, salary
		into vempno, vname, vcomm, vsalary
		from employees
		where employee_id = 145;
		
		if vcomm > 0 then
			vsalary := vsalary + vcomm;
		else
			vsalary := vsalary + 0;
	end if;
	
	dbms_output.put_line(vempno || '	' || vcomm || '	' || vsalary);
end;
/

SQL> @c:/testsql/if02
145     .4      14000.4

PL/SQL 처리가 정상적으로 완료되었습니다.

------------------------------------------

if 조건식 then
 문장;
 elsif 조건식 then
 문장;
 elsif 조건식 then
 문장;
 else
 문장;
end if;

------------------------------------------

sql> edit c:/testsql/if03

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vdeptno employees.department_id%type;
	vdname varchar2(20);
	
	begin
		select employee_id, first_name, department_id
		into vempno, vname, vdeptno
		from employees
		where employee_id = 100;
		
		if vdeptno = 10 then
		vdname := 'ACCOUNT';
		elsif vdeptno = 20 then
		vdname := 'RESEARCH';
		elsif vdeptno = 30 then
		vdname := 'SALES';
		elsif vdeptno = 40 then
		vdname := 'OPERATIONS';
		else
		vdname := 'other';
		end if;
		
		dbms_output.put_line(vempno || '	' || vname || '	' || vdeptno || '	' || vdname);
	end;
	/

SQL> @c:/testsql/if03
100     Steven  90      other

PL/SQL 처리가 정상적으로 완료되었습니다.

------------------------------------------

CASE
	WHEN condition1 THEN result1
	WHEN condition1 THEN result1
	ELSE default
END CASE;

------------------------------------------

sql> edit c:/testsql/case01

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vdeptno employees.department_id%type;
	vdname varchar2(20);
	
	begin
		select employee_id, first_name, department_id
		into vempno, vname, vdeptno
		from employees
		where employee_id = 100;
		
		CASE 
		when vdeptno = 10 then
		vdname := 'ACCOUNT';
		when vdeptno = 20 then
		vdname := 'RESEARCH';
		when vdeptno = 30 then
		vdname := 'SALES';
		when vdeptno = 40 then
		vdname := 'OPERATIONS';
		else
		vdname := 'other';
		end case;
		
		dbms_output.put_line(vempno || '	' || vname || '	' || vdeptno || '	' || vdname);
	end;
	/

SQL> @c:/testsql/case01
100     Steven  90      other

PL/SQL 처리가 정상적으로 완료되었습니다.



sql> edit c:/testsql/case02

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vdeptno employees.department_id%type;
	vdname varchar2(20);
	
	begin
		select employee_id, first_name, department_id
		into vempno, vname, vdeptno
		from employees
		where employee_id = 100;
		
		vdname := case
		when vdeptno = 10 then	'ACCOUNT'
		when vdeptno = 20 then	'RESEARCH'
		when vdeptno = 30 then	'SALES'
		when vdeptno = 40 then	'OPERATIONS'
		else	'other'
		end;
		
		dbms_output.put_line(vempno || '	' || vname || '	' || vdeptno || '	' || vdname);
	end;
	/
	
SQL> @c:/testsql/case02
100     Steven  90      other

PL/SQL 처리가 정상적으로 완료되었습니다.



sql> edit c:/testsql/case03

declare
	vempno employees.employee_id%type;
	vname employees.first_name%type;
	vdeptno employees.department_id%type;
	vdname varchar2(20);
	
	begin
		select employee_id, first_name, department_id
		into vempno, vname, vdeptno
		from employees
		where employee_id = 100;
		
		vdname := case vdeptno
		when 10 then	'ACCOUNT'
		when 20 then	'RESEARCH'
		when 30 then	'SALES'
		when 40 then	'OPERATIONS'
		else	'other'
		end;
		
		dbms_output.put_line(vempno || '	' || vname || '	' || vdeptno || '	' || vdname);
	end;
	/
	

SQL> @c:/testsql/case03
100     Steven  90      other

PL/SQL 처리가 정상적으로 완료되었습니다.

--------------------------------------------------
LOOP
	statement;
	EXIT [WHERE condition];
END LOOP;

--------------------------------------------------

sql> edit c:/testsql/loop01

declare
	num number := 1;
begin 
	loop
		dbms_output.put_line(num);
		num := num +1;
		exit when num >5;
	end loop;
end;
/

SQL> @c:/testsql/loop01
1
2
3
4
5

PL/SQL 처리가 정상적으로 완료되었습니다.


sql> edit c:/testsql/loop02

declare
	num number := 1;
begin 
	loop
		dbms_output.put_line(num);
		num := num +1;
		if num >5 then
			exit;
		end if;
	end loop;
end;
/

SQL> @c:/testsql/loop02
1
2
3
4
5

PL/SQL 처리가 정상적으로 완료되었습니다.

--------------------------------------------------

WHEN condition LOOP
	statement;
END LOOP;

--------------------------------------------------

sql> edit c:/testsql/loop03

declare
	num number := 1;
begin 
	while num < 6 loop
		dbms_output.put_line(num);
		num := num +1;
	end loop;
end;
/

SQL> @c:/testsql/loop03
1
2
3
4
5

PL/SQL 처리가 정상적으로 완료되었습니다.

--------------------------------------------------

FOR counter IN [REVERSE] start..end loop
	statement;
END loop;

--------------------------------------------------

sql> edit c:/testsql/loop04

begin
	for i IN 1..5 loop
		dbms_output.put_line(i);
	end loop;
end;
/

SQL> @c:/testsql/loop04
1
2
3
4
5

PL/SQL 처리가 정상적으로 완료되었습니다.

단을 사용자로부터 입력받아 for문을 이용해서 구구단을 출력하는 문장을 구현하시오.


sql> edit c:/testsql/loop05

declare
	input number := '&num';
begin
	for i IN 1..9 loop
		dbms_output.put_line(input || '*' || i || '=' || i * input);
	end loop;
end;
/

SQL> @c:/testsql/loop05
num의 값을 입력하십시오: 5
구   2:         input number := '&num';
신   2:         input number := '5';
5*1=5
5*2=10
5*3=15
5*4=20
5*5=25
5*6=30
5*7=35
5*8=40
5*9=45

PL/SQL 처리가 정상적으로 완료되었습니다.






