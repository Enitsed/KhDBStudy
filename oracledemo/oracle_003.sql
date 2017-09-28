--------------------------------------------------------------
오라클에서 제공되는 명령어
1 DQL(Data Query Language) : 
  데이터를 검색해서 추출할때 사용된다.(select)
2 DML(Data Manipulation Language) : 
  데이터는 추가, 수정, 삭제,병합해주는 명령어들이다.
  (insert, update, delete,merge)
3 DDL(Data Definition Language ) : 
  테이블의 구조를 정의, 변경해주는 명령어들이다.
  (create, drop, alter, truncate)
4 DCL(Data Control Language) : 
  사용자의 권한을 부여,제거해주는 명령어들이다.(grant ,revoke)
5 TCL(Transaction Control Language) : 
  트랜잭션 설정,취소을 처리해주는 명령어들이다
  (commit, rollback, savepoint
--------------------------------------------------------------
-- emp01 테이블 삭제
DROP TABLE emp01;

-- 테이블 구조를 복사
CREATE TABLE emp01
AS
SELECT first_name, salary
FROM employees
WHERE 1 = 0;

-- 테이블에 레코드를 삽입
INSERT INTO 테이블(컬럼1, 컬럼2)
VALUES('값1', 값2);

INSERT INTO emp01(first_name, salary)
VALUES('candy', 5000);

-- 테이블 모든 컬럼에 데이터를 삽입 할 때는 컬럼명을 생략할 수 있다.
INSERT INTO emp01
VALUES('Steven', 4000);

-- 묵시적 NULL 삽입 방법
INSERT INTO emp01(first_name)
VALUES('LEX');

-- 명시적 NULL 삽입 방법
INSERT INTO emp01
VALUES('Paran', null);

--------------------------------------------------------------
UPDATE
	테이블의 내용을 수정하는 명령어이다.
	UPDATE 테이블명 SET 컬럼1 = 값1, 컬럼2 = 값2 WHERE 컬럼 = 값;
--------------------------------------------------------------

-- emp01 테이블 first_name컬럼의 값이 'candy' 일 때 salary컬럼의 값을 8000으로 수정하라.
	UPDATE emp01
	SET salary = 8000
	WHERE first_name = 'candy';
	
	UPDATE emp01
	SET salary = salary + 8000
	WHERE first_name = 'candy';

--------------------------------------------------------------
DELETE
	DELETE FROM 테이블명 WHERE 컬럼 = 값;
--------------------------------------------------------------

-- emp01 테이블에서 first_name컬럼의 값이 candy일 때 데이터를 삭제하라.
	DELETE FROM emp01
	WHERE first_name = 'Paran';
	
	
SELECT * FROM emp01;

============================================================================

트랜잭션(Transaction)
1 트랜잭션 정의
  -한번에 수행되어야 할 데이터베이스의 일련의 Read와 Write 연산을 수행하는 단위
  -하나의 논리적 기능을 수행하기 위한 작업의 단위로서 데이터베이스의 일관된 상태를 또 다른 일관된 상태로 변환시킴
  
  트랜잭션시작-> 수정->삭제->삽입 -> 트랜잭션종료
  하나의 작업이 시작해서 정상적으로 종료될때까지의 과정을 말한다. (논리적인 작업단위)
  
  은행(ATM)->기계 카드삽입-> 기계가 카드를 읽음-> 인출금액 입력-> 비밀번호 입력-> 기계에서 출금액 처리 -> 출금금액 제공-> 카드제공
  
  <트랜잭션 시작>
  -데이터베이스에 처음 접속했을 때
  -하나 또는 여러 개의 DML문이 실행된후 commit 또는 rollback 문이 실행된 직후
  
   <트랜잭션 종료>
  - commit 또는 rollback문이 실행될때
  - DDL 또는 DCL문이 실행될 때
  - 정상적으로 데이터베이스를 종료할때
  - 비정상적으로 데이터베이스를 종료할때
  
2 트랜잭션 안전성 확보를 위한 ACID
  1) ACID정의 
     -데이터베이스에서 논리적인 작업단위인 트랜잭션이 안전하게 수행되는 것을 보장하는 특성집합
  2) ACID의 필요성
     -다중 사용자 환경 대응 :동일데이터-다중작업환경에서의 데이터 처리 정확성 보장
     -안전한 트랜잭션 수행을 통한 데이터베이스 무결성 유지
  3) 트랜잭성 구성요소   
    Atomicity(원자성):
     -트랜잭션은 한 개 이상의 동작을 논리적으로 한 개의 작업단위(single unit of work)로서 분해가 불가능한 최소의 단위
     -연산 전체가 성공적으로 처리되거나 또는 한 가지라도 실패할 경우 전체가 취소되어 무결성을 보장 (All or Nothing)
    Consistency(일관성):
    -트랜잭션이 실행을 성공적으로 완료하면 언제나 모순 없이 일관성 있는 데이터베이스 상태를 보존함
    -반복적인 수행 결과가 동일한 환경에서는 동일한 결과를 얻는 성질(관리:무결성제어기)
    Isolation(고립성,독립성):
    -트랜잭션이 실행 중에 생성하는 연산의 중간 결과를 다른 트랜잭션이 접근할 수 없음(관리:병행제어관리자)
    -팬텀충돌(phantom Conflict)현상->트랜잭션 Isolation제공
	Durability(영속성,지속성,내구성):
    -성공이 완료된 트랜잭션의 결과를 영구적으로 데이터베이스에 저장됨(관리:회복기법, 연관회복관리자)

