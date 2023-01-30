%v1_1 adds met data
%v1_2 add 3rd site
%v1_3 moved to TRACER folder
clear; close all;
tS=cell(1,4); 
ppt=cell(1,4); vwc=cell(1,4); temp=cell(1,4); 
ec=cell(1,4); ka=cell(1,4); 
batt=cell(1,4); 

tS_met=cell(1,4); 
tair = cell(1,4);
rh = cell(1,4);
ws = cell(1,4);
wd = cell(1,4);
srad = cell(1,4);
eto = cell(1,4);
rso = cell(1,4);

dir_mat='E:\Soil_Moisture\TRACER_Report\TCEQ_read\'; %matfile directory
%dir of raw files
dirname1='E:\Soil_Moisture\TRACER_Report\LoggerNet\';



station=[{'CR300_17_TRACER1'};{'CR300_18_TRACER2'};{'CR300_19_TRACER3'};{'CR300_20_TRACER4'}];
  numsen=[4 4 4 4]; %number of soil moisture sensors for each station

start_over=1;
if start_over==0
load([dir_mat,'TCEQ_sites_v1_3.mat']) %matfile to add on to
end

%%
tic
for j=1:4
    %j
clear dataarray
 clear C
start_over=1;

  filename=dir([dirname1,station{j},'_SubHourly_soil.dat']);     
  
  dirname=dirname1;
  dirname
  filename.name
  %formatSpec
  start_over
       
	  
      formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
      [tS_temp, dataarray]=read_TCEQ_func(dirname,filename.name,formatSpec,start_over);  

    if start_over==1
    ind=0;
    else
    %find index of last data point     
    ind=find(tS{j}(end)==tS_temp);
    end
  sensornumbers=numsen(j);
  n=sensornumbers-1;

tS{j}=[tS{j}; tS_temp(ind+1:end,1)];
ppt{j}=[ppt{j}; dataarray(ind+1:end,3)]; 
n1=4+n;
vwc{j}=[vwc{j}; dataarray(ind+1:end,4:n1)]; 
n2=n1+1+n;
temp{j}=[temp{j}; dataarray(ind+1:end,n1+1:n2)]; 
n3=n2+1+n;
ec{j}=[ec{j}; dataarray(ind+1:end,n2+1:n3)]; 
n4=n3+1+n;
ka{j}=[ka{j}; dataarray(ind+1:end,n3+1:n4)];
batt{j}=[batt{j}; dataarray(ind+1:end,n4+1)];     



end

%%
for j=1:4
    j
clear dataarray
 clear C


  filename=dir([dirname1,station{j},'_SubHourly_met.dat']);     
  
  dirname=dirname1;
  
       
	  
      formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
      [tS_temp, dataarray]=read_TCEQ_func(dirname,filename.name,formatSpec,start_over);  

    if start_over==1
    ind=0;
    else
    %find index of last data point     
    ind=find(tS_met{j}(end)==tS_temp);
    end
  sensornumbers=numsen(j);
  n=sensornumbers-1;

tS_met{j}=[tS_met{j}; tS_temp(ind+1:end,1)];
tair{j}=[tair{j}; dataarray(ind+1:end,4)]; 
rh{j}=[rh{j}; dataarray(ind+1:end,5)]; 
ws{j}=[ws{j}; dataarray(ind+1:end,6)]; 
wd{j}=[wd{j}; dataarray(ind+1:end,7)]; 
srad{j}=[srad{j}; dataarray(ind+1:end,8)]; 
eto{j}=[eto{j}; dataarray(ind+1:end,9)]; 
rso{j}=[rso{j}; dataarray(ind+1:end,10)]; 

end
%%
toc
cd(dir_mat)
save TCEQ_sites_v1_3 tS ppt vwc temp ec ka filename station batt tS_met tair rh ws wd srad eto rso




