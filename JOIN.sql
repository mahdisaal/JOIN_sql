/* Tasks */
/* A - Querying tables city and country:*/
/* 1 - Using INNER JOIN ..ON, write a query that displays the name of cities, the cities' 
       population and cities' continent. Sort the result by continent, then by city population, 
	   then by city name.
       Note that the field called 'name' is present in the two tables, use a table alias 
       to resolve the conflict. */
SELECT city.name, city.Population, country.Continent
FROM city
INNER JOIN country on city.CountryCode = country.Code
ORDER BY country.Continent, city.Population, city.Name;



/* 2 - Rewrite the previous query using WHERE/FROM. */
SELECT city.name, city.Population, country.Continent
FROM city, country
WHERE city.CountryCode = country.Code
ORDER BY country.Continent, city.Population, city.Name;


/* 3 - Rewrite the query in question 1 to countries that became independent in 1960. */
SELECT city.name, city.Population, country.Continent
FROM city
INNER JOIN country on city.CountryCode = country.Code
WHERE country.IndepYear = 1960
ORDER BY country.Continent, city.Population, city.Name;

/* 4 - Rewrite the previous query using WHERE/FROM. */
SELECT city.name, city.Population, country.Continent
FROM city, country
WHERE city.CountryCode = country.Code
AND country.IndepYear = 1960
ORDER BY country.Continent, city.Population, city.Name;

/* 5 - Using INNER JOIN ..ON, write a query that displays, for the city of Ottawa, 
       the name of the city and the head of state of its country. */
SELECT city.Name, country.HeadOfState
FROM city
INNER JOIN country on city.CountryCode = country.Code
WHERE city.Name = 'Ottawa';



/* 6 - Using INNER JOIN ..ON, write a query that displays the name of the city, the city 
       population, the continent, and the country population of the city of Toronto. */
SELECT city.Name, city.Population, country.Continent, country.Population
FROM city
INNER JOIN country on city.CountryCode = country.Code
WHERE city.Name = 'Toronto';

/* B - Querying tables city and countryLanguage:*/
/* 1 - Using INNER JOIN ..ON, write a query that answers the following question. 
       What languages along with their percentage are spoken in the city of Ottawa? */
SELECT c.Name, co.Language, co.Percentage
From city c
INNER JOIN countrylanguage co ON c.CountryCode = co.CountryCode
WHERE c.Name = 'Ottawa';


/* 2 - Using WHERE/FROM, write a query that answers the following question. 
       What official languages along with their percentage are spoken in the city of Ottawa? */
SELECT c.Name, co.Language, co.Percentage
From city c, countrylanguage co
WHERE c.CountryCode = co.CountryCode
AND c.Name = 'Ottawa'
AND co.IsOfficial = 'T';


/* 3 - Using INNER JOIN ..ON, write a query that reports the percentage of people speaking 
       an official language in the city of Ottawa as well as the percentage of people 
	   speaking Polish in the city of Ottawa */
SELECT c.Name, co.Language, co.Percentage
From city c
INNER JOIN countrylanguage co ON c.CountryCode = co.CountryCode
WHERE c.Name = 'Ottawa'
AND (co.IsOfficial = 'T' OR co.Language = 'Polish');



/* 4 - Using INNER JOIN ..ON and SUM, write a query that reports the total percentage
       of people speaking an official language as well as speaking Italian in the city 
	   of Ottawa */
SELECT c.Name, co.isOfficial, SUM(co.Percentage)
From city c
INNER JOIN countrylanguage co ON c.CountryCode = co.CountryCode
WHERE c.Name = 'Ottawa'
AND (co.IsOfficial = 'T' OR co.Language = 'Italian')
GROUP BY co.IsOfficial;


/* C - Querying tables city, country and countryLanguage:*/
/* 1 - Using INNER JOIN ..ON the three tables, write a query that displays the name of the city, 
      the city continent, the city head of state, the year of independence and the total number 
	  of people who speak Italian in the city of Toronto. */
SELECT c.Name, co.Continent, co.HeadOfState, co.IndepYear,
ROUND((c.Population * cl.Percentage)/100, 0) as numberSpeakItalian
FROM city c
INNER JOIN country co on c.CountryCode = co.Code
INNER JOIN countrylanguage cl on c.CountryCode = cl.CountryCode
WHERE c.Name = 'Toronto'
AND cl.Language = 'Italian';


/* 2 - Rewrite the previous query using WHERE/FROM.*/
SELECT c.Name, co.Continent, co.HeadOfState, co.IndepYear,
ROUND((c.Population * cl.Percentage)/100, 0) as numberSpeakItalian
FROM city c, country co, countrylanguage cl
WHERE c.CountryCode = co.Code
AND c.CountryCode = cl.CountryCode
AND c.Name = 'Toronto'
AND cl.Language = 'Italian';


/* 3 - Using LEFT JOIN ..ON the three tables, write a query that displays the city continent, the 
      country the city is in, the city name and the language spoken in that city */
SELECT co.Continent, co.Name, c.Name, cl.Language
FROM country co
LEFT JOIN city as c on c.CountryCode = co.Code
LEFT JOIN countrylanguage cl on co.Code = cl.CountryCode;
