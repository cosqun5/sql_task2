Create table Authors
(
Id int identity primary key,
Name nvarchar(25)not null ,
Surname nvarchar(30) not null,
)

Create table Books
(
id int identity primary key,
Name nvarchar(100) not null,
PageCount int,
CHECK(LEN(Name)>2),
CHECK (PageCount>=10),
AuthorId int references Authors(Id)
)

--View-----------------------------------------------------------------

Create view BookAuthor
As
select b.id,
b.Name'Kitablar',
b.PageCount,
a.Name'Muellifin Adi',
a.Surname'Muellifin Soyadi' 
from Books b
join Authors a
on b.AuthorId = a.Id

select * from BookAuthor



---Procedure----------------------------------------------------------



create procedure user_GetProcedureBookNameAuthorName @Name nvarchar(100)
As
select b.id,
b.Name'Kitablar',
b.PageCount,
a.Name'Muellifin Adi',
a.Surname'Muellifin Soyadi' 
from Books b
join Authors a
on b.AuthorId = a.Id
where b.Name = @Name

Exec user_GetProcedureBookNameAuthorName 'Kitab'


drop procedure GetProcedureBookNameAuthorName

---function---------------------------------------------
create function MinPageCount(@PageCount int = 10)
Returns int
as
Begin
    Declare @count int
	Select @count=COUNT(*) from Books where PageCount>=@PageCount
	Return @Count
End

select dbo.MinPageCount(200)

---trigger----------------------------------------------
delete from Books where Id=3

create trigger InserDeleteDataFormsBookstoDeleteBooks
on Books
After Delete
AS
Begin
    Declare @Name nvarchar(100)
    Declare @PageCount int
    Declare @AuthorId int
	Select @Name=GroupList.Name, @PageCount=GroupList.PageCount,@AuthorId=GroupList.AuthorId from deleted GroupList
	insert into DeleteBooks values(@Name,@PageCount,@AuthorId)
end


drop trigger InserDeleteDataFormsBookstoDeleteBooks