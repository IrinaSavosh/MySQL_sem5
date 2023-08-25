-- Задача 1. Получить с помощью оконных функции:
-- средний балл ученика
-- наименьшую оценку ученика
-- наибольшую оценку ученика
-- сумму всех оценок
-- количество всех оценок

SELECT 
	distinct name, 
    AVG(grade) OVER (partition by name ) as avg_grade,
    MIN(grade) OVER (partition by name ) as min_grade,
    MAX(grade) OVER (partition by name ) as max_grade,
    SUM(grade) OVER (partition by name ) as sum_grade,
    COUNT(grade) OVER (partition by name ) as count_grade
FROM academic_record;