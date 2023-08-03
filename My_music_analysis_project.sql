/* Easy Question Set */

/* Q1: Who is the senior most employee based on job title? */

select * from employee
order by levels desc
limit 1

/* Q2: Which countries have the most Invoices? */
select billing_country, count(invoice_id) as "Number of Invoice" from invoice
group by billing_country
order by count(invoice_id) DESC

/* Q3: What are top 3 values of total invoice? */
select i.invoice_id, i.total from invoice as i
order by total desc
limit 3

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city, sum(total) as "Money Total" from invoice
group by billing_city
order by sum(total) DESC
LIMIT 1

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select i.customer_id, c.first_name, c.last_name, sum(i.total) as "Money Total" from invoice as i
join customer as c on c.customer_id=i.customer_id
group by i.customer_id, c.first_name, c.last_name
order by sum(total) DESC
LIMIT 1

/* Intermediate Question Set */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select c.customer_id, c.email, c.first_name, c.last_name, g.name from customer as c
join invoice as i on c.customer_id = i.customer_id
join invoice_line as il on i.invoice_id = il.invoice_id
join track as t on t.track_id = il.track_id
join genre as g on g.genre_id =t.genre_id
where g.name like 'Rock'
group by c.customer_id, g.name
order by c.email asc

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select a.artist_id, a.name, count(g.name) as "Number of Rock tracks" from artist as a
join album as al on a.artist_id = al.artist_id
join track as t on al.album_id = t.album_id
join genre as g on t.genre_id = g.genre_id
where g.name like 'Rock'
group by a.artist_id
order by count(g.name) DESC
LIMIT 10

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select track_id, name, milliseconds as "Duration" from track
where milliseconds > (select AVG(milliseconds) from track)
order by milliseconds desc

/* Advance Question Set */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return 
customer name, artist name and total spent. */

select c.first_name as customer_first_name, c.last_name as customer_last_name, ar.name as artist_name, sum((il.unit_price*il.quantity)::int) as total_spent from customer c
join invoice i on i.customer_id = c.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album a on a.album_id = t.album_id
join artist ar on a.artist_id = ar.artist_id
group by c.first_name, c.last_name, ar.name
order by 4 desc

/*  */

