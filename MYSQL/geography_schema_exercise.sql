select peak_name from peaks order by peak_name asc;

select country_name, population  from countries where continent_code = 'EU' order by population desc, country_name asc limit 30;

select country_name, country_code,
IF (currency_code = "EUR", 'Euro', 'Not Euro') as 'currency' from countries order by country_name asc;