============================================================================

commit -- 통상적으로 ; 을 찍어야한다.
INSERT INTO emp01
VALUES('Beta', 7000);

commit

INSERT INTO emp01
VALUES('John', 2000);

savepoint sp

DELETE FROM emp01
WHERE first_name='Beta';

ROLLBACK TO sp 

create table emp02(
	emp_id number primary key,
	first_name varchar2(50),
	salary number
)

SELECT * FROM emp02;
DML문을 실행하면 해당 트랜잭션에 발생한 데이터가 다른 사용자에 의해 변경이 발생하지 않도록 LOCK(잠금현상)을 발생시킨다.
이러한 현상은 commit 또는 rollback문이 실행되면 해제가 된다.

A세션
	INSERT INTO emp02 VALUES(1,'park',9000);
	SELECT * FROM emp02;
	
B세션 -- sql 콘솔창에서 실행
	INSERT INTO emp02 VALUES(1,'park',9000); -- A세션에서 입력중인 데이터는 입력할 수 없다. waiting 상태가 된다(LOCK 발생)
	

A세션
	commit

B세션
	-- ORA-00001: 무결성 제약 조건(HR.SYS_C003994)에 위배됩니다
	실행 취소됨.


-- 테이블 구조 정의
	CREATE TABLE 테이블명(
		컬럼명 자료형,
		컬럼명 자료형
	);

================================================
자료형 (DATA TYPE)
varchar2 - 가변길이 문자를 저장
char - 고정길이 문자를 저장
number(m) - 정수 저장
number(m,n) - 실수 저장 (m 총 자리수, n 소수점 자리수)
date - 날짜 저장
================================================

CREATE TABLE student(
	name varchar2(20), -- 괄호안의 인자는 바이트
	age number(3), -- 괄호안의 인자는 자리수
	avg number(5,2), -- 5는 전체 자리수, 2는 소수점 자리수
	hire date
);

-- 정상 삽입
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 97.85, sysdate);

-- '박차고 나온 세상에'(26바이트 : 크기 초과(20 바이트까지만 가능))
INSERT INTO student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30, 97.85, sysdate);

-- age 칼럼 값이 4자리 수, 크기초과(3자리까지만 가능)
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 4000, 97.85, sysdate);

-- avg 칼럼 값 크기 초과, (5자리까지만 허용) - 소수점은 포함하지 않는다.
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 2921.8589, sysdate);

-- 정상 삽입
INSERT INTO student(name, age, avg, hire)
VALUES('포동이', 30, 621.8, sysdate);

