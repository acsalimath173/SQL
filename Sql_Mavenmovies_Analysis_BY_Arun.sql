use mavenmovies;
show tables;
# ACTOR_TABLE
select * from actor;
select * from actor order by last_update;
select last_update,count(*) from actor group by last_update;
select first_name,last_name from actor where last_name like "a%d"; 
select first_name,last_name from actor where last_name like "a%" ;
select * from actor where actor_id > 10;

#ACTOR_AWARD
select * from actor_award;
-- How many awards are taken by each actors 
#Using Subqueries
select actor_id , count(*),first_name,last_name from actor_award group by actor_id ;
#Using Joins
select actor.actor_id,actor.first_name,count(actor_award_id) as number_of_awards from actor 
join actor_award on actor.last_name = actor_award.last_name 
group by actor.actor_id
order by number_of_awards desc;

-- How many actors are not taken award 
#Using subqueries
select actor_id from actor where actor_id not in (select actor_id from actor_award);
#Using Joins
select actor.actor_id,actor.first_name,count(actor_award_id) as number_of_awards from actor 
join actor_award on actor.last_name = actor_award.last_name 
group by actor_id
having number_of_awards = 0; -- is null

-- Find awards like Emmy,Oscar
select * from actor_award
where awards = ("Emmy"and"Oscar");   -- paranthesis is must to get desired output 
select * from actor_award 
where awards = "Emmy"and"Oscar"and"Tony";  -- if not error 

# Customer->Address->City->Country
-- Finding indian customers 
select c.first_name,c.last_name,ct.city,cn.country from customer c 
join address a on c.address_id = a.address_id 
join city ct on a.city_id = ct.city_id 
join country cn on cn.country_id = ct.country_id
where country = "India";

# Film->Film_actor->Film_category->Film_text
select * from film;
-- Find films whose rating="NC-17"
select title from film where rating = "NC-17";

-- Using case statements distribute rental_rate 
select film_id,title,rental_rate,
case 
  when rental_rate < 1 then "Poor"
  when rental_rate > 1 and rental_rate < 3 then "Good"
  when rental_rate > 3 and rental_rate < 5 then "Very good"
end 
from film;

-- find the films whose rental_duration is greter than 5
select * from film where rental_duration > 5;

-- find films and actors_id  and how many ratings have each films 
select fa.actor_id,f.film_id,f.rating , count(*) from film f 
join film_actor fa on f.film_id = fa.film_id
group by f.rating order by count(*) desc;

-- Find how many categories of films are there and write those categoris 
select c.name,fc.category_id,count(fc.category_id)
from film_category fc 
join category c on fc.category_id = c.category_id 
group by fc.category_id;

-- How many actors are acted in each movies 
select f.title,fa.film_id , count(fa.actor_id) as count_of_actors 
from film f join film_actor fa on f.film_id = fa.film_id 
group by fa.film_id;
-- In which movie highest actors are acted
select f.title,fa.film_id , count(fa.actor_id) as count_of_actors 
from film f join film_actor fa on f.film_id = fa.film_id 
group by fa.film_id
order by count_of_actors desc limit 5 ;

-- How many films are acted by each actors 
select actor_id,count(film_id) as number_of_movies 
from film_actor 
group by actor_id
order by number_of_movies desc;
-- getting actors with above query 
select a.first_name,a.last_name,fa.actor_id,count(fa.film_id) as number_of_movies 
from film_actor fa join actor a on a.actor_id = fa.actor_id
group by fa.actor_id
order by number_of_movies desc;
-- How many actors are acted in each movies/films 
select f.title,fa.film_id,count(fa.actor_id) as number_of_actors_acted 
from film_actor fa join film f on f.film_id = fa.film_id
group by fa.film_id 
order by number_of_actors_acted desc;

#Payment -> Customer 
-- find amount of money have rent by each customers_id
create view total_amounts as
select customer_id , sum(amount)as total_amount from payment
group by customer_id
order by total_amount desc;
select * from total_amounts; ----- Created VIew
-- each customers above query 
create view customers_total_amount as
select c.first_name,c.last_name,p.customer_id , sum(p.amount)as total_amount 
from payment p join customer c on c.customer_id = p.customer_id
group by p.customer_id
order by total_amount desc;
select * from customers_total_amount; ----- Created VIew

-- Find the customers whose toatl_amount greater than average total_amount
select customer_id,first_name,total_amount from customers_total_amount
 where total_amount > (select avg(total_amount) as avg_amount from customers_total_amount) order by total_amount asc;
 
 # Store-> s
 




