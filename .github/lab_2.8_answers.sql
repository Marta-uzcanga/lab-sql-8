-- 1. Write a query to display for each store its store ID, city, and country.
use sakila; 

SELECT store_id, city, country 
FROM sakila.store s
JOIN sakila.address a
ON s.address_id = a.address_id 
JOIN sakila.city c
ON c.city_id = a.city_id
join sakila.country co 
on c.country_id = co.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(amount) as total_money 
FROM sakila.store s
JOIN sakila.staff st
ON s.store_id = st.store_id 
JOIN sakila.payment p
ON p.staff_id = st.staff_id
group by store_id;

-- 3. Which film categories are longest?
select name, avg(length) as duration
from category as c 
join film_category as f
on c.category_id = f.category_id 
join sakila.film fi
on fi.film_id = f.film_id
group by name
order by avg(length) desc;


-- 4. Display the most frequently rented movies in descending order.

select title, count(rental_id) as total_rents
from rental as r 
join inventory as i
on r.inventory_id = i.inventory_id 
join sakila.film f
on f.film_id = i.film_id
group by title
order by count(rental_id) desc
limit 10;

-- 5. List the top five genres in gross revenue in descending order.
select name, sum(amount) as groos_revenue
from category as c 
join film_category as f
on c.category_id = f.category_id 
join sakila.film fi
on fi.film_id = f.film_id
join inventory as i
on fi.film_id = i.film_id
join sakila.rental r
on r.inventory_id = i.inventory_id
join sakila.payment p
on p.rental_id = r.rental_id
group by name
order by sum(amount) desc
limit 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
select title, s.store_id
from sakila.store as s 
join inventory as i
on i.store_id = s.store_id 
join sakila.film f
on f.film_id = i.film_id
group by title
having title = 'Academy Dinosaur' and store_id = 1;

-- 7. Get all pairs of actors that worked together.


select * from film_actor;


select f1.film_id, f1.actor_id as actor_one, f2.actor_id as actor_two from film_actor as f1
join film_actor as f2
on f1.film_id = f2.film_id
where (f1.actor_id < f2.actor_id)
order by film_id, f1.actor_id, f2.actor_id;



-- this lists the actor that acted tegether in one film
-- 8. Get all pairs of customers that have rented the same film more than 3 times.


Select
	f.film_id, 
    C1.CUSTOMER_id as CUSTOMERr_one, 
    C2.CUSTOMER_ID as CUSTOMER_two 
from CUSTOMER as C1
join CUSTOMER as C2
ON C1.CUSTOMER_ID = C2.CUSTOMER_ID
join rental r
on r.customer_id = c1.customer_id
join inventory i
on i.inventory_id = r.inventory_id
join film f
on f.film_id = i.film_id
where (f.film_id <> i.film_id) and (f.film_id < i.film_id)
ORDER BY C1.CUSTOMER_id,C2.CUSTOMER_ID, f.film_id;



-- 9. For each film, list actor that has acted in more films.
select first_name, last_name, title, count(f.film_id)
from actor a
join film_actor fa
on fa.actor_id = a.actor_id
join film f
on f.film_id = fa.film_id
group by FIRST_NAME
having count(f.film_id)>1
ORDER BY TITLE;

