뷰(view) :
1) 물리적인 테이블을 근거한 논리적인 가상 테이블을 의미한다.
2) 기본테이블에서 파생된 객체로서 기본테이블에 대한 하나의 쿼리문이다.
3) 사용자에게 주어진 뷰를 통해서 기본 테이블을 제한적으로 사용하게 한다.
4) 뷰를 생성하기 위해 실제적으로 데이터를 저장하고 있는 물리적인 테이블이 존재해야 하는데 이를 기본 테이블이라 한다.

sql> conn system/a1234
sql> grant create view to hr;
sql> conn hr/a1234

select * from employees
where employee_id =100;
/*위의 경우와 같이 데이터를 검색하기 위해서 select 문을 계속 사용하는데 이는 작업의 번거로움을 초래한다. 이런문제를 해결하기 위해 나온 개념이 뷰이다.*/

-- 자주사용하는 select 쿼리를 뷰로 생성한다.
create view emp_view
as
select * from employees
where employee_id = 100;

select * from emp_view;

-- 생성된 emp_view 뷰의 구조를 확인한다.
desc emp_view;

-- user_view 데이타 디셔너리에서 테이블 이름(뷰)과 텍스트(뷰를 생성할 때 사용한 쿼리문)출력
select view_name, text from user_views;

/* select * from emp_view으로 질의하면 오라클은 user_views 데이타 디셔너리에서 emp_view인 뷰 이름을 찾아서 이를 정의할 때 기술한 서브 쿼리문이 저장된 text값을 실행시킨다 */

create table emp_copy
as select * from employees;

create view emp_view100
as
select * from emp_copy
where employee_id = 100;

select * from emp_view100;

-- emp_view100 에 레코드 삽입
insert into emp_view100(employee_id, first_name, last_name, email, hire_date, job_id)
values(10, 'John', 'Tom', 'john@daum.net', sysdate, 'AD_VP'); -- 삽입은 가능

update emp_view100
set first_name = 'Park'
where employee_id = 10; -- 뷰 업데이트는 안됌

delete from emp_view100
where employee_id = 10; -- 뷰 속성 삭제도 안됌

select * from emp_copy where employee_id = 10;

뷰를 사용하는 이유
1) 복잡하고 긴 쿼리문을 뷰로 정의하면 접근을 단순화 시킬 수 있다.
2) 보안에 유리하다.

뷰의 종류 : 뷰를 정의하기 위해 사용된 기본 테이블의 갯수에 따라 단순 뷰(simple view)와 복합 뷰로 구분한다.

단순 뷰 : 뷰를 정의하기 위해 기본 테이블을 하나 사용.

-- 결과 출력시 실제 컬럼명을 출력하지 않고 여기서 정의한 컬럼명을 출력한다.
create view emp_view10(사원번호, 이름, 부서번호)
as select employee_id, first_name, department_id
from emp_copy
where department_id=10;

select * from emp_view10 where 사원번호=200; -- 정상적으로 처리
select * from emp_view10 where employee_id=200; -- ORA-00904: "EMPLOYEE_ID": 부적합한 식별자

복합 뷰 : 뷰 생성시 두개 이상의 기본 테이블로 생성

create table dept_copy
as
select * from departments;

-- 두개의 기본테이블로  emp_dept_join 뷰 생성
create view emp_dept_join
as
select e.employee_id, e.first_name, d.department_name
from emp_copy e, dept_copy d
where e.department_id = d.department_id;

-- emp_dept_join 뷰 조회
select * from emp_dept_join;

-- 뷰 디셔너리 검색
select view_name, text from user_views;

-- 뷰 제거
drop view emp_view10;

-- create or replace 구분으로 뷰 재생성
create or replace view emp_dept_join
as
select e.employee_id, e.first_name, d.department_name
from emp_copy e, dept_copy d
where e.department_id = d.department_id;


뷰의 생성할때 지정하는 FORCE/NOFORCE 옵션 : 기본적으로 뷰를 생성할때에는 기본 테이블이 있다는 존재하에 쿼리문을 작성한다. 하지만 기본 테이블이 존재하지 않는 경우에도 뷰를 생성할 수가 있다.
이 때에는 FORCE 옵션이 지정되어 있어야 한다. 특별한 설정이 없으면 NOFORCE옵션이 지정되어 있는 것으로 간주한다.

--ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
select * from emp;

