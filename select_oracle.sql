/*
 * 입사일이 1980년 1월 1일부터 1982년 12월 31일 사이이며,
 * 직업이 'SALESMAN' 또는 'CLERK'인 사원 중에서
 * comm이 null이 아닌 경우는 comm을 연봉(sal*12)에 더한 값을,
 * null인 경우는 comm을 0으로 간주한 연봉(sal*12 + NVL(comm, 0))을 계산하라.
 *
 * 조회 결과는 다음 정보를 포함한다:
 * 사번, 사원명, 직업, 입사일, 부서번호, 월 급여, 커미션, 연봉(별칭으로 표시)
 *
 * 결과는 연봉 내림차순, 같은 연봉일 경우 이름 오름차순으로 정렬
 * 이름에 'M'또는 'm'이 초함된 사원만 출력
 * 출력 시 이름은 대문자로 변환하여 출력
 * 부서번호 중복 제거 없이 출력하되, 출력 테이블 구조를 한번 확인하는 쿼리도 함께 작성
 */
SELECT empno AS "사번", ename AS "사원명", job AS "직업",
hiredate AS "입사일", sal AS "월 급여",
comm AS "커미션", sal*12+NVL(comm,0) AS "연봉"
FROM emp WHERE hiredate BETWEEN DATE '1980-01-01' AND DATE '1982-12-31'
AND job IN('SALESMAN','CLERK') AND UPPER(ename) LIKE '%M%'
ORDER BY 연봉 DESC, 사원명 asc;



/*
 * 다음 조건을 모두 만족하는 직원들의 이름(ename), 직무(job), 급여(sal), 커미션(comm), 입사일(hiredate)을 조회하시오.
 *조건: 부서번호(deptno)가 30번이며
 *급여(SAL)가 1000 이상 2500 이하이고
 *커미션(COMM)이 존재하고(IS NOT NULL), 0보다 커야 하며
 *결과는 입사일(HIREDATE) 오름차순으로 정렬할 것
 */


SELECT ename AS 이름, job AS 직무, sal AS 급여, comm AS 커미션,
hiredate AS 입사일 FROM emp WHERE deptno=30
AND job='SALESMAN' AND sal BETWEEN 1000 AND 2500
AND comm IS NOT NULL AND comm > 0
ORDER BY hiredate asc;

/*
 * 커미션이 NULL이 아닌 사원 중
 *부서번호가 30번이며, 입사일이 1980-09-01 이후인 사람만 조회
 *사원명, 부서번호, 커미션, 입사일을 출력하되
 *커미션 내림차순, 입사일 오름차순 정렬
 */

SELECT ename AS 사원명, deptno AS 부서번호, comm AS 커미션,
hiredate AS 입사일 FROM emp WHERE comm IS NOT NULL
AND deptno=30 AND hiredate > DATE '1980-09-01'
ORDER BY comm DESC, hiredate ASC;

/*
 * 이름에 'M' 또는 'm'이 포함된 사원 중,
직업이 SALESMAN 또는 CLERK이며
입사일이 1981년 이후인 사원을 조회하시오.
조회 항목은 사번, 이름(대문자), 직무, 입사일, 급여, 커미션,
연봉(sal*12 + comm, 단 null은 0 처리) 이며,
연봉이 높은 순으로 정렬하시오.
 */

SELECT empno AS 사번, ename AS 이름,
job AS 직무, hiredate AS 입사일, sal AS 급여,
comm AS 커미션, sal*12+NVL(comm,0) AS 연봉
FROM emp WHERE UPPER(ename) LIKE '%M%'
AND job IN('SALESMAN','CLERK') AND hiredate >= DATE '1981-01-01'
ORDER BY 연봉 desc;



