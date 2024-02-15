USE mavenmovies;
-- Basic Aggregate Functions:
-- Question1: Retrieve the total number of rentals made in the Sakila database.
select count(rental_id) from rental;

-- Question2: Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(rental_duration/24) as average_rental_duration_in_days from film;

-- String Functions:
-- Question3: Display the first name and last name of customers in uppercase.
select upper(concat(first_name,' ',last_name)) as full_name from customer;

-- Question4: Extract the month from the rental date and display it alongside the rental ID.
select rental_id,month(rental_date) as month,monthname(rental_date) as month_name,rental_date from rental;

-- GROUP BY:
-- Question5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select count(rental_id) as count_of_rentals,customer_id from rental group by customer_id order by count_of_rentals;

-- Question6: Find the total revenue generated by each store.
select sum(payment.amount) as total_revenue,staff.store_id from payment 
join staff on payment.staff_id = staff.staff_id
group by store_id;

-- Joins:
-- Question7: Display the title of the movie, customers first name, and last name who rented it.
select film.title,customer.first_name,customer.last_name from rental 
join customer on rental.customer_id = customer.customer_id 
join inventory on rental.inventory_id = inventory.inventory_id 
join film on inventory.film_id = film.film_id;

-- Question 8:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
select actor.first_name,actor.last_name from film
join film_actor ON film.film_id = film_actor.film_id
join actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'Gone with the Wind';

-- GROUP BY:
-- Question 1:
-- Determine the total number of rentals for each category of movies.
select count(rental_id),category.name,film_category.category_id from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by category_id;

-- Question 2:
-- Find the average rental rate of movies in each language.
select avg(film.rental_rate),language.language_id,language.name from language
join film on language.language_id = film.language_id
group by language.language_id;

-- Joins:
-- Question 3:
-- Retrieve the customer names along with the total amount they've spent on rentals.
select concat(customer.first_name,' ',customer.last_name) as customer_name,sum(payment.amount) as 
total_amount from customer
join payment on customer.customer_id = payment.customer_id
join rental on payment.rental_id = rental.rental_id
group by customer.customer_id order by total_amount;

-- Question 4:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
select film.title,concat(customer.first_name,' ',customer.last_name) as customer_name,city.city
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join customer on rental.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
where city.city = 'london';

-- Advanced Joins and GROUP BY:
-- Question 5:
-- Display the top 5 rented movies along with the number of times they've been rented.
select count(rental.rental_date) as rented_times,film.title 
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id
order by rented_times desc limit 5;

-- Question 6:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT r.customer_id,c.first_name,c.last_name,
COUNT(DISTINCT i.store_id) AS total_stores_rented
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;




