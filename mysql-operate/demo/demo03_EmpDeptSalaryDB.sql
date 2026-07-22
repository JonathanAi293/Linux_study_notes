--demo03:基于企业人事薪资数据库的 SQL 查询案例
--简介：基于 MySQL 搭建部门、员工、薪资等级三表结构，内置业务测试数据，包含 11 道经典多表查询习题，覆盖连接查询、子查询、分组统计、薪资分级、部门均值对比等核心 SQL 语法，实现企业人事薪资各类统计筛选需求。

--准备数据
create table dept(id int primary key auto_increment,name varchar(20))comment '部门表' CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
create table emp(
id int primary key auto_increment,
name varchar(20),
age tinyint unsigned,
job varchar(20),
salary int,
entrydate date,
managerid int comment '上级id',
dept_id int comment '部门id',
constraint fk_emp_dept foreign key(dept_id) references dept(id)
)comment '员工表' CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
create table salgrade(
    grade int,
    losal int,
    hisal int
) comment '薪资等级表';
insert into dept(name)values
('研发部'),
('市场部'),
('财务部'),
('销售部'),
('总经办'),
('人事部');
insert into emp values
(1,'王建国',66,'总裁',20000,'2000-01-01',null,5),
(2,'李志强',20,'项目经理',12500,'2005-12-05',1,1),
(3,'刘宏',33,'开发',8400,'2000-11-03',2,1),
(4,'马明远',48,'开发',11000,'2002-02-05',2,1),
(5,'周凯',43,'开发',10500,'2004-07-09',3,1),
(6,'陈小雨',19,'产品助理',6600,'2004-10-12',2,1),
(7,'吴桂兰',60,'财务总监',8500,'2002-09-12',1,3),
(8,'林晓燕',19,'会计',4800,'2006-06-02',7,3),
(9,'郑佳',23,'出纳',5250,'2009-05-12',7,3),
(10,'赵海峰',20,'市场部总监',12500,'2002-02-05',1,2),
(11,'孙卫国',56,'市场职员',3750,'2006-12-05',10,2),
(12,'钱浩',19,'市场职员',3750,'2006-05-25',10,2),
(13,'冯子安',19,'市场职员',5500,'2002-11-05',10,2),
(14,'高长青',88,'销售总监',14000,'2003-06-15',1,4),
(15,'黄俊',38,'销售',4600,'2003-07-05',14,4),
(16,'徐博文',40,'销售',4600,'2004-09-18',14,4),
(17,'郭明',42,null,2000,'2010-06-16',1,null);
insert into salgrade(grade,losal,hisal) values
(1,0,3000),
(2,3001,5000),
(3,5001,8000),
(4,8001,10000),
(5,10001,15000),
(6,15001,20000),
(7,20001,25000),
(8,25001,30000);

--查询数据
--1.查询员工的姓名、年龄、职位、部门信息。(隐式内连接)
select emp.name,emp.age,emp.job,dept.name from emp,dept where emp.dept_id=dept.id;
--2.查询年龄小于 30 岁的员工姓名、年龄、职位、部门信息。(显式内连接)
select emp.name,emp.age,emp.job,dept.name from emp inner join dept on emp.age<=30&&emp.dept_id=dept.id; 
--3.查询拥有员工的部门 ID、部门名称。
select distinct dept.id,dept.name from dept left join emp on dept.id=emp.dept_id;
--4.查询所有年龄大于 40 岁的员工，及其归属的部门名称；如果员工没有分配部门，也需要展示出来。
select emp.name,emp.age,dept.name from emp left join dept on emp.dept_id=dept.id where emp.age>=40; 
--5.查询所有员工的工资等级。
select e.name,s.grade from emp e join salgrade s on e.salary>=s.losal&&e.salary<=s.hisal;
--6.查询 "研发部" 所有员工的信息及工资等级。
select e.*,s.grade '工资等级' from emp e join salgrade s on e.salary>=s.losal&&e.salary<=s.hisal where e.dept_id=(select id from dept where name='研发部');
--7.查询 "研发部" 员工的平均工资。
select avg(salary) from emp where dept_id=(select id from dept where name='研发部');
--8.查询工资比 "吴桂兰" 高的员工信息。
select * from emp where salary>(select salary from emp where name='吴桂兰');
--9.查询比平均薪资高的员工信息。
select * from emp where salary>(select avg(salary) from emp);
--10.查询低于本部门平均工资的员工信息。
select emp.* from emp join (select dept_id,avg(salary) asalary from emp group by dept_id) a on emp.dept_id=a.dept_id&&emp.salary<a.asalary;
--select * from emp e where salary<(select avg(salary) from emp where e.dept_id=dept_id);
--11.查询所有的部门信息，并统计部门的员工人数。
select dept.*,count(emp.id) '人数' from dept left join emp on dept.id=emp.dept_id group by dept.id;
