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

부서번호를 입력받아 부서에 해당하는 사원번호, 사원명(first_name), 연봉, 부서번호를 출력하는 문장을 구현하시오.

declare
   vdmt number := '&dmt';
   type rec_emp_type is record(
	v_empid employees.employee_id%type,
	v_name employees.first_name%type,
	v_salary employees.salary%type,
	v_deptid employees.department_id%type
   );
   type tbl_emp_type is table of rec_emp_type index by binary_integer;
   emp_list tbl_emp_type;
   i binary_integer := 0;
   
   begin
      for data_list in(select employee_id, first_name, salary, department_id from employees where department_id = vdmt) loop
         i := i+1;
         emp_list(i).v_empid := data_list.employee_id;
         emp_list(i).v_name := data_list.first_name;
         emp_list(i).v_salary := data_list.salary;
         emp_list(i).v_deptid := data_list.department_id;
      
      dbms_output.put_line(emp_list(i).v_empid || '  ' ||
							emp_list(i).v_name || '  ' ||
							emp_list(i).v_salary || '  ' ||
							emp_list(i).v_deptid );
      end loop;
   end;
   /
   
[실행결과]

SQL> @c:/testsql/loop06
dmt의 값을 입력하십시오: 100
구   2:    vdmt number := '&dmt';
신   2:    vdmt number := '100';
108  Nancy  12000  100
109  Daniel  9000  100
110  John  8200  100
111  Ismael  7700  100
112  Jose Manuel  7800  100
113  Luis  6900  100

PL/SQL 처리가 정상적으로 완료되었습니다.

[저장 프로시저(Stored Procedure)]
pl/sql문을 데이터베이스에 저장할 수 있도록 저장 프로시저를 제공한다.
특정한 처리를 수행하는 pl/sql 서브 프로그램이다. 파라미터를 받아서 특정 작업을 수행한다.

CREATE OR REPLACE PROCEDURE name
	IN argument
	OUT argument
	IN OUT argument
	
IS

	[변수의 선언]
	
BEGIN --> 필수

	[PL/SQL BLOCK]
	-- SQL문장, PL/SQL제어 문장

	[EXCEPTION] --> 선택
	--error가 발생할 때 수행하는 문장
	
END; --> 필수
/

SQL> edit C:/testsql/proce01
CREATE OR REPLACE PROCEDURE greetings
AS
	BEGIN
		dbms_output.put_line('Hello World!');
	END;
/

SQL> @C:/testsql/proce01 -- 프로시저 생성
SQL> execute greetings -- 프로시저 실행
Hello World!
PL/SQL 처리가 정상적으로 완료되었습니다.


SQL> edit C:/testsql/proce02
CREATE OR REPLACE PROCEDURE greetings2
AS
	BEGIN
		dbms_output.put_lin('Hello World!'); -- 일부러 오타 생성
	END;
/

SQL> @c:/testsql/proce02
경고: 컴파일 오류와 함께 프로시저가 생성되었습니다.

-- 컴파일 오류 메세지 확인
SQL> show error;
PROCEDURE GREETINGS2에 대한 오류:
LINE/COL ERROR
-------- -----------------------------------------------------------------
4/3      PL/SQL: Statement ignored
4/15     PLS-00302: 'PUT_LIN' 구성 요소가 정의되어야 합니다

-- 사용자가 정의한 소스 저장을 확인하기 위해 user_source 구조 확인
SQL> desc user_source
 이름                                      널?      유형
 ----------------------------------------- -------- ----------------------------

 NAME                                               VARCHAR2(30)
 TYPE                                               VARCHAR2(12)
 LINE                                               NUMBER
 TEXT                                               VARCHAR2(4000)
 
 -- 저장 프로시저 확인
 sql> select name, text from user_source;


SQL> edit c:/testsql/proc03_inmode
create or replace procedure proc03_inmode
(v_empid in emp.employee_id%type) -- 값을 받아들임
is
begin
	update emp
	set salary = salary * 1.5
	where employee_id = v_empid;
