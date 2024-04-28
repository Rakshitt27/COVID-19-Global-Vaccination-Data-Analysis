
-- Summary of Administered Vaccines by Country and Date
-- Description: This query provides a summary of the total number of administered vaccines for each country on each date.

SELECT location AS 'Country Name (CN)', 
Date AS 'Administered Vaccine on OD (VOD)', 
SUM(total_vaccinations) AS 'Total Administered Vaccines'
FROM vaccinations 
GROUP BY location,date
ORDER BY location,date ASC;

-- Cumulative Doses of Administered Vaccines by Country
-- Description: This query calculates the cumulative number of administered vaccine doses for each country.

SELECT (
 SELECT location
FROM Locations
WHERE iso_code = vaccinations.iso_code
 and location is NOT NULL 
 )
 AS Country,
 SUM(NULLIF(total_vaccinations, "") ) AS [Cumulative Doses]
FROM vaccinations
where Country is not null
 GROUP BY location 
ORDER BY location ASC;

-- Vaccine Types by Country
-- Description: This query lists the types of vaccines administered in each country.

SELECT location AS 'Country', vaccines as "Vaccine Type"
FROM vaccines 
ORDER BY location ASC;

-- Total Administered Vaccines by Source Website
-- Description: This query aggregates the total number of administered vaccines by the source website from which the data was obtained.

SELECT SourceWebsite AS [Source Name(URl)],
 SUM(TOTAL) AS [Total Administered Vaccines]
 FROM (
 SELECT iso_code,
 SUM(NULLIF(total_vaccinations, "") ) AS Total,
( SELECT source_name
 FROM data_source
 WHERE iso_code =
vaccinations.iso_code)
 AS SourceName,
 ( SELECT source_website FROM data_source
WHERE iso_code = vaccinations.iso_code)
AS SourceWebsite FROM vaccinations GROUP BY iso_code )
GROUP BY SourceWebsite
ORDER BY SourceName;

-- People Fully Vaccinated Over Time for Selected Countries
-- Description: This query shows the number of people fully vaccinated over time for selected countries (Australia, United States, Germany, Italy) within the specified date range.

SELECT vaccinations.date,
 MAX(CASE WHEN vaccinations.iso_code = (
 SELECT iso_code
 FROM Locations WHERE location = 'Australia')
 THEN vaccinations.people_fully_vaccinated END) AS Australia,
 MAX(CASE WHEN vaccinations.iso_code = (
 SELECT iso_code
 FROM Locations
 WHERE location = 'United States' )
 THEN vaccinations.people_fully_vaccinated END) AS [United States], MAX(CASE WHEN vaccinations.iso_code = (
 SELECT iso_code
 FROM Locations
 WHERE location = 'Germany')
 THEN vaccinations.people_fully_vaccinated END) AS Germany, MAX(CASE WHEN vaccinations.iso_code = (
 SELECT iso_code FROM Locations
 WHERE location = 'Italy' )
 THEN vaccinations.people_fully_vaccinated END) AS Italy
 FROM vaccinations WHERE vaccinations.date BETWEEN '2022-01-01' AND '2022-12-31' 
GROUP BY vaccinations.date
ORDER BY vaccinations.date ASC;