-- avg 칼럼 값 크기 초과, 소수점은 무조건 2자리로 계산 (컬럼 생성시의 자리수)
INSERT INTO student(name, age, avg, hire)
VALUES('포동이', 30, 4621.3, sysdate);

------------------------------------------------------------------
ALTER
	테이블의 구조를 변경해주는 명령어이다.
------------------------------------------------------------------
-- 테이블에 컬럼을 추가한다.
ALTER TABLE student
ADD loc varchar2(50);

-- 데이터가 삽입되어 있는 상태에서 줄일 수는 없다.
ALTER TABLE student
MODIFY name varchar2(5);

-- 테이블의 컬럼 삭제
ALTER TABLE student
DROP COLUMN hire;

-- 테이블에 컬럼명을 수정한다.
ALTER TABLE student
RENAME COLUMN avg to jumsu;

------------------------------------------------------------------
TRUNCATE : 테이블에 저장된 데이터를 모두 제거한다.(auto COMMIT이 됨)
DROP : 테이블 자체를 제거한다.
DELETE : 테이블에 저장된 데이터를 모두 삭제한다.(auto COMMIT이 안됨)
------------------------------------------------------------------
COMMIT

DELETE FROM student;

ROLLBACK

DROP TABLE student;

ROLLBACK

TRUNCATE TABLE emp01;

ROLLBACK


SELECT * FROM emp01;

---------------------------------------------------
 무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면 제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   
   무결정제약조건 5종류 : not null, unique, primary key, foreign key, check
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.

 무결성제약조건 2가지 레벨 : 컬럼레벨, 테이블레벨
---------------------------------------------------

 컬럼 레벨 설정
 CREATE TABLE emp06(
	id varchar2(10) constraint emp06_id_pk primary key, -- 컬럼단계의 제약조건 , constraint 제약조건명 제약조건 .
	name varchar2(20) constraint emp06_name_nk not null,
	age number(3) constraint emp06_age_uk check(age between 20 and 50),
	gen char(2) constraint emp06_gen_uk check(gen in ('m', 'w'))
 );
 
 -- ORA-02290: 체크 제약조건(HR.EMP06_AGE_UK)이 위배되었습니다
 INSERT INTO emp06(id, name, age, gen)
 VALUES('100', 'PARK', 15, 'm');
 
 테이블 레벨 설정 - not null은 테이블 레벨에서 설정할 수 없다.
 CREATE TABLE emp07(
 	id varchar2(10),
 	name varchar2(20) constraint emp07_name_nk not null,
 	age number(3),
 	gen char(2),
 	constraint emp07_id_pk primary key(id),
 	constraint emp07_age_uk check(age between 20 and 50),
 	constraint emp07_gen_uk check(gen in ('m', 'w'))
 );
 
 -- ORA-01400: NULL을 ("HR"."EMP07"."ID") 안에 삽입할 수 없습니다
 INSERT INTO emp07(id, name, age, gen)
 VALUES(null, 'PARK', 15, 'm');

 ---------------------------------------------------------------
 제약 조건 추가
 alter table 테이블명
 	add constraint constraint_name
 						constraint_type(column_name);
 ---------------------------------------------------------------
 
 CREATE TABLE emp08
 as
 SELECT employee_id, first_name, salary
 FROM employees
 WHERE 0 = 1;
 
 alter table emp08 add constraint emp08_employee_id_pk primary key (employee_id);
 
 INSERT INTO emp08
 VALUES (100, 'Steven', 5000);

 -- ORA-00001: 무결성 제약 조건(HR.EMP08_EMPLOYEE_ID_PK)에 위배됩니다
 INSERT INTO emp08
 VALUES (100, 'Lex', 4000);
 
 
 SELECT * FROM emp08;
 
 -------------------------------------------------------------
 데이터 딕셔너리(Data Dictionary)
  데이터베이스를 운영하기 위한 정보들을 모두 특정한 곳에 모아두고 
  관리하는데 이것을 데이터 딕셔너리라고 한다.
  데이터 딕셔너리는  메모리구조와 파일에 대한 구조정보, 
  각 오브젝트들이 사용되는 공간들의 정보, 제약조건 정보,
  사용자에 대한 정보, 권한이나 프로파일, 롤에대한 정보, 
  감사에 대한 정보들을 관리한다.
 -------------------------------------------------------------
