Declare @Value varchar(50) --value for that find the column Name
Set @Value='ABC'


--for that I m creaating one tamp table
Create Table #Table
(
	TableName Varchar(500),ColumnName Varchar(500),
	Id int Identity(1,1) --use for iteration
)
insert into #Table
SELECT TABLE_SCHEMA + '.' + TABLE_NAME As TableNam,Column_name As ColumnName
FROM INFORMATION_SCHEMA.COLUMNS
where Data_type In ('char','nchar','varchar','nvarchar')
--use char supported datatype because you provide sample data as 'ABC'


Declare @Count Int --total record to iterated
Set @Count=0;


Select @Count=Count(*) From #Table


Declare @I int --initial value one to iterate
Set @I=1;


Declare @TableName varchar(500)
Set @TableName=''
Declare @ColumnName varchar(500)
Set @ColumnName=''


Declare @Str nvarchar(1000)
Set @Str=''
Declare @param nvarchar(1000)
set @param=''


Declare @TableNameFound varchar(max)
Set @TableNameFound=''


Declare @Found bit
Set @Found=0;




While @I<=@Count
Begin


	Set @Found=0;
	Select @TableName=TableName,@ColumnName=ColumnName From #Table where Id=@I;
	

	Set @param='@TableName varchar(500),@ColumnName varchar(500),@Value varchar(50),@TableNameFound varchar(max),@Found bit output'


	Set @str='Select @Found=1 From '+@TableName+' where '+@ColumnName+'=@Value'
	

	

	-- here we are using tablename and actual value to find in table
	print @str
	exec sp_executesql @str,@param,@TableName,@ColumnName,@Value,TableNameFound,@Found output
	

	if @Found=1
	Begin
		Set @TableNameFound=@TableNameFound+','+@TableName
	End
	



print @I
--increament value of @I
Set @I=@I+1;
End




Select substring(@TableNameFound,2,len(@TableNameFound)) As TableFound
--Table name where column value matched
drop table #Table