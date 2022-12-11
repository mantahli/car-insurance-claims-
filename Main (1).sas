
/*show 5 observations*/

proc print data=work.insurance(obs=5);
run;

PROC MEANS;
RUN;


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

DATA WORK.MY_FILTERED_DATA;
SET work.Case_statement (WHERE=(response = 1));
RUN;
/*How Many Claims have we received*/
proc sgplot data=WORK.INSURANCE;
title 'Claims Approved vs Denied';
	vbar Response /;
	yaxis grid;
	
run;
/*'Where do we get most claims from*/
%let TopN = 10;
title'Region By Claims';
proc freq data=WORK.INSURANCE order=freq;
   tables Response*Region_Code / maxlevels=&TopN
  plots=freqplot(twoway=stacked);
       
run;
proc sgplot data=WORK.INSURANCE;
title'Gender By Claims';
	vbar Gender / group=Response groupdisplay=cluster;
	yaxis grid;
run;

/*%let TopN = 10;
title'Claims By Sales Channel';
proc freq data=WORK.INSURANCE order=freq;
   tables  response*Policy_Sales_Channel/ maxlevels = &TopN 
    plots=freqplot;
       
run;*/
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=Policy_Sales_Channel /;
		endlayout;
		endgraph;
	end;
run;


proc sgrender template=SASStudio.Pie data=WORK.MY_FILTERED_DATA;
title 'Markerting strategy with most approved claims';
run;

proc sgplot data=WORK.CASE_STATEMENT;
title 'Age Group  By Number of Claims';
	vbar age_group / group=Response groupdisplay=cluster;
	yaxis grid;
run;
proc sgplot data=WORK.CASE_STATEMENT;
title'Customers with previous insurance by Age Group';
	vbar age_group / group=Previously_Insured groupdisplay=stack;
	yaxis grid;
run;

proc sgplot data=WORK.CASE_STATEMENT;
title'Average Annual Premium By Age Group';
	vbar age_group / response=Annual_Premium stat=mean;
	yaxis grid;
run;

proc sgplot data=WORK.CASE_STATEMENT;
title'Average Annual Premium By Region';
	vbar region_code / response=Annual_Premium stat=mean;
	yaxis grid;
run;

proc sgplot data=WORK.INSURANCE;
title'Avg of Annul Premium By Vehicl Age';
	vbar Vehicle_Age / response=Annual_Premium stat=mean;
	yaxis grid;
run;


proc sgplot data=WORK.MY_FILTERED_DATA;
TITLE'Vehicle age By Approved Claims with Vehicle Damage ';
	vbar Vehicle_Age / group=Vehicle_Damage groupdisplay=cluster;
	yaxis grid;
run;
/*How Many Cars were Damaged and were not Covered?*/
proc sgplot data=WORK.INSURANCE;
title 'Vehicle Damage By Previously Insured'
	vbar Previously_Insured / group=Vehicle_Damage groupdisplay=cluster;
	yaxis grid;
run;
/*From Which Region do we get claims for Damaged Cars*/
proc sgplot data=WORK.INSURANCE;
	vbar Region_Code / group=Vehicle_Damage groupdisplay=cluster
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

/*Gender where we get most Damaged Car Claims*/
proc sgplot data=WORK.INSURANCE;
	vbar gender / group=Vehicle_Damage groupdisplay=cluster
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;
/*Age Group where we get Damaged Car Claims*/
proc sgplot data=WORK.CASE_STATEMENT;
	vbar age_group / group=Vehicle_Damage groupdisplay=cluster
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;
/*Avg Days A CLIENT sTAYS WITH AGE BY AGE GROUP*/
TITLE'Avg Days since they tken the insurance';
proc sgplot data=WORK.CASE_STATEMENT;
	vbar Age / response=Vintage stat=mean
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;
/*....................................................................*/

/*claims premiun average vs denied      */








































