constraint_type : primary key=>p  foregin key=>r
                  check, not null=>c
                  unique=>u
 
 SELECT * FROM user_constraints
 WHERE constraint_name like '%EMP%';
 
 SELECT * FROM user_constraints -- 제약조건 조회
 WHERE table_name like 'EMP08';
 
 SELECT * FROM user_tables; -- 시퀀스 조회
  
 SELECT * FROM user_sequences; -- 시퀀스 조회
 
 
 -------------------------------------------------------------
 제약 조건 수정
	 alter table 테이블 명
	 modify column_name constraint constraint_name constraint_type;
 -------------------------------------------------------------
 ALTER TABLE emp08
 MODIFY first_name constraint emp08_name_uk unique;

 -- ORA-00001: 무결성 제약 조건(HR.EMP08_NAME_UK)에 위배됩니다
 INSERT INTO emp08
 VALUES(200, 'Steven', 6000);
 
 -------------------------------------------------------------
 제약 조건 삭제
 	ALTER TABLE 테이블 명
 	DROP constraint constraint_name;
 -------------------------------------------------------------
 ALTER TABLE emp08
 DROP constraint emp08_name_uk;

 INSERT INTO emp08
 VALUES(200, 'Steven', 6000);

 select * FROM emp08;
 
 -------------------------------------------------------------

 create table dept01(
 	deptno number(2)
 		constraint dept01_deptno_pk primary key,
 	dname varchar2(20)
 );

 INSERT INTO dept01
 VALUES(10, 'accounting');

 INSERT INTO dept01
 VALUES(20, 'sales');
 
 INSERT INTO dept01
 VALUES(30, 'research');
 
-- desc 명령어  : SQL창에서 테이블의 구조를 확인한다.
SELECT * FROM dept01;

COMMIT


====================================================================
--20170928

CREATE TABLE loc01(
  locno number(2),
  locname varchar2(20),
  constraint loc01_locno_pk primary key(locno)
  );
  
  INSERT INTO loc01
  VALUES (11,'seoul');
  
   INSERT INTO loc01
  VALUES (22,'jeju');
  
   INSERT INTO loc01
  VALUES (33,'busan');
  
SELECT * from loc01;

CREATE TABLE emp09(
empno number(2) primary key,
deptno number(2)
         constraint emp09_deptno_fk
         references dept01(deptno),
locno number(2),
         constraint emp09_locno_fk foreign key(locno)
         references loc01(locno));
         
-- 정상삽입         
 INSERT INTO emp09
 VALUES (1,10,11);

 INSERT INTO emp09
 VALUES (2,20,22);

