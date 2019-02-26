%%
%Author: Ashwin Raj Kumar.
%
clc
clear all
close all
subjectID = [string('1388') , string('1547') , string('1614') , string('1641') , string('1644') , string('1651') , string('1654'), string('1655') , string('1656') , string('1657') , string('1658') , string('1660') , string('1662') , string('1665') , string('1667') ,string('1668') , string('1670')];
cd('F:/Design of Medical devices_1/cup controller raw data/new device/')
addpath('F:/Design of Medical devices_1/cup controller raw data/')
list=dir();
var = 3;               %edit var to different numbers 3 to length(list) to access other folders
% for i=3:length(list)
cd(strcat('F:/Design of Medical devices_1/cup controller raw data/new device/',list(var).name));
spike_files=dir('*.txt');
s1=80;
s1_ = 1/s1;
sample = 1000;
t1 = [0:s1_:(sample-1)/s1];
LF = zeros(length(spike_files),sample);
GF = zeros(length(spike_files),sample);
GFR = zeros(length(spike_files),sample);
LFR = zeros(length(spike_files),sample);
PLFR_whole = zeros(14,10);
PGFR_whole = zeros(14,10);
PLFR_time =  zeros(14,10);
PGFR_time =  zeros(14,10);
LF_dif = zeros(14,sample);
GF_dif = zeros(14,sample);
for j = 1:length(spike_files)
    fngr(j,:)=strsplit(spike_files(j).name,'_'); 
    D = strcat('F:/Design of Medical devices_1/cup controller raw data/new device/',list(var).name);
    C = strcat(D,'/',spike_files(j).name);
[LF(j,:),GF(j,:),LFR(j,:),GFR(j,:)] = importgraspdevicedata(C,1,sample);
end

for i=1:length(spike_files)
LF(i,:) = smooth(LF(i,:));
GF(i,:) = smooth(GF(i,:));
LFR(i,:) = smooth(LFR(i,:));
GFR(i,:) = smooth(GFR(i,:));
for j = 2:sample
    LF_dif(i,j) = (LF(i,j) - LF(i,j-1))/(t1(1,j) - t1(1,j-1));
    if(LF_dif(i,j)<0)
        LF_dif(i,j) = 0;
    end
    GF_dif(i,j) = (GF(i,j) - GF(i,j-1))/(t1(1,j) - t1(1,j-1));
     if(GF_dif(i,j)<0)
        GF_dif(i,j) = 0;
     end
end
   LF_dif(i,:) =  smooth(LF_dif(i,:));
   GF_dif(i,:) = smooth(GF_dif(i,:));
   [LFR_peaks,LFR_T] = findpeaks(LF_dif(i,:),t1,'MinPeakHeight',10,'MinPeakDistance',0.75);
   [GFR_peaks,GFR_T] = findpeaks(GF_dif(i,:),t1,'MinPeakHeight',10,'MinPeakDistance',0.75);
PLFR_whole(i,1:length(LFR_peaks)) = LFR_peaks; 
PGFR_whole(i,1:length(GFR_peaks)) = GFR_peaks;
PLFR_time(i,1:length(LFR_T)) = LFR_T;
PGFR_time(i,1:length(GFR_T)) = GFR_T; 

