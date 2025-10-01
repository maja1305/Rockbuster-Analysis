-- SQL query to calculate the average spending of the top 5 customers in the most populated cities and countries
SELECT AVG(total_amount_paid.total_payment) AS average_amount_paid
FROM
(SELECT cust.customer_id, cust.first_name, cust.last_name, cty.city, ctry.country,
SUM(pay.amount) AS total_payment
FROM customer AS cust
INNER JOIN payment AS pay ON cust.customer_id=pay.customer_id
INNER JOIN address AS adr ON cust.address_id=adr.address_id
INNER JOIN city AS cty ON adr.city_id=cty.city_id
INNER JOIN country AS ctry ON cty.country_id=ctry.country_id
WHERE cty.city IN (
    SELECT city.city
    FROM customer
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    GROUP BY city.city
    ORDER BY COUNT(customer.customer_id) DESC
    LIMIT 10
)
AND ctry.country IN (
    SELECT country.country
    FROM customer
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    INNER JOIN country ON city.country_id = country.country_id
    GROUP BY country.country
    ORDER BY COUNT(customer.customer_id) DESC
    LIMIT 10
)GROUP BY cust.customer_id, cust.first_name, cust.last_name, cty.city, ctry.country
ORDER BY total_payment DESC
LIMIT 5)
AS total_amount_paid;
