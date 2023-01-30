clear; close all;
%need to get srad max

dirname='path to the data folder';
load ([dirname,'\TCEQ_sites_v1_3.mat']) %from read_TCEQ_v1

%%
tic

Ledieu_param=[-0.081	0.093];
Evett_param=[-0.081	0.085	0.031];
Topp_param=[-1.04E-06  -1.15E-04   1.75E-02  3.83E-02];
%%

%%
t_start = datenum('05/01/21'); % plotting limits
t_end=datenum(datetime('now','TimeZone','-06:00'));

%time range to keep the data on the same time
ts_same=datenum('05/01/21 00:00:00'):datenum('00/00/0000 00:05:00'):datenum(clock);
tS_hr=datenum('05/01/21 00:00:00'):datenum('00/00/0000 01:00:00'):datenum(clock);
ts_hr_dv=datevec(tS_hr);
ts_same=datevec(ts_same); %this fixes rounding problems
ts_same=datenum(ts_same);

numsen=[4 4 4 4]; %number of soil moisture sensors for each station

T=NaN(length(ts_same),max(numsen),length(temp));
VWC=NaN(length(ts_same),max(numsen),length(temp));
Ka=NaN(length(ts_same),max(numsen),length(temp));
EC=NaN(length(ts_same),max(numsen),length(temp));

PPT=NaN(length(ts_same),length(temp));
Batt=NaN(length(ts_same),length(temp));

Tair=NaN(length(ts_same),length(temp));
RH=NaN(length(ts_same),length(temp));
Ws=NaN(length(ts_same),length(temp));
Wd=NaN(length(ts_same),length(temp));
Srad=NaN(length(ts_same),length(temp));
ETo=NaN(length(ts_same),length(temp));
Rso=NaN(length(ts_same),length(temp));
Tdew=NaN(length(ts_same),length(temp));

T_hr=NaN(length(tS_hr),max(numsen),length(temp));
VWC_hr=NaN(length(tS_hr),max(numsen),length(temp));
Ka_hr=NaN(length(tS_hr),max(numsen),length(temp));
EC_hr=NaN(length(tS_hr),max(numsen),length(temp));

PPT_hr=NaN(length(tS_hr),length(temp));

Tair_hr=NaN(length(tS_hr),length(temp));
RH_hr=NaN(length(tS_hr),length(temp));
Ws_hr=NaN(length(tS_hr),length(temp));
Wd_hr=NaN(length(tS_hr),length(temp));
Srad_hr=NaN(length(tS_hr),length(temp));
ETo_hr=NaN(length(tS_hr),length(temp));
Rso_hr=NaN(length(tS_hr),length(temp));
Tdew_hr=NaN(length(tS_hr),length(temp));


