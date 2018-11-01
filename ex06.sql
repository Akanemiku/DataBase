--1(1)
update orderInfo set payment = 
(select sum(price*quantity) from book,orderBook
where book.bookID = orderBook.bookID
and orderBook.orderID = orderInfo.orderID)

--1(2)
insert into bookstas
select book.bookID,title,categoryID,price,sum(quantity)
from book,orderBook
where book.bookID = orderBook.bookID 
and categoryID = 2
group by book.bookID,title,categoryID,price
--除了聚合函数之外的，都放到group by中

--1(3)
insert into userstas
select userInfo.userID,userName,count(*),sum(payment)
from userInfo,orderInfo
where orderInfo.userID = userInfo.userID
and userState in('正常使用','锁定')
group by userInfo.userID,userName

--1(4)
update userInfo set level = 
(select 
case 
when sum(payment) between 100 and 200 then 1
when sum(payment) between 200 and 300 then 2
when sum(payment) > 300 then 3
else 0 
end
from orderInfo
where orderInfo.userID = userInfo.userID)

--1（5）
--生成订单
insert into orderInfo calues('2016008','102',null,getdate(),'未提交')
--插入图书购买记录
insert into orderBook values('2016008','1001',1)
--更新订单
update orderInfo set payment = 
(select sum(price*quantity) from book,orderBook
where book.bookID = orderBook.bookID
and orderBook.orderID = '2016008'),orderState = '已提交'
where orderID = '2016008'
--更新库存
update book set stockAmount = stockAmount-(select quantity from orderBook
where orderID = '2016008' and bookID = book.bookID)
where bookID in
where bookID in (select bookID from orderBook where orderID = '2016008')

