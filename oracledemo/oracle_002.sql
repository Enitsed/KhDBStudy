===========================================================================================================================
조인(join) : 두개 이상의 테이블에서 원하는 데이터를 추출해주는 쿼리문이다.
join은 oracle 제품에서 사용되는 oracle용 join이 있고 모든 제품에서 공통적으로 사용되는 표준(ansi) join이 있다.
===========================================================================================================================

1. cartesian product(카티션 곱) 조인 :
	테이블 행의 개수만큼 출력해주는 조인이다.
	
	employees테이블의 행의 갯수가 10이고, jobs 테이블의 행의 갯수가 5개이면 총 50개의 결과를 출력한다.
	
	(1) oracle용 cartesian product
	SELECT e.department_id, e.first_name, e.job_id, j.job_title -- 테이블에 alias를 통하여 원하는 칼럼을 선택할 수 있다.
	FROM employees e, jobs j; -- 두 테이블을 쉼표로 구분한다.
  
	(2) ansi용 cartesian product(cross join)
	SELECT e.department_id, e.first_name, e.job_id, j.job_title
	FROM employees e cross join jobs j; -- 쉼표 대신에 cross join 명령을 사용한다.
  
2. equi join :
	가장 많이 사용되는 조인 방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결하여 결과를 생성하는 방법이다.
	
	(1)oracle용 equi join
	SELECT e.department_id, e.first_name, e.job_id, j.job_title
	FROM employees e, jobs j
	WHERE e.job_id = j.job_id; -- = 연산자를 사용하여 join한다.

	(2)ansi용 equi join(inner join)
	SELECT e.department_id, e.first_name, e.job_id, j.job_title
	FROM employees e inner join jobs j
	ON e.job_id = j.job_id;
	
	-- employees와 departments 테이블에서 사원번호(employee_id), 부서번호(department_id), 부서명(department_name)을 검색하시오.
	SELECT e.employee_id, e.department_id, d.department_name
	FROM employees e, departments d
	WHERE e.department_id = d.department_id;
	
	-- employees와 jobs테이블에서 사원번호(employee_id), 직업번호(job_id), 직업명(job_title)을 검색하시오.
	SELECT e.employee_id, e.job_id, j.job_title
	FROM employees e, jobs j
	WHERE e.job_id = j.job_id;
	
	-- job_id가 'FI_MGR'인 사원이 속한 연봉(salary)의 최소값(min_salary), 최대값(max_salary)을 출력하시오(결과 1행)
	SELECT e.salary, j.min_salary, j.max_salary
	FROM employees e, jobs j
	WHERE (e.job_id = j.job_id)
	AND e.job_id = 'FI_MGR';
	
	-- 부서가 'Seattle'에 있는 부서에서 근무하는 직원들의 first_name, hire_date, department_name, city 출력하는 SELECT문장을 작성하여라(결과 18행)
	SELECT e.first_name, e.hire_date, d.department_name, l.city
	FROM employees e, departments d, locations l
	WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.city = 'Seattle';
	
	-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름을 출력하시오(결과 2행)
	SELECT d.department_name, e.first_name
	FROM departments d, employees e
	WHERE d.department_id = e.department_id
	AND d.department_id = 20;
	
	-- 1400, 1500번 위치의 도시 이름과 그곳에 있는 부서의 이름을 출력하시오(결과 2행)
	SELECT l.city, d.department_name
	FROM locations l, departments d
	WHERE l.location_id = d.location_id
	AND	l.location_id in (1400, 1500);
	
  SELECT employee_id, department_id FROM employees;
  SELECT department_id, department_name FROM departments;

3. NATURAL JOIN
	NATURAL JOIN은 두 테이블 간의 동일한 이름을 갖는 모든 칼럼들에 대해 EQUI(=) JOIN을 수행한다. NATURAL JOIN이 명시되면,
	추가로 USING 조건절, ON 조건절, WHERE 절에서 JOIN 조건을 정의할 수 없다.
	그리고 SQL SERVER에서는 지원하지 않는 기능이다.
	<공통적인 컬럼이 존재해야 한다>
	SELECT first_name, salary, department_id, department_name
	FROM employees natural join departments; (O)
	
	<Alias나 테이블명과 같은 접두사를 붙일 수 없음>
	SELECT e.first_name, e.salary, d.department_id, d.department_name
	FROM employees e natural join departments d; (X)
	
