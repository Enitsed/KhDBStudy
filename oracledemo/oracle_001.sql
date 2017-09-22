SELECT * FROM employees;

데이터베이스 : 모아놓은 데이터의 집합
데이터베이스관리시스팀(DBMS):데이터를 관리하는 소프트웨어
Database Management System(oracle, mysql, mssql...)

database <-> DBMS(oracle) <-> SQL Tool(Database Development)
						  <-> 응용프로그램(java)
						  
member
회원번호	이름	주소			연락처			직업
001		윤아	서울시 종로구	001-5239-5232	방송인
002		경아	서울시 강남구	010-8921-523	예술인

CREATE TABLE memexample(
	num NUMBER(3),
	name VARCHAR2(30),
	address VARCHAR2(100),
	tel VARCHAR2(20),
	job VARCHAR2(15)
)

INSERT INTO memexample(num,name,address,tel,job) values(1,'윤아','서울시 종로구','001-5239-5232','방송인');

SELECT * FROM memexample;

데이터베이스의 특징
 (1) 실시간 접근성(Real-time Accessibility) : 다수의 사용자의 요구에 대해서
     처리 시간이 몇 초를 넘기지 말아야 한다는 의미이다.
 (2) 지속적인 변화(Continuos Evolution) : 데이터베이스에 저장된 데이터는
     최신 정보가 정확하게 저장되어 처리되어야 한다.
 (3) 동시 공유(Concurrent Sharing) : 동일한 데이터를 동시에 서로 다른 목적으로
     사용할 수 있어야 한다.
 (4) 내용에 대한 참조 : 데이터베이스 내에 있는 데이터 레코드들은 주소나 위치에
     의해 참조되는 것이 아니라 가지고 있는 값에 따라 참조해야 한다.

데이터베이스관리시스템
 : 기업이 지속적으로 유지 관리해야 하는 데이터의 집합을 데이터베이스(Database)라
   하며, 이러한 방대한 양의 데이터를 편리하게 저장하고 효율적으로 관리하고
   검색할 수 있는 환경을 제공해주는 시스템 소프트웨어를 데이터베이스 관리시스템
   (Database Management System)이라고 하며 일반적으로 약어로 DBMS라 부른다.
 
관계형 데이터베이스 시스템(Relational DataBase Management System)
 : 일련의 정형화된 데이터 항목의 집합체로, 데이터베이스를 만들거나 이용하기가
   쉬우며 무엇보다도 확장이 용이하다는 장점이 있다. 또한 처음 데이터베이스를
   만든 후 관련되는 응용 프로그램들을 변경하지 않고도 새로운 데이터 항목을
   데이터베이스에 추가할 수 있다는 장점이 있다.
   대표적인 RDMS로는 오라클,인포믹스, MySQL, Access, MS-SQL등이 있다.
   RDMS는 정보를 저장하기 위한 구조를 위해 테이블을 이용한다.
   테이블은 2차원 형태의 표처럼 볼수 있수 있도록 로우(ROW:행)와 
   컬럼(COLUMN:열)으로구성된다.

데이터베이스 관리시스템의 구성요소 : 저장장치(데이터사전,데이터베이스)와 
  이를 사용하기 위한 데이터베이스 관리시스템(자료정의, 질의처리, 저장관리, 
  트랜잭션관리),사용자(데이터베이스관리자, 응용프로그래머, 최종사용자)등으로 구성된다.
 
데이터베이스 시스템 사용자
 (1) 데이터베이스 관리자(DBA) : 데이터베이스 설계와 정의, 관리 및 운영등
     데이터베이스 시스템을 관리하고 제어하는 사용자이다.
 (2) 응용프로그래머(Application Programmer) : 응용 프로그래머는 데이터베이스를
     실제적으로 설계하며 최종 사용자들의 요구에 맞는 인터페이스와 응용프로그램을
     개발한다.
 (3) 최종사용자(End User) : 데이터베이스를 실질적으로 사용하는 사용자이다.

 
 -- 한라인 주석처리
 /* 여러 라인 주석처리 */
 
 도메인 : 속성(컬럼)들이 갖을 수, 값들의 집합
 컬럼(속성) : 테이블에서 관리하는 구체적인 정보 항목에 해당
 레코드(튜플) : 테이블에서 하나의 객체에 속한 구성단위
 테이블(릴레이션) : 데이터베이스에서 정보를 구분하여 저장하는 기본단위
 
 -- 테이블에서 컬럼에 해당하는 데이터를 검색하라.
SELECT column1, column2, column3
FROM table;

SELECT job_title, min_salary, max_salary
FROM jobs;

SELECT *
FROM jobs;