for i =1:4%length(station)
    clear ts_temp vwc_temp temp_temp ec_temp ka_temp
    ts_temp=tS{i};
    ts_temp_dv=datevec(ts_temp);
    vwc_temp=vwc{i};
    temp_temp=temp{i};
    ec_temp=ec{i};
    ka_temp=ka{i};
    ppt_temp=ppt{i};
    batt_temp=batt{i};
    
    ts_met_temp=tS_met{i};
    ts_met_temp_dv=datevec(ts_met_temp);
    Tair_temp=tair{i};
    RH_temp=rh{i};
    Ws_temp=ws{i};
    Wd_temp=wd{i};
    Srad_temp=srad{i};
    ETo_temp=eto{i};
    Rso_temp=rso{i};
    Tdew_temp = 243.12*(log(RH_temp/100)+17.625*Tair_temp./(243.12+Tair_temp))./(17.625-log(RH_temp/100)-17.625*Tair_temp./(243.12+Tair_temp));
    
    for j=1:length(ts_same)
        ind=find(ts_same(j)==ts_temp);
        ind2=find(ts_same(j)==ts_met_temp);
        if isempty(ind)==0
            
            T(j,1:numsen(i),i)=temp_temp(ind(1),:); %had to use ind(1)... repeated data
            VWC(j,1:numsen(i),i)=vwc_temp(ind(1),:);
            Ka(j,1:numsen(i),i)=ka_temp(ind(1),:);
            EC(j,1:numsen(i),i)=ec_temp(ind(1),:);
            PPT(j,i)=ppt_temp(ind(1),:);
            Batt(j,i)=batt_temp(ind(1),:);
            
            Tair(j,i)=Tair_temp(ind2(1),:); %had to use ind(1)... repeated data
            RH(j,i)=RH_temp(ind2(1),:);
            Ws(j,i)=Ws_temp(ind2(1),:);
            Wd(j,i)=Wd_temp(ind2(1),:);
            Srad(j,i)=Srad_temp(ind2(1),:);
            ETo(j,i)=ETo_temp(ind2(1),:);
            Rso(j,i)=Rso_temp(ind2(1),:);
            Tdew(j,i)=Tdew_temp(ind2(1),:);
        end
    end
    
    for j=1:length(tS_hr)
        ind=find(ts_hr_dv(j,1)==ts_temp_dv(:,1) & ts_hr_dv(j,2)==ts_temp_dv(:,2) & ts_hr_dv(j,3)==ts_temp_dv(:,3) & ts_hr_dv(j,4)==ts_temp_dv(:,4));
        ind2=find(ts_hr_dv(j,1)==ts_met_temp_dv(:,1) & ts_hr_dv(j,2)==ts_met_temp_dv(:,2) & ts_hr_dv(j,3)==ts_met_temp_dv(:,3) & ts_hr_dv(j,4)==ts_met_temp_dv(:,4));
        if isempty(ind)==0
            
            T_hr(j,1:numsen(i),i)=mean(temp_temp(ind,:)); %had to use ind(1)... repeated data
            VWC_hr(j,1:numsen(i),i)=mean(vwc_temp(ind,:));
            Ka_hr(j,1:numsen(i),i)=mean(ka_temp(ind,:));
            EC_hr(j,1:numsen(i),i)=mean(ec_temp(ind,:));
            PPT_hr(j,i)=sum(ppt_temp(ind,:));
            
            v_east = mean(Ws_temp(ind2).*sin(Wd_temp(ind2) * pi/180));
            v_north = mean(Ws_temp(ind2).*cos(Wd_temp(ind2) * pi/180));
            Tair_hr(j,i)=mean(Tair_temp(ind2,:)); %had to use ind(1)... repeated data
            RH_hr(j,i)=mean(RH_temp(ind2));
            Ws_hr(j,i)=mean(Ws_temp(ind2));
            Wd_hr(j,i)=mod(360+(atan2(v_east,v_north)*180/pi()),360);
            Srad_hr(j,i)=mean(Srad_temp(ind2));
            ETo_hr(j,i)=sum(ETo_temp(ind2));
            Rso_hr(j,i)=mean(Rso_temp(ind2));
            Tdew_hr(j,i)=mean(Tdew_temp(ind2));
        end
    end
    last_collection(i,1)=tS{i}(end);
    last_battery(i,1)=batt{i}(end);
    
end
%%



%%

tS=ts_same;
%%

%%


legendnames={[{'5 cm'} {'10 cm'} {'20 cm'} {'50 cm'}];... %CR300_17_TRACER1
    [{'5 cm'} {'10 cm'} {'20 cm'} {'50 cm'}];... %CR300_18_TRACER2
    [{'5 cm'} {'10 cm'} {'20 cm'} {'50 cm'}];... %CR300_19_TRACER3
    [{'5 cm'} {'10 cm'} {'20 cm'} {'50 cm'}];... %CR300_20_TRACER4
    };


%%
ind =  VWC > 0.52;
VWC(ind) = -0.053 + 0.0292.*Ka(ind) - 0.00055.*Ka(ind).^2 + 0.0000043*Ka(ind).^3;

%% filters
Flag=repmat(Ka*0,[1,1,1,10]);
Flag(tS<datenum('05-May-2021 14:55:00'),:,1,1)=1;
Flag(tS<datenum('06-May-2021 11:15:00'),:,2,1)=1;
Flag(tS<datenum('10-Sept-2021 13:15:00'),:,3,1)=1;
Flag(tS<datenum('26-May-2022 14:20:00'),:,4,1)=1;


