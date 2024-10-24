use classicmodels;
desc orders;
SELECT 
  customerName, 
  COUNT(*) order_count 
FROM 
  orders 
  INNER JOIN customers using (customerNumber) 
GROUP BY 
  customerName 
HAVING 
  COUNT(*) >= 5 
ORDER BY 
  order_count DESC
;

-- 서브쿼리
-- 테이블명 : employees, offices
-- usa에근무하는employees를찾고싶어요
select * from employees;
select * from offices;

-- 풀어가는 방식
-- 메인쿼리, 서브쿼리
-- 메인쿼리:직원을찾기,lastname,firstname,email을가져와employees테이블에서
-- 서브쿼리:usa를찾자,offices에서
select officecode, country from offices where country = 'usa';
-- officecode : 1,2,3이 usa에 있음
select
	lastname
    , firstname
    , email
from
	employees
where
	officecode in (1,2,3)
; -- 이건 우리가 수동으로 먼저 usa에 있는 오피스의 코드가 
-- 1,2,3이라는 거 알고 나서 쓴것

select
	lastname
    , firstname
    , email
from
	employees
where
	officecode in (
   select officecode from offices where country = 'usa')
; -- 이건 서브쿼리 이용해서 구함

-- 최소 금액의 결제를한고객찾기
-- 테이블명:payments
-- 함수 :min()

select * from payments;

-- 메인퀴리:고객찾기
select customernumber, checknumber, amount from payments;
-- 서브쿼리 : 최소 금액 결제
select min(amount) from payments;

-- 2개쿼리합치기
select customernumber, checknumber, amount
from payments
where amount = (select min(amount) from payments)
;

-- amount의평균보다더초과해서구매한고객을조회하세요
select customernumber, checknumber, amount
from payments
where amount > (select avg(amount) from payments)
;

-- 주문갯수가50개초과인 주문번호와주문날짜를구하세요
-- 테이블명 : orders, orderdetails

select distinct a.ordernumber, orderdate, b.quantityordered
from orders a
join orderdetails b on a.ordernumber = b.ordernumber
where b.quantityordered > 50
;

-- 메인쿼리 : 주문번호와 주문날짜 출력
SELECT ordernumber, orderdate
FROM orders
WHERE orderNumber IN (
    SELECT orderNumber
    FROM orderdetails
    WHERE quantityOrdered > 50
);

-- 문제 : 주문을아예하지않은고객명조회
-- 테이블명 :customers,orders
-- hint : not in 연산자 사용할것
-- 메인쿼리 :고객명조회
select
	customername
from
	customers
;
select count(distinct customernumber) from orders; -- 98명
select
	count(customernumber)
from customers -- 그냥 고객 정보에서
; -- 122명
-- 전체고객은 122명인데, 주문한고객은 98명, 24명은 주문 안 함

-- 주문을한고객만조회
select 
	customername
from
	customers
where
	customername not in
    (select distinct customernumber
    from orders)
;

-- 인라인 뷰, from 절 서브 쿼리
-- 임시 테이블을 생성한다 이런 느낌으로 접근하면이해에도움될것임
-- 최대, 최소, 평균 주문건수 계산
select
	ordernumber, count(ordernumber) as 주문건수
from
	orderdetails
group by ordernumber
;

select
	max(주문건수), min(주문건수), avg(주문건수) as 평균주문건수
from (
select
	ordernumber, count(ordernumber) as 주문건수
from
	orderdetails
group by ordernumber
) a
;

-- 예제
-- 가장 비싼 생산품 5개를 출력을 하세요
-- from 절 서브 쿼리를 활용할 것
-- productname, buyprice
-- hint : order by 절 활용하세요
select * from products;

-- 메인쿼리 : productname, buyprice
select
	productname
    , buyprice
from(
   select *
   from products
   order by buyprice desc
) a
limit 5
;

--
select * from orderdetails
order by productcode desc
;

-- 각 제품의 평균 주문 수량 찾기
-- from 절 서브 쿼리 사용
-- 출력값 : productcode, avgquantity
-- 조건 : avgquantity 내림차순 정렬

select
	productcode
    , avg(quantityordered) as avgquantity
from
	orderdetails
group by productcode
-- order by avgquantity -- 이렇게해도되지만이렇게하지말고서브쿼리로!
;

-- 
SELECT * FROM orderdetails
ORDER BY productCode DESC;

-- 각 제품의 평균 주문 수량 찾기
-- FROM 절 서브쿼리 사용
-- 출력값 : productCode, avgQuantity
-- 조건 : avgQuantity 내림차순 정렬

SELECT 
	* 
FROM (
	SELECT 
		productCode
		, AVG(quantityOrdered) AS avgQuantity
	FROM 
		orderdetails
	GROUP BY productCode
) A
ORDER BY avgQuantity DESC
;


-- 매출 top5 국가 및 매출
-- 국가별 매출 구하기
select
	*
from
	orders a
left join orderdetails b
	on a.ordernumber = b.ordernumber
left join customers c
	on a.customernumber = c.customernumber
;
-- 매출 top5 국가 및 매출
-- 국가별 매출 구하기
-- 국가별 country sales
-- usa 000
create table classicmodels.stat as 
select
	c.country
    , sum(b.priceeach * b.quantityordered) as sales
from
	orders a
left join orderdetails b
	on a.ordernumber = b.ordernumber
left join customers c
	on a.customernumber = c.customernumber
group by 1
order by 2 desc
;
SELECT 
	country 
    , SALES
    , DENSE_RANK() OVER(ORDER BY SALES DESC) RNK