-- ORA-02291: 무결성 제약조건(HR.EMP09_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
 INSERT INTO emp09
 VALUES(3,40,11);
 
 INSERT INTO emp09
 VALUES(4,30,11);
-- ORA-02292: 무결성 제약조건(HR.EMP09_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
 DELETE FROM dept01
 WHERE deptno = 30;

----------------------------------------------------------
다른 테이블에서 현재 테이블을 참조해서 사용하고 있을 때는 
제약조건을 제거한 후 현재 테이블의 데이터를 삭제한다.
----------------------------------------------------------

ALTER TABLE emp09
DROP CONSTRAINT emp09_deptno_fk;

-- 정상 삭제
         DELETE FROM dept01
         WHERE deptno = 30;
         
------------------------------------------------------
자식 테이블에서 부모테이블의 데이터를 참조 하고 있을때 삭제
1. 자식 테이블의 제약조건을 제거한다.
2. 부모 테이블의 레코드를 삭제한다.
3. 자식 테이블의 레코드를 삭제한다.
4. 자식 테이블의 제약조건을 다시 설정한다.
------------------------------------------------------

DELETE FROM emp09 WHERE deptno = 30;

--------------------------------------------------------------------------------
제약조건 

on delete restrict -- dept01테이블의 deptno값이 삭제 못하게함
on update restrict --dept01테이블의 deptno값이 수정 못하게함

on delete cascade -- dept01테이블의 deptno값이 삭제되면 forgin key 도 삭제
on update cascade --dept01테이블의 deptno값이 수정되면 forgin key 도 수정
 
on delete set null-- dept01테이블의 deptno값이 삭제되면 forgin key 값은 null 수정
on update set null--dept01테이블의 deptno값이 수정되면 forgin key 값은 null 수정
 
on delete no action-- dept01테이블의 deptno값이 삭제되어도 아무런동작을 안함
on update no action --dept01테이블의 deptno값이 수정되어도 아무런 동작을 안함

--------------------------------------------------------------------------------

ALTER TABLE emp09
 add constraint emp09_deptno_fk foreign key(deptno)
 	references dept01(deptno) on delete cascade;

DELETE FROM dept01
WHERE deptno = 10;

-- 제약조건은 수정이 안되므로 삭제를한다.
ALTER TABLE emp09
drop constraint emp09_locno_fk;


-- update은 오라클(10g)에서는 할 수 없음. (트리거를 사용해야 한다.)
ALTER TABLE emp09
add constraint emp09_locno_fk foreign key(locno)
	references loc01(locno)
		on update set null;


DROP trigger loc01_tri;


-- 콘솔창에 입력 (트리거 생성)
CREATE OR REPLACE TRIGGER loc01_tri
AFTER UPDATE ON loc01 FOR EACH ROW
BEGIN
		UPDATE emp09
		SET locno = 88
		WHERE locno = 44;
END;
/
--

UPDATE loc01 SET locno = 88 WHERE locno = 44;


SELECT * FROM emp09;
SELECT * FROM dept01;
SELECT * FROM loc01;

 INSERT INTO loc01
 VALUES(44, 'inchon');
 
 INSERT INTO emp09
 VALUES(3, 20, 44);

--------------------------------------------------------------------------

 시퀀스(sequence)
   테이블 내의 유일한 숫자를 자동으로 생성하는 자동번호 발생이므로 시퀀스를
   기본 키로 사용하면 사용자의 부담을 줄일 수 있다.

   create sequence 시퀀스명
     start with  n - 시퀀스 시작번호
     increment by n  -시퀀스 증가치
     nocache  - cache는 메모리상의 시퀀스값을 관리하게 하는데 기본값이 20이다.
              - nocache은 메모리상의 시퀀스를 관리하지 않는다.
     nocycle  - cycle은 지정된 시퀀스값이 최대값까지 증가를 완료하면 start with
                옵션에 지정된 시작값에시 다시 시퀀스를 시작한다.
              - nocycle은  증가가 완료되면 에러를 유발한다.

    maxvalue n; - 시퀀스가 가질수 있는 최대값을 지정한다.
              maxvalue의 기본값은 ascending일때 1027승, descending 일때 -1이다.
              
--------------------------------------------------------------------------

CREATE TABLE emp10(
	num number,
	name varchar2(20)
);

CREATE sequence emp10_num_seq
	start with 1
	increment by 1
	nocache
	nocycle;

INSERT INTO emp10(num, name)
VALUES(emp10_num_seq.nextval, 'kim');

DELETE FROM emp10
WHERE num = 2;

SELECT * FROM emp10;

------------------------------------
자바에서 사용할 테이블 생성
------------------------------------

DROP TABLE mem;

CREATE TABLE mem(
	num number,
	name varchar2(20),
	age number(3),
	loc varchar2(10)
);

CREATE sequence mem_num_seq
	start with 1
	increment by 1
	nocache
	nocycle;
	
INSERT INTO mem
VALUES (mem_num_seq.nextval, '홍길동', 30, '서울');


SELECT * FROM mem;



