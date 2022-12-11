use a1;
drop table employee;
create table employee(
eid int primary key identity,
ename varchar(255),
mid int foreign key references employee(eid)
)

Insert into employee values ('jaddhu', NULL),
('mahesh', NULL),
('sai', NULL),
('tarun', NULL),
('lavan', NULL),
('simran', NULL),
('don', NULL),
('bro', NULL),
('suresh', NULL),
('Sam', NULL)


Update employee Set mid = 8 Where ename IN ('mahesh', 'sai', 'lavan')
Update employee Set mid = 2 Where ename IN ('suresh', 'simran')
Update employee Set mid = 3 Where ename IN ('tarun')
Update employee Set mid = 5 Where ename IN ('jaddhu', 'Sam')
Update employee Set mid = 4 Where ename IN ('don')

select * from employee

declare @id int;
set @id = 6 ;

with emp_cte as 
(
   select eid,ename,mid from employee
   where eid = @id

   union all 

   select e.eid,e.ename,e.mid
   from employee e join emp_cte ec on e.eid = ec.mid 
)
select e1.ename as EmployeeNAme,coalesce(e2.ename,'Superior Authority' )as ManagerNAme 
from emp_cte e1 left join emp_cte e2 on e1.mid = e2.eid;