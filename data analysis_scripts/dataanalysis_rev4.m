% Data analysis for DoD written by Ashwin RajKumar
% Edited by Matthew Bird
clc
clear all
close all
%Variables involved in the study GFO, PLFR, and PreLD
% A = 'C:\Users\mbird\Documents\Quarantine Files\Grip Device\GripDataUpdate_04_08_20\M120'; 
A = 'C:\Users\mbird\Downloads\Updated_Test_Grip_Data'; 
cd(A);      %Enter the command prompt of the folder.
list=dir();        
spike_files=dir('*.txt');       %Collects all the file names in a single variable with *.txt file type

fid1 = fopen('C:\Users\mbird\Documents\Quarantine Files\Grip Device\GripDataUpdate_04_08_20\M120\datasummary.txt','w');
% fid1 = fopen('C:\Users\mbird\Downloads\Updated_Test_Grip_Data\datasummary.txt','w');

% Header names of the output file
fprintf( fid1, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s','Subject ID','Session Number','Pre/Post','First/Second','Instructor','Weight','Texture','Trial Number','GF Peak','GFR Max','LFR Max','GFOn','LFOn','PreLD','GFL','LFL','GFD','LFD','GFOff','LFOff','PostLD','GFR Min','LFR Min');
% fprintf( fid1, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s','Subject ID','Session Number','Pre/Post','First/Second','Instructor','Weight','Texture','Trial Number','GF Peak','GFR Max','LFR Max','GFOn','LFOn','PreLD','GFL','LFL','GFD','LFD','GFR Min','LFR Min');
fprintf( fid1,'\n');

% M101
% Invalid
% 
%%%%%%%%%%%%%%%%%%%%
% Too Long
% 
%%%%%%%%%%%%%%%%%%%%
% Check
% 

%%%%%%%%%%%%%%%% Change Number of Peaks %%%%%%%%%%%%%%%%%
N_Peaks = 10;
%%%%%%%%%%%%%%% Change Min Peak Distance %%%%%%%%%%%%%%%%
MinPeakDist = 35;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for i = 1:length(spike_files)
% for i = 1

Invalid = [6 8 9 16 17 20 21 22 24 71];
Check = [];
Too_Long = [];
Largest = max([max(Invalid) max(Check) max(Too_Long)]);
removed = [Invalid Check Too_Long];
all_files = 1:length(spike_files);
some_files = setdiff(all_files,removed);
for i = some_files
% for i = Largest+1:length(spike_files)
    
    C = strcat(A,'\',spike_files(i).name);
    fid = fopen(C, 'rb');
    delimiter = ',';
    fileID = fopen(C,'r');
    formatSpec = '%s%s%[^\n\r]';
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
    fclose(fileID);
    raw = repmat({''},length(dataArray{1}),length(dataArray)-1);

    for col=1:length(dataArray)-1
        raw(1:length(dataArray{col}),col) = dataArray{col};
    end

    numericData = NaN(size(dataArray{1},1),size(dataArray,2));

    for col=[1,2]
        % Converts text in the input cell array to numbers. Replaced non-numeric
        % text with NaN.
        rawData = dataArray{col};

        for row=1:size(rawData, 1)
            % Create a regular expression to detect and remove non-numeric prefixes and
            % suffixes.
            regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
            try
                result = regexp(rawData{row}, regexstr, 'names');
                numbers = result.numbers;

                % Detected commas in non-thousand locations.
                invalidThousandsSeparator = false;
                if any(numbers==',')
                    thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                    if isempty(regexp(numbers, thousandsRegExp, 'once'))
                        numbers = NaN;
                        invalidThousandsSeparator = true;
                    end
                end
                % Convert numeric text to numbers.
                if ~invalidThousandsSeparator
                    numbers = textscan(strrep(numbers, ',', ''), '%f');
                    numericData(row, col) = numbers{1};
                    raw{row, col} = numbers{1};
                end
                catch me
            end
       end
end

LF = cell2mat(raw(:, 1));
GF = cell2mat(raw(:, 2));
t = (0:1:length(LF)-1);
t = t/60; % 120 Hz
rLF = round(LF,1);
rGF = round(GF,1);

if mode(rGF) == max(rGF)
    GF = GF - min(rGF);
else
    GF = GF - mode(rGF);
end

if mode(rLF) == max(rLF)
    LF = LF - min(rLF);
else
    LF = LF - mode(rLF);
end

% Smooth using 5 span moving average filter
LF = smooth(LF);
GF = smooth(GF);

LFR = zeros(size(LF));
GFR = zeros(size(GF));

for j = 2:length(LF)
    LFR(j,1) = (LF(j,1) - LF(j-1,1))/((t(1,j) - t(1,j-1)));
%     if(LFR(j,1)<0)
%         LFR(j,1) = 0;
%     end
    GFR(j,1) = (GF(j,1) - GF(j-1,1))/((t(1,j) - t(1,j-1)));
%     if(GFR(j,1)<0)
%         GFR(j,1) = 0;
%     end
end

% GFR = smooth(GFR);
% LFR = smooth(LFR);

minimum = 0.5 * max(GF);

% %%%%%%%%%%%%%%%% Change Number of Peaks %%%%%%%%%%%%%%%%%
% N_Peaks = 10;
% %%%%%%%%%%%%%%% Change Min Peak Distance %%%%%%%%%%%%%%%%
% MinPeakDist = 35;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [GFL_peaks,GFL_T] = findpeaks(GF,'MinPeakHeight',minimum,'MinPeakDistance',40);
[GF_peaks,GF_T] = findpeaks(GF,'MinPeakHeight',minimum,'NPeaks',N_Peaks,'MinPeakDistance',MinPeakDist);
color5 = [0.25,0.25,0.25];
% [LFRmax_peaks,LFRmax_T] = findpeaks(LFR,'MinPeakHeight',10,'NPeaks',length(PFL_peaks),'MinPeakDistance',50);
% [LFRmax_peaks,LFRmax_T] = findpeaks(LFR,'MinPeakHeight',10,'MinPeakDistance',50);

%% Define all variables and colors for plotting

% LF
color1 = [0,0,1]; % Blue
% GF
color2 = [1,0,0]; % Red
% LFR
color3 = [0,0.4479,0.7410]; % Dark Blue
% GFR
color4 = [0.6350,0.0780,0.1840]; % Dark Red

% % Plot data
% figure(i)
% ylabel('N and N/s')
% xlabel('t (seconds)');
% title(sprintf('%s',spike_files(i).name));
% hold on
% plot(t,LF,'Color',color1,'LineWidth',2)
% plot(t,GF,'Color',color2,'LineWidth',2)
% plot(t,GFR,'Color',color4,'LineWidth',2)
% plot(t,LFR,'Color',color3,'LineWidth',2)
% scatter(t(GF_T),GF_peaks,'MarkerEdgeColor',color5,'LineWidth',4)

leng = length(GF_peaks);
LFRmax_peaks = zeros(size(GF_peaks));  % Lift Force Rate
LFRmax_T = ones(size(GF_peaks));
color6 = [0.3010,0.7450,0.9330]; % Light Blue

GFRmax_peaks  = zeros(size(GF_peaks));  % Grip Force Rate
GFRmax_T = ones(size(GF_peaks));
color7 = [0.5608,0.1451,0.1451]; % Darker Red

GFOn_peaks = zeros(size(GF_peaks));  % Grip Force at Onset
GFOn_T = ones(size(GF_peaks));
color8 = [0.85,0.325,0.098]; % Burnt Orange

LFOn_peaks = zeros(size(GF_peaks));  % Lift Force at Onset
LFOn_T  = ones(size(GF_peaks));
color9 = [0.929,0.694,0.125]; % Golden Yellow

GFL_peaks = zeros(size(GF_peaks));  % Grip Force at Lift
GFL_T = ones(size(GF_peaks));
color10 = [0.4940,0.1840,0.5560]; % Purple

LFL_peaks = zeros(size(GF_peaks));  % Lift Force at Lift
LFL_T = ones(size(GF_peaks));
color11 = [0.4660,0.6740,0.1880]; % Olive Green

GFRmin_peaks = zeros(size(GF_peaks)); % Grip Force Rate Minimum
GFRmin_T = ones(size(GF_peaks));
color14 = [0.5608,0.1451,0.1451];

LFRmin_peaks = zeros(size(GF_peaks)); % Lift Force Rate Minimum
LFRmin_T = ones(size(GF_peaks));
color15 = [0.3010,0.7450,0.9330];

% GFOff_peaks = zeros(size(GF_peaks)); % Grip Force Offset
% GFOff_T = ones(size(GF_peaks));
% color16 = [1 0.4118 0.1608];
% 
% LFOff_peaks = zeros(size(GF_peaks)); % Lift Force Offset
% LFOff_T = ones(size(GF_peaks));
% color17 = [1 1 0];

GFD_peaks = zeros(size(GF_peaks));  % Grip Force at Drop/Release
GFD_T = ones(size(GF_peaks));   
color12 = [0.75,0,0.75]; % Light Purple

LFD_peaks = zeros(size(GF_peaks));  % Lift Force at Drop/Release
LFD_T = ones(size(GF_peaks));
color13 = [0,0.5,0]; % Dark Green 

PreLD = zeros(size(GF_peaks));        % Pre-Load Phase Duration

% PostLD = zeros(size(GF_peaks));       % Post-Load Phase Duration

%%

sections = ones(1,leng+2);
sections(2:end-1) = GF_T;
sections(end) = length(GF);

for x = 1:leng
    
    lower_end = sections(x);
    upper_end = sections(x+1);
    
    for y = lower_end:upper_end
       
        % GFR: Grip Force Rate
        if (upper_end+10) > length(GF)
            if lower_end == 1
                [peak,location] = max(GFR(lower_end+5:upper_end));
                GFRmax_T(x) = location + lower_end - 1 + 5; 
            else
                [peak,location] = max(GFR(lower_end:upper_end));
                GFRmax_T(x) = location + lower_end - 1; 
            end 
        else
            if lower_end == 1
                [peak,location] = max(GFR(lower_end+5:upper_end+10));
                GFRmax_T(x) = location + lower_end - 1 + 5; 
            else
                [peak,location] = max(GFR(lower_end:upper_end+10));
                GFRmax_T(x) = location + lower_end - 1; 
            end
        end
        GFRmax_peaks(x) = peak;
               
        
        lower_end2 = GFRmax_T(x) - 5;
        if lower_end2 < 6
            lower_end2 = 6;
        end
        
        % LFR: Lift Force Rate
        if (upper_end+10) > length(GF)
            [peak2,location2] = max(LFR(lower_end2:upper_end));
            LFRmax_peaks(x) = peak2;
            LFRmax_T(x) = location2 + GFRmax_T(x)-5 - 1;
        else
            [peak2,location2] = max(LFR(lower_end2:upper_end+10));
            LFRmax_peaks(x) = peak2;
            LFRmax_T(x) = location2 + GFRmax_T(x)-5 - 1;
        end
        
    end
end
     
    if (GFRmax_T(1)-5) < 5 
        LF_start = LF(5);
    else
        LF_start = LF(5:GFRmax_T(1)-5);
    end
    
    LF = LF-mean(LF_start);
    LF(LF<=0) = 0;
    LF = LF - min(LF);
    GF(GF<=0)=0;
    
for x = 1:leng
        
    lower_end = sections(x);
    upper_end = sections(x+1);
    
    % GFOn: Grip Force Onset (When Grip Force begins slope and first exceeds 0.1N)
    for  z = GFRmax_T(x)+1:-1:(lower_end-1)
        if GF(z) > GF(z-1) && GF(z-1) >= 0.1
            GFOn_peaks(x) = GF(z-1);
            GFOn_T(x) = z-1;
        else
            break
        end
    end

    % LFOn: Lift Force Onset (When Lift Force begins slope and first exceeds 0.1N)
    for z2 = LFRmax_T(x)+1:-1:(lower_end-1)
        if LF(z2) > LF(z2-1) && LF(z2-1) >= 0.1
            LFOn_T(x) = z2-1;
            LFOn_peaks(x) = LF(LFOn_T(x));
        else
            break    
        end
    end
    
    % PreLD: Pre-Load Phase Duration
    PreLD(x) = t(LFOn_T(x)) - t(GFOn_T(x));
    
    % LFL: Lift Force at Lift
    for z3 = LFRmax_T(x):length(GF)-1
        if (LFR(z3+1) < LFR(z3)) && (LFR(z3+1) <= 0.5)
            LFL_T(x) = z3+1;
            LFL_peaks(x) = LF(LFL_T(x));
            break
        end
    end
    
    % GFL: Grip Force at Lift
    GFL_T(x) = LFL_T(x);
    GFL_peaks(x) = GF(GFL_T(x));
    
    % LFD: Lift Force at Drop/Release
    for z4 = LFRmax_T(x):length(LF)-1
        if LFR(z4) < -10
            LFD_T(x) = z4-1;
            LFD_peaks(x) = LF(LFD_T(x));
            break
        end
    end
    
    % GFD: Grip Force at Drop/Release
    GFD_T(x) = LFD_T(x);
    GFD_peaks(x) = GF(GFD_T(x));
    
  
    % GFRmin: Minimum Grip Force Rate
    second_half = (sections(x+1)-10):(sections(x+2)-10);
    second_half = second_half(second_half>0);
    
    [peak3,location3] = min(GFR(second_half));
    GFRmin_peaks(x) = peak3;
    GFRmin_T(x) = location3 + sections(x+1) - 10 - 1;

    % LFRmin: Minimum Lift Force Rate
    [peak4,location4] = min(LFR(second_half));
    LFRmin_peaks(x) = peak4;
    LFRmin_T(x) = location4 + sections(x+1) - 10 - 1;
    
%     % GFOff: Grip Force Offset
%     second_half2 = LFD_T(x):(sections(x+2)-10);
%     if second_half2(1) == 1
%         second_half2 = second_half2(2:end);
%     end
%     
%     for z5 = second_half2
%         if GF(z5) < 0.2
%             GFOff_T(x) = z5-1;
%             GFOff_peaks(x) = GF(z5-1);
%             break
%         elseif GF(z5) == 0.2
%             GFOff_T(x) = z5;
%             GFOff_peaks(x) = GF(z5);
%             break
%         end
%     end
% 
%     % LFOff: Lift Force Offset
%     for z6 = second_half2
%         if LF(z6) < 0.2
%             LFOff_T(x) = z6-1;
%             LFOff_peaks(x) = LF(z6-1);
%             break
%         elseif LF(z6) == 0.2
%             LFOff_T(x) = z6;
%             LFOff_peaks(x) = LF(z6);
%             break
%         end
%     end
%     
%     % Post Load Duration
%     PostLD(x) = t(GFOff_T(x)) - t(LFOff_T(x));
    
end

% Plot data
figure(i)
ylabel('N and N/s')
xlabel('t (seconds)');
title(sprintf('%s',spike_files(i).name));
hold on
plot(t,LF,'Color',color1,'LineWidth',2)
plot(t,GF,'Color',color2,'LineWidth',2)
plot(t,GFR,'Color',color4,'LineWidth',2)
plot(t,LFR,'Color',color3,'LineWidth',2)
scatter(t(GF_T),GF_peaks,'MarkerEdgeColor',color5,'LineWidth',4)
% Continue plotting data, adds peak identifiers
scatter(t(LFRmax_T),LFRmax_peaks,'MarkerEdgeColor',color6,'LineWidth',4)
scatter(t(GFRmax_T),GFRmax_peaks,'MarkerEdgeColor',color7,'LineWidth',4)
scatter(t(GFOn_T),GFOn_peaks,'MarkerEdgeColor',color8,'LineWidth',4)
scatter(t(LFOn_T),LFOn_peaks,'MarkerEdgeColor',color9,'LineWidth',4)
scatter(t(LFL_T),LFL_peaks,'MarkerEdgeColor',color11,'LineWidth',4)
scatter(t(GFL_T),GFL_peaks,'MarkerEdgeColor',color10,'LineWidth',4)
scatter(t(LFD_T),LFD_peaks,'MarkerEdgeColor',color13,'LineWidth',4)
scatter(t(GFD_T),GFD_peaks,'MarkerEdgeColor',color12,'LineWidth',4)
scatter(t(GFRmin_T),GFRmin_peaks,'MarkerEdgeColor',color14,'LineWidth',4)
scatter(t(LFRmin_T),LFRmin_peaks,'MarkerEdgeColor',color15,'LineWidth',4)
% scatter(t(GFOff_T),GFOff_peaks,'MarkerEdgeColor',color16,'LineWidth',4)
% scatter(t(LFOff_T),LFOff_peaks,'MarkerEdgeColor',color17,'LineWidth',4)
% legend({'LF_{GR}','GF_{GR}','GFR_{GR}','LFR_{GR}','GFL_{GR}','PLFR_{GR}','PGFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','blue','Orientation','horizontal')
hold off

% Break apart file name
S = strsplit(spike_files(i).name,'--_');
St = strsplit(char(S(1)),'-');
data = char(S(2));

% Extract variable information from title
texture = data(end-5:end-4);
weight = data(end-8:end-7);
instructor = data(end-11:end-10);
subject_ID = data(1:end-13);
session_number = St(6);
pre_post = St(7);
first_second = St(8);

for k = 1:leng
% fprintf( fid1, '%s,%s,%s,%s,%s,%s,%s,%s,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d',char(subject_ID),char(session_number),char(pre_post),char(first_second),char(instructor),char(weight),char(texture),strcat('Trial--', int2str(k)),GF_peaks(k),GFRmax_peaks(k),LFRmax_peaks(k),GFOn_peaks(k),LFOn_peaks(k),PreLD(k),GFL_peaks(k),LFL_peaks(k),GFD_peaks(k),LFD_peaks(k),GFOff_peaks(k),LFOff_peaks(k),PostLD(k),GFRmin_peaks(k),LFRmin_peaks(k));
fprintf( fid1, '%s,%s,%s,%s,%s,%s,%s,%s,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d,%.2d',char(subject_ID),char(session_number),char(pre_post),char(first_second),char(instructor),char(weight),char(texture),strcat('Trial--', int2str(k)),GF_peaks(k),GFRmax_peaks(k),LFRmax_peaks(k),GFOn_peaks(k),LFOn_peaks(k),PreLD(k),GFL_peaks(k),LFL_peaks(k),GFD_peaks(k),LFD_peaks(k),GFRmin_peaks(k),LFRmin_peaks(k));
fprintf( fid1,'\n');
end
% clearvars LF GF LFR GFR GFRmax_peaks LFRmax_peaks t GFRmax_T LFRmax_T GFOn_peaks GFOn_T LFOn_peaks LFOn_T LFL_peaks LFL_T LFD_peaks LFD_T GFD_peaks GFD_T k len j leng PreLD GFO t GFL_peaks GFL_T...
%     color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 ...
%     location location2 lower_end lower_end2 minimum peak peak2 x y z N_PeaksLFO GF_peaks GF_T i;
end

fclose(fid1);