
/*
RACHEL B. BITTAR ID:301006074
Assignment 1 - ADVANCED DATA BASE SEC 010
CENTENNIAL COLLEGE
MONDAY, SEP 24, 2018
*/


SELECT * FROM OFFICERS;
SELECT * FROM CRIME_OFFICERS;
SELECT * FROM CRIME_CHARGES;
SELECT * FROM APPEALS;

/*1 1. List the name of each officer
who has reported more than the average number of crimes 
officers have reported.*/

SELECT CO.OFFICER_ID, O.FIRST, O.LAST
FROM CRIME_OFFICERS CO JOIN OFFICERS O ON CO.OFFICER_ID = O.OFFICER_ID
GROUP BY CO.OFFICER_ID, O.LAST, O.FIRST
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT OFFICER_ID)
FROM CRIME_OFFICERS);

SELECT FIRST,LAST
FROM OFFICERS 
  JOIN CRIME_OFFICERS USING(OFFICER_ID)
  JOIN CRIMES USING(CRIME_ID)
    GROUP BY FIRST, LAST
     HAVING COUNT(CRIME_ID)> 
      (SELECT AVG(COUNT(CRIME_ID))
         FROM CRIMES 
         JOIN CRIME_OFFICERS USING(CRIME_ID)
      GROUP BY OFFICER_ID) ;

/*2
2. List the names of all criminals
who have committed less than average
number of crimes and aren’t listed as violent offenders.
*/

  
  SELECT  FIRST, LAST
  FROM CRIMINALS JOIN CRIMES USING (CRIMINAL_ID) 
  WHERE V_STATUS ='N'
  GROUP BY FIRST, LAST
  HAVING COUNT(CRIMINAL_ID) <
    (SELECT (AVG(COUNT(CRIMINAL_ID)))
      FROM CRIMES 
      GROUP BY CRIMINAL_ID);
  

/*3
3. List appeal information for each appeal
that has a less than 
average number of days between the filing and hearing dates
*/


SELECT *
FROM appeals
WHERE ((hearing_date - filing_date)) < (SELECT AVG((hearing_date -filing_date ))
FROM APPEALS);


/*4
 4.List the names of probation officers who have had a less than average number of criminals assigned.
*/

SELECT LAST,FIRST
FROM PROB_OFFICERS JOIN SENTENCES USING(PROB_ID)
GROUP BY LAST,FIRST
HAVING COUNT(CRIMINAL_ID)<(SELECT AVG(COUNT(CRIMINAL_ID)) FROM SENTENCES GROUP BY PROB_ID);


SELECT LAST,FIRST
FROM PROB_OFFICERS JOIN SENTENCES USING(PROB_ID)
GROUP BY LAST,FIRST
HAVING COUNT(CRIMINAL_ID)< (SELECT AVG(COUNT(CRIMINAL_ID))
FROM SENTENCES
GROUP BY PROB_ID);

/*
5. List each crime that has had the highest number of appeals recorded.
*/

SELECT CRIME_ID, COUNT(APPEAL_ID)
FROM APPEALS
GROUP BY CRIME_ID
HAVING COUNT(APPEAL_ID) = (SELECT MAX(COUNT(APPEAL_ID))
  FROM APPEALS
  GROUP BY CRIME_ID);




