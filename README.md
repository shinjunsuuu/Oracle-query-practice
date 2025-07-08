# Oracle-query-practice
Oracle DB 쿼리문 연습 예제입니다.


## 👥 Team Members

| | 이름  | GitHub |
|--|------|--------|
| <img src="https://github.com/Hyunsoo1998.png" width=40/> | 김현수 | [@Hyunsoo1998](https://github.com/Hyunsoo1998) | 
| <img src="https://github.com/0-zoo.png" width="40"/> | 이영주 | [@0-zoo](https://github.com/0-zoo) |
| <img src="https://github.com/shinjunsuuu.png" width="40"/> | 신준수 | [@shinjunsuuu](https://github.com/shinjunsuuu) |
| <img src="https://github.com/Minkyoungg0.png" width="40"/> | 문민경 | [@Minkyoungg0](https://github.com/Minkyoungg0) |


# 📘 SQL 조건 문제 미니 프로젝트

> 실무에서 자주 활용되는 SQL 조건문 작성 능력을 기르기 위한 미니 프로젝트입니다.  
Oracle DB의 EMP 테이블을 기준으로, 다양한 조건을 조합해 복잡한 조회 쿼리를 설계하고 주석 기반 문제 정의를 연습했습니다.

<br>

## ✅ 프로젝트 목적

- 실무에서 자주 쓰이는 `WHERE`, `ORDER BY`, `NVL`, `TO_DATE`, `UPPER`, `LIKE` 등의 SQL 문법 연습
- 요구사항 기반 문제 정의 → 주석으로 SQL 조건 정리 → 쿼리 작성 흐름 경험
- 복잡한 조건과 정렬, 출력 항목 설계를 연습하며 SQL 문장 구성 능력 강화

<br>

## 🗂️ 문제 구성

- 총 4문제, 주석 기반 문제 정의
- 모두 EMP 테이블을 기준으로 작성 (Oracle SQL 문법 기준)
- 각 문제는 `출력 항목`, `조건`, `정렬`을 명확하게 구분하여 정의

<br>

## 🔍 문제 목록

### 💡 문제 1: 이름에 M 포함 + 특정 직업군 + 연봉 계산
```
/****************************************************************************************
 * 출력 항목
 * - 사번(empno)
 * - 사원명(ename, 대문자 변환)
 * - 직업(job)
 * - 입사일(hiredate)
 * - 부서번호(deptno)
 * - 월급여(sal)
 * - 커미션(comm)
 * - 연봉(sal*12 + NVL(comm, 0)) AS annual_salary
 *
 * 조건
 * - 입사일이 1980년 1월 1일부터 1982년 12월 31일 사이
 * - 직업이 'SALESMAN' 또는 'CLERK'
 * - 이름에 'M' 또는 'm'이 포함된 사원만 조회
 *
 * 정렬
 * - 연봉 내림차순
 * - 연봉이 같을 경우 이름 오름차순
 ****************************************************************************************/
```

<details>
<summary>✅ 정답 보기</summary>

```sql
SELECT empno,
       UPPER(ename)             AS ename,
       job,
       hiredate,
       deptno,
       sal,
       comm,
       sal * 12 + NVL(comm, 0)  AS annual_salary
FROM   emp
WHERE  hiredate BETWEEN TO_DATE('1980-01-01', 'YYYY-MM-DD') AND TO_DATE('1982-12-31', 'YYYY-MM-DD')
  AND  job IN ('SALESMAN', 'CLERK')
  AND  (ename LIKE '%M%' OR ename LIKE '%m%')
ORDER BY annual_salary DESC,
         ename ASC;
```

</details>

---

### 💡 문제 2: 커미션이 존재하는 부서 10번 사원 조회
```
/****************************************************************************************
 * 출력 항목
 * - 사원명(ename)
 * - 부서번호(deptno)
 * - 커미션(comm)
 * - 입사일(hiredate)
 *
 * 조건
 * - 부서번호가 10번
 * - 커미션이 NULL이 아님
 * - 입사일이 1981년 9월 1일 이후
 *
 * 정렬
 * - 커미션 내림차순
 * - 커미션이 같을 경우 입사일 오름차순
 ****************************************************************************************/
```

<details>
<summary>✅ 정답 보기</summary>

```sql
SELECT ename,
       deptno,
       comm,
       hiredate
FROM   emp
WHERE  deptno   = 10
  AND  comm    IS NOT NULL
  AND  hiredate > TO_DATE('1981-09-01','YYYY-MM-DD')
ORDER  BY comm DESC,
          hiredate ASC;
```

</details>

---

### 💡 문제 3: 부서 30번의 특정 조건을 만족하는 SALESMAN 조회
```
/****************************************************************************************
 * 출력 항목
 * - 사번(empno)
 * - 사원명(ename)
 * - 직업(job)
 * - 입사일(hiredate)
 * - 부서번호(deptno)
 * - 월급여(sal)
 * - 커미션(comm)
 *
 * 조건
 * - 부서번호가 30번
 * - 직업이 'SALESMAN'
 * - 급여(sal)가 1,000 이상 2,500 이하
 * - 커미션이 NULL이 아니고 0보다 큼
 *
 * 정렬
 * - 입사일 오름차순
 ****************************************************************************************/
```

<details>
<summary>✅ 정답 보기</summary>

```sql
SELECT empno,
       ename,
       job,
       hiredate,
       deptno,
       sal,
       comm
FROM   emp
WHERE  deptno = 30
  AND  job    = 'SALESMAN'
  AND  sal BETWEEN 1000 AND 2500
  AND  comm IS NOT NULL
  AND  comm  > 0
ORDER  BY hiredate ASC;
```

</details>

---

### 💡 문제 4: 이름에 M 포함 + 1982년 이후 입사자 + 연봉 기준 정렬
```
/****************************************************************************************
 * 출력 항목
 * - 사번(empno)
 * - 사원명(ename, 대문자 변환)
 * - 직업(job)
 * - 입사일(hiredate)
 * - 월급여(sal)
 * - 커미션(comm)
 * - 연봉(sal*12 + NVL(comm, 0)) AS annual_salary
 *
 * 조건
 * - 이름에 'M' 또는 'm'이 포함됨
 * - 직업이 'SALESMAN' 또는 'CLERK'
 * - 입사일이 1982년 1월 1일 이후
 *
 * 정렬
 * - 연봉 내림차순
 ****************************************************************************************/
```

<details>
<summary>✅ 정답 보기</summary>

```sql
SELECT empno,
       UPPER(ename)                 AS ename,
       job,
       hiredate,
       sal,
       comm,
       sal*12 + NVL(comm,0)         AS annual_salary
FROM   emp
WHERE  (ename LIKE '%M%' OR ename LIKE '%m%')
  AND  job IN ('SALESMAN','CLERK')
  AND  hiredate >= TO_DATE('1982-01-01','YYYY-MM-DD')
ORDER  BY annual_salary DESC;
```

</details>

---

<br>

## 📝 정리 및 느낀 점

- 조건 해석을 명확히 주석으로 정의하는 습관이 쿼리 작성에 큰 도움이 되었다.
- 단순 SELECT 문이라도 `정렬`, `NULL 처리`, `문자 포함 조건` 등을 복합적으로 고려해야 한다는 점에서 실제 실무 SQL 인터뷰 문제와 유사한 느낌을 받았다.
- 향후 다양한 테이블 조인 문제, DML 연습으로 확장할 계획이다.
