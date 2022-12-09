/*Modify car  claim  table*/

%MACRO insurance_modify(id=, region_code=, vehicle_age=, response=,annual_premium=,vintage=);
%put id = &id;
%put region_code = &region_code;
%put vehicle_age = &vehicle_age;
%put response = &response;
%put annual_premium =&annual_premium;
%put vintage =&vintage;

	data temp_data;
	id = &id;
	region_code = &region_code;
	vehicle_age = &vehicle_age ;
	response = &response;
	annual_premium=&annual_premium;
	vintage=&vintage;
	
	run;
	proc print data = temp_data(obs=5);
	title'Modified Car Claims Table';
	where id = &id ; 

run;
%MEND bank_acc;
%insurance_modify(id=4, region_code=11.0, vehicle_age='>2years', response=1,annual_premium=39890.8,vintage=303);

