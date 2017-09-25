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








