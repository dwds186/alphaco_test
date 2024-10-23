-- SQL 순서
-- from => where => group by =>
-- select => distinct => order by
use classicmodels;
select
	status
from
	orders
group by
	status
;

-- distinct를사용
select
	distinct status
from
	orders
;

-- 그룹바이 :count()
select
	status
    , count(*)
from
	orders
group by
	status
;

desc products;

-- 테이블명 : orderdetails
select * from orderdetails;

select
	orderNumber
    , quantityordered * priceEach as 매출액
from
	orderdetails
;

-- 주문번호당, 총매출액, 평균 매출액을 구하세요
-- 이거 문제화하기 딱 좋네요

select
	ordernumber
    , sum(quantityordered * priceEach) as 총매출액
    , avg(quantityordered * priceEach) as 평균매출액
    , stddev_samp(quantityordered * priceEach) as 표준편차
    , var_samp(quantityordered * priceEach) as 분산

from
	orderdetails
group by
	ordernumber
;

-- productcode, orderlinenumber 당 집계 함수
select
	productcode
    , orderlinenumber
    , sum(quantityordered * priceEach) as 총매출액
    , avg(quantityordered * priceEach) as 평균매출액
    , stddev_samp(quantityordered * priceEach) as 표준편차
    , var_samp(quantityordered * priceEach) as 분산

from
	orderdetails
group by
	productcode
    , orderlinenumber
;

-- having
-- 순서 from->where->groupby->having
-- 위에 있는코드에서 having 절 추가
-- orderlinenumber에서 1만 별도로 조회
select
	productcode
    , orderlinenumber
    , sum(quantityordered * priceEach) as 총매출액
    , avg(quantityordered * priceEach) as 평균매출액
    , stddev_samp(quantityordered * priceEach) as 표준편차
    , var_samp(quantityordered * priceEach) as 분산

from
	orderdetails
group by
	productcode
    , orderlinenumber
having
	orderlinenumber = 1
    and 총매출액 >= 10000 -- 메모:다른dbms에서는에러날수도있음
order by
	productcode
    , orderlinenumber
;

-- 테이블명 : orderdetails
-- 출력값
-- ordernumber 주문갯수 매출액
-- 10100       151    10223.83
-- 조건 : 주문갯수가 700개 이상만 조회
desc orderdetails;
select
	ordernumber
    , quantityordered
    , sum(quantityordered * priceEach) as 총매출액
from
	orderdetails
group by
	ordernumber
having
	quantityordered >= 700
;