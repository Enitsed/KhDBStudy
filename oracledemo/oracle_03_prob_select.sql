1)EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
  <출력: 월        직원수   >
SELECT to_char(hire_date, 'mm') as "월", count(*) as "직원수"
FROM employees
GROUP BY to_char(hire_date, 'mm')
ORDER BY to_char(hire_date, 'mm');

2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
SELECT nvl(department_name, '<미배치인원>'), count(*)
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
GROUP BY d.department_name
HAVING count(*) <= 5
ORDER BY count(*) desc;

3)각 부서 이름 별로 1995년 이전에 입사한 직원들의 인원수를 조회하시오.(결과 11행)
 <출력 :    부서명		입사년도	인원수  >
SELECT d.department_name as "부서명", to_char(hire_date, 'yyyy') as "입사년도", count(*) as "인원수"
FROM departments d, employees e
WHERE d.department_id = e.department_id
AND to_char(hire_date, 'yyyy') < '1995'
GROUP BY d.department_name, to_char(e.hire_date, 'yyyy')
ORDER BY d.department_name;

4)직책(job_title)이 'Manager' 인 사람의 이름(first_name), 직책(job_title), 부서명(department_name)을 조회하시오.
SELECT e.first_name, j.job_title, d.department_name
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
AND j.job_title LIKE '%Manager';

5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
 <출력 : 부서번호 직원명  관리자명  >
 SELECT e.department_id AS "부서번호", e.first_name AS "직원명", e2.first_name AS "관리자명"
 FROM employees e, employees e2, departments d
 WHERE e.department_id = d.department_id
 AND e2.employee_id(+) = e.manager_id
 AND d.department_name = 'Executive';
 
6)department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오.
  SELECT d.department_name, l.city
  FROM locations l, departments d
  WHERE l.location_id = d.location_id
  AND d.department_id = 60;
  
  SELECT city -- 속도가 더 빠르다
  FROM locations
  WHERE location_id = (SELECT location_id FROM departments WHERE department_id = 60);
    
7)사번이 107인 사람과 부서가같고,167번의 연봉보다 많은 사람들의 사번,이름,성,연봉를 출력하시오.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE employee_id = 107)
AND salary > (SELECT salary FROM employees WHERE employee_id = 167);

8) 연봉평균보다 연봉을 적게받는 사람들중 커미션을 받는 사람들의 사번,이름(first_name),연봉,커미션 퍼센트를 출력하시오.
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE salary < (SELECT avg(salary) FROM employees)
AND commission_pct is not null;
    
9)각 부서의 최소연봉이 20번 부서의 최소연봉보다 많은 부서의 번호와 그부서의 최소연봉를 출력하시오.
SELECT department_id, min(salary)
FROM employees
WHERE (SELECT min(salary) FROM employees) > (SELECT min(salary) FROM employees WHERE department_id = 20)
GROUP BY department_id;
    