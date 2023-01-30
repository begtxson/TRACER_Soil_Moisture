% Run Matlab compiler to complete automation: mcc -e run_TCEQ_v1_3_2.m
read_TCEQ_v1_3
%produces TCEQ_sites
%%
addpath('path to the data folder')
combine_and_clean_TCEQ_v1_3
%read TCEQ_sites
%produces TCEQ_final
%%
plot_all_TCEQ_hourly_v1_3
%1_3_2 changed email address
%1_3_1 changed directory  
%1_2_1 added 3rd station
%1_1_4 typo varname now varnames in plot_all_TCEQ_hourly
%1_1_3