-- 컬럼명, 테이블에 별칭을 지정할 수 있다.
-- 별칭(alias)으로 한글이나 영문공백을 사용할 때는 "	"(따옴표)를 지정한다.
SELECT salary, salary * 10 AS "b o n u s"
FROM employees;

-- 컬럼명들을 하나의 문장처럼 출력할 때 결합연산자(||)를 사용한다.
SELECT last_name || '님의 연봉은 ' || salary || ' 입니다.' AS data
FROM employees;

-- distinct은 중복제거를 한 후 출력해주는 명령어이다.
SELECT distinct first_name
FROM employees;

SELECT distinct first_name, last_name
FROM employees;

-- SELECT 입력순서
SELECT 컬럼명, 컬럼명
FROM 테이블명
WHERE 컬럼명 = '값'
GROUP BY 컬럼명
HAVING 컬럼명 = '값'
ORDER BY 컬럼명 desc; -- 정렬 , asc 오름차순 (생략하는 경우가 많다) desc 내림차순

-- SELECT 해석순서
FROM 테이블명
WHERE 컬럼명 = '값'
GROUP BY 컬럼명
HAVING 컬럼명 = '값'
SELECT 컬럼명, 컬럼명
ORDER BY 컬럼명 desc;

-- employees테이블에서 salary이 3000미만일 때의 first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE salary < 3000; -- 조건문으로 True or False 를 반환한다.

-- employees테이블에서 first_name컬럼의 값이 'David' 일때의 --first_name, salary을 출력하시오.
SELECT first_name, salary
FROM employees
WHERE first_name = 'David'; -- 문자열은 무조건 홑따옴표, 대소문자 구분에 유의한다.

-- employees테이블에서 first_name컬럼의 값이 'David'가 아닐때의 --first_name, salary을 출력하시오.
SELECT first_name, salary
FROM employees
WHERE first_name != 'David'; -- 문자열은 무조건 홑따옴표, 대소문자 구분에 유의한다.

SELECT first_name, salary
FROM employees
WHERE first_name <> 'David'; -- 오라클에서 제공하는 연산자 <> : 다르다 (!=)와 같다.

-- employees테이블에서 salary이 3000, 9000, 17000일 때 first_name, hire_date, salary를 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary = 3000 or salary = 9000 or salary = 17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary in (3000,9000,17000); -- 같은 칼럼내에서 비교할때 in 연산자를 사용한다.

-- employees 테이블에서 salary이 3000부터 5000까지 일때의 first_name hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary >= 3000 or salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary between 3000 and 5000;

-- employees테이블에서 job_id가 'IT_PROG'이 아닐때
-- first_name, email, job_id을 출력하라.
SELECT first_name, email, job_id
FROM employees
WHERE job_id <> 'IT_PROG';

SELECT first_name, email, job_id
FROM employees
WHERE job_id != 'IT_PROG';

SELECT first_name, email, job_id
FROM employees
WHERE not (job_id = 'IT_PROG');

-- employees 테이블에서 salary이 3000부터 5000까지의 수가 아닐 때의 first_name hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE not(salary >= 3000 AND salary <= 5000);

SELECT first_name, hire_date, salary
FROM employees
WHERE salary not between 3000 and 5000;

-- employees 테이블에서 commission_pct null일 때 first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct is null; -- is 연산자를 사용한다.

-- employees 테이블에서 commission_pct null이 아닐 때 first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct is not null;

-- employees 테이블에서 first_name에 'der'이 포함이된  first_name, salary, email을 출력하라.
SELECT first_name, salary, email
FROM employees
WHERE  first_name like '%der%'; -- 일부 문자열이 포함이 된 값을 찾기 위해서는 like연산자를 사용하고 % 와일드카드를 사용한다.

-- employees 테이블에서 first_name의 값중 A로 시작하고 두번째문자는 임의의 문자이며 exander로 끝나는 first_name, salary, email을 출력하라.
SELECT first_name, salary, email
FROM employees
WHERE first_name like 'A_exander'; -- 임의의 문자를 의미하는 와일드카드는 _ 이다.

/*
WHERE 절에서 사용된 연산자 3가지 종류
1 비교연산자 : = > >= < <= != <> ^=, NOT 컬럼명 =
2 SQL연산자 : BETWEEN a AND b, IN, LIKE, IS NULL
3 논리연산자 : AND, OR, NOT

우선순위
1 괄호()
2 not연산자
3 비교연산자, SQL연산자
4 AND
5 OR
 */

-- employees 테이블에서 job_id를 오름차순으로 first_name, email, job_id를 출력하시오
SELECT first_name, email, job_id
FROM employees
ORDER BY job_id asc;


