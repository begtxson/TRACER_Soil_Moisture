clear; close all;

dirname='path to data folder';
dirname_fig='path to where figures want to be saved';
load ([dirname,'\TCEQ_final_v1_3_jan.mat'])


t_end=datenum(datetime('now','TimeZone','-06:00'));
t_start=t_end-(datenum('02/00/0000')); %

numsen=[4 4 4 4]; %number of soil moisture sensors for each station
icon_txson=imread([dirname,'./website_images\TxSON.jpg']);

sample_pic_opt=dir([dirname,'./website_images\*.jpg']);

fns=14;
%%
for i=1:3
    fig=figure('Position',[0 0 900 700]);
    
    ind_pic=find(cellfun('length',regexp({sample_pic_opt.name},station(i,:))) > 0);
    if ~isempty(ind_pic)
        subplot(10,10,[67:70 77:80 87:90 97:100])
        sample_pic=imread([dirname,'\website_images\',sample_pic_opt(ind_pic(end)).name]);
        if i==1
            image(sample_pic);hold on
        else
            image(rot90(sample_pic,3));hold on
        end
    end
    set(gca,'Visible','off')
    
    subplot(10,10,[1:5 11:15 21:25])
    for j=1:numsen(i)
        plot(tS(Flag(:,j,i)==0),squeeze(VWC_E(Flag(:,j,i)==0,j,i)));hold on
    end
    ylabel('VSM [m^3/m^3]')
    title(station{i},'interpreter','none')
    xlim([t_start t_end])
    datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
    grid on
    set(gca,'FontWeight','bold','FontSize',fns,'LineWidth',2);
    ylim([0 .7])
    %datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
    
    title(station(i,:),'interpreter','none')
    set(gca,'FontSize',fns,'LineWidth',2);
    pos=get(gca,'Position');
    set(gca,'Position',[.10 pos(2) .45 .20])
    yyaxis right
    b=bar(tS,PPT(:,i));
    b.BarWidth=24;
    ylabel('PPT [mm]')
    set(gca,'YDir','reverse')
    xlim([t_start t_end])
    %datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
    ylim([0 40])
    yticks([0:10:40])
    legend2=legend([legendnames{i} {'Rain'}] ,'Location','NorthWest');
    pos=get(legend2,'position');
    set(legend2,'Position',[pos(1)+.50 pos(2) pos(3) pos(4)]);
    
    subplot(10,10,[31.1:35 41.1:45 51.1:55])
    for j=1:numsen(i)
        plot(tS(Flag(:,j,i)==0),squeeze(T(Flag(:,j,i)==0,j,i)));hold on
    end
    ylabel('Soil Temp [C]')
    xlim([t_start t_end])
    ylim([0 50])
    datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
    grid on
    set(gca,'FontWeight','bold','FontSize',fns,'LineWidth',2);
    % legend2=legend(legendnames{i},'Location','NorthWest');
    % pos=get(legend2,'position');
    % set(legend2,'Position',[pos(1)+.40 pos(2) pos(3) pos(4)]);
    set(gca,'FontSize',fns,'LineWidth',2);
    
    pos=get(gca,'Position');
    set(gca,'Position',[.10 pos(2) .45 .20])
    
    %     subplot(413)
    % plot(ts_same,squeeze(ka_all(:,1:numsen_update(i),i)))
    %  ylabel('Ka')
    % xlim([t_start t_end])
    %   set(gca,'FontWeight','bold','FontSize',fns,'LineWidth',2);
    %  datetick('x', 'mm/dd','KeepLimits')
    
    %  subplot(414)
    subplot(10,10,[61.1:65 71.1:75 81.1:85 ])
    for j=1:numsen(i)
        plot(tS(Flag(:,j,i)==0),squeeze(EC(Flag(:,j,i)==0,j,i)));hold on
    end
    ylabel('EC [dS/m]')
    xlim([t_start t_end])
    datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
    grid on
    % legend2=legend(legendnames{i},'Location','NorthWest')
    % pos=get(legend2,'position');
    % set(legend2,'Position',[pos(1)+.40 pos(2) pos(3) pos(4)]);
    set(gca,'FontWeight','bold','FontSize',fns,'LineWidth',2);
    set(gca,'FontSize',fns,'LineWidth',2);
    pos2=get(gca,'Position');
    set(gca,'Position',[.10 pos2(2) .45 .20])
    
    annotation(fig,'textbox',...
        [0.03 0.03 .25 .1],...
        'String',{['Last Collection: ' datestr(last_collection(i))],['Battery Min (V): ',num2str(last_battery(i),3)]},...
        'FitBoxToText','on','EdgeColor', 'none');
    
    annotation(fig,'textbox',...
        [0.30 0.030 .25 .1],...
        'String',{'PRECIPITATION',['Last hr: ',num2str(nansum(PPT(end-12:end,i)),3),'mm  ',num2str(nansum(PPT(end-12:end,i)/25.4),3),'in'],['24 hrs: ',num2str(nansum(PPT(end-(12*24*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*1):end,i))/25.4,3),'in'] ,['7 days: ',num2str(nansum(PPT(end-(12*24*7*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*7*1):end,i))/25.4,3),'in'] },...%,['30 days: ',num2str(nansum(PPT(end-(12*24*30*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*30*1):end,i))/25.4,3),'in']},...
        'FitBoxToText','off','EdgeColor', 'none');
    %'String',{'PRECIPITATION',['Last hr: ',num2str(nansum(PPT(end-12:end,i)),3),'mm  ',num2str(nansum(PPT(end-12:end,i)/25.4),3),'in'],['24 hrs: ',num2str(nansum(PPT(end-(12*24*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*1):end,i))/25.4,3),'in'] ,['7 days: ',num2str(nansum(PPT(end-(12*24*7*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*7*1):end,i))/25.4,3),'in'] ,['30 days: ',num2str(nansum(PPT(end-(12*24*30*1):end,i)),3),'mm  ',num2str(nansum(PPT(end-(12*24*30*1):end,i))/25.4,3),'in']},...
    
    
    subplot(10,10,[9:10 19:20])
    image(icon_txson)
    set(gca,'Visible','off')
    pos=get(gca,'Position');
    set(gca,'Position',[pos(1)+.05 pos(2) pos(3) pos(4)])
    
    print( '-r100', '-dpng', [dirname_fig,'/',station{i},'.png'])
    
    close(fig)
end
%%
symbol_f={'.','*','s','d','o'};%filter symbols
%%
figure()
subplot(511)
plot(tS_hr,Ws_hr(:,1:3));hold on
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
subplot(512)
plot(tS_hr,Wd_hr(:,1:3));hold on
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
subplot(513)
plot(tS_hr,Tair_hr(:,1:3));hold on
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
subplot(514)
plot(tS_hr,Tdew_hr(:,1:3));hold on
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
subplot(515)
plot(tS_hr,Srad_hr(:,1:3));hold on
xlim([t_start t_end])
datetick('x', 'mmm-dd','KeepLimits','KeepTicks')
for j=1:5
    subplot(511)
    plot(tS_hr(Ws_hr_flag(:,1,j)==1),Ws_hr(Ws_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
    plot(tS_hr(Ws_hr_flag(:,2,j)==1),Ws_hr(Ws_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
    plot(tS_hr(Ws_hr_flag(:,3,j)==1),Ws_hr(Ws_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
    
    subplot(512)
    plot(tS_hr(Wd_hr_flag(:,1,j)==1),Wd_hr(Wd_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
    plot(tS_hr(Wd_hr_flag(:,2,j)==1),Wd_hr(Wd_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
    plot(tS_hr(Wd_hr_flag(:,3,j)==1),Wd_hr(Wd_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
    subplot(513)
    plot(tS_hr(Tair_hr_flag(:,1,j)==1),Tair_hr(Tair_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
    plot(tS_hr(Tair_hr_flag(:,2,j)==1),Tair_hr(Tair_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
    plot(tS_hr(Tair_hr_flag(:,3,j)==1),Tair_hr(Tair_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
    subplot(514)
    plot(tS_hr(Tdew_hr_flag(:,1,j)==1),Tdew_hr(Tdew_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
    plot(tS_hr(Tdew_hr_flag(:,2,j)==1),Tdew_hr(Tdew_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
    plot(tS_hr(Tdew_hr_flag(:,3,j)==1),Tdew_hr(Tdew_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
    subplot(515)
    plot(tS_hr(Srad_hr_flag(:,1,j)==1),Srad_hr(Srad_hr_flag(:,1,j)==1,1),['b',symbol_f{j}])
    plot(tS_hr(Srad_hr_flag(:,2,j)==1),Srad_hr(Srad_hr_flag(:,2,j)==1,2),['r',symbol_f{j}])
    plot(tS_hr(Srad_hr_flag(:,3,j)==1),Srad_hr(Srad_hr_flag(:,3,j)==1,3),['k',symbol_f{j}])
end
print( '-r100', '-dpng', [dirname_fig,'/flag_met_tracer.png'])


%%
var1=nansum(Ws_hr_flag,3);
completeness(1,1)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,1)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(1,2)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,2)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(1,3)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,3)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));

var1=nansum(Wd_hr_flag,3);
completeness(2,1)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,1)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(2,2)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,2)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(2,3)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,3)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));

var1=nansum(Tair_hr_flag,3);
completeness(3,1)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,1)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(3,2)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,2)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(3,3)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,3)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));

var1=nansum(Tdew_hr_flag,3);
completeness(4,1)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,1)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(4,2)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,2)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(4,3)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,3)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));

var1=nansum(Srad_hr_flag,3);
completeness(5,1)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,1)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(5,2)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,2)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));
completeness(5,3)=length(find(var1(tS_hr>t_end-2 & tS_hr<t_end-1,3)==0))/length(find(tS_hr>t_end-2 & tS_hr<t_end-1));

varnames={'Ws','Wd','Tair','Tdew','Srad'};

%% Had to turn on "Less secure app access"

mail = 'txson.soilmoisture@gmail.com'; %Your GMail email address
password = 'TxSONBeg*it';  %Your GMail password
setpref('Internet','SMTP_Server','smtp.gmail.com');

setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');


recipients={'khayamdashti@gmail.com'};
for i=1:3
    x=0;
    if last_battery(i)<12
        %sendmail(recipients,['Check Battery Voltage at ',station{i}],['Battery Voltage Low at ',station{i}])
        x=1;
    end
    if last_collection(i)<(t_end-1)
        %sendmail(recipients,['Check Communication at ',station{i}],['No communication since ',datestr(last_collection(i)),' at ',station{i}])
        x=1;
    end
    for j=1:5
        if completeness(j,i)<.70
            %sendmail(recipients,['Check Flags at ',station{i}],['Flag for ',varnames{j},' at ',station{i}])
            x=1;
        end
    end
    
    if x==0 %& (abs(t_end-floor(t_end))<.02)
        %sendmail(recipients,['Everything ok ',station{i}],['No flag for ',station{i}])
    end
end

close all

%%