-- 1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
-- город и пол), которые не старше 20 лет.

USE semimar_4;
CREATE VIEW at_least_20_yers_old AS 
SELECT id, firstname, lastname,
(SELECT hometown FROM profiles WHERE profiles.user_id = u.id) AS hometown,
(SELECT gender FROM profiles WHERE profiles.user_id = u.id) AS gender
FROM users AS u
WHERE u.id IN (SELECT profiles.user_id FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) < 20);

SELECT * FROM at_least_20_yers_old;

-- DROP VIEW at_least_20_yers_old;




