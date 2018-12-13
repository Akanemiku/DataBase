--2
select userName,sex,sum(payment) payTotal,count(*) orderNum from userInfo,orderInfo
where userInfo.userID = orderInfo.userID
group by userName,sex
go

--3
create function payTotal(@userID int)
returns int
as
begin
declare @pay int
select @pay = sum(payment) from orderInfo
where userID = @userID
return @pay
end
go
select userID,dbo.payTotal(userID) payTotal from userInfo
group by userID
order by userID 

--5
go
create procedure proc1
@userID int
as
select orderID,payment,orderTime,orderState,avg(payment) from orderInfo
where userID = 102
group by orderID,payment,orderTime,orderState