-- employees 테이블에서 department_id를 오름차순으로 first_name을 내림차순으로 department_id, first_name, salary를 출력하시오
SELECT department_id, first_name, salary
FROM employees
ORDER BY department_id asc, first_name desc; -- 각 절에서 여러개를 나열할 때 , 으로 구분한다.

-- employees 테이블에서 최근 입사 순으로 first_name, salary, hire_date를 출력하시오
SELECT first_name, salary, hire_date
FROM employees
ORDER BY hire_date desc;

-- employees 테이블에서 직업(job_id)이 'FI_ACCOUNT'인 사원들의 연봉(salary)이 높은 순으로 first_name, job_id, salary를 출력하시오
SELECT first_name, job_id, salary
FROM employees
WHERE job_id = 'FI_ACCOUNT'
ORDER BY salary desc;


========================================

집합연산자
 - 둘 이상의 query결과를 하나의 결과로 조합한다.
 - select의 인자 갯수가 같아야한다. select가 2개이면 두번째 select도 2개여야 한다.
 - 타입이 일치해야 한다.. 에를 들어 character이면 character이여야 한다.
 
집합연산자 종류
 union(합집합) - 중복행이 제거된 두 query
 union all(합집합) - 중복행이 포함된 두 query
 intersect(교집합) - 두 query에 공통적인 행
 minus(차집합) - 첫번째 query에 있는 행 중 두번째 query에 없는 행 표시
 
집합연산자 사용이유
 - 서로 다른 테이블에서 유사한 형태의 결과를 반환하기 위해서
 - 서로 같은 테이블에서 서로 다른 질의를 수행하여 결과를 합치기 위해서
 
========================================================

-- union(합집합)
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 40
union
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 60;

-- intersect(교집합)
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 40
intersect
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 60;

-- minus(차집합)
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 40
minus
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 or department_id = 60;

======================================================
SQL (Structured Query Language) 함수
1. 단일행 함수: 행 하나당 하나의 결과를 출력한다.
			(문자 함수, 숫자 함수, 날짜 함수, 변환 함수, 일반 함수)
2. 복수행 함수: 행 여러개당 하나의 결과를 출력한다.
			(합계, 평균, 최대, 최소, 갯수)
======================================================

-- select문에서는 반드시 테이블 명을 명시해야한다.
-- 하지만 select절에 식이나 특정 함수를 이용해서 결과값을 가져올때 사용 할 수 있는 dual이라는 테이블을 제공하고 있다.

SELECT 3+2
FROM dual;

SELECT sysdate
FROM dual;

SELECT sysdate, 3+2
FROM dual;

-- 문자 함수
-- 단어의 첫글자만 대문자로 변경해주는 함수이다.
SELECT initcap('korea hello')
FROM dual;

SELECT upper('korea')
FROM dual;

SELECT 	first_name, upper(first_name),
		last_name, upper(last_name)
FROM employees;
-- SELECT 명령어와 함께 실행할 시에 데이터의 변경은 이루어지지 않는다.

-- 모든 문자를 소문자로 변경해주는 함수이다.
SELECT lower('KOREA')
FROM dual;

SELECT	first_name, lower(first_name)
		last_name, lower(last_name)
FROM employees;

-- employees 테이블에서 first_name에서 대소문자 구분없이 'Ja'가 포함이 된 first_name, salary를 출력하라.
SELECT first_name, salary
FROM employees
WHERE lower(first_name) like lower('%Ja%');

-- 문자의 길이를 리턴해주는 함수이다.
SELECT length('korea')
FROM dual;

SELECT length('한국')
FROM dual;

-- 문자의 길이를 바이트로 구해서 리턴해주는 함수이다.
SELECT lengthb('korea') -- 함수 뒤에 b가 붙으면 byte를 의미한다.
FROM dual;

SELECT lengthb('한국')
FROM dual;

CREATE TABLE user1(
	data varchar2(5)
);

INSERT INTO user1(data)
VALUES('korea');

INSERT INTO user1(data)
VALUES('한국'); -- ORA-12899: "HR"."USER1"."DATA" 열에 대한 값이 너무 큼(실제: 6, 최대값: 5)
-- 한글은 글자 하나당 3바이트를 차지한다.

SELECT *
FROM user1;

-- 특정범위의 문자를 추출 해주는 함수이다.
-- substr('문자위치', 시작위치, 갯수)
SELECT substr('oracle test', 2, 4) -- 오라클에서는 인덱스가 1부터 시작한다.
FROM dual;

SELECT substr('오라클 테스트', 4, 4) -- 갯수에 공백도 포함이 된다.
FROM dual;

