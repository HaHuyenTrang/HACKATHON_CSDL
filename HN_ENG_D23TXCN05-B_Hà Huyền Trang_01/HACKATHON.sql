create database hackathon;
use hackathon;



create table tbl_authors(
	author_id int primary key auto_increment,
	author_name varchar(100) not null,
    birth_year year
);

create table tbl_books(
	book_id int primary key auto_increment,
    title varchar(255) not null,
    author_id int,
    category varchar(100) ,
    published_year  year,
    available_copies int,
    FOREIGN KEY (author_id) REFERENCES tbl_authors(author_id)
);



create table tbl_members(
	member_id int primary key auto_increment,
    member_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) unique not null,
    address varchar(255)
);

create table tbl_member_info(
	member_id int primary key auto_increment,
	foreign key(member_id) references tbl_members(member_id) ,
    membership_type ENUM('Standard', 'Premium'),
    registration_date date,
    expiry_date date
);

create table tbl_borrow_records(
	borrow_id int primary key auto_increment,
    member_id int,
    foreign key(member_id) references tbl_members(member_id),
    book_id int,
    foreign key(book_id) references tbl_books(book_id),
    borrow_date date,
    return_date date
);


-- thêm
alter table tbl_borrow_records add column fine_amount DECIMAL(10,2);

-- sửa
alter table tbl_members  modify column phone  VARCHAR(15);

-- xóa
alter table tbl_member_info drop column expiry_date ;


-- câu 3

insert into tbl_books(book_id, title, author_id, category, published_year, available_copies)
value
(1, 'Đất rừng phương Nam', 1, 'Tiểu thuyết', 1954, 10),
(2, 'Tắt đèn', 2, 'Tiểu thuyết', 1940, 5),
(3, 'Đời thừa', 3, 'Tiểu thuyết', 1943, 8),
(4, 'Số đỏ', 4, 'Tiểu thuyết', 1940, 12),
(5, 'Dế mèn phiêu lưu ký', 5, 'Truyện thiếu nhi', 1941, 7);

insert into tbl_authors(author_id, author_name, birth_year)
value
(1, 'Đoàn Giỏi', 2000),
(2, 'Ngô Tất Tố',2000 ),
(3, 'Nam Cao', 2000),
(4, 'Vũ Trọng Phụng',2000 ),
(5, 'Tô Hoài',2000 );

insert into tbl_members(member_id , member_name , phone ,email , address )
value
(
1,
'Nguyễn Văn A',
'0932767326',
'anv@gmail.com',
'Hà Nội'
),
(
2,
'Trần Thị B',
'0992378636',
'btt@gmail.com',
'Hồ Chí Minh'
),
(
3,
'Lê Văn C',
'0932767365',
'clv@gmail.com',
'Đà Nẵng'
),
(4,'Phạm Thị D','0973265632','dpt@gmail.com','Hà Nội'),
(
5,
'Nguyễn Thị E',
'0923865633',
'ent@gmail.com',
'Hồ Chí Minh'

);


insert into tbl_member_info(member_id ,membership_type , registration_date, expiry_date  )
value
(
1,
'Premium',
'2023-01-01',
'2024-01-01'
),
(
2,
'Standard',
'2023-04-05',
'2024-04-05'
),
(
3,
'Premium',
'2023-03-10',
'2024-03-10'
),
(
4,
'Premium',
'2023-02-15',
'2024-02-15'

),
(
5,
'Standard',
'2023-05-20',
'2024-05-20'

);


insert into tbl_borrow_records(borrow_id, 	member_id, book_id ,borrow_date, return_date)
value
(
1,
1,
1,
'2023-01-10',
'2023-01-20'
),
(
2,
2,
2,
'2023-02-05',
'2023-02-15'

),
(
3,
3,
3,
'2023-03-15',
NULL

),
(
4,
4,
4,
'2023-04-10',
'2023-04-25'

),
(
5,
5,
5,
'2023-05-05',
'2023-05-15'

);



-- LẤY SÁCH CÂU 4

select 
	book_id,title,category,published_year,available_copies
from tbl_books;

select distinct m.member_id, m.member_name, m.phone, m.email, m.address
from tbl_members m
join tbl_borrow_records br ON m.member_id = br.member_id;

-- CÂU 5

select 
	a.author_name, count(b.book_id) AS quantity_book
from tbl_authors a join tbl_books b on a.author_id = b.book_id
group by a.author_name;


select
	b.title, count(br.borrow_id) as cout_borrow
from  tbl_books b join  tbl_borrow_records br on b.book_id= br.borrow_id
group by b.title;

-- CÂU 6
select
	b.member_name, count(br.borrow_id) as cout_borrow
from  tbl_members b join  tbl_borrow_records br on b.member_id= br.borrow_id
where count(br.borrow_id) >3
group by b.title;