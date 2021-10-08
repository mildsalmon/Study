SELECT SUM(SAL)
FROM EMP;

SELECT ENAME, SUM(SAL)
FROM EMP;

SELECT SUM(DISTINCT SAL),
    SUM(ALL SAL),
    SUM(SAL)
FROM EMP;

SELECT COUNT(*)
FROM EMP;

SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;

SELECT COUNT(DISTINCT SAL),
    COUNT(ALL SAL),
    COUNT(SAL)
FROM EMP;

SELECT COUNT(COMM)
FROM EMP;

SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL;

SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;

SELECT AVG(DISTINCT SAL)
FROM EMP
WHERE DEPTNO = 30;

SELECT AVG(SAL), '10' AS DEPTNO
FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL), '20' AS DEPTNO
FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL), '30' AS DEPTNO
FROM EMP WHERE DEPTNO = 30;

SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB);

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB);

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY JOB, ROLLUP(DEPTNO);

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
    GROUPING(DEPTNO),
    GROUPING(JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO,
    DECODE(GROUPING(JOB), 1, 'ALL_JOB', JOB) AS JOB,
    COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
    GROUPING(DEPTNO),
    GROUPING(JOB),
    GROUPING_ID(DEPTNO, JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, MGR, COUNT(*), SUM(SAL),
    GROUPING(DEPTNO),
    GROUPING(JOB),
    GROUPING(MGR),
    GROUPING_ID(DEPTNO, JOB, MGR)
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY CUBE(DEPTNO, JOB, MGR)
ORDER BY DEPTNO, JOB, MGR;

SELECT ENAME
FROM EMP
WHERE DEPTNO = 10;

SELECT DEPTNO, ENAME
FROM EMP
GROUP BY DEPTNO, ENAME;

SELECT DEPTNO,
    LISTAGG(ENAME, ', ')
    WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO,
    LISTAGG(ENAME)
    WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT *
FROM (SELECT DEPTNO, SAL, JOB
    FROM EMP)
PIVOT(MAX(SAL)
    FOR DEPTNO IN (10, 20, 30)
    )
ORDER BY JOB;
-- 따로 기록
SELECT *
FROM (SELECT DEPTNO, SAL
    FROM EMP)
PIVOT(MAX(SAL)
    FOR DEPTNO IN (10, 20, 30)
    );

SELECT *
FROM (SELECT DEPTNO, SAL
    FROM EMP)
PIVOT(SAL
    FOR DEPTNO IN (10, 20, 30)
    );

SELECT *
FROM (SELECT DEPTNO, SAL, JOB, MGR
    FROM EMP)
PIVOT(MAX(SAL)
    FOR DEPTNO IN (10, 20, 30)
    )
ORDER BY JOB;

SELECT *
FROM(SELECT JOB, DEPTNO, SAL
    FROM EMP)
PIVOT(MAX(SAL)
    FOR JOB IN ('CLERK' AS CLERK,
                'SALESMAN' AS SALESMAN,
                'PRESIDENT' AS PRESIDENT,
                'MANAGER' AS MANAGER,
                'ANALYST' AS ANALYST)
    )
ORDER BY DEPTNO;

SELECT DEPTNO,
    MAX(DECODE(JOB, 'CLERK', SAL)) AS CLERK,
    MAX(DECODE(JOB, 'SALESMAN', SAL)) AS SALESMAN,
    MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS PRESIDENT,
    MAX(DECODE(JOB, 'MANAGER', SAL)) AS MANAGER,
    MAX(DECODE(JOB, 'ANALYST', SAL)) AS ANALYST
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
    
SELECT *
FROM (SELECT DEPTNO,
        MAX(DECODE(JOB, 'CLERK', SAL)) AS CLERK,
        MAX(DECODE(JOB, 'SALESMAN', SAL)) AS SALESMAN,
        MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS PRESIDENT,
        MAX(DECODE(JOB, 'MANAGER', SAL)) AS MANAGER,
        MAX(DECODE(JOB, 'ANALYST', SAL)) AS ANALYST
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO)
UNPIVOT(SAL
    FOR JOB IN (CLERK,
                SALESMAN,
                PRESIDENT,
                MANAGER,
                ANALYST))
ORDER BY DEPTNO, JOB;

-- 연습문제

SELECT DEPTNO, TRUNC(AVG(SAL)) AS AVG_SAL, MAX(SAL) AS MAX_SAL, MIN(SAL) AS MIN_SAL, COUNT(EMPNO) AS CNT
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO DESC;

SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, DEPTNO, COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY') DESC;

SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM, COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

SELECT DEPTNO,
    TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
    COUNT(*) AS CNT,
    MAX(SAL),
    SUM(SAL),
    AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));