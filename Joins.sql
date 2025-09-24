-- Query to find the top 10 countires for Rockbuster in terms of customer numbers
SELECT ctry.country,
COUNT(customer_id) AS numb_of_customers
FROM customer AS cust
INNER JOIN address AS adr ON cust.address_id=adr.address_id
INNER JOIN city AS cty ON adr.city_id=cty.city_id
INNER JOIN country AS ctry ON cty.country_id=ctry.country_id
GROUP BY ctry.country
ORDER BY numb_of_customers DESC
LIMIT 10;

-- Query to find top 10 cities within the top 10 countries by customer count
SELECT cty.city, ctry.country,
COUNT(customer_id) AS numb_of_customers
FROM customer AS cust
INNER JOIN address AS adr ON cust.address_id=adr.address_id
INNER JOIN city AS cty ON adr.city_id=cty.city_id
INNER JOIN country AS ctry ON cty.country_id=ctry.country_id
WHERE ctry.country IN('India', 'China', 'United States', 'Japan','Mexico','Brazil','Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY ctry.country, cty.city
ORDER BY numb_of_customers DESC
LIMIT 10;


