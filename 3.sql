use a1;

create or alter procedure calculate(@a int,@b int,@op char)
as 
begin
	declare @ans int;
		if @op = '+' set @ans = @a + @b 
		if @op = '-' set @ans = @a - @b 
		if @op = '*' set @ans = @a * @b 
		if @op = '/' set @ans = @a / @b
	print @ans
end

exec calculate 40,20,'+';
exec calculate 40,20,'-';
exec calculate 40,20,'*';
exec calculate 40,20,'/';