for i=1:4
    for j=1:4% it  was 3 for 3 stations
        ind = isnan(T(:,i,j));
        Flag(ind,i,j,1) = 1;
        
        ind = Ka(:,i,j) <1 | Ka(:,i,j) > 80;
        Flag(ind,i,j,2) = 1;
        
        
        ind = EC(:,i,j) <=0;
        Flag(ind,i,j,3) = 1;
        
        ind = VWC(:,i,j) <0 | VWC(:,i,j) > .9;
        Flag(ind,i,j,4) = 1;
        
        ind = T(:,i,j) <0 | T(:,i,j) > 60;
        Flag(ind,i,j,4) = 1;
        % if temperature is the same for 10 hours timesteps then sensor is likely broken
        for k=100:length(tS)
            if all(squeeze(T(k-99:k,i,j))==squeeze(T(k,i,j)))
                Flag(k,i,j,5)=1;
            end
        end
        
    end
end
%%
VWC_L=   Ledieu_param(1) + (Ledieu_param(2).*sqrt(Ka));
VWC_E=   Evett_param(1) + (Evett_param(2).*sqrt(Ka))+(Evett_param(3).*sqrt(EC));

VWC_L_hr=Ledieu_param(1) + (Ledieu_param(2).*sqrt(Ka_hr));
VWC_E_hr=Evett_param(1) + (Evett_param(2).*sqrt(Ka_hr))+(Evett_param(3).*sqrt(EC_hr));

%%
VWC_L_Flag_hr=repmat(VWC_L_hr*0,[1,1,1,10]);
VWC_L_Flag_hr(tS_hr<datenum('05-May-2021 14:55:00'),:,1,1)=1;
VWC_L_Flag_hr(tS_hr<datenum('06-May-2021 11:15:00'),:,2,1)=1;
VWC_L_Flag_hr(tS_hr<datenum('10-Sept-2021 13:15:00'),:,3,1)=1;
VWC_L_Flag_hr(tS_hr<datenum('26-May-2022 14:20:00'),:,4,1)=1;
D=[.05 .10 .20 .50] %measurment depth of the sensor (m)
A=0.05 %Accuracy of the sensor (m3m-3)
p=.5 %soil porosity
for i=25:length(tS_hr)-25
    for k=1:4
        for j=1:4
            x=VWC_L_hr(:,k,j);
            P=PPT_hr(:,j);
            xprime=diff(x);
            xdoubleprime=diff(xprime);
            xT=T_hr(:,k,j);
            %Equation 1 and 2
            if x(i)>x(i-1) %Eq 1
                if x(i)-x(i-24)>2*std(x(i-24:i)) %Eq 2
                    Pmin=D(k)*A*p; %Eq 3
                    if sum(P(i-24:i))<Pmin
                        VWC_L_Flag_hr(i,j,k,2)=1;
                    end
                end
            end
            if xT(i)<0% Soil temperature below 0
                VWC_L_Flag_hr(i,j,k,3)=1;
            end
            %Spectrum-Based Approaches
            %Spike Detection
            %     % can't be done in real time
            if x(i)/x(i-1)>1.15 || x(i)/x(i-1)<.85 %Eq 4
                if abs(xdoubleprime(i-1)/xdoubleprime(i+1))>=1.2 || abs(xdoubleprime(i-1)/xdoubleprime(i+1))<=.8 %Eq 5
                    if abs(var(x(i-12:i+12))/mean(x(i-12:i+12)))<1 %Eq 6
                        VWC_L_Flag_hr(i,j,k,4)=1;
                    end
                end
            end
            
            %Break detection
            n=24;
            if (x(i)-x(i-1))/x(i)<.1 && abs(x(i)-x(i-1))>.01 % Eq 7
                if (xprime(i))> 10*(1/n)*sum(x(i-12:i+12)) %Eq8  first derivative 
                    eq9term1(i)=abs(xdoubleprime(i)/xdoubleprime(i+1)); % Eq 9 
                    if abs(xdoubleprime(i+1)/xdoubleprime(i+2))>10 %Eq 9
                        VWC_L_Flag_hr(i,j,k,5)=1;
                    end
                    
                end
            end
            
            %constant values
            %      n=6;
            %      if var(x(i-n:i+n))<=0.0005 %eq 10
            %          flag(i,8)=1;
            %      end
            %
            %     if max((xprime((i-n-12):(i-n-12))))>=0.00025 & min((xprime((i-n-12):(i-n-12))))<0
            %         tS1=tS_hr(xprime((i-n-12):(i-n-12))==max((xprime((i-n-12):(i-n-12)))));
            %         tS2=tS_hr(xprime((i-n-12):(i-n-12))==min((xprime((i-n-12):(i-n-12)))));
            %         if mean(x(tS_hr>tS1 & tS_hr<tS2))>(.95*max(x))
            %     end
            %
            %     end
        end
    end
