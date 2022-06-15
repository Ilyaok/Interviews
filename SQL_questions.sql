/*
1. Какие знаешь Constraints?
2. Чем truncate отличается от drop?
3. Какие есть уровни изоляции транзакций?
4. Что такое партиционирование, и зачем оно нужно?
5. Что такое индексы и зачем они нужны?
6. Как в Hive-таблице изменить тип данных столбца?
 */

-- Дан код. Напиши результаты select-ов
create table t1 (id int, val int);
create table t2 (id int, val int);

insert into t1
values
(1, 100),
(1, 120),
(2, 200),
(3, 300),
(3, 330),
(null, 1000),
(4, null);

insert into t2
values
(1, 1100),
(2, 2000),
(2, 2200),
(3, 3000),
(null, null);

select * from t1 inner join t2 on t1.id = t2.id;
select * from t1 left join t2 on t1.id = t2.id;
select * from t1 right join t2 on t1.id = t2.id;
select * from t1 full join t2 on t1.id = t2.id;

-- Напиши вычисление нарастающего итога в новом поле 'salary_total' для каждого сотрудника (оконными ф-циями)
create table charges(date date, employee varchar(20), salary int);

insert into charges values
('2022-01-01', 'John', 1000 ),
('2022-01-01', 'Liza', 2000 ),
('2022-01-01', 'Mike', 3000 ),
('2022-02-01', 'John', 500 ),
('2022-02-01', 'Liza', 700 ),
('2022-02-01', 'Mike', 900 ),
('2022-03-01', 'John', 1200 ),
('2022-03-01', 'Liza', 1300 ),
('2022-03-01', 'Mike', 1400 )
;

select * from charges;

select date, employee, salary,
       sum(salary) over (partition by employee order by date)
from charges;

select
    date, employee, salary,
    sum(salary) over(partition by employee rows between unbounded preceding and current row ) as salary_total
from charges;


