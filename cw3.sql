-- Задача 3. Для базы lesson_4 решите :
-- создайте представление, в котором будут выводится все сообщения, в которых принимал участие пользователь с id = 1;
use semimar_4;
CREATE VIEW msg AS
SELECT * FROM messages 
WHERE 
	from_user_id = 1
    OR to_user_id = 1;
    
SELECT * from msg;
SELECT id, body from msg;
-- найдите друзей у  друзей пользователя с id = 1 и поместите выборку в представление; 
-- (решение задачи с помощью CTE)
WITH msg_cte AS
	(SELECT IF(initiator_user_id = @fr, target_user_id, initiator_user_id) AS friend
	FROM friend_requests
	WHERE 
		(initiator_user_id = (@fr := 1) OR
		target_user_id = @fr) AND 
		status = 'approved')
SELECT IF(initiator_user_id IN (SELECT friend FROM msg_cte), target_user_id, initiator_user_id) AS friend_of_friends
FROM friend_requests
WHERE (initiator_user_id IN (SELECT friend FROM msg_cte) OR
    target_user_id IN (SELECT friend FROM msg_cte)) AND 
    status = 'approved' AND 
    (initiator_user_id != @fr AND
	target_user_id != @fr);
--  найдите друзей у  друзей пользователя с id = 1. 
-- (решение задачи с помощью представления “друзья”)


CREATE OR REPLACE VIEW msg_veiw AS
	SELECT initiator_user_id AS friend
	FROM friend_requests
	WHERE 
		target_user_id = 1 AND 
		status = 'approved'
	UNION
    SELECT target_user_id
	FROM friend_requests
	WHERE 
		initiator_user_id = 1 AND 
		status = 'approved';
        
SELECT * FROM msg_veiw;
SELECT fr.target_user_id FROM friend_requests as fr
JOIN msg_veiw on msg_veiw.friend = fr.initiator_user_id
WHERE target_user_id != 1 AND fr.status = 'approved'
UNION
SELECT fr.initiator_user_id FROM friend_requests as fr
JOIN msg_veiw ON msg_veiw.friend = fr.target_user_id
WHERE initiator_user_id != 1 AND fr.status = 'approved';