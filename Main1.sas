PROC sql;
create table car_insurance as 
select * from  work.insurance;
RUN;

/*show number of claims */
proc sgplot data=WORK.INSURANCE;
title 'Claims Approved vs Denied';
	vbar Response /;
	yaxis grid;
	
run;

/*Grouping age */

DATA work.Case_statement;
 ATTRIB age_group LENGTH=$14;
 SET WORK.INSURANCE;
 SELECT;
 WHEN (age < 30) age_group = '20s';
 WHEN (age < 40) age_group = '30s';
 WHEN (age < 50) age_group = '40s';
 WHEN (age < 60) age_group = '50s';
 WHEN (age < 70) age_group = '60s';
 WHEN (age < 80) age_group = '70s';
 OTHERWISE age_group = '80s';
 END; 
run;
/*filter dataset to take only those with approved claims*/

DATA WORK.MY_FILTERED_DATA;
SET work.Case_statement (WHERE=(response = 1));
RUN;