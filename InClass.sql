--4(1)
select book.bookID,title,price,count(*) orderCount
from book,orderBook
where book.bookID = orderBook.bookID
group by book.bookID,title,price
having count(*)>
(select count(*)/count(distinct bookID) from orderBook)

--4(2)
select orderID,userID,orderTime,orderState from orderInfo
where not exists
(select * from orderBook A where orderID = 2016003 and not exists(
select * from orderBook B where B.orderID=orderInfo.orderID and B.bookID = A.bookID))

select orderID,userID,orderTime,orderState from orderInfo
where not exists
(select bookID from orderBook A where orderID = 2016003 
 except
 select bookID from orderBook B where orderID = orderInfo.orderID)

--4(3)
select  userInfo.* from userInfo
where userID in (select userID from orderInfo,orderBook,book 
where orderInfo.orderID = orderBook.orderID 
and orderBook.bookID = book.bookID 
and press = '清华大学出版社')

--4(4)
select distinct userInfo.*  from userInfo,orderInfo,orderBook
where orderInfo.orderID = orderBook.orderID
and orderInfo.userID = userInfo.userID
and bookID in (select bookID from userInfo,orderInfo,orderBook 
where orderInfo.orderID = orderBook.orderID 
and orderInfo.userID = userInfo.userID
and userName = '王丽')

--4(5)
select userID,C1.* from orderInfo A1,orderBook B1,book C1
where A1.orderID = B1.orderID
and B1.bookID = C1.bookID
and price > (select avg(price) from orderInfo A2,orderBook B2,book C2
where A2.orderID = B2.orderID
and B2.bookID = C2.bookID
and A2.userID = A1.userID)

--4(6)
select A1.* from userInfo A1
where not exists(select * from userInfo B1,orderInfo B2,orderBook B3 
where B1.userID = B2.userID
and B2.orderID = B3.orderID
and B1.userName = '张三'
and not exists(select * from orderInfo C2,orderBook C3
where C2.orderID = C3.orderID
and C2.userID = A1.userID 
and C3.bookID = B3.bookID))

--触发器
create trigger tg1
	on orderBook
	after insert
as
	begin
		declare @num int
		select @num = quantity from inserted
		update book set stockAmount = stockAmount - @num
			where bookID in
			(select bookID from inserted)
	end
