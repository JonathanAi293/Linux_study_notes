--demo01
--用途：练习MySQL表的创建、字段修改、数据的插入与修改

--建表
create table tb_user (
id int comment ' 编号 ',
name varchar (50) comment ' 姓名 ',
age int comment ' 年龄 ',
gender varchar (1) comment ' 性别 '
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 comment '用户表';
desc tb_user;

--修改、删除字段
alter table tb_user add nickname varchar(20) comment '昵称';
desc tb_user;
alter table tb_user change nickname username varchar(30) comment '用户名';
desc tb_user;
alter table tb_user drop username;
desc tb_user;
alter table tb_user rename to user_table;
desc user_table;

--添加、修改、删除数据
insert into user_table values(1, '李明', 25, '男');
insert into user_table values(2, '王琳', 24, '女');
select * from user_table;
update user_table set age=26 where id=1;
select * from user_table;
delete from user_table where id=2;
select * from user_table;
