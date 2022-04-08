SELECT title from books where substring(title, 1, 3) ="The";

select replace(title, 'The', '***') as title from books WHERE substring(title,1,3) = "The";

select concat(first_name," ", last_name) as 'Full Name', timestampdiff(day, born,died) as 'Days Lived' from authors;

select title from books where title LIKE "Harry Potter%"