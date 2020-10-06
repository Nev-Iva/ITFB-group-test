use selpo;

-- 3.1 Выбрать все марки гречки;
select * from goods where catalog_id in (select id from catalogs where name = 'Гречка');

-- 3.2 Выбрать все транзакции с суммой менее 1 рубля;
select * from full_purchase where sum_purch < 1;

-- 3.3 Выбрать все транзакции постоянного покупателя Иванова;
select * from full_purchase where user_id in (select id from clients where lastname = 'Иванов');

-- 3.4 Выбрать топ-5 покупателей, которые совершили больше всего покупок;
SELECT clients.firstname as name, clients.lastname as surname,
 full_purchase.user_id as user_id, count(full_purchase.id) as count_purch
FROM clients INNER JOIN full_purchase ON full_purchase.user_id = clients.id 
group by user_id order by count_purch DESC limit 5;

-- 3.5 Сформировать выгрузку (отчет), в котором будет указано, сколько в среднем в месяц тратит Иванов в магазине.
SELECT EXTRACT(YEAR_MONTH FROM purch_date) AS ym, count(id), SUM(sum_purch) AS sum, AVG(sum_purch) as avg
FROM full_purchase where user_id in (select id from clients where lastname = 'Иванов')
GROUP BY EXTRACT(YEAR_MONTH FROM purch_date); 