4. non_equi join
	(=)연산자를 제외한 >=, <=, >, < 등의 연산자를 이용해서 조건을 지정하는 조인방법이다.
	
	(1) oracle용 non_equi join
	SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
	FROM employees e, jobs j
	WHERE e.job_id = j.job_id
	AND e.salary >= j.min_salary
	AND e.salary <= j.max_salary;

	(2) ansi용 non_equi join
	SELECT e.first_name, e.salary, j.min_salary, j.max_salary, j.job_title
	FROM employees e join jobs j
	ON e.job_id = j.job_id
	AND e.salary >= j.min_salary
	AND e.salary <= j.max_salary;

5. outer join
	한쪽 테이블에는 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에 데이터가 있는 테이블의 내용을 모두 가져오는 조인이다.
	1) oracle용 outer join
	SELECT e.first_name, e.employee_id, d.department_id, e.department_id
	FROM employees e , departments d
	WHERE e.department_id = d.department_id(+) /* LEFT OUTER JOIN */
	ORDER BY e.department_id;
	
	SELECT e.first_name, e.employee_id, d.department_id, e.department_id
	FROM employees e , departments d
	WHERE e.department_id(+) = d.department_id /* RIGHT OUTER JOIN */
	ORDER BY e.department_id;

	-- 오라클에서는 full outer join 이 지원되지 않는다.
	
	2) ansi용 outer join
	SELECT e.first_name, e.employee_id, d.department_id, e.department_id
	FROM employees e left outer join departments d /* LEFT OUTER JOIN */
	ON e.department_id = d.department_id
	ORDER BY e.department_id;
	
	SELECT e.first_name, e.employee_id, d.department_id, e.department_id
	FROM employees e right outer join departments d /* RIGHT OUTER JOIN */
	ON e.department_id = d.department_id
	ORDER BY e.department_id;

	SELECT e.first_name, e.employee_id, d.department_id, e.department_id
	FROM employees e full outer join departments d /* FULL OUTER JOIN */
	ON e.department_id = d.department_id
	ORDER BY e.department_id;

6. self join
	하나의 테이블을 두개의 테이블로 설정해서 사용하는 조인방법이다.
	
	1) oracle용 self join
	SELECT e.employee_id as "사원번호",
			e.first_name as "사원이름",
			e.manager_id as "관리자번호",
			m.first_name as "관리자이름"
	FROM employees e, employees m
	WHERE e.manager_id = m.employee_id;
	
	2) ansi용 self join
	SELECT e.employee_id as "사원번호",
			e.first_name as "사원이름",
			e.manager_id as "관리자번호",
			m.first_name as "관리자이름"
	FROM employees e join employees m
	ON e.manager_id = m.employee_id;

