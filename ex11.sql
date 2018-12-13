--1
select substring(userName,1,1)+
case sex
when '男' then '先生'
when '女' then '女士'
end
from userInfo
go

--2
select userName,sex,sum(payment) payTotal,count(*) orderNum from userInfo,orderInfo
where userInfo.userID = orderInfo.userID
group by userName,sex

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

--4
create function orderCount(@userID int)
returns table
as 
return 
select count(*) as '订购次数',sum(quantity) as '订购总册数' from orderBook,orderInfo
where orderBook.orderID = orderInfo.orderID
and userID = @userID
select 102 userID,* from dbo.orderCount(102)

--5
go
create procedure proc1
@userID int
as
select orderInfo.orderID,payment,orderTime,orderState,Convert(decimal(18,2),payment/sum(quantity)) as '平均金额'  from orderInfo,orderBook
where userID = @userID and orderInfo.orderID = orderBook.orderID
group by orderInfo.orderID,payment,orderTime,orderState 
order by orderTime desc

exec proc1 102

--6
go
create procedure proc2
@orderID int,@bookID int,@quantity int
as
insert into orderBook(orderID,bookID,quantity)
values(2016001,1001,2)
update orderInfo
                                                                                        