SELECT substrb('oracle test', 2, 4)
FROM dual;

SELECT substrb('오라클 테스트', 4, 4) -- 해당 범위내 바이트에서 완전하게 표현할 수 있는 문자만 표시가 된다.
FROM dual;

-- 특정 문자의 인덱스를 추출해주는 함수이다.
SELECT instr('korea', 'or') -- 2 리턴
FROM dual;

SELECT instr('한국자바', '자') -- 3 리턴
FROM dual;

-- 특정문자의 바이트 인덱스를 추출해주는 함수이다.
SELECT instrb('korea', 'or') -- 2 리턴
FROM dual;

SELECT instrb('한국자바', '자') -- 7 리턴
FROM dual;

-- 주어진 문자열에서 왼쪽으로 특정 문자를 채우는 함수이다.
SELECT lpad('korea', 8, '*')
FROM dual;

-- 주어진 문자열에서 오른쪽으로 특정 문자를 채우는 함수이다.
SELECT rpad('korea', 8, '*')
FROM dual;

-- 주어진 문자열에서 왼쪽의 특정 문자를 삭제하는 함수이다.
SELECT ltrim('***korea', '*')
FROM dual;

-- 주어진 문자열에서 오른쪽의 특정 문자를 삭제하는 함수이다.
SELECT rtrim('korea***', '*')
FROM dual;

-- 주어진 문자열에서 특정문자를 다른 문자로 변경해주는 함수이다.
SELECT replace('oracle test', 'test', 'sample')
FROM dual;

--------------------------------------
숫자함수
--------------------------------------

-- 3.55을 소수점 1의 자리까지 구하시오(반올림)
SELECT round(3.55, 1)
FROM dual;

-- 2535.598을 십의 자리까지 구하시오(반올림)	
SELECT round(2535.598, -1)
FROM dual;

-- 256.78을 무조건 올림한다. (올림)
SELECT ceil(256.78) -- 자리수 지정 없음
FROM dual;

-- 289.78에서 소수 이하는 무조건 버린다.(버림)
SELECT floor(289.78) -- 자리수 지정 없음
FROM dual;

-- 2의 3승 (거듭제곱)
SELECT power(2, 3)
FROM dual;

-- 25의 제곱근
SELECT sqrt(25)
FROM dual;

-- 나머지
SELECT mod(10, 3)
FROM dual;

----------------------------------------
날짜함수
----------------------------------------

-- 현재 시스템에서 제공해주는 오늘의 날짜 구하는 함수
SELECT sysdate -- 2017-09-22
FROM dual;

-- 첫번째 인자의 달에 두번째 인자값을 더한 날짜를 반환
SELECT add_months(sysdate, 10) -- 2018-07-22
FROM dual;

-- 두 날짜 월의 차를 반환. 앞에 있는 값이 크면 +로 리턴하고 반대이면 -로 리턴
SELECT months_between('2013-01-01', '2013-09-30') -- - 리턴
FROM dual;

-- 첫번째 인자를 기준으로 앞으로 다가올 날짜를 두번째에서 지정한 요일의 날짜를 구함
SELECT next_day(sysdate, '일요일') -- 2017-09-24
FROM dual;

-- 현재 날짜를 기준으로 달의 마지막 일을 구함
SELECT last_day(sysdate) -- 2017-09-30
FROM dual;

숫자		->		문자		<-		날짜
	to_char()			to_char()

숫자		<-		문자		->		날짜
	to_number()			to_date()

--------------------------
to_char()
1 숫자->문자
2 날짜->문자
--------------------------

-- 숫자 -> 문자
-- 첫번째 인자값을 두번째 인자값의 형식으로 변환해주는 함수
SELECT to_char(2532, '999,999.99')
FROM dual; -- 리턴     2,532.00

SELECT to_char(2532, '009,999.00')
FROM dual; -- 리턴  002,532.00
-- 인자값의 형식이 '9'일때와 '0'일때의 결과값이 다르다.

-- 각 나라의 통화를 표현해 줄 때 L기호를 사용한다.
SELECT to_char(2532, 'L999,999.99')
FROM dual; -- 리턴           ￦2,532.00

-- 날짜 -> 문자
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss day')
FROM dual; -- 리턴  2017-09-22 06:04:51 금요일

SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss dy')
FROM dual; -- 리턴  2017-09-22 06:05:33 금

SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss dy')
FROM dual; -- 리턴  2017-09-22 18:06:29 금

SELECT to_char(sysdate, 'yyyy-mon-dd hh24:mi:ss dy')
FROM dual; -- 리턴  2017-9월 -22 18:07:00 금






