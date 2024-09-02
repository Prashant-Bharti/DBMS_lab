create database person;
use person;
create table teacher(id int , name varchar(5),marks int );
insert into teacher(id,name,marks) values (1,"abc",60);
insert into teacher(id,name,marks) values (3,"l2@mn",40);
insert into teacher(id,name,marks) values (5,"x/1syz",50);
insert into teacher(id,name,marks) values (3,"lmn",80);
insert into teacher(id,name,marks) values (5,"xyz",100);

select name,avg(marks) from teacher group by name order by avg(marks) asc;

select*from teacher;
drop database person;
drop table teacher;
update table teacher 
delete 