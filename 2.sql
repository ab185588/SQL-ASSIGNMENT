create type employee_type as table(empid int,empname varchar(255),empsalary int);
drop table employee;
create table employee(id int,nam varchar(255),salary int);
insert into employee values(1,'abhi',100000),(3,'nithin',300000)

select * from employee;

create or alter procedure emp_proc (@emp employee_type readonly)
as
begin
	declare 
	@temp_id int,
	@temp_name varchar(40),
	@temp_sal int,
	@cnt int
	select @temp_id = empid from @emp;
	select @temp_name = empname from @emp;
	select @temp_sal = empsalary from @emp;
	
	select @cnt = count(*) from employee where id=@temp_id;

	if @cnt > 0
	update employee set nam = @temp_name ,salary = @temp_sal  where id = @temp_id;
	else 
	insert into employee values(@temp_id,@temp_name,@temp_sal);
end



-- insert new values 
declare @temp_type_table employee_type
insert into @temp_type_table values(2,'meghanath',250000);
insert into @temp_type_table values(3,'nithin',430000);
exec emp_proc @temp_type_table


select * from employee;

-- updating old values 
declare @temp_type_table_1 employee_type
insert into @temp_type_table values(2,'meghanath',500000);
insert into @temp_type_table values(3,'nithin',830000);
exec emp_proc @temp_type_table_1

select * from employee;