end;
/
SQL> @c:/testsql/proc03_inmode

프로시저가 생성되었습니다.
SQL> execute proc03_inmode(200) -- 값을 입력함

PL/SQL 처리가 정상적으로 완료되었습니다.
SQL> select employee_id, salary from employees where employee_id=200;

EMPLOYEE_ID     SALARY
----------- ----------
        200       4400

SQL> select * from emp where employee_id = 200;

EMPLOYEE_ID FIRST_NAME                                   SALARY
----------- ---------------------------------------- ----------
        200 Jennifer                                       6600

SQL> edit c:/testsql/proc04_outmode

create or replace procedure proc04_outmode
(
	v_id in employees.employee_id%type, -- 값은 받아들임
	v_name out employees.first_name%type, -- 값을 내보냄
	v_salary out employees.salary%type, -- 값을 내보냄
	v_avg_salary out employees.salary%type, -- 값을 내보냄
	v_deptname out departments.department_name%type -- 값을 내보냄
)
is
	v_deptid number;
begin
	select first_name, salary, department_id
	into v_name, v_salary, v_deptid
	from employees
	-- 사원번호가 받아들인 값과 같은 사람의 ename, sal, deptno를 추출
	where employee_id=v_id;
	select d.department_name, a.avg_sal
	-- 선택한 사원이 속한 부서의 평균 salary와 부서명 추출
	into v_deptname, v_avg_salary
	from departments d,
		(select round(avg(salary)) avg_sal from employees where department_id = v_deptid) a
		where d.department_id = v_deptid;
end;
/

SQL> @c:/testsql/proc04_outmode
프로시저가 생성되었습니다.
-- 출력될 변수 선언
SQL> variable g_name varchar2(20)
SQL> variable g_salary number
SQL> variable g_avg number
SQL> variable g_deptname varchar2(20)

SQL> execute proc04_outmode(200,:g_name,:g_salary,:g_avg,:g_deptname)

-- 프로시저 실행 후 바인드된 변수 출력
SQL> print g_name
G_NAME
------------------
Jennifer

SQL> print g_salary
  G_SALARY
----------
      4400

SQL> print g_avg
     G_AVG
----------
      4400

SQL> print g_deptname
G_DEPTNAME
-------------------------
Administration




SQL> edit c:/testsql/proc05_inoutmode

create or replace procedure proc05_inoutmode
	(v_salary in out varchar2)
	is
begin
	-- 외부 변수로부터 값을 받아들여 이 양식에 맞게 다시 내보냄
	v_salary := '$' || SUBSTR(v_salary, -9, 3) || ',' || SUBSTR(v_salary, -6, 3) || ',' || SUBSTR(v_salary, -3, 3);
end;
/

SQL> @c:/testsql/proc05_inoutmode
프로시저가 생성되었습니다.

-- // 외부변수 선언
SQL> variable g_salary varchar2(20)
SQL> begin
  2     :g_salary:= '123456789';
  3  end;
  4  /

PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> print g_salary
G_SALARY
------------------------------------------------
123456789

SQL> execute proc05_inoutmode(:g_salary)
PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> print g_salary
G_SALARY
--------------------------------------------------
$123,456,789

SQL> edit c:/testsql/proc06_othermode
create or replace procedure proc06_othermode
(v_name in mem.name%type default '홍길동',
v_location in mem.loc%type default '서울')
is

begin
	insert into mem
	values(mem_num_seq.nextval, v_name, 40, v_location);
end;
/

SQL> @c:/testsql/proc06_othermode
프로시저가 생성되었습니다.

SQL> execute proc06_othermode
PL/SQL 처리가 정상적으로 완료되었습니다.


SQL> select * from mem;

	NUM		NAME	AGE		LOC
	1		윤아		30		서울
	5		홍길동	40		서울
	2		조윤희	35		경기
	NUM		NAME	AGE		LOC
	3		야옹이	21		부산
	4		야옹이	40		부산

