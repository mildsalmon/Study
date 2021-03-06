SELECT A.AGRDE_SE_CD
        , SUM(A.POPLTN_CNT) AS POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD = 'T'
GROUP BY A.AGRDE_SE_CD
ORDER BY A.AGRDE_SE_CD
;

SELECT A.AGRDE_SE_CD
        , SUM(A.POPLTN_CNT) AS POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD = 'T'
GROUP BY ROLLUP(A.AGRDE_SE_CD)
ORDER BY A.AGRDE_SE_CD
;

SELECT A.AGRDE_SE_CD
        , A.POPLTN_SE_CD
        , SUM(A.POPLTN_CNT) AS POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD IN ('M', 'F')
GROUP BY ROLLUP(A.AGRDE_SE_CD, A.POPLTN_SE_CD)
ORDER BY A.AGRDE_SE_CD
;

SELECT CASE WHEN GROUPING(A.AGRDE_SE_CD) = 0
                        THEN A.AGRDE_SE_CD ELSE '전체합계' END AS AGRDE_SE_CD
            , CASE WHEN GROUPING(A.POPLTN_SE_CD) = 0
                        THEN A.POPLTN_SE_CD ELSE '연령대별남녀합계' END AS POPLTN_SE_CD
            , SUM(A.POPLTN_CNT) AS POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
        AND A.POPLTN_SE_CD IN ('M', 'F')
GROUP BY ROLLUP(A.AGRDE_SE_CD, A.POPLTN_SE_CD)
ORDER BY A.AGRDE_SE_CD
;

SELECT CASE WHEN GROUPING_AGRDE_SE_CD = 1 AND GROUPING_POPLTN_SE_CD = 1 THEN '전체합계'
                       WHEN GROUPING_AGRDE_SE_CD = 1 AND GROUPING_POPLTN_SE_CD = 0 THEN '연령대별합계'
                       WHEN GROUPING_AGRDE_SE_CD = 0 AND GROUPING_POPLTN_SE_CD = 1 THEN '성별합계'
                       WHEN GROUPING_AGRDE_SE_CD = 0 AND GROUPING_POPLTN_SE_CD = 0 THEN '연령대+성별합계'
                       ELSE '' END AS 합계구분
            , NVL(AGRDE_SE_CD, '연령대합계') AS AGRDE_SE_CD
            , NVL(POPLTN_SE_CD, '성별합계') AS POPLTN_SE_CD
            , POPLTN_CNT
FROM (
                SELECT A.AGRDE_SE_CD
                            , GROUPING(A.AGRDE_SE_CD) AS GROUPING_AGRDE_SE_CD
                            , A.POPLTN_SE_CD
                            , GROUPING(A.POPLTN_SE_CD) AS GROUPING_POPLTN_SE_CD
                            , SUM(A.POPLTN_CNT) AS POPLTN_CNT
                FROM TB_POPLTN A
                WHERE A.STD_YM = '202010'
                    AND A.POPLTN_SE_CD IN ('M', 'F')
                GROUP BY CUBE(A.AGRDE_SE_CD, A.POPLTN_SE_CD)
                ORDER BY A.AGRDE_SE_CD
        ) A
;    

SELECT A.AGRDE_SE_CD AS AGRDE_SE_CD
            , '성별전체' AS POPLTN_SE_CD
            , SUM(POPLTN_CNT) POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD IN ('M', 'F')
GROUP BY AGRDE_SE_CD

UNION ALL

SELECT '연령대별전체' AS AGRDE_SE_CD
            , A.POPLTN_SE_CD AS POPLTN_SE_CD
            , SUM(POPLTN_CNT) POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD IN ('M', 'F')
GROUP BY POPLTN_SE_CD

UNION ALL

SELECT '연령대별전체' AS AGRDE_SE_CD
            , '성별전체' AS POPLTN_SE_CD
            , SUM(POPLTN_CNT) POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD IN ('M', 'F')
ORDER BY AGRDE_SE_CD, POPLTN_SE_CD, POPLTN_CNT    
;

SELECT NVL(AGRDE_SE_CD, '연령대별전체') AS AGRDE_SE_CD
        , NVL(POPLTN_SE_CD, '성별전체') AS POPLTN_SE_CD
        , SUM(POPLTN_CNT) POPLTN_CNT
FROM TB_POPLTN A
WHERE A.STD_YM = '202010'
    AND A.POPLTN_SE_CD IN ('M', 'F')
GROUP BY GROUPING SETS(AGRDE_SE_CD, POPLTN_SE_CD, ())
ORDER BY AGRDE_SE_CD, POPLTN_SE_CD, POPLTN_CNT
;