end

%

VWC_E_Flag_hr=repmat(VWC_E_hr*0,[1,1,1,10]);
VWC_E_Flag_hr(tS_hr<datenum('05-May-2021 14:55:00'),:,1,1)=1;
VWC_E_Flag_hr(tS_hr<datenum('06-May-2021 11:15:00'),:,2,1)=1;
VWC_E_Flag_hr(tS_hr<datenum('10-Sept-2021 13:15:00'),:,3,1)=1;
VWC_E_Flag_hr(tS_hr<datenum('26-May-2022 14:20:00'),:,4,1)=1;
D=[.05 .10 .20 .50] %measurment depth of the sensor (m)
A=0.05 %Accuracy of the sensor (m3m-3)
p=.5 %soil porosity
for i=25:length(tS_hr)-25
    for j=1:4
        for k=1:4
            x=VWC_E_hr(:,j,k);
            P=PPT_hr(:,k);
            xprime=diff(x);
            xdoubleprime=diff(xprime);
            xT=T_hr(:,j,k);
            %Equation 1 and 2
            if x(i)>x(i-1) %Eq 1
                if x(i)-x(i-24)>2*std(x(i-24:i)) %Eq 2
                    Pmin=D(k)*A*p; %Eq 3
                    if sum(P(i-24:i))<Pmin
                        VWC_E_Flag_hr(i,j,k,2)=1;
                    end
                end
            end
            if xT(i)<0% Soil temperature below 0
                VWC_E_Flag_hr(i,j,k,3)=1;
            end
            %Spectrum-Based Approaches
            %Spike Detection
            %     % can't be done in real time
            if x(i)/x(i-1)>1.15 || x(i)/x(i-1)<.85 %Eq 4
                if abs(xdoubleprime(i-1)/xdoubleprime(i+1))>=1.2 || abs(xdoubleprime(i-1)/xdoubleprime(i+1))<=.8 %Eq 5
                    if abs(var(x(i-12:i+12))/mean(x(i-12:i+12)))<1 %Eq 6
                        VWC_E_Flag_hr(i,j,k,4)=1;
                    end
                end
            end
            
            %Break detection
            n=24;
            if (x(i)-x(i-1))/x(i)<.1 && abs(x(i)-x(i-1))>.01 % Eq 7
                if (xprime(i))> 10*(1/n)*sum(x(i-12:i+12)) %Eq8  first derivative 
                    eq9term1(i)=abs(xdoubleprime(i)/xdoubleprime(i+1)); % Eq 9 
                    if abs(xdoubleprime(i+1)/xdoubleprime(i+2))>10 %Eq 9
                        VWC_E_Flag_hr(i,j,k,5)=1;
                    end
                    
                end
            end
            
            %constant values
            %      n=6;
            %      if var(x(i-n:i+n))<=0.0005 %eq 10
            %          flag(i,8)=1;
            %      end
            %
            %     if max((xprime((i-n-12):(i-n-12))))>=0.00025 & min((xprime((i-n-12):(i-n-12))))<0
            %         tS1=tS_hr(xprime((i-n-12):(i-n-12))==max((xprime((i-n-12):(i-n-12)))));
            %         tS2=tS_hr(xprime((i-n-12):(i-n-12))==min((xprime((i-n-12):(i-n-12)))));
            %         if mean(x(tS_hr>tS1 & tS_hr<tS2))>(.95*max(x))
            %     end
            %
            %     end
        end
    end
