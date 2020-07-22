use store;

# Выведите все позиций списка товаров принадлежащие какой-либо категории с названиями товаров и названиями категорий.
# Список должен быть отсортирован по названию товара, названию категории. 
 
SELECT good.name AS good_name, category.name AS category_name FROM category_has_good
  INNER JOIN good ON category_has_good.good_id = good.id
    INNER JOIN category ON category_has_good.category_id = category.id
    ORDER BY good.name, category.name;
    
# Выведите список клиентов (имя, фамилия) и количество заказов данных клиентов, имеющих статус "new".
 
SELECT client.first_name AS first_name, client.last_name AS last_name, count(sale.status_id) AS new_sale_sum
 FROM client
  INNER JOIN sale ON client.id = sale.client_id
  INNER JOIN status ON sale.status_id = status.id
  WHERE status.name = 'new'
    GROUP BY client.first_name, client.last_name;
    
# Выведите список товаров с названиями товаров и названиями категорий, 
# в том числе товаров, не принадлежащих ни одной из категорий. 

SELECT good.name AS good_name, category.name AS category_name FROM category_has_good
  RIGHT JOIN good ON category_has_good.good_id = good.id
    LEFT  JOIN category ON category_has_good.category_id = category.id
    ORDER BY good.name, category.name;
    
# Выведите список товаров с названиями категорий, в том числе товаров, 
# не принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни одного товара.

SELECT good.name AS good_name, category.name AS category_name FROM category_has_good
  RIGHT JOIN good ON category_has_good.good_id = good.id
    LEFT  JOIN category ON category_has_good.category_id = category.id
UNION
SELECT good.name AS good_name, category.name AS category_name FROM category_has_good
  LEFT JOIN good ON category_has_good.good_id = good.id
    RIGHT  JOIN category ON category_has_good.category_id = category.id
    WHERE good.name is NULL;
    
# Выведите список всех источников клиентов и суммарный объем заказов по каждому источнику. 
# Результат должен включать также записи для источников, по которым не было заказов.

SELECT source.name AS source_name , sum(sale.sale_sum) AS sale_sum FROM client
  RIGHT JOIN source ON client.source_id = source.id
    LEFT  JOIN sale ON client.id = sale.client_id
    GROUP BY source.name;
    
# Выведите названия товаров, которые относятся к категории 'Cakes' или фигурируют в заказах текущий статус которых 'delivering'. 
# Результат не должен содержать одинаковых записей. В запросе необходимо использовать оператор UNION для объединения выборок по разным условиям.

SELECT good.name AS good_name FROM category_has_good
    JOIN good ON category_has_good.good_id = good.id
	JOIN category ON category_has_good.category_id = category.id
    WHERE category.name = 'Cakes'
UNION
SELECT good.name AS good_name FROM good
	JOIN sale_has_good ON good.id = sale_has_good.good_id
    JOIN sale ON sale_has_good.sale_id = sale.id
    JOIN status ON sale.status_id = status.id
    WHERE status.name = 'delivering';
    
# Выведите список всех категорий продуктов и количество продаж товаров, относящихся к данной категории. 
# Под количеством продаж товаров подразумевается суммарное количество единиц товара данной категории, фигурирующих в заказах с любым статусом.

SELECT category.name AS good_name, sale.sale_num AS sale_num FROM category_has_good
    JOIN good ON category_has_good.good_id = good.id
	JOIN category ON category_has_good.category_id = category.id
    WHERE category.name = 'Cakes'

