create database a1;
use a1;
create table sales(
id int not null,
nam varchar(255),
price int ,
salesd Date
)

insert into sales values(1,'Apple',50,'2022-12-10'),
(1,'Apple',50,'2022-11-01'),
(2,'Pear',100,'2022-12-31'),
(2,'Pear',100,'2022-12-03'),
(3,'grapes',200,'2022-3-03');
 

create table discount(
id int not null,
Nam varchar(255),
dprice int ,
fsales Date ,
tsales Date
);

insert into discount values(1,'Apple',10,'2022-12-01','2022-12-31'),
(2,'Pear',20,'2022-12-01','2022-12-05');




select s.id,s.nam,s.salesd, 
case 
	when s.salesd between d.fsales and d.tsales then s.price - d.dprice
    else s.price
end as overall_price 

from sales s  left join discount  d on   s.id = d.id ;


