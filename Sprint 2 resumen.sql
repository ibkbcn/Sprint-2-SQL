# Se da por entendido que anteriormente ya se ha ejecutado la estructura de la base de datos y se han insertado los datos en las distintas tablas. (Respectivos al Ejercicio 1) 
# Tablas company y transaction creadas y con datos.

#Ejercició 2

SELECT distinct country FROM company JOIN transaction ON company.id = transaction.company_id;

SELECT count(distinct country) FROM company JOIN transaction ON  company.id = transaction.company_id;

SELECT company_name, avg(amount) 
FROM company 
JOIN transaction ON company.id = transaction.company_id 
WHERE transaction.declined = 0
group by company_name
order by avg(amount) DESC
LIMIT 1;

#Ejercició 3

SELECT id FROM transaction WHERE company_id IN (SELECT id FROM company WHERE country = 'Germany');  

SELECT company_name
FROM company
WHERE id IN (
    SELECT company_id
    FROM transaction 
    WHERE amount > (
        SELECT AVG(amount) 
        FROM transaction
    )
);   

SELECT c.company_name 
FROM company c 
WHERE c.id NOT IN (
	SELECT t.company_id 
    FROM transaction t);
    
#testeo
SELECT c.company_name, count(t.id)
FROM company c 
JOIN transaction t ON c.id = t.company_id
GROUP BY c.company_name
ORDER BY count(t.id);


#Nivell 2

#Ejercicio 1
SELECT DATE(timestamp), SUM(amount)
FROM transaction
WHERE declined = 0
GROUP BY DATE(timestamp)
ORDER BY sum(amount) DESC
LIMIT 5;   
#funcion DATE

#Ejercicio 2
SELECT company.country, avg(amount) FROM company JOIN transaction ON company.id = transaction.company_id 
WHERE declined = 0
GROUP BY company.country
ORDER BY avg(amount) DESC;  

#Ejercicio 3

# Mostra el llistat aplicant JOIN i subconsultes. (SelfJoin)

SELECT t.id
FROM transaction t
WHERE t.company_id IN
(SELECT c1.id 
FROM company c1
JOIN company c2
WHERE c1.country = c2.country
AND c2.company_name = 'Non Institute');


# Mostra el llistat aplicant solament subconsultes.

SELECT id
FROM transaction
WHERE company_id IN(
	SELECT id 
	FROM company 
	WHERE country = (
			(SELECT country
			FROM company 
			WHERE company_name = "Non Institute")
            )
		);
        

# Nivell 3

# Ejercicio 1 
SELECT c.company_name, c.phone,c.country,DATE(t.timestamp),t.amount
FROM company c
JOIN transaction t
ON c.id = t.company_id
WHERE t.amount BETWEEN 100 AND 200  AND  DATE(t.timestamp) IN ('2021-04-29','2021-07-20','2022-03-13')
ORDER BY t.amount DESC;

#Ejercicio 2  cantidad transacciones por empresa y si tienen más de 4 o menos
SELECT c.company_name, count(t.id) AS transaction_count, 
CASE WHEN count(t.id) > 4  THEN 'more than 4'
ELSE 'is 4 or lower'
END AS clasification_count
FROM company c
JOIN transaction t ON c.id = t.company_id
GROUP BY  c.company_name;

