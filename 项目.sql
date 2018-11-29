create table Manufacturer
(
	mid int primary key,
	mname varchar(20) not null unique,
	maddress varchar(50),
	mphone varchar(20)
)
create table Goods
(
	gid int primary key,
	mid int foreign key references.Manufacturer,
	gname varchar(20) not null unique,
	gprice int not null
)
create table Stock
(
	gid int foreign key references.Goods,
	quantity int not null default(0) check(quantity > 0)
)

create table StockIn
(
	iid int primary key,
	inum int not null,
	idate datetime
)
create table StockOut
(
	oid int primary key,
	onum int not null,
	odate datetime 
)
create table Stuff
(
	sid int primary key,
	sname varchar(20) not null,
	sphone varchar(20),
	position varchar(20) not null
)

insert into Manufacturer values(1000,'江南皮革厂','浙江温州','12345678')
insert into Manufacturer values(1001,'哇哈哈集团有限公司','浙江杭州','87654321')
insert into Goods values(1,1000,'牛皮大衣',9999)
insert into Goods values(2,1001,'哇哈哈矿泉水',1)
insert into Stock values(1,2)
insert into Stock values(2,100)