SQL> begin
	--매개변수로 아무런 값도 안넣을때 디폴트 값이 들어감
  2  proc06_othermode;
  -- 각각 v_name, v_location 변수에 저장
  3  proc06_othermode('박재미', '경기');
  -- v_name에 '돌돌이' 값이 저장되고 v_location변수에는 티폴트값이 저장
  4  proc06_othermode(v_name => '돌돌이');
  5  end;
  6  /

PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> select * from mem order by num;

	NUM		NAME		AGE		LOC
---------- ---------------------------------------- ----------
	1		윤아			30		서울
	2		조윤희		35		경기
	3		야옹이		21		부산
	4		야옹이		40		부산
	5		홍길동		40		서울
	6		홍길동		40		서울
	7		박재미		40		경기
	8		돌돌이		40		서울

SQL> execute proc06_othermode(v_location=>'제주');
PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> select * from mem order by num;
	NUM		NAME		AGE		LOC
---------- ---------------------------------------- ----------
	1		윤아			30		서울
	2		조윤희		35		경기
	3		야옹이		21		부산
	4		야옹이		40		부산
	5		홍길동		40		서울
	6		홍길동		40		서울
	7		박재미		40		경기
	8		돌돌이		40		서울
	9		홍길동		40		제주

	
	
[사용자 정의 함수(Stored Function)]
사용자가 만든 함수이며 어떤 연산을 수행한 뒤 결과 값을 반환한다.
SQL> edit c:/testsql/func01
create or replace function func01
	(v_deptid in employees.department_id%type)
	return char
is
	v_deptname departments.department_name%type;
begin
	select department_name into v_deptname
	from departments
	where department_id = v_deptid;
	return(v_deptname);
end;
/

SQL> @ c:/testsql/func01
함수가 생성되었습니다.

SQL> select employee_id, first_name, func01(department_id) from employees;
	EMPLOYEE_ID		FIRST_NAME	FUNC01(DEPARTMENT_ID)
-----------------------------------------------------------------------------
	205				Shelley		Accounting
	206				William		Accounting

1. Procedure는 Return값이 없어도 되지만, Function은 Return값이 반드시 존재한다.
(Procedure는 Return값이 없거나 2개 이상일 수도 있지만, Function은 반드시 1개의 Return 값이 존재한다.)
2. Function은 Select문에서 호출이 가능하지만, Procedure는 Select문에서 호출이 불가능하다.

-------------------------------------------------------------------------------------------

[PL/SQL Cursor(커서)]
select문의 수행 결과가 여러개의 로우(레코드)로 구해지는 경우에 모든 로우에 대해 어떤 처리를 하고싶을때 사용한다.
오라클 서버에서는 SQL문을 실행할 때마다 처리(Execution)를 위한 메모리공간을 SQL커서라고 한다.
즉 사용자가 요청하는 데이터를 데이터베이스 버퍼 캐시에서 커서로 복사해 온 후 커서에서 원하는 데이터를
추출하여(Fetch) 후속 작업을 한다는 뜻이다.
커서는 cursor, open, fetch, close 4단계 명령에 의해서 사용된다.
DECLARE
  CURSOR cursor_name IS statement;  -- 커서선언[select문]
BEGIN
  OPEN cursor_name;  -- 커서열기
                                      [LOOP]
  FETCH cursor_name INTO variable_name; --커서로부터 데이터를 읽어와 변수에 저장
                                      [END LOOP;]
                                           
  CLOSE cursor_name; --커서닫기
END;

커서의 상태
커서이름%NOTFOUND : 커서 영역의 자료가 모두 FETCH 돼었다면 TRUE
커서이름%FOUND : 커서 영역에 FETCH되지 않은 자료가 있다면 TRUE
커서이름%ISOPEN : 커서가 OPEN된 상태이면 TRUE
커서이름%ROWCOUNT : 커서가 얻어 온 레코드의 갯수

