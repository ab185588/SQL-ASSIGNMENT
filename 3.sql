--This code also shows multiple exceptions if occured like here in this case if invalid exception and delete by zero occurs it shows both the errors


use a1;
create or alter procedure calculate(@a int,@b int,@op char)
as 
begin
	declare @ans int;
	begin try 
	    if @op not in  ('+','-','*','/')
		begin 
           RAISERROR('Invalid Character', 16,1)
		end 
	end try 
	begin catch 
    select 
    ERROR_MESSAGE(), -- or add your custom message          
    ERROR_NUMBER();  -- parameter: original error number.
	end catch
	begin try
		if @op = '+' set @ans = @a + @b 
		if @op = '-' set @ans = @a - @b 
		if @op = '*' set @ans = @a * @b 
		else set @ans = @a / @b
	end try
	begin catch 
		select 
    ERROR_MESSAGE(), -- or add your custom message          
    ERROR_NUMBER();  -- parameter: original error number.
	end catch 
	print @ans
end

exec calculate 40,20,'+';
exec calculate 40,20,'-';
exec calculate 40,20,'*';
exec calculate 40,1,'/';
exec calculate 40,0,'@';
