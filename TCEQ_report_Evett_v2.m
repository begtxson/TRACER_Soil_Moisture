clear
addpath('C:\Users\dashtianh\Downloads\github_repo')
%  YOU NEED TO CHANGE THESE DATE RANGES FOR EACH MONTHLY REPORT!!!
%t_end=datenum('12/31/2021 00:00');
%t_start=datenum('11/30/2021 23:55'); %
t_end=datenum('11/30/2022 23:55');
t_start=datenum('11/01/2022 00:00'); %
%%
dirname='E:\Soil_Moisture\TRACER_Report\TCEQ_read';
load ([dirname,'\TCEQ_final_v1_3.mat'])
%%
symbol_f={'.','*','s','d','o'};%filter symbols
site={'UHCC','La Porte','UHSL','GUYT'};

site_title={'University of Houston Coastal Center Site','La Porte Airport Site','University of Houston Sugar Land Site','Guy Texas Site'};

%% VWC data
VWC_insitu(1,1)=mean([0.607 0.515 0.581 0.533]);
VWC_insitu(2,1)=std([0.607 0.515 0.581 0.533]);

VWC_insitu(1,2)=mean([0.339 0.402 0.431 0.314]);
VWC_insitu(2,2)=std([0.339 0.402 0.431 0.314]);

VWC_insitu(1,3)=mean([0.309 0.342 0.346 0.333]);
VWC_insitu(2,3)=std([0.309 0.342 0.346 0.333]);

tS_insitu(1)=datenum('05-May-2021 15:00:00');
tS_insitu(2)=datenum('06-May-2021 11:15:00');
tS_insitu(3)=datenum('10-Sept-2021 13:15:00');
tS_insitu(4)=datenum('26-May-2022 14:20:00');

figure()
subplot(511)
%bar(tS,PPT(:,1:2));hold on
plot(tS(tS>tS_insitu(1)),cumsum(PPT(tS>tS_insitu(1),1:4),'omitnan'));hold on
xticks([t_start:5:t_end])
xlim([t_start t_end])
%ylim([0 max(max(PPT))]);
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['PPT [mm]'])