%Display as a figure uncommenting below
% figure(i)
% plot(t1,GF(i,:),'k:','LineWidth',2)
% hold on
% title(spike_files(i).name)
% plot(t1,LF(i,:),'b:','LineWidth',2)
% plot(t1,GF_dif(i,:),'k--','LineWidth',1)
% plot(t1,LF_dif(i,:),'b--','LineWidth',1)
% scatter(LFR_T,LFR_peaks,'LineWidth',4)
% scatter(GFR_T,GFR_peaks,'LineWidth',4)
% legend({'GF_{GR}','LF_{GR}','GFR_{GR}','LFR_{GR}','PLFR_{GR}','PGFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','blue','Orientation','vertical')
% ylabel('N and N/s')
% xlabel('Time (seconds)');

end



%% ATI device
close all
subjectID = [string('1388') , string('1547') , string('1614') , string('1641') , string('1644') , string('1651') , string('1654'), string('1655') , string('1656') , string('1657') , string('1658') , string('1660') , string('1662') , string('1665') , string('1667') ,string('1668') , string('1670')];
cd('F:/Design of Medical devices_1/cup controller raw data/ATI/')
list=dir();
%var = 3;
cd(strcat('F:/Design of Medical devices_1/cup controller raw data/ATI/',list(var).name));
spike_files=dir('*.txt');
 Fs = 2000; % Sampling Frequency
N = 2; % Order
Fc = 8; % Cutoff Frequency
sampl = 18460;
% Calculate the zpk values using the BUTTER function.
[b, a] = butter(N, Fc/(Fs/2),'low'); 
LFR_ATI= zeros(14,sampl);
GFR_ATI= zeros(14,sampl);
PLFR_ATIwhole = zeros(14,10); 
PGFR_ATIwhole = zeros(14,10);
PLFR_ATItime = zeros(14,10);
PGFR_ATItime = zeros(14,10); 
 for trial=1:length(spike_files) 
                data=importdata(spike_files(trial).name);
                fnati(trial,:)=strsplit(spike_files(trial).name,'_');    
                time(trial,:) = data.data(1:sampl,1)';
                fz1=data.data(1:sampl,2);  
                fz2=data.data(1:sampl,3);  
                fy1=data.data(1:sampl,4); 
                fy2=data.data(1:sampl,5);  
                plate=data.data(1:sampl,7); 
                %low pass filter  
                fz1=filtfilt(b,a,fz1);
                fz2=filtfilt(b,a,fz2); 
                fy1=filtfilt(b,a,fy1); 
                fy2=filtfilt(b,a,fy2);
                foz1s=smooth(fz1(:),50); %uses a smoothing filter with a span of 50 (span=5=> yy(4) = (y(2) + y(3) + y(4) + y(5) + y(6))/5),(average of the input data from times t-arg1 to t+arg1, arg1=12.5 ms)
                        foz2s=smooth(fz2(:),50); 
                        foy1s=smooth(fy1(:),50); 
                        foy2s=smooth(fy2(:),50);  
                        GF_ATI(trial,:)=foz2s'; %GRIP FORCE IS AVERAGE OF THUMB AND INDEX, GF=foz2s; %
                        LF_ATI(trial,:)=foy1s'+foy2s';   %LOAD FORCE IS SUMATION OF THUMB AND INDEX FORCES
                        %{---------------------------------------------------------------------------  
                        %Below calculate the Peak grip force rate and peak load force rate then find the timing of it.
                        %}--------------------------------------------------------------------------  
                        step=10; 
                        %average of fingers derivative
                        LF_offset = min(LF_ATI(trial,:));
                        GF_offset = min(GF_ATI(trial,:));
                        LF_ATI(trial,:) = LF_ATI(trial,:) - LF_offset;
                        GF_ATI(trial,:) = GF_ATI(trial,:) - GF_offset;
                        for x=step+1:1:length(LF_ATI(trial,:))-step-1 
                        LFR_ATI(trial,x)=(LF_ATI(trial,x+step)-LF_ATI(trial,x-step))./(time(trial,x+step)-time(trial,x-step)); %get the first derivative (The slope at time t is calculated from the points in the time range t-arg1 to t+arg1, arg1=12.5 ms) 
                        if(LFR_ATI(trial,x)<0)
                         LFR_ATI(trial,x) = 0;
                         end
                        end 

                        for x=step+1:1:length(GF_ATI(trial,:))-step-1 
                        GFR_ATI(trial,x)=(GF_ATI(trial,x+step)-GF_ATI(trial,x-step))./(time(trial,x+step)-time(trial,x-step)); %get the first derivative (The slope at time t is calculated from the points in the time range t-arg1 to t+arg1, arg1=12.5 ms) 
                           if(GFR_ATI(trial,x)<0)
                            GFR_ATI(trial,x) = 0;
                           end
                        end
                    
   GFR_ATI(trial,:) =  smooth(GFR_ATI(trial,:));
   LFR_ATI(trial,:) = smooth(LFR_ATI(trial,:));
   [LFR_peaks_ATI,LFR_TATI] = findpeaks(LFR_ATI(trial,:),time(trial,:),'MinPeakHeight',5,'MinPeakDistance',0.65);
   [GFR_peaks_ATI,GFR_TATI] = findpeaks(GFR_ATI(trial,:),time(trial,:),'MinPeakHeight',5,'MinPeakDistance',0.65);
PLFR_ATIwhole(trial,1:length(LFR_peaks_ATI)) = LFR_peaks_ATI; 
PGFR_ATIwhole(trial,1:length(GFR_peaks_ATI)) = GFR_peaks_ATI;
PLFR_ATItime(trial,1:length(LFR_TATI)) = LFR_TATI;
PGFR_ATItime(trial,1:length(GFR_TATI)) = GFR_TATI; 
                                          
figure(trial)
 plot(time(trial,:),GF_ATI(trial,:),'k:','LineWidth',2)
hold on
 title(spike_files(trial).name)
plot(time(trial,:),LF_ATI(trial,:),'b:','LineWidth',2)
 plot(time(trial,:),GFR_ATI(trial,:),'k--','LineWidth',1)
 plot(time(trial,:),LFR_ATI(trial,:),'b--','LineWidth',1)
 scatter(GFR_TATI,GFR_peaks_ATI,'LineWidth',4)
 scatter(LFR_TATI,LFR_peaks_ATI,'LineWidth',4)
legend({'GF_{ATI}','LF_{ATI}','GFR_{ATI}','LFR_{ATI}','PGFR_{ATI}','PLFR_{ATI}'},'Location','northwest','FontSize',11,'TextColor','blue','Orientation','vertical')
ylabel('N and N/s')
xlabel('Time (seconds)');  
hold off
                                       
 end
 
 
%% 
 %%Combined plotting
 
for i=1:4
figure(i)
plot(time(i,:),GF_ATI(i,:),'k-','LineWidth',2)
hold on
axis 'tight'
title(fngr(i,3))
plot(t1,GF(i,:),'b-','LineWidth',2)
plot(time(i,:),GFR_ATI(i,:),'k:','LineWidth',1)
plot(t1,GF_dif(i,:),'b:','LineWidth',1)
legend({'GF_{ATI}','GF_{GR}','GFR_{ATI}','GFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','black','Orientation','vertical')
ylabel('N and N/s')
xlabel('Time (seconds)');  
end

%%
% for i=1:4
% figure(i)
% % plot(time(i,:),GF_ATI(i,:),'k-','LineWidth',2)
% hold on
% axis 'tight'
% title(fngr(i,3))
% % plot(t1,GF(i,:),'b-','LineWidth',2)
%  plot(time(i,:),GFR_ATI(i,:),'k:','LineWidth',1)
%  plot(t1,GF_dif(i,:),'b:','LineWidth',1)
% legend({'GFR_{ATI}','GFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','black','Orientation','vertical')
% ylabel('N and N/s')
% xlabel('Time (seconds)');  
% end

for i=5:14
figure(i)
plot(time(i,:),LF_ATI(i,:),'k-','LineWidth',2)
hold on
axis 'tight'
title(fngr(i,3))
plot(t1,LF(i,:),'b-','LineWidth',2)
plot(time(i,:),LFR_ATI(i,:),'k:','LineWidth',1)
plot(t1,LF_dif(i,:),'b:','LineWidth',1)
legend({'LF_{ATI}','LF_{GR}','LFR_{ATI}','LFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','black','Orientation','vertical')
ylabel('N and N/s')
xlabel('Time (seconds)');  
end

%  for i=5:14
% figure(i)
% % plot(time(i,:),LF_ATI(i,:),'k-','LineWidth',2)
% hold on
% axis 'tight'
% title(fngr(i,3))
% % plot(t1,LF(i,:),'b-','LineWidth',2)
% plot(time(i,:),LFR_ATI(i,:),'k:','LineWidth',1)
% plot(t1,LF_dif(i,:),'b:','LineWidth',1)
% legend({'LFR_{ATI}','LFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','black','Orientation','vertical')
% ylabel('N and N/s')
% xlabel('Time (seconds)');  
% end