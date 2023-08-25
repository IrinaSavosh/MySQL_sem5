-- 2. Найдите кол-во отправленных сообщений каждым пользователем и выведите
-- ранжированный список пользователей, указав имя и фамилию пользователя, количество
-- отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
-- количеством сообщений) . (используйте DENSE_RANK)

USE semimar_4;

-- создание представления
CREATE VIEW message_quantity AS
SELECT u.firstname,
	u.lastname, 
(SELECT count(*) 
FROM messages AS m
WHERE m.from_user_id = u.id
GROUP BY m.from_user_id) AS message_count
FROM users AS u
ORDER BY message_count DESC;

SELECT * FROM message_quantity;

-- ранжирование
SELECT firstname,
	lastname,
    message_count,
    DENSE_RANK () over (ORDER BY message_count BY)
FROM message_quantity;