end

%%

%% filters
%%met
%Windspeed and direction variability of 3hrs
for i = 3:length(Ws_hr)
    Ws_hr3(i,:) = abs((max(Ws_hr(i-2:i,:)) - min(Ws_hr(i-2:i,:))));
    Wd_hr3(i,:) = abs((max(Wd_hr(i-2:i,:)) - min(Wd_hr(i-2:i,:))));
end
%Windspeed and direction variability of 6hrs
for i = 6:length(Ws_hr)
    Ws_hr6(i,:) = abs((max(Ws_hr(i-5:i,:)) - min(Ws_hr(i-5:i,:))));
    Wd_hr6(i,:) = abs((max(Wd_hr(i-5:i,:)) - min(Wd_hr(i-5:i,:))));
end
%Windspeed and temperature variability of 12hrs
for i = 12:length(Ws_hr)
    Ws_hr12(i,:) = abs((max(Ws_hr(i-11:i,:)) - min(Ws_hr(i-11:i,:))));
    Tair_hr12(i,:) = abs((max(Tair_hr(i-11:i,:)) - min(Tair_hr(i-11:i,:))));
    Tdew_hr12(i,:) = abs((max(Tdew_hr(i-11:i,:)) - min(Tdew_hr(i-11:i,:))));
    Tdew_Tair_hr12(i,:) = max(abs(Tdew_hr(i-11:i,:) - (Tair_hr(i-11:i,:))));
    
end


%%
Ws_hr_flag=repmat(zeros(size(Ws_hr)),[1,1,5]);
Wd_hr_flag=repmat(zeros(size(Wd_hr)),[1,1,5]);
Tair_hr_flag=repmat(zeros(size(Tair_hr)),[1,1,5]);
Tdew_hr_flag=repmat(zeros(size(Tdew_hr)),[1,1,5]);
Srad_hr_flag=repmat(zeros(size(Srad_hr)),[1,1,5]);


Ws_hr_flag(tS_hr<datenum('05-May-2021 14:55:00'),1,1)=1;
Wd_hr_flag(tS_hr<datenum('05-May-2021 14:55:00'),1,1)=1;
Tair_hr_flag(tS_hr<datenum('05-May-2021 14:55:00'),1,1)=1;
Tdew_hr_flag(tS_hr<datenum('05-May-2021 14:55:00'),1,1)=1;
Srad_hr_flag(tS_hr<datenum('05-May-2021 14:55:00'),1,1)=1;

Ws_hr_flag(tS_hr<datenum('06-May-2021 11:15:00'),2,1)=1;
Wd_hr_flag(tS_hr<datenum('06-May-2021 11:15:00'),2,1)=1;
Tair_hr_flag(tS_hr<datenum('06-May-2021 11:15:00'),2,1)=1;
Tdew_hr_flag(tS_hr<datenum('06-May-2021 11:15:00'),2,1)=1;
Srad_hr_flag(tS_hr<datenum('06-May-2021 11:15:00'),2,1)=1;

Ws_hr_flag(tS_hr<datenum('10-Sept-2021 13:15:00'),3,1)=1;
Wd_hr_flag(tS_hr<datenum('10-Sept-2021 13:15:00'),3,1)=1;
Tair_hr_flag(tS_hr<datenum('10-Sept-2021 13:15:00'),3,1)=1;
Tdew_hr_flag(tS_hr<datenum('10-Sept-2021 13:15:00'),3,1)=1;
Srad_hr_flag(tS_hr<datenum('10-Sept-2021 13:15:00'),3,1)=1;


