-- 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
-- (created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося
-- списка. (используйте LEAD или LAG)

-- создание представления
USE semimar_4;
CREATE VIEW sorted_messages AS
SELECT *
FROM messages
ORDER BY created_at ASC;  -- asc - сортировка по возрастанию; можно не использовать, но для запоминания пока использую

-- проверка залитой таблицы с сортировкой 
SELECT * FROM sorted_messages;

SELECT id,
	created_at,
	LEAD(created_at) OVER (ORDER BY created_at ASC) AS "lead",
    TIMEDIFF (LEAD(created_at) OVER (ORDER BY created_at ASC), created_at) AS difference
FROM sorted_messages;

SELECT id,
	created_at,
	LAG(created_at) OVER (ORDER BY created_at ASC) AS "lag",
    TIMEDIFF (LAG(created_at) OVER (ORDER BY created_at ASC), created_at) AS difference
FROM sorted_messages;
