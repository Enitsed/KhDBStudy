1) 모든사원에게는 상관(Manager)이 있다. 하지만 employees테이블에 유일하게 상관이
   없는 로우가 있는데 그 사원(CEO)의 MGR컬럼값이 NULL이다. 상관이 없는 사원을
   출력하되 MGR컬럼값 NULL 대신 CEO로 출력하시오.
    SELECT manager_id, 
           nvl(to_char(manager_id),'CEO') as "MGR" 
	FROM employees
    ORDER BY manager_id desc;

2) 가장최근에 입사한 사원의 입사일과 가장오래된 사원의 입사일을 구하시오.
   SELECT max(hire_date), min(hire_date) 
   FROM employees;
 
3) 부서별로 커미션을 받는 사원의 수를 구하시오.
   SELECT count(commission_pct),department_id 
   FROM employees 
   GROUP BY department_id
   ORDER BY department_id;
   
4) 부서별 최대연봉이 10000이상인 부서만 출력하시오.   
   SELECT department_id,max(salary) 
   FROM employees 
   GROUP BY department_id
   HAVING max(salary)>=10000
   ORDER BY department_id;

5) employees 테이블에서 직종이 'IT_PROG'인 사원들의 연봉평균을 구하는 SELECT문장을 기술하시오
    SELECT avg(salary)   
    FROM employees  
    WHERE job_id = 'IT_PROG';

6) employees 테이블에서 직종이 'FI_ACCOUNT' 또는 'AC_ACCOUNT' 인 사원들 중 최대연봉을  구하는    SELECT문장을 기술하시오   
    SELECT max(salary)    
    FROM employees 
    WHERE job_id = 'FI_ACCOUNT' 
     OR job_id='AC_ACCOUNT';

7) employees 테이블에서 50부서의 최소연봉를 출력하는 SELECT문장을 기술하시오
    SELECT min(salary) 
    FROM employees 
    WHERE department_id = 50;
    
8) employees 테이블에서 아래의 결과처럼 입사인원을 출력하는 SELECT문장을 작성하여라
   <출력:  1987		1989		1990
   	   2              1              1   >
   		   
  SELECT sum(decode(to_char(hire_date, 'yyyy'), '1987',1,0)) as "1987",
         sum(decode(to_char(hire_date, 'yyyy'), '1989',1,0)) as "1989",
         sum(decode(to_char(hire_date, 'yyyy'), '1990',1,0)) as "1990" 
  FROM employees;
    
9) employees 테이블에서 각 부서별 인원이 10명 이상인 부서의 부서코드,
  인원수,연봉의 합을 구하는  SELECT문장을 작성하여라
   SELECT department_id, count(*), sum(salary) 
   FROM employees
   GROUP BY department_id
   HAVING count(*) >= 10;   
   
   
   
   