Ws_hr_flag(tS_hr<datenum('26-May-2022 14:20:00'),4,1)=1;
Wd_hr_flag(tS_hr<datenum('26-May-2022 14:20:00'),4,1)=1;
Tair_hr_flag(tS_hr<datenum('26-May-2022 14:20:00'),4,1)=1;
Tdew_hr_flag(tS_hr<datenum('26-May-2022 14:20:00'),4,1)=1;
Srad_hr_flag(tS_hr<datenum('26-May-2022 14:20:00'),4,1)=1;

%
Srad_max_hr=Srad_hr+1; %figure this out
for i=1:4
    
    Ws_hr_flag(isnan(Srad_hr(:,i)),i,1)=1;
    Wd_hr_flag(isnan(Srad_hr(:,i)),i,1)=1;
    Tair_hr_flag(isnan(Srad_hr(:,i)),i,1)=1;
    Tdew_hr_flag(isnan(Srad_hr(:,i)),i,1)=1;
    Srad_hr_flag(isnan(Srad_hr(:,i)),i,1)=1;
    
    %0 m/s ? WS ? 25 m/s,
    Ws_hr_flag(Ws_hr(:,i)<0,i,2)=1;
    Ws_hr_flag(Ws_hr(:,i)>25,i,3)=1;
    %Ws_hr_flag(Ws_hr3(:,i)<.1,i,4)=1; %WS varies ? 0.1 m/s for 3 consecutive hours
    Ws_hr_flag(Ws_hr6(:,i)<.1,i,4)=1; %WS varies ? 0.1 m/s for 6 consecutive hours
    Ws_hr_flag(Ws_hr12(:,i)<.5,i,5)=1; %WS varies ? 0.5 m/s for 12 consecutive hours
    
    %0°? WD ? 360°,
    Wd_hr_flag(Wd_hr(:,i)<0,i,2)=1;
    Wd_hr_flag(Wd_hr(:,i)>360,i,3)=1;
    Wd_hr_flag(Wd_hr3(:,i)<1,i,4)=1; %WD varies ? 1°/3 consecutive hours
    
    %Local record low? Temp? local record high
    Tair_hr_flag(Tair_hr(:,i)<-14,i,2)=1; %record low
    Tair_hr_flag(Tair_hr(:,i)>43,i,3)=1; %record high
    Tair_hr_flag(abs(diff(Tair_hr(:,i)))>=5,i,4)=1; %Temp ? 5°C from previous hourly record
    Tair_hr_flag(Tair_hr12(:,i)<0.5,i,5)=1; %Temp varies ? 0.5°C over 12 consecutive hours
    
    Tdew_hr_flag(Tdew_hr(:,i)>Tair_hr(:,i),i,2)=1; %Dew Pont Temp ? Ambient temp for time period
    Tdew_hr_flag(abs(diff(Tdew_hr(:,i)))>=5,i,3)=1; %Temp ? 5°C from previous hourly record
    Tdew_hr_flag(Tdew_hr12(:,i)<0.5,i,4)=1; %Temp ? 0.5°C from previous hourly record
    Tdew_hr_flag(Tdew_Tair_hr12(:,i)<.01,i,5)=1; %Dew Pont Temp ? Ambient Temp for 12 consecutive hrs. (.01 tolerance)
    
    
    %Temp ? 0.5°C from previous hourly record  %Dew Pont Temp ? 0.5°C over 12 consecutive hours
    %Dew Pont Temp ? Ambient Temp for 12 consecutive hrs.
    
    Srad_hr_flag(Srad_hr(:,i)>Srad_max_hr(:,i),i,2)=1; %Temp ? 0.5°C from previous hourly record
end
%%


%%
cd(dirname);
save TCEQ_final_v1_3 tS T EC VWC PPT Ka filename legendnames station VWC_E VWC_L last_collection last_battery Flag ...
    Ws Wd Tdew Tair Srad ETo ...
    tS_hr T_hr EC_hr VWC_hr PPT_hr Ka_hr Ws_hr Wd_hr Tdew_hr Tair_hr Srad_hr ETo_hr ...
    Ws_hr_flag Wd_hr_flag Tdew_hr_flag Tair_hr_flag Srad_hr_flag ...
    VWC_L_hr VWC_E_hr VWC_L_Flag_hr VWC_E_Flag_hr

