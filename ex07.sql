alter login sa enable
alter login sa with password = '123456'
create login L1 with password = '123' 
--默认创建后只有连接服务器权限，不能用use bookstore
create user U1 from login L1
--创建用户后只有访问权限，能用use bookstore