-- emp테이블이 존재하지 않으므로 오류발생
create or replace view emp_view2
as
select * from emp;

/* 실제 존재하지 않는 emp기본테이블로 emp_view2 뷰를 생성한다. 결과는 정상 실행한다. 기본테이블이 없으면 반드시 뷰생성시 force옵션을 설정해야 한다.*/
create or replace force view emp_view2
as
select * from emp;

create table emp
as
select employee_id, first_name, salary
from employees;

select * from emp_view2;

인덱스
1) SQL 명령문의 처리 속도를 향상시키기 위해 컬럼에 대해서 생성하는 객체
2) 오라클에서 인덱스 내부 구조는 B* 트리구조 형식이다.
3) 만약에 14번 위치에 있는 데이터 값을 검색하고 싶다면 일반적인 방법으로는 14번을 검색해야 한다.
그러나, 인덱스 방법을 사용하게 되면 root에 1-10:A, 11-20:B 정보를 가지고 있다, branch에는 A에 있는 1번부터 10번까지의 위치번호와 rowid의 정보를 가지고 있다.
leaf에는 위치번호와 rowid값을 가지고 있다.

ROOT 	1-10: A
		11-20: B
		
BRANCH		A				B
		  1-10:a1
		  				  11-20:b2
		  				  
LEAF 		a1				b2
		위치번호  rowid	위치번호	rowid
		  1		 x231	  11	  x850
		  2		 x753	  12	  x933


-- 서브 쿼리를 이용해서 e2테이블 생성
create table e2
as
select * from employees;

-- 검색속도의 차이를 느끼려면 많은 데이터가 있어야 하기 떄문에 e2테이블에 데이터를 추가한다.
insert into e2 select * from e2;

-- Elapsed Time:  0 hr, 0 min, 0 sec, 2 ms.
select * from e2
where first_name = 'Steven';

-- idex_e2_ename의 index생성
create index idx_e2_ename -- 인덱스명
on e2(first_name); -- 테이블명(컬럼명)

-- Elapsed Time:  0 hr, 0 min, 0 sec, 2 ms.
select * from e2
where first_name = 'Steven';

-- 데이터 디셔너리 user_indexes 테이블에 저장된 내용 검색
select index_name, table_name
from user_indexes
where table_name='E2';

-- d2테이블 생성
create table d2
as select * from departments;

insert into d2(department_id, department_name)
values(1, '인사과');

insert into d2(department_id, department_name)
values(2, '충무과');

insert into d2(department_id, department_name)
values(3, '재무과');

select * from d2;

select문 검색결과를 보면 department_id 인덱스로 지정하는 경우에 부서번호가 중복되어 저장되어 있지 않고 유일한 값만 갖고 있으므로 고유 인덱스로 지정할 수 있다.
location_id 컬럼은 인덱스로 지정하는 경우에 지역명이 중복되어 저장되어 있으므로 비 고유 인덱스로 지정해야 한다.

-- d2테이블의 department_id컬럼에 idx_02_deptno 고유 인덱스 설정
create unique index idx_02_deptno
on d2(department_id);


--ORA-01452: 중복 키가 있습니다. 유일한 인덱스를 작성할 수 없습니다
create unique index idx_02_loc
on d2(location_id);

-- 정상 실행 (location_id가 중복된 값을 가지고 있기 때문에 비 고유 인덱스 설정한다.)
create index idx_02_loc
on d2(location_id);

-- idx_02_loc 인덱스 삭제
drop index idx_02_loc;

/* department_id, department_name 컬럼 2개로 idx_02_com 결합인덱스 설정한다. 인덱스 설정시 컬럼2개 이상이 사용되면 이를 결합인덱스라 하고 컬럼1개 일때는 단일 인덱스라 한다. */
create index idx_02_com
on d2(department_id, department_name);

/* 데이터 딕셔너리인 user_ind_columns 테이블에서 idx_d2_com 인덱스의 내용 확인 */
select index_name, column_name
from user_ind_columns
where table_name = 'D2';

[인덱스를 사용해야 하는 경우]
1) 테이블에 행의 수가 많을 때
2) where 문에 해당 컬럼이 많을 때
3) 검색결과가 전체 데이터의 2%~ 4%일때
4) join에 자주 사용되는 컬럼이나 null을 포함하는 컬럼이 많은경우

