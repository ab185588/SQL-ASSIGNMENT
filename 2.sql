create type employees_type as table(empid int,empname varchar(255),empsalary int);
--drop table employees;
create table employees(id int,nam varchar(255),salary int);
insert into employees values(1,'abhi',100000),(3,'nithin',300000)

select * from employees;

create or alter procedure emp_proc @emp employees_type readonly
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
	
	set  @cnt = (select count(*) from employees where id=@temp_id);

	if @cnt > 0
	update employees set nam = @temp_name ,salary = @temp_sal  where id = @temp_id;
	else 
	insert into employees select * from @emp;
end



-- insert new values 
declare @temp_type_table employees_type
insert into @temp_type_table values(2,'meghanath',250000);
exec emp_proc @temp_type_table


select * from employees;

-- updating old values 
declare @temp_type_table_1 employees_type
insert into @temp_type_table_1 values(2,'meghanath',500000);
exec emp_proc @temp_type_table_1

select * from employees;

f