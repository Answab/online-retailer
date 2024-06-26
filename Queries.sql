-- creating and using of new database

CREATE DATABASE online_retailer;
USE online_retailer;

-- creating tables and inserting values into it

CREATE TABLE customers (customer_id INT PRIMARY KEY, first_name VARCHAR (30) NOT NULL, last_name VARCHAR (30) NOT NULL, email VARCHAR (30) NOT NULL);
INSERT INTO customers (customer_id, first_name, last_name, email) VALUES (123,'David', 'John', 'david.john@gmail.com'), (456,'Mary', 'Kurian', 'mary26@yahoo.com'), (789,'Anwar', 'Basheer', 'anwar.b@gmail.com'), (357,'Sangeeth','Kumar','sangeeth@gmail.com'), (468,'Wafa','Hameed','hameedwafa@gmail.com');

CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT NOT NULL, order_date DATE NOT NULL, FOREIGN KEY (customer_id) REFERENCES customers (customer_id));
INSERT INTO orders (order_id, customer_id, order_date) VALUES (2124,123,'2024-06-22'), (3493,456,'2024-06-25'), (8378,789,'2024-06-23'), (4503,357,'2024-06-24'), (6754,468,'2024-06-28'), (7482,468,'2024-06-20'), (9056,123,'2024-06-22'), (4372,789,'2024-06-21'), (3663,468,'2024-06-26'), (8249,456,'2024-06-23'), (6857,357,'2024-06-22'), (8614,468,'2024-06-24'), (4699,123,'2024-06-21'), (6455,468,'2024-06-22'), (7773,123,'2024-06-21'), (8765,456,'2024-06-20'), (3354,468,'2024-06-20'), (9082,468,'2024-06-19');

CREATE TABLE products (product_id VARCHAR (10) PRIMARY KEY, product_name VARCHAR (30) NOT NULL, price FLOAT NOT NULL);
INSERT INTO products (product_id, product_name, price) VALUES ('gdb','Gooday Biscuits',40), ('pps','Pepsi Softdrink',45), ('cms','Cavins Milkshake',56), ('cbs','Cadbury Silk Chocolate',75), ('mgn','Maggi Noodles',23), ('skc','SKC Ghee',35),('mbi','Merriboy Ice Cream',100);

CREATE TABLE order_items (order_item_id INT PRIMARY KEY, order_id INT NOT NULL, product_id VARCHAR (10) NOT NULL, quantity FLOAT NOT NULL, price FLOAT NOT NULL, FOREIGN KEY (order_id) REFERENCES orders (order_id), FOREIGN KEY (product_id) REFERENCES products (product_id));
INSERT INTO order_items (order_item_id, order_id, product_id,quantity,price) VALUES (12,2124,'gdb',4,160), (26,3493,'pps',5,235), (35,8378,'cms',3,168), (49,4503,'cbs',2,150), (53,6754,'mgn',4,92);

-- displaying all the tables and the data in them

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_items;

-- finding the total number of orders placed by each customer

SELECT cust.customer_id, cust.first_name, cust.last_name, cust.email, COUNT(ord.order_id) AS number_of_orders FROM customers cust
JOIN orders ord ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id, cust.first_name, cust.last_name, cust.email
ORDER BY number_of_orders DESC;

-- listing the products that have never been ordered

SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_items);

-- finding the customer who has spent the most money

SELECT cust.customer_id, cust.first_name, cust.last_name, SUM(orditem.quantity * orditem.price) AS total_spent FROM customers cust
JOIN orders ord ON cust.customer_id = ord.customer_id
JOIN order_items orditem ON ord.order_id = orditem.order_id
GROUP BY cust.customer_id, cust.first_name, cust.last_name
ORDER BY total_spent DESC
LIMIT 1;