[인덱스를 사용하지 말아야 하는 경우]
1) 테이블의 행의 수가 적을 때
2) where문에 해당 컬럼이 자주 사용되지 않을때
3) 검색 결과가 전체 데이터의 10%~15%이상일 때
4) 테이블에 DML작업이 많은 경우

-- e3 테이블 생성
create table e3
as select * from employees;

-- salary 컬럼에 인덱스가 설정되어 있으면 인덱스를 이용해서 데이터 검색
select * from e3
where salary = 4800;

-- salary 컬럼에 수식이 사용되고 있을때는 인덱스를 이용하지 않음
select * from e3
where salary * 2 = 9600;

/* 함수나 수식이 사용된 컬럼에 인덱스를 이용해서 데이터를 검색하기 위해서는 함수기반 인덱스를 설정해야 한다. */
-- 함수기반의  dex_e3_annsal 인덱스 설정
create index dex_e3_annsal
on e3(salary*2);

-- 데이터 디셔너리인 user_ind_columns 테이블의 내용 확인
select index_name, column_name
from user_ind_columns
where table_name = 'E3';


사용자 관리
/* 사용자계정 user01, 비밀번호 tiger를 가진 사용자 생성을 생성하나 오류발생, 사용자 계정은 시스템 관리에게만 권한이 있다. */

-- ORA-01031: 권한이 불충분합니다
create user user01 identified by tiger;

-- 시스템 계정을 생성하기 위해 시스템 관리자로 접속
sql> conn system/a1234

-- 현재 시스템 관리자 상태이기 때문에 다른 사용자 계정 생성 가능하므로 정상실행
sql> create user user01 identified by tiger;

