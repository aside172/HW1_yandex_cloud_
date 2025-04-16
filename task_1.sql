-- Агрегация по валютам
SELECT 
    currency,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions_v2
WHERE currency IN ('USD', 'EUR', 'RUB')
GROUP BY currency;

-- Анализ мошенничества
SELECT 
    is_fraud,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount
FROM transactions_v2
GROUP BY is_fraud;

-- Статистика по дням
SELECT 
    DATE(transaction_date) AS transaction_day,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount
FROM transactions_v2
GROUP BY DATE(transaction_date)
ORDER BY transaction_day;

-- Детализация по месяцам и дням
SELECT 
    MONTH(transaction_date) AS transaction_month,
    DAY(transaction_date) AS transaction_day,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions_v2
GROUP BY MONTH(transaction_date), DAY(transaction_date)
ORDER BY transaction_month, transaction_day;

-- Количество логов на транзакцию
SELECT 
    t.transaction_id,
    COUNT(l.log_id) AS log_count,
    MAX(l.category) AS most_frequent_category
FROM transactions_v2 t
LEFT JOIN logs_v2 l
ON t.transaction_id = l.transaction_id
GROUP BY t.transaction_id
ORDER BY log_count DESC
LIMIT 5;

-- Мошеннические транзакции с логами
SELECT 
    t.transaction_id,
    t.amount,
    t.currency,
    t.is_fraud,
    l.category,
    l.comment
FROM transactions_v2 t
LEFT JOIN logs_v2 l
ON t.transaction_id = l.transaction_id
WHERE t.is_fraud = 1
ORDER BY t.amount DESC;

-- Статистика по категориям логов
SELECT 
    l.category,
    COUNT(DISTINCT t.transaction_id) AS transaction_count,
    SUM(t.amount) AS total_amount
FROM transactions_v2 t
LEFT JOIN logs_v2 l
ON t.transaction_id = l.transaction_id
GROUP BY l.category
ORDER BY total_amount DESC