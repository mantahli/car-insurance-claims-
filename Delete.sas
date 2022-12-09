%macro delete_(id);
	%put id= &id;
	
	data work.insurance;
    set insurance;
    if id = &id then delete;
	run;
	
	proc sort data= insurance;
	    by id;
	run;	
%mend delete_;

%delete_(4)