-- 현재 사용자 계정 검색(sys,system 일때만 사용자계정 생성할 수 있음)
sql> show user;

 데이터베이스 관리자가 가지는 시스템권한
 1) create user : 새롭게 사용자를 생성하는 권한
 2) drop user : 사용자를 삭제하는 권한
 3) drop any table : 임의의 테이블을 삭제할 수 있는 권한
 4) query rewrite : 질의재작성을 할 수 있는 권한
 5) backup any table : 임의의 테이블을 백업할 수 있는 권한

 일반 사용자가 데이터베이스를 관리하는 권한
 1) create session : 데이터베이스에 접속할수 있는 권한
 2) create table : 사용자 스키마에게 테이블을 생성할 수 있는 권한
 3) create view : 사용자 스키마에게 뷰를 생성할 수 있는 권한
 4) create sequence : 사용자 스키마에게 시퀀스를 생성할 수 있는 권한
 5) create procedure : 사용자 스키마에게 프로시저(함수)를 생성할수 있는 권한

 사용자에게 권한 부여하기 위한 grant 명령어
 sql> grant system_privilege to user_name;
 
 -- user01 사용자에게 데이터베이스 접근 권한 부여
 sql> grant create session to user01;
 
 -- 사용자 계정 변경
 sql> conn user01/tiger
 
 -- ORA-01031 : 권한이 불충분합니다.
 sql> select * from employees;
 
 create table tdata(id number);
 
 sql> conn system/a1234;
 
 sql> create user user02 identified by tiger;
 
 /* user02 계정에 데이터 베이스 접근 권한 부여시 WITH ADMIN OPTION 옵션을 지정하게 되면 현재 사용자 계정으로 다른 사용자에게 권한을 부여할 수 있다.*/
 sql> grant create session to user02 with ADMIN option;
 
 sql> show user;
 
 sql> conn user02/tiger;
 
 sql> show user;
 
 /* user02계정에서 user01계정에게 데이터베이스 접근 권한 부여(user02 게정 생성시 with admin option 옵션을 지정했기 때문에 user02계정으로 user01계정에 권한 부여가 가능하다) */
 sql> grant create session to user01;
 
 객체권한부여 : 객체 권한은 테이블이나 뷰나 시퀀스나 함수 등과 같은 객체별로 DML문(SELECT, INSERT, DELETE)을 사용할 수 있는 권한 설정
 
 sql> grant object_privilege on object to user_name;
 
 sql> select * from emp;
 
 -- hr계정과 a1234비밀번호로 접속
 sql> conn hr/a1234 
 
 /* hr계정이 가지고 있는 emp객체를 user01계정에게 select문을 실행시킬수 있는 권한을 부여한다. */
 sql> grant select on emp to user01;
 
 -- user01 계정과 tiger 비밀번호로 접속
 sql> conn user01/tiger;
 
 sql> select * from emp;
 
 sql> select * from hr.emp;
 
 사용자에게 부여된 권한 조회
 1) user_tab_privs_made 데이터 디셔너리 : 현재 사용자가 다른 사용자에게 부여한 권한 정보를 알려줌
 
 2) user_tab_privs_recd 데이터 디셔너리 : 자신에게 부여된 권한 정보를 알려줌
 
 
 sql> conn hr/a1234

 --hr 계정에 다른 소유자에게 부여한 권한 정보 조회
 sql> select * from user_tab_prvs_made;
 
 sql> conn user01/tiger;
 
 --user01 계정에 부여된 권한 정보 조회
 sql> select * from user_tab_prvs_recd;
 
 사용자에게 권한을 뺏기 위한 revoke 명령어
 : 사용자에게 부여한 권한을 데이터베이스 관리자나 객체 소유자로부터 철회하기 위해서 사용
 sql> revoke object_privilege on object from user_name;

 
 sql> conn hr/a1234
 
 /* user01 계정에 부여한 emp객체를 조회할 수 있는 select 명령문 철회 */
 sql> revoke select on emp from user01;
 
 sql> select * from user_tab_privs_made;
 
 sql> conn user01/tiger
 
 sql> select * from hr.emp;
 
 데이터베이스 (role) 권한제어
 	롤 : 사용자에게 보다 효율적으로 권한을 부여할 수 있도록 여러개의 권한을 묶어 놓은것
 	
 	롤의 종류 : 데이터베이스를 설치하면 기본적으로 제공되는 사전 정의된 롤과 사용자가 정의한 롤로 구분
 
  사전 정의된 롤의 종류(db설치시 제공)
   1) CONNECT 롤 : 사용자가 데이터베이스에 접속 가능하도록
         하기 위해서 가장 기본적인 시스템권한 8가지를 정의
      -ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK,
       CREATE SEQUENCE, CREATE SESSION, CREATE SYNONYM,
       CREATE TABLE, CREATE VIEW

   2)RESOURCE 롤 : 사용자가 객체(테이블, 뷰, 인덱스)를 생성할
      수 있도록 하기 위해서 시스템 권한을 묶어 정의
      - CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE,
        CREATE TABLE, CREATE TRIGER
   3)DBA 롤 : 사용자들이 소유한 데이터베이스 객체를 관리하고
       사용자들을 작성하고 변경하고 제거할 수 있도록하는 모든 권한
  
 sql> conn system/a1234
 
 sql> create user user04 identified by tiger;
 
 sql> grant create session to user04;
 
 -- user04계정에 connect, resource 를 권한 부여
 sql> grant connect, resource to user04;
 
 sql> conn user04/tiger
 
 sql> create table mytable(id number, name varchar2(50));
 
 sql> insert into mytable values(10, 'min');
 
 sql> select * from mytable;
 
 -- 데이터디셔너리인 dict테이블에서 role을 검색
 sql> select * from dict where table_name like '%ROLE%';
 
 사용자 롤 정의 순서
 1) 롤을 생성한다. (데이터베이스 관리자)
 sql> create role role_name;
 2) 롤에 권한 부여한다.(특정 사용자)
 sql> grant object_priv to role_name;
 3) 사용자에게 롤을 부여한다(데이터베이스 관리자)
 sql> grant role_name to user_name;
 
 
 -- 롤을 생성하기 위해 system 계정으로 접속
 sql> conn system/a1234
 
 -- mrole을 생성
 sql> create role mrole;
 
 --생성한 mrole 롤에 구너한을 설정하기 위해서 hr계정으로 접속
 sql> conn hr/a1234
 
 --mrole에 emp객체 조회할 수 있는 select문 권한 설정
 sql> grant select on emp to mrole;
 
 sql> conn system/a1234
 
 sql> grant mrole to user04;
 
 sql> conn user04/tiger
 
 sql> select * from hr.emp;
 
 [user05 사용자 계정을 생성 및 롤을 이용한 권한부여]
 
 sql> create table mem2(id varchar2(10), name varchar2(50));
 
 sql> insert into mem2 values('a001', '홍길동');
 sql> select * from mem2;
 
 
 
 
 
 
 
 
 
 
 
 