커서에는 명시적커서와 묵시적 커서 두가지 유형이 있다.

명시적 커서는 사용자가 선언하여 생성후 사용하는 SQL커서로, 주로 여러 개의 행을
처리하고자 할 경우 사용한다. 만약 여러건을 검색하는  SELECT문장의 경우 묵시적 커서를
사용할 경우 오라클은 예외사항(TOO_MANY_ROWS)을 발생하게 된다.
명시적 커서는 묵시적 커서와는 다르게 동시에 여러 개가 선언되어 사용될 수 있다.
또한 묵시적 커서와 마찬가지로 커서 속성 변수로 커서의 내용을 파악하고 보다 쉽게 작업할수 있게해준다.
명시적 커서는 여러 개가 선언될 수 있으므로, 커서 속성 변수는 '커서명%'을 커서 속성 변수의 접두어로
붙여서 사용된다.   

SQL> edit c:/testsql/cursor01

declare
vempno number;
vename varchar2(20);
vsal number(7);
	-- cs라는 이름의 명시적 커서를 선언한다.
	-- 이 커서가 open될때 마치 view처럼 서브쿼리가 수행된다.
cursor cs is
	select employee_id, first_name, salary
	from employees
	where department_id = 20;

begin
	open cs; -- 커서를 열기한다.
		loop
			fetch cs into vempno, vename, vsal;
			exit when cs%notfound;
			dbms_output.put_line(vempno || '	' || vename || '	' || vsal);
		end loop;
	close cs; -- 커서는 닫기 한다.
end;
/

SQL> @c:/testsql/cursor01
201	Michael	13000
202	Pat	6000
PL/SQL 처리가 정상적으로 완료되었습니다.



SQL> edit c:/testsql/cursor02
declare
-- 커서를 선언한다.
cursor emp_cur is
	select employee_id, first_name, salary
	from employees
	where department_id = 20;
begin
	--커서의 데이터를 저장할 emp_rec변수를 선언한다.
	for emp_rec in emp_cur loop
	dbms_output.put_line(emp_rec.employee_id || '	' || emp_rec.first_name || '	' || emp_rec.salary);
	end loop;
end;
/

SQL> @c:/testsql/cursor02
201	Michael	13000
202	Pat	6000

PL/SQL 처리가 정상적으로 완료되었습니다.


SQL> edit c:/testsql/cursor03
declare
-- 변수 선언
vemp employees%rowtype;

-- 커서를 선언한다.
cursor emp_cur is
	select employee_id, first_name, salary
	from employees
	where department_id = 20;
begin
	--커서의 데이터를 저장할 emp_rec변수를 선언한다.
	for vemp in emp_cur loop
	dbms_output.put_line(vemp.employee_id || '	' || vemp.first_name || '	' || vemp.salary);
	end loop;
end;
/

SQL> @c:/testsql/cursor03
201     Michael 13000
202     Pat     6000
PL/SQL 처리가 정상적으로 완료되었습니다.

묵시적 커서
묵시적 커서(implicit cursor)란 오라클 내부에서 각각의 쿼리 결과에 접근하여 사용하기 위한 내부적 커서.
묵시적 커서를 사용할 경우 'SQL'이라는 이름로 속성에 접근.

SQL> edit c:/testsql/cursor04

declare
	count1 number;
	count2 number;
begin
	select count(*)
	into count1
	from employees
	where department_id = 20;
	
	--%notfound와 기능이 유사한 %rowcount란 기능도 존재한다.
	--%rowcount : 카운터(counter)역할.
	-- 커서가 막 오픈되었을 때는 0이고 fetch 될때마다 1씩 증가됨.
	count2 := SQL%rowcount;
	dbms_output.put_line('select count is ' || count1);
	dbms_output.put_line('row count is ' || count2);
end;
/

SQL> @c:/testsql/cursor04
select count is 2
row count is 1
PL/SQL 처리가 정상적으로 완료되었습니다.



































