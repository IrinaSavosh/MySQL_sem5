-- Задача 2. Получить информацию об оценках 
-- Пети по физике по четвертям: 
-- текущая успеваемость 
-- оценка в следующей четверти
-- оценка в предыдущей четверти

SELECT 
	*, 
    LAG(grade, 2, 0) OVER grd AS lag_grade,
    LEAD(grade, 2, 0) OVER grd AS lead_grade
FROM academic_record
WHERE name = "Петя" AND subject = "физика"
WINDOW grd AS(ORDER BY quartal);