--------------------------------------------------------------- 
서브쿼리(subquery)

 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다.
 서브쿼리는 알려지지 않은 기준을 이용한 검색을 위해 사용한다.
 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다. 
 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인방식으로 변환하거나 함수, 스칼라 서브쿼리(scarar subquery)등을 사용해야 한다. 
 조인은 집합간의 곱(Product)의 관계이다. 
 즉, 1:1 관계의 테이블이 조인하면 1(= 1 * 1) 레벨의 집합이 생성되고, 
  1:M 관계의 테이블을 조인하면 M(= 1 * M) 레벨의 집합이 생성된다. 
 그리고 M:N 관계의 테이블을 조인하면 MN(= M * N) 레벨의 집합이 결과로서 생성된다. 
 예를 들어, 조직(1)과 사원(M) 테이블을 조인하면 결과는 사원 레벨(M)의 집합이 생성된다. 
 그러나 서브쿼리는 서브쿼리 레벨과는 상관없이 항상 메인쿼리 레벨로 결과 집합이 생성된다. 
 예를 들어, 메인쿼리로 조직(1), 서브쿼리로 사원(M) 테이블을 사용하면 결과 집합은 조직(1) 레벨이 된다.
 SQL문에서 서브쿼리 방식을 사용해야 할 때 잘못 판단하여 조인 방식을 사용하는 경우가 있다.
 예를 들어, 결과는 조직 레벨이고 사원 테이블에서 체크해야 할 조건이 존재한다고 가정하자. 
 이런 상황에서 SQL문을 작성할 때 조인을 사용한다면 결과 집합은 사원(M) 레벨이 될 것이다. 
 이렇게 되면 원하는 결과가 아니기 때문에 SQL문에 DISTINCT를 추가해서 결과를 다시 조직(1) 레벨로 만든다. 
 이와 같은 상황에서는 조인 방식이 아니라 서브쿼리 방식을 사용해야 한다. 
 메인쿼리로 조직을 사용하고 서브쿼리로 사원 테이블을 사용하면 결과 집합은 조직 레벨이 되기 때문에 원하는 결과가 된다.

외부 쿼리 (메인쿼리)
 :일반 쿼리를 의미합니다.
스칼라 서브쿼리
 :SELECT 절에 쿼리가 사용되는 경우로, 함수처럼 레코드당 정확히 하나의 값만을 반환하는 서브쿼리입니다.
인라인 뷰
 :FROM 절에 사용되는 쿼리로, 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회할 때 사용합니다.


서브쿼리를 사용할 때 다음 사항에 주의
  서브쿼리를 괄호로 감싸서 사용한다. 
  서브쿼리는 단일 행(Single Row) 또는 복수 행(Multiple Row) 비교 연산자와 함께 사용 가능하다. 
  단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다. 
  서브쿼리에서는 ORDER BY를 사용하지 못한다. 
  ORDER BY절은 SELECT절에서 오직 한 개만 올 수 있기 때문에 ORDER BY절은 메인쿼리의 마지막 문장에 위치해야 한다.
  

서브 쿼리 사용가능한 위치
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT문의 VALUES,
UPDATE문의 SET, CREATE문

서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류할 수 있다.
1 동작하는 방식에 따른 서브쿼리 분류
  Un-Correlated(비연관) : 서브쿼리가 메인쿼리 컬럼을 가지고 있지 않는 형태의 서브쿼리이다.
          메인쿼리에 값(서브쿼리가 실행된 결과)를 제공하기 위한 목적으로  주로 사용한다.
  Correlated(연관) : 서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리이다.
          일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인
	  하고자 할 때 주로 사용된다.
2 반환되는 데이터의 형태에 따른 서브쿼리 종류
  Single Row(단일행 서브쿼리) : 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다. 
          단일행 서브쿼리는 단일 행 비교 연산자와 함께 사용된다.
	  단일 행 비교 연산자는 =, <, <=, >, >=, <>이 있다.
  Multi Row(다중행 서브쿼리) : 서브쿼리의 실행 결과가 여러 건인 서브쿼리를 의미한다. 
          다중 행 서브쿼리는 다중 행 비교 연산자와 함께 사용된다. 
	  다중 행 비교 연산자에는 in, all, any, some, exists가 있다.
	      in : 메인쿼리의 비교조건('='연산자로 비교할 경우)이 서브쿼리의 결과 중에서
               하나라도 일치하면 참이다.
           any,some : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면
                참이다.
           all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참이다.
           exists : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도
               존재하면 참이다.
  Multi Column(다중칼럼 서브쿼리) : 서브쿼리의 실행 결과로 여러 컬럼을 반환한다.
          메인쿼리의 조건절에 여러 컬럼을 동시에 비교할 수 있다. 
	  서브쿼리와 메인쿼리에서 비교하고자 하는 컬럼 갯수와 컬럼의 위치가 동일해야 한다.
--------------------------------------------------------------- 






