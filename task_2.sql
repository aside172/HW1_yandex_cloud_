-- По статусу оплаты
SELECT 
    payment_status,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_sum,
    AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY payment_status;

-- Общая статистика товаров
SELECT 
    COUNT(*) AS total_items,
    SUM(product_price * quantity) AS total_revenue,
    AVG(product_price) AS avg_price
FROM order_items;

-- По дням
SELECT 
    toDate(order_date) AS order_day,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_sum
FROM orders
GROUP BY order_day
ORDER BY order_day;

-- Активные пользователи
SELECT 
    user_id,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 5;

-- Самые частые товары
SELECT 
    product_name,
    SUM(quantity) AS total_sold
FROM order_items
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Средний чек по пользователю
SELECT 
    user_id,
    ROUND(AVG(total_amount), 2) AS avg_order
FROM orders
GROUP BY user_id;

-- Товары с выручкой > 1000
SELECT 
    product_name,
    SUM(product_price * quantity) AS revenue
FROM order_items
GROUP BY product_name
HAVING revenue > 1000
ORDER BY revenue DESC;