FROM (
	SELECT 
		C.country
		, SUM(B.priceEach * B.quantityOrdered) AS sales
	FROM 
		orders A
	LEFT JOIN orderdetails B
		ON A.ordernumber = B.ordernumber
	LEFT JOIN customers C 
		ON A.customerNumber = C.customerNumber
	GROUP BY 1
	ORDER BY 2 DESC
) A
;
-- 이제 rank윈도우함수를이용해서등수를매길것
create table classicmodels.stat_rnk as
select
	country
    , sales
    , dense_rank() over(order by sales desc) rnk
from stat
;

-- between 연산자

select * from stat_rnk
where rnk between 1 and 5; -- 1위부터5위까지출력

-- 테이블 생성 : product_sales
-- 출력 값: select * from product_sales
-- 미국시장이제일커서미국시장만조회할것임
-- productname sales
-- 1952 ~~~   78860.11
use classicmodels;
drop table product_sales;
CREATE TABLE classicmodels.product_sales AS
SELECT 
	D.productname
    , SUM(B.priceEach * B.quantityOrdered) AS sales
FROM 
	orders A
LEFT JOIN orderdetails B
	ON A.ordernumber = B.ordernumber
LEFT JOIN customers C 
	ON A.customerNumber = C.customerNumber
LEFT JOIN products D
	ON B.productcode = D.productcode
WHERE C.country = 'USA'
GROUP BY 1
;

select
	*
    , row_number() over(order by sales desc) rnk
 from product_sales
 limit 5 -- 5등까지만출력
 ; -- 인라인 뷰(조인문) & 윈도우 함수 조합으로 코드 작성
 
 -- churnrate(%) 구하기 - 이탈률
 -- 이 테이블의 마지막 구매일을 확인
 select max(orderdate) as mx_order
 from orders
 ; -- '2005-05-31' 05년5월31일이 마지막 주문 날짜임
 
 -- 2005-06-01일을 기준으로 마지막 구매일과의 차이 일자를 구하기
 -- 각 고객의 마지막 구매일을 구할 수 있음
 -- 2005-06-01 -(빼기) 2004-11-25
 select
	customernumber
    , max(orderdate) mx_order
from
	orders
group by 1
; -- 이렇게하면각고객별로마지막구매일이나옴

-- 2005-06-01일을 기준으로 마지막 구매일과의 차이 일자를 구하기
-- 각 고객의 마지막 구매일을 구할 수 있음
-- 2005-06-01 -(빼기) 2004-11-25
select datediff('2005-06-01','2004-11-25'); -- 188일

select
	customernumber
    , mx_order
    , '2005-06-01'
    , datediff('2005-06-01', mx_order) AS DIFF
from (
	select
	customernumber
    , max(orderdate) mx_order
from
	orders
group by 1 
) a
; -- diff가 188이면, 이 고객은 마지막 거래 이후 188일 동안
-- 거래가 없었다는 뜻




-- diff가 90일이상이면,이탈고객으로가정하겠음, 이탈고객(churn)
-- 미션 : 전체 데이터를 가지고 오고 case when을
-- 사용해서 90일 이상이면 이탈고객
-- 그 外는 비이탈고객
select 
	case when diff >= 90
    then "이탈고객"
    else "非이탈고객" end as 이탈有無
from (
select
	customernumber
    , mx_order
    , '2005-06-01'
    , datediff('2005-06-01', mx_order) AS DIFF
from (
	select
	customernumber
    , max(orderdate) mx_order
from
	orders
group by 1 
) a
) a
;
 
 
-- 개수 구하기
select 
	case when diff >= 90
    then "이탈고객"
    else "非이탈고객" end as 이탈有無
    , count(distinct customernumber) as 명수
from (
select
	customernumber
    , mx_order
    , '2005-06-01'
    , datediff('2005-06-01', mx_order) AS DIFF
from (
	select
	customernumber
    , max(orderdate) mx_order
from
	orders
group by 1 
) a
) a
group by 1
;

use etc;
CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales;

-- sum()
select sum(sale) from sales;
select fiscal_year, sum(sale)
from sales
group by 1;

-- 윈도우 함수 사용
select
	fiscal_year
    , sales_employee
    , sale
   -- , sum(sale) over (partition by fiscal_year) total_sales -- 회계연도에따라서묶여서계산됨
  -- , sum(sale) over () total_sales -- total_sales는 1500
-- , sum(sale) over (partition by fiscal_year order by sale) total_sales -- 각 그룹 안에서 누적값으로계산됨
	, sum(sale) over (order by fiscal_year) total_sales
from 
	sales
;

SELECT 
	fiscal_year
    , sales_employee
    , sale
    -- , SUM(sale) OVER (PARTITION BY fiscal_year) total_sales
    -- , SUM(sale) OVER () total_sales
    -- , SUM(sale) OVER (PARTITION BY fiscal_year ORDER BY sale) total_sales
    -- , SUM(sale) OVER (ORDER BY fiscal_year) total_sales
    , SUM(sale) OVER (PARTITION BY fiscal_year ORDER BY sale ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 복잡스럽다
FROM 
	sales
;

-- notion 페이지에 <강사님 코드>라고 정리해두었음

-- lag() ==> pandas shift 메서드와 유사함
select
	fiscal_year
    , sales_employee
    , sale
    , lag (sale, 1,0) over (partition by sales_employee
				order by fiscal_year) as "이전연도"
from
	sales
;
    
	