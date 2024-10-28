use titanic;
select * from titanic;

-- 중복값 확인
select
	count(passengerid) 승객수
    , count(distinct passengerid) 중복승객수확인
from
	titanic
; -- 714명으로 값이 같이 나왔음, 즉 중복값이 없다는 뜻 ==> 결측치가 없다는 의미도 됨

-- 성별에 따른 승객 수와 생존자 수 구하기
-- column 확인 : 생존여부 0은사망,1은생존
select * from titanic;
-- 출력값
-- 성별 승객수 생존자수
-- 남   몇명  몇명
-- 여   몇명  몇명

SELECT 
    Sex AS 성별,
    COUNT(passengerid) AS 승객수,
    SUM(Survived) AS 생존자수
FROM 
    titanic
GROUP BY 1
;

-- 성별탑승객수와 생존자수의 비중 구해주세요
SELECT 
    Sex AS 성별,
    COUNT(*) AS 탑승객수,                           -- 성별 별 탑승객 수
    SUM(Survived) AS 생존자수,                      -- 성별 별 생존자 수 (Survived 필드가 1인 경우)
    ROUND(SUM(Survived) / COUNT(*), 3) AS 생존율  -- 성별 별 생존 비율 (소수점 2자리까지)
FROM titanic
GROUP BY 1;

-- 연령에 따른 생존율 (연령의경우범주화를할필요성有)
select age from titanic;

-- sql에서연령대를범주화하려면
-- case when을 사용할 수 있음
-- 0~10세 ==> 0대
-- 11~20세 ==> 10대 ... 이런식으로하면코드가겁나길고非효율적
-- select floor(21/10) * 10; 이런식으로 연령 구할거에요
select floor(age/10) * 10 ageband
, age
from titanic;
-- 이제 연령별 승객수, 생존자수, 생존율 구할 수 있음
SELECT 
    FLOOR(age / 10) * 10 AS ageband,                  -- 10대 단위로 연령대 구분
    COUNT(*) AS 승객수,                              -- 연령대별 승객 수
    SUM(Survived) AS 생존자수,                       -- 연령대별 생존자 수
    ROUND(SUM(Survived) / COUNT(*) * 100, 2) AS 생존율  -- 연령대별 생존율 (소수점 2자리까지 반올림)
FROM 
    titanic
WHERE 
    age IS NOT NULL                                 -- 나이가 NULL인 행 제외
GROUP BY 
    ageband
ORDER BY 
    ageband
    -- 생존율 -- 생존율로 순서 나열
;

-- 연령별, 성별 승객수, 생존자수, 생존율
SELECT 
    FLOOR(age / 10) * 10 AS 연령대,               -- 10대 단위로 연령대 구분
    Sex AS 성별,                                   -- 성별 구분
    COUNT(*) AS 승객수,                            -- 연령대와 성별 별 승객 수
    SUM(Survived) AS 생존자수,                     -- 연령대와 성별 별 생존자 수
    ROUND(SUM(Survived) / COUNT(*) * 100, 2) AS 생존율  -- 연령대와 성별 별 생존율 (소수점 2자리까지 반올림)
FROM 
    titanic
WHERE 
    age IS NOT NULL                                -- 나이가 NULL인 경우 제외
GROUP BY 
    연령대, 성별                                   -- 연령대와 성별로 그룹화
ORDER BY 
    성별, 연령대
    -- 연령대, 성별
;

-- 원하는 테이블
-- 연령대 남성생존율 여성생존율 생존율차이(여생존-남생존)
-- 0대   0.594   0.633   0.03
/* 
select *
from () a
left join () b
on ... 이런식으로하세요 hint
*/
SELECT 
    A.연령대
    , A.생존율 AS 남성생존율
    , B.생존율 AS 여성생존율
    , B.생존율 - A.생존율 AS 생존율차이
FROM (
    SELECT 
        FLOOR(AGE/10) * 10 AS 연령대
        , SEX AS 성별
        , COUNT(PassengerId) AS 승객수
        , SUM(SURVIVED) AS 생존자수
        , ROUND(SUM(SURVIVED) / COUNT(PassengerId), 3) AS 생존율
    FROM titanic
    GROUP BY 1, 2
    HAVING SEX = 'male'
) A 
LEFT JOIN (
    SELECT 
        FLOOR(AGE/10) * 10 AS 연령대
        , SEX AS 성별
        , COUNT(PassengerId) AS 승객수
        , SUM(SURVIVED) AS 생존자수
        , ROUND(SUM(SURVIVED) / COUNT(PassengerId), 3) AS 생존율
    FROM titanic
    GROUP BY 1, 2
    HAVING SEX = 'female'
) B
ON A.연령대 = B.연령대
ORDER BY 1
;

-- 연령대 성별에 따른 생존율이 다른 이유는 무엇인가?
-- 분석 : 질적인 측면, 양적인 측면을 동시에 고려
-- 주어진 데이터에서는 더 이상의 분석은 불가
-- 다른 해상사고 찾아서 결과 확인 후 교차 검증 진행
-- 역으로 다시 분석 및 추정


-- 1852년 ~ 2011 년 세계 주요 해상 사고 생존자 분석
-- 선장과 승무원의 생존율이 제일 높음
-- 아이가 있는 젊은 엄마 생존율이 높았음
-- 이런식으로 통계를 잘 하는 것 자체도 좋지만, 백그라운드 지식 굉장히
-- 중요합니다. 물론 통계를 잘 하는 것도 매우 중요!
-- pclass

-- 객실 등급별로 승객 수, 생존자 수, 생존율을 계산을 하십시오
-- 결과 보니 객실등급1~3있는데,3은생존율 20%정도,1은65%정도
SELECT 
        pclass as 객실등급
        -- , sex as 성별
        , COUNT(PassengerId) AS 승객수
        , SUM(SURVIVED) AS 생존자수
        , ROUND(SUM(SURVIVED) / COUNT(PassengerId), 3) AS 생존율
    FROM titanic
    GROUP BY 1
    order by 1
    ;
-- 객실등급 & 성별
SELECT 
        pclass as 객실등급
        , sex as 성별
        , floor(age/10) * 10 as 연령대
        , COUNT(PassengerId) AS 승객수
        , SUM(SURVIVED) AS 생존자수
        , ROUND(SUM(SURVIVED) / COUNT(PassengerId), 3) AS 생존율
    FROM titanic
    GROUP BY 1,2,3
    order by 2,1
;

-- 결론 : 유아일수록생존율이높음
-- 모든객실등급에서남성보다여성의생존율높음


-- 탑승객 분석
-- 출발지, 도착지별 승객 수
select * from titanic;

-- boarded출발지, destination목적지
-- 출발지-목적지별 승객 수 구해주세요

select
	boarded
    , destination
    , count(passengerid) 승객수
from titanic
group by 1,2
;

-- 상위 5개 경로를추출할떄탑승객수로순위매기기
-- row_number() over
-- boarded, destination, 승객수, rnk
SELECT * 
FROM (
    SELECT 
        *
        , ROW_NUMBER() OVER(ORDER BY N_PASSENGERS DESC) RNK
    FROM (
            SELECT 
                BOARDED
                , DESTINATION
                , COUNT(PASSENGERID) N_PASSENGERS
            FROM titanic
            GROUP BY BOARDED, DESTINATION
    ) BASE
) BASE
WHERE RNK BETWEEN 1 AND 5
;

-- hometown別탑승객수,생존율
select * from titanic;
select sum(1); -- 1이 나옴 결과로
select sum(1) from titanic; -- 714가나옴 결과로

-- use etc; -- 잠깐 다른 데이터베이스로 갔다옵시다ㅎ
-- select sum(1) from sales; -- 이렇게 하면 결과로9가나옴
/*이제sum(1)의역할이 대강 파악이 되나요? 행의 개수!*/
-- 결론 sum(1)은 테이블의 행의 개수를 구한다

-- 승객수가10명이상이면서생존율0.5이상인hometown만출력해보아요
use titanic; -- 다시 타이타닉 데이터베이스로 돌아옴
select
	hometown
    , sum(1) 승객수
    , sum(survived) / sum(1) 생존율
from
	titanic
group by 1
HAVING
    COUNT(*) >= 10   -- 승객수가 10명 이상
    AND SUM(survived) / COUNT(*) >= 0.5;  -- 생존율이 0.5 이상
;

SELECT 
	HOMETOWN
    , SUM(1) 승객수
    , SUM(SURVIVED) / SUM(1) 생존율
FROM 
	titanic
GROUP BY 1
HAVING SUM(SURVIVED) / SUM(1) >= 0.5
	AND SUM(1) >= 10
;

-- 정규표현식
-- 정지훈 근데 예전에는 이름 입력할 때 정 지훈 이런식으로 성 띄었음
-- 정지훈 정 지훈 지훈정 지훈 정 정지훈a 이런식으로회사마다데이터다름

-- 정규표현식 예제 -- 정규표현식은 월요일 시험에는 나오지 않아요!
-- 내용:
-- 문자와 기호:
-- .: 임의의 단일 문자
-- ^: 문자열의 시작
-- $: 문자열의 끝
-- *: 0개 이상의 반복
-- +: 1개 이상의 반복
-- ?: 0개 또는 1개의 반복
-- |: 논리적 OR
-- []: 범위 또는 문자 클래스
-- (): 그룹화
use etc;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

-- 샘플 데이터 삽입

INSERT INTO users (username, email, phone) VALUES
('john.doe', 'john.doe@example.com', '123-456-7890'),
('jane_smith', 'jane.smith@example.net', '555-1234'),
('alice99', 'alice123@wonderland.com', '987-654-3210'),
('bob-builder', 'bob.builder@construction.org', '321-654-0987'),
('charlie.brown', 'charlie.brown@example.com', '555-9876');

select * from users;
-- 1. 임의의단일문자
-- 문제:username컬럼에서임의의한문자(t)가있는이름찾아서조회하세요
select * from users where username regexp '.t';

-- 2. 문자열의시작 : ^
-- 'a'로 시작하는 사용자 이름을 찾는 쿼리
select * from users where username regexp '^a';
select * from users where username regexp '^j';
select * from users where username regexp '^ja';

-- 3.문자열의끝
-- 'm'으로 끝나는 이메일을 찾는 쿼리
select * from users;
select * from users where email regexp 'm$';

-- 4. * : 0개이상의반복
select * from users where username regexp 'do.*';

-- 5. + :1개이상의반복
-- 숫자를하나이상포함하는사용자이름찾기 --[0-9]로범위지정해줄수있어요
-- 숫자를의미하는[:digit:]로쓸수도있음
select * from users where username regexp '[0-9].+';
select * from users where username regexp '[:digit:].+';

-- 
