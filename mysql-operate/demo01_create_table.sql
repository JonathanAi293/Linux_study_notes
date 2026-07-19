--创建、修改用户表
--用途：练习MySQL表的创建、字段修改

create table tb_user (
id int comment ' 编号 ',
name varchar (50) comment ' 姓名 ',
age int comment ' 年龄 ',
gender varchar (1) comment ' 性别 '
) comment ' 用户表 ';
desc tb_user;

alter table tb_user add nickname varchar(20) comment '昵称';
desc tb_user;
alter table tb_user change nickname username varchar(30) comment '用户名';
desc tb_user;
alter table tb_user drop username;
desc tb_user;
alter table tb_user rename to user_table;
desc tb_user;
desc user_table;
