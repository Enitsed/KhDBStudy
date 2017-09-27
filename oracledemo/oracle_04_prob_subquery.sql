1)department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오.
SELECT department_id, city
FROM departments d, locations l
WHERE d.location_id = l.location_id
AND department_id = 60;
    
2)사번이 107인 사람과 부서가같고,167번의 연봉보다 많은 사람들의 사번,이름,성,연봉를 출력하시오.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE employee_id = 107)
AND salary > (SELECT salary FROM employees WHERE employee_id = 167);
    
3) 연봉평균보다 연봉을 적게받는 사람들중 커미션을 받는 사람들의 사번,이름(first_name),연봉,커미션 퍼센트를 출력하시오.
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE salary < (SELECT avg(salary) FROM employees)
AND commission_pct is not null;

4)각 부서의 최소연봉이 20번 부서의 최소연봉보다 많은 부서의 번호와 그부서의 최소연봉를 출력하시오.
SELECT department_id, min(salary)
FROM employees e
GROUP BY department_id
HAVING min(salary) > (SELECT min(salary) FROM employees WHERE department_id = 20)
ORDER BY department_id;

5) 사원번호가 177인 사원과 담당 업무가 같은 사원의 사원이름(first_name)과 담당업무(job_id)하시오.
SELECT first_name, job_id
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 177);

6) 최소 급여를 받는 사원의 이름(first_name), 담당 업무(job_id) 및 연봉(salary)를 표시하시오(그룹함수 사용).
SELECT first_name, job_id, salary
FROM employees
WHERE salary = (SELECT min(salary) FROM employees);

7)평균 연봉이 가장 적은 사원의 담당 업무(job_id)를 찾아 담당 업무(job_id)과 평균 연봉를 표시하시오.
SELECT job_id, avg(salary)
FROM employees e
WHERE salary < all (SELECT min(salary) FROM employees GROUP BY job_id)
GROUP BY job_id
ORDER BY job_id;

8) 각 부서의 최소 연봉를 받는 사원의 이름(first_name), 연봉(salary), 부서번호(department_id)를 표시하시오.
SELECT first_name, salary, department_id
FROM employees e
WHERE salary = (SELECT min(salary) FROM employees WHERE department_id = e.department_id GROUP BY department_id)
ORDER BY department_id;

9)담당 업무가 프로그래머(IT_PROG)인 모든 사원보다 연봉이 적으면서 
업무가 프로그래머(IT_PROG)가 아닌 
사원들의 사원번호(employee_id), 이름(first_name), 
담당 업무(job_id), 연봉(salary))하시오.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary < all (SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

10)부하직원이 없는 모든 사원의 이름을 표시하시오
SELECT first_name
FROM employees e
WHERE not exists (SELECT '부하직원이 있는 사원' FROM employees WHERE manager_id = e.employee_id)
