INSERT INTO dwh.dim_date (
    date_sk, date_actual, day, month, quarter, year,
    weekday_name, weekend_flag, insert_date, update_date, batch_id
)
SELECT
    TO_NUMBER(TO_CHAR(d, 'YYYYMMDD'))                          AS date_sk,
    d                                                          AS date_actual,
    TO_NUMBER(TO_CHAR(d, 'DD'))                                AS day,
    TO_NUMBER(TO_CHAR(d, 'MM'))                                AS month,
    TO_NUMBER(TO_CHAR(d, 'Q'))                                 AS quarter,
    TO_NUMBER(TO_CHAR(d, 'YYYY'))                              AS year,
    TRIM(TO_CHAR(d, 'DAY'))                                    AS weekday_name,
    CASE WHEN TO_CHAR(d, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') IN ('SAT','SUN')
         THEN 'Y' ELSE 'N' END                                 AS weekend_flag,
    SYSTIMESTAMP                                                AS insert_date,
    NULL                                                        AS update_date,
    1                                                           AS batch_id
FROM (
    SELECT DATE '2016-01-01' + LEVEL - 1 AS d
    FROM dual
    CONNECT BY LEVEL <= (DATE '2019-12-31' - DATE '2016-01-01' + 1)
);

SELECT COUNT(*) FROM dwh.dim_date;  -- should be 1461 (4 years, 2016-2019, including leap year 2016)

SELECT date_sk, date_actual, day, month, quarter, year, weekday_name, weekend_flag
FROM dwh.dim_date
WHERE date_actual IN (DATE '2018-01-01', DATE '2018-07-14')  -- spot check a Monday and a Saturday
ORDER BY date_actual;