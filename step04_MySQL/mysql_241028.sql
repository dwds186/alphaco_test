SHOW DATABASES;

use book_ratings;

-- 테이블 생성
drop table books;
CREATE TABLE books(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(100),
    release_year YEAR(4)
)
;

describe books;