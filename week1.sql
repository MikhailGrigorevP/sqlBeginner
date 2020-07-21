
# # # 1.2 # # #

use billing_simple;

# Выведите поступления денег от пользователя с email 'vasya@mail.com'.
# В результат включите все столбцы таблицы и не меняйте порядка их вывода. 
# Если, конечно, хотите успешно пройти проверку результата запроса )
 
SELECT * FROM billing WHERE payer_email = 'vasya@mail.com'

# Добавьте в таблицу одну запись о платеже со следующими значениями:
# 	email плательщика: 'pasha@mail.com'
# 	email получателя: 'katya@mail.com'
#	сумма: 300.00
# 	валюта: 'EUR'
# 	дата операции: 14.02.2016
# 	комментарий: 'Valentines day present)'

insert into billing values ('pasha@mail.com', 'katya@mail.com', 300.00, 'EUR', '2016-02-14', 'Valentines day present)');

# Измените адрес плательщика на 'igor@mail.com' для всех записей таблицы,
# где адрес плательщика 'alex@mail.com'

update billing set payer_email = 'igor@mail.com' 
	where  payer_email = 'alex@mail.com';

# Удалите из таблицы записи, где адрес плательщика или 
# адрес получателя установлен в неопределенное значение или пустую строку.

delete from billing 
	where recipient_email is null or 
	payer_email is null or 
	recipient_email = "" or 
	payer_email = "";

# # # 1.3 # # #

use project_simple;

# Выведите общее количество заказов компании.

select count(1) from project;

use store_simple;

# Выведите количество товаров в каждой категории. Результат должен содержать два столбца: 
# 	название категории, 
# 	количество товаров в данной категории.

select category, count(1) from store group by category;

# Выведите 5 категорий товаров, продажи которых принесли наибольшую выручку. 
# Под выручкой понимается сумма произведений стоимости товара на количество проданных 
# единиц. Результат должен содержать два столбца: 
# 	название категории,
# 	выручка от продажи товаров в данной категории.

select category, sum(sold_num * price) as sold
from store group by category order by sold desc limit 5;

# Выведите в качестве результата одного запроса общее количество заказов, сумму стоимостей (бюджетов)
# всех проектов, средний срок исполнения заказа в днях.

select count(1), sum(budget), avg(datediff(project_finish, project_start)) from project;