for i=1:4
subplot(5,1,i+1)
h=plot(tS,squeeze(VWC_E(:,i,1:4)));hold on
set(h(4), 'Color', 'k')
if i==1
%errorbar(tS_insitu, VWC_insitu(1,:), VWC_insitu(2,:),'.')
end
plot(0,0,'k.')
plot(0,0,'k*')
plot(0,0,'ks')
plot(0,0,'kd')
plot(0,0,'ko')
ylim([.2 .7])
xlim([t_start t_end])
ylabel('VWC [m^3/m^3]')
xticks([t_start:5:t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
for j=1:5
subplot(5,1,i+1)
plot(tS(Flag(:,i,1,j)==1),squeeze(VWC_E(Flag(:,i,1,j)==1,i,1)),['b',symbol_f{j}])
plot(tS(Flag(:,i,2,j)==1),squeeze(VWC_E(Flag(:,i,2,j)==1,i,2)),['r',symbol_f{j}])
plot(tS(Flag(:,i,3,j)==1),squeeze(VWC_E(Flag(:,i,3,j)==1,i,3)),['k',symbol_f{j}])
plot(tS(Flag(:,i,4,j)==1),squeeze(VWC_E(Flag(:,i,4,j)==1,i,4)),['g',symbol_f{j}])

end
end
%%
VWC_E_plot=cat(2,VWC_E, VWC_E(:,4,:));
T_plot=cat(2,T, T(:,4,:));
%%
% 
% for i=1:2
% figure('Position',[0 0 1200 1800])
% h1=subplot(311)
% plot(tS(Flag(:,1,i)==0),squeeze(T(Flag(:,1,i)==0,:,i)))
% ylabel('T [C]')
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% yyaxis right
% plot(tS(tS>tS_insitu(i)),cumsum(PPT(tS>tS_insitu(i),1),'omitnan'),'c','linewidth',2);hold on
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% %ylim([0 max(max(PPT))]);
% legend('5cm','10cm','20cm','50cm','PPT','Location','NorthWest')
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% ylabel(['PPT [mm]'])
% ax = gca;
% ax.YAxis(2).Color = 'c';
% originalSize1 = get(gca, 'Position');
% 
% h3=subplot(312)
% p=pcolor(tS(Flag(:,1,i)==0),[2.5 7.5 15 35 60],squeeze(T_plot(Flag(:,1,i)==0,:,i))')
% p.EdgeColor = 'none';
% colormap(jet)
% set(gca,'Ydir','reverse')
% yticks([5 10 20 50])
% ylim([0 60])
% %p.FaceColor = 'interp'
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% ylabel('Depth [cm]')
%     originalSize = get(gca, 'Position');
%     h=colorbar;
%     fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
%     set(h3, 'Position', fixSize);
%     ylabel(h,'T [C]')
% 
% h3=subplot(313)
% p=pcolor(tS(Flag(:,1,i)==0),[5 10 20 50,60],squeeze(T_plot(Flag(:,1,i)==0,:,i))')
% p.EdgeColor = 'none';
% colormap(jet)
% yticks([5 10 20 50])
% set(gca,'Ydir','reverse')
% p.FaceColor = 'interp'
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% ylim([0 60])
% ylabel('Depth [cm]')
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% 
%     originalSize = get(gca, 'Position');
%     h=colorbar;
%     fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
%     set(h3, 'Position', fixSize);
%     ylabel(h,'T [C]')
%     suptitle(site{i})
%     export_fig(['./figures_report/T_',site{i},'_',datestr(t_start,'YYYYmm')], '-tiff', '-r300', '-transparent')
% end
% %%
% for i=1:2
% figure('Position',[0 0 1200 1800])
% h1=subplot(311)
% plot(tS(Flag(:,1,i)==0),squeeze(VWC_E(Flag(:,1,i)==0,:,i)));hold on
% %errorbar(tS_insitu(i), VWC_insitu(1,i), VWC_insitu(2,i),'.')
% ylabel('VWC [m^3/m^3]')
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% yyaxis right
% plot(tS(tS>tS_insitu(i)),cumsum(PPT(tS>tS_insitu(i),i),'omitnan'),'c','linewidth',2);hold on
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% %ylim([0 max(max(PPT))]);
% ax = gca;
% ax.YAxis(2).Color = 'c';
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% ylabel(['PPT [mm]'])
% %legend('5cm','10cm','20cm','50cm','in situ','PPT')
% legend('5cm','10cm','20cm','50cm','PPT','Location','NorthWest')
% originalSize1 = get(gca, 'Position');
% 
% h3=subplot(312)
% p=pcolor(tS(Flag(:,1,i)==0),[2.5 7.5 15 35 60],squeeze(VWC_E_plot(Flag(:,1,i)==0,:,i))')
% p.EdgeColor = 'none';
% colormap(flipud(jet))
% set(gca,'Ydir','reverse')
% yticks([5 10 20 50])
% %p.FaceColor = 'interp'
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% ylim([0 60])
% ylabel('Depth [cm]')
%     originalSize = get(gca, 'Position');
%     h=colorbar;
%     fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
%     set(h3, 'Position', fixSize);
%     ylabel(h,'VWC [m^3/m^3]')
%     
% h3=subplot(313)
% p=pcolor(tS(Flag(:,1,i)==0),[5 10 20 50 60],squeeze(VWC_E_plot(Flag(:,1,i)==0,:,i))')
% p.EdgeColor = 'none';
% colormap(flipud(jet))
% yticks([5 10 20 50])
% set(gca,'Ydir','reverse')
% p.FaceColor = 'interp'
% xticks([t_start:5:t_end])
% xlim([t_start t_end])
% ylim([0 60])
% ylabel('Depth [cm]')
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
%     originalSize = get(gca, 'Position');
%     h=colorbar;
%     fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
%     set(h3, 'Position', fixSize);
%     ylabel(h,'VWC [m^3/m^3]')
%         suptitle(site{i})
% export_fig(['./figures_report/VWC_',site{i},'_',datestr(t_start,'YYYYmm')], '-tiff', '-r300', '-transparent')
% 
% end
%%

for i=1:4
figure('Position',[0 0 1200 1800])
h1=subplot(311)
plot(tS(Flag(:,1,i)==0),squeeze(VWC_E(Flag(:,1,i)==0,:,i)));hold on
%errorbar(tS_insitu(i), VWC_insitu(1,i), VWC_insitu(2,i),'.')
ylabel('VWC [m^3/m^3]')
xticks([t_start:5:t_end])
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
yyaxis right
plot(tS(tS>t_start),cumsum(PPT(tS>t_start,i),'omitnan'),'c','linewidth',2);hold on
xticks([t_start:5:t_end])
caxis([.35 .7])
xlim([t_start t_end])
%ylim([0 max(max(PPT))]);
ax = gca;
ax.YAxis(2).Color = 'c';
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['PPT [mm]'])
%legend('5cm','10cm','20cm','50cm','in situ','PPT')
legend('5cm','10cm','20cm','50cm','PPT','Location','NorthWest')
originalSize1 = get(gca, 'Position');
yLimits = get(gca,'YLim');
text(t_end+1,yLimits(2)+12,'a')

   
h2=subplot(312)
p=pcolor(tS(Flag(:,1,i)==0),[5 10 20 50 60],squeeze(VWC_E_plot(Flag(:,1,i)==0,:,i))')
p.EdgeColor = 'none';
colormap(flipud(jet))
yticks([5 10 20 50])
set(gca,'Ydir','reverse')
p.FaceColor = 'interp'
xticks([t_start:5:t_end])
xlim([t_start t_end])
ylim([0 60])
caxis([.1 .7])

ylabel('Depth [cm]')
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
originalSize = get(gca, 'Position');
h=colorbar;
fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
set(h2, 'Position', fixSize);
ylabel(h,'VWC [m^3/m^3]')
suptitle(site_title{i})
yLimits = get(gca,'YLim');
  text(t_end+1,yLimits(1)-3,'b')
        
        %
h3=subplot(313)
p=pcolor(tS(Flag(:,1,i)==0),[5 10 20 50,60],squeeze(T_plot(Flag(:,1,i)==0,:,i))')
p.EdgeColor = 'none';
colormap(jet)
yticks([5 10 20 50])
set(gca,'Ydir','reverse')
p.FaceColor = 'interp'
xticks([t_start:5:t_end])
xlim([t_start t_end])
ylim([0 60])
caxis([5 45])
ylabel('Depth [cm]')
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
  text(t_end+1,yLimits(1)-3,'c')

    originalSize = get(gca, 'Position');
    h=colorbar;
    fixSize=[originalSize(1) originalSize(2) originalSize(3) originalSize1(4)];
    set(h3, 'Position', fixSize);
    ylabel(h,'T [C]')
    suptitle(site_title{i})
    colormap(h2,flipud(jet))
colormap(h3,jet)
yLimits = get(gca,'YLim');
export_fig(['E:\Soil_Moisture\TRACER_Report\TCEQ_read\figures_report\VWC_T\',site{i},'_',datestr(t_start,'YYYYmm')], '-tiff', '-r300', '-transparent')

end

i

%% VWC data

figure()
subplot(511)
%bar(tS,PPT(:,1:2));hold on
h1=plot(tS(tS>tS_insitu(1)),cumsum(PPT(tS>tS_insitu(1),1:4),'omitnan'));hold on
set(h1(4), 'Color', 'k')

xticks([t_start:5:t_end])
xlim([t_start t_end])
%ylim([0 max(max(PPT))]);
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['PPT [mm]'])

for i=1:4
subplot(5,1,i+1)
h2=plot(tS,squeeze(T(:,i,1:4)));hold on
set(h2(4), 'Color', 'k')

ylim([15 40])
xlim([t_start t_end])
ylabel('Temperature [C]')
xticks([t_start:5:t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
for j=1:5
subplot(5,1,i+1)
plot(tS(Flag(:,i,1,j)==1),squeeze(T(Flag(:,i,1,j)==1,i,1)),['b',symbol_f{j}])
plot(tS(Flag(:,i,2,j)==1),squeeze(T(Flag(:,i,2,j)==1,i,2)),['r',symbol_f{j}])
plot(tS(Flag(:,i,3,j)==1),squeeze(T(Flag(:,i,3,j)==1,i,3)),['k',symbol_f{j}])
plot(tS(Flag(:,i,4,j)==1),squeeze(T(Flag(:,i,4,j)==1,i,3)),['g',symbol_f{j}])

end
end

%%
% 
% figure()
% subplot(511)
% bar(tS_hr,PPT_hr(:,1:2));hold on
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% ylabel(['PPT [mm]'])
% for i=1:4
% subplot(5,1,i+1)
% plot(tS_hr,squeeze(VWC_E_hr(:,i,1:2)));hold on
% plot(0,0,'k.')
% plot(0,0,'k*')
% plot(0,0,'ks')
% plot(0,0,'kd')
% plot(0,0,'ko')
% 
% xlim([t_start t_end])
% datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
% for j=1:5
% subplot(5,1,i+1)
% plot(tS_hr(VWC_E_Flag_hr(:,i,1,j)==1),squeeze(VWC_E_hr(VWC_E_Flag_hr(:,i,1,j)==1,i,1)),['b',symbol_f{j}])
% plot(tS_hr(VWC_E_Flag_hr(:,i,2,j)==1),squeeze(VWC_E_hr(VWC_E_Flag_hr(:,i,2,j)==1,i,2)),['r',symbol_f{j}])
% end
% end

%% met data
figure('Position',[0 0 1200 1800])
subplot(611)
h1=plot(tS(tS>t_start),cumsum(PPT(tS>t_start,1:4),'omitnan'));hold on
set(h1(4), 'Color', 'k')

%bar(tS_hr,PPT_hr(:,1:2));hold on
xlim([t_start t_end])
xticks([t_start:5:t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['PPT [mm]'])
subplot(612)
h2=plot(tS_hr,Ws_hr(:,1:4));hold on
set(h2(4), 'Color', 'k')

xlim([t_start t_end])
xticks([t_start:5:t_end])

datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['Windspeed [m/s]'])
subplot(613)
h3=plot(tS_hr,Wd_hr(:,1:4));hold on
set(h3(4), 'Color', 'k')

xlim([t_start t_end])
xticks([t_start:5:t_end])

datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['Wind direction'])
subplot(614)
h4=plot(tS_hr,Tair_hr(:,1:4));hold on
set(h4(4), 'Color', 'k')

xlim([t_start t_end])
xticks([t_start:5:t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['Temp air [C]'])
subplot(615)
h5=plot(tS_hr,Tdew_hr(:,1:4));hold on
set(h5(4), 'Color', 'k')

xlim([t_start t_end])
xticks([t_start:5:t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
ylabel(['Dew point temperature [C]'])
subplot(616)
h6=plot(tS_hr,Srad_hr(:,1:4));hold on

plot(0,0,'k.')
plot(0,0,'k*')
plot(0,0,'ks')
plot(0,0,'kd')
plot(0,0,'ko')
ylabel(['Srad [W/m^2]'])
legend('UHCC','La Porte','UHSL','GUYT','Flag1','Flag2','Flag3','Flag4','Flag5','AutoUpdate','off','Location','NorthWest')
xticks([t_start:5:t_end])
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
for j=1:5
subplot(612)
plot(tS_hr(Ws_hr_flag(:,1,j)==1),Ws_hr(Ws_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
plot(tS_hr(Ws_hr_flag(:,2,j)==1),Ws_hr(Ws_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
plot(tS_hr(Ws_hr_flag(:,3,j)==1),Ws_hr(Ws_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
plot(tS_hr(Ws_hr_flag(:,4,j)==1),Ws_hr(Ws_hr_flag(:,4,j)==1,4),['g',symbol_f{j}])

subplot(613)
plot(tS_hr(Wd_hr_flag(:,1,j)==1),Wd_hr(Wd_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
plot(tS_hr(Wd_hr_flag(:,2,j)==1),Wd_hr(Wd_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
plot(tS_hr(Wd_hr_flag(:,3,j)==1),Wd_hr(Wd_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
plot(tS_hr(Wd_hr_flag(:,4,j)==1),Wd_hr(Wd_hr_flag(:,4,j)==1,4),['g',symbol_f{j}])

subplot(614)
plot(tS_hr(Tair_hr_flag(:,1,j)==1),Tair_hr(Tair_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
plot(tS_hr(Tair_hr_flag(:,2,j)==1),Tair_hr(Tair_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
plot(tS_hr(Tair_hr_flag(:,3,j)==1),Tair_hr(Tair_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
plot(tS_hr(Tair_hr_flag(:,4,j)==1),Tair_hr(Tair_hr_flag(:,4,j)==1,4),['g',symbol_f{j}])

subplot(615)
plot(tS_hr(Tdew_hr_flag(:,1,j)==1),Tdew_hr(Tdew_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
plot(tS_hr(Tdew_hr_flag(:,2,j)==1),Tdew_hr(Tdew_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
plot(tS_hr(Tdew_hr_flag(:,3,j)==1),Tdew_hr(Tdew_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
plot(tS_hr(Tdew_hr_flag(:,4,j)==1),Tdew_hr(Tdew_hr_flag(:,4,j)==1,4),['g',symbol_f{j}])

subplot(616)
plot(tS_hr(Srad_hr_flag(:,1,j)==1),Srad_hr(Srad_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
plot(tS_hr(Srad_hr_flag(:,2,j)==1),Srad_hr(Srad_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
plot(tS_hr(Srad_hr_flag(:,3,j)==1),Srad_hr(Srad_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
plot(tS_hr(Srad_hr_flag(:,4,j)==1),Srad_hr(Srad_hr_flag(:,4,j)==1,4),['g',symbol_f{j}])

end
set(h6(3), 'Color', 'k')

export_fig(['E:\Soil_Moisture\TRACER_Report\TCEQ_read\figures_report\Met_\',datestr(t_start,'YYYYmm')], '-tiff', '-r300', '-transparent')

%%
var1=nansum(Ws_hr_flag,3);
completeness_total(1,1)=length(find(var1(tS_hr>tS_insitu(1),1)==0))/length(find(tS_hr>tS_insitu(1)));
completeness_total(1,2)=length(find(var1(tS_hr>tS_insitu(2),2)==0))/length(find(tS_hr>tS_insitu(2)));
completeness_total(1,3)=length(find(var1(tS_hr>tS_insitu(3),3)==0))/length(find(tS_hr>tS_insitu(3)));
completeness_total(1,4)=length(find(var1(tS_hr>tS_insitu(4),4)==0))/length(find(tS_hr>tS_insitu(4)));

var1=nansum(Wd_hr_flag,3);
completeness_total(2,1)=length(find(var1(tS_hr>tS_insitu(1),1)==0))/length(find(tS_hr>tS_insitu(1)));
completeness_total(2,2)=length(find(var1(tS_hr>tS_insitu(2),2)==0))/length(find(tS_hr>tS_insitu(2)));
completeness_total(2,3)=length(find(var1(tS_hr>tS_insitu(3),3)==0))/length(find(tS_hr>tS_insitu(3)));
completeness_total(2,4)=length(find(var1(tS_hr>tS_insitu(4),4)==0))/length(find(tS_hr>tS_insitu(4)));

var1=nansum(Tair_hr_flag,3);
completeness_total(3,1)=length(find(var1(tS_hr>tS_insitu(1),1)==0))/length(find(tS_hr>tS_insitu(1)));
completeness_total(3,2)=length(find(var1(tS_hr>tS_insitu(2),2)==0))/length(find(tS_hr>tS_insitu(2)));
completeness_total(3,3)=length(find(var1(tS_hr>tS_insitu(2),3)==0))/length(find(tS_hr>tS_insitu(3)));
completeness_total(3,4)=length(find(var1(tS_hr>tS_insitu(2),4)==0))/length(find(tS_hr>tS_insitu(4)));

var1=nansum(Tdew_hr_flag,3);
completeness_total(4,1)=length(find(var1(tS_hr>tS_insitu(1),1)==0))/length(find(tS_hr>tS_insitu(1)));
completeness_total(4,2)=length(find(var1(tS_hr>tS_insitu(2),2)==0))/length(find(tS_hr>tS_insitu(2)));
completeness_total(4,3)=length(find(var1(tS_hr>tS_insitu(3),3)==0))/length(find(tS_hr>tS_insitu(3)));
completeness_total(4,4)=length(find(var1(tS_hr>tS_insitu(4),4)==0))/length(find(tS_hr>tS_insitu(4)));

var1=nansum(Srad_hr_flag,3);
completeness_total(5,1)=length(find(var1(tS_hr>tS_insitu(1),1)==0))/length(find(tS_hr>tS_insitu(1)));
completeness_total(5,2)=length(find(var1(tS_hr>tS_insitu(2),2)==0))/length(find(tS_hr>tS_insitu(2)));
completeness_total(5,3)=length(find(var1(tS_hr>tS_insitu(3),3)==0))/length(find(tS_hr>tS_insitu(3)));
completeness_total(5,4)=length(find(var1(tS_hr>tS_insitu(4),4)==0))/length(find(tS_hr>tS_insitu(4)));

%%
var1=nansum(Ws_hr_flag,3);
completeness_report(1,1)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,1)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(1,2)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,2)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(1,3)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,3)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(1,4)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,4)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));

var1=nansum(Wd_hr_flag,3);
completeness_report(2,1)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,1)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(2,2)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,2)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(2,3)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,3)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(2,4)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,4)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));

var1=nansum(Tair_hr_flag,3);
completeness_report(3,1)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,1)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(3,2)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,2)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(3,3)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,3)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(3,4)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,4)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));

var1=nansum(Tdew_hr_flag,3);
completeness_report(4,1)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,1)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(4,2)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,2)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(4,3)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,3)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(4,4)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,4)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));

var1=nansum(Srad_hr_flag,3);
completeness_report(5,1)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,1)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(5,2)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,2)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(5,3)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,3)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));
completeness_report(5,4)=length(find(var1(tS_hr>t_start & tS_hr<=t_end,4)==0))/length(find(tS_hr>t_start & tS_hr<=t_end));

