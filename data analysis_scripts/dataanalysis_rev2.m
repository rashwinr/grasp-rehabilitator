%Data analysis for DoD written by Ashwin RajKumar
clc
clear all
close all
%Variables involved in the study GFO, PLFR, and PLD
A = 'F:\grasp rehabdevice\data_analysis_MS\gr_data\'; 
cd(A);      %Enter the command prompt of the folder.
list=dir();        
spike_files=dir('*.txt');               %Collects all the file names in a single variable with *.txt file type
fid1 = fopen('F:\grasp rehabdevice\data_analysis_MS\gr_data\datasummary.txt','w');
fprintf( fid1, '%s,%s,%s,%s,%s,%s,%s,%s,%s','Subject ID','Weight','Texture','Instructor','Trial NO','PLFR','PGFR','PLD','GFO');
fprintf( fid1,'\n');
for i = 1:length(spike_files)
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
    
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator;
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
GF = GF - min(GF);
LF = LF - min(LF);
LF = smooth(LF);
GF = smooth(GF);
time = (0:1:length(LF)-1);
time = time/60;
LFR = zeros(size(LF));
GFR = zeros(size(GF));

for j = 2:length(LF)
    LFR(j,1) = (LF(j,1) - LF(j-1,1))/((time(1,j) - time(1,j-1)));
    if(LFR(j,1)<0)
        LFR(j,1) = 0;
    end
    GFR(j,1) = (GF(j,1) - GF(j-1,1))/((time(1,j) - time(1,j-1)));
     if(GFR(j,1)<0)
        GFR(j,1) = 0;
     end
end

GFR = smooth(GFR);
LFR = smooth(LFR);
[GFL_peaks,GFL_T] = findpeaks(GF,'MinPeakHeight',5,'NPeaks',10,'MinPeakDistance',100);
% [GFR_peaks,GFR_T] = findpeaks(GFR,'MinPeakHeight',10,'MinPeakDistance',50);
% [LFR_peaks,LFR_T] = findpeaks(LFR,'MinPeakHeight',10,'MinPeakDistance',50);

leng = length(GFL_peaks);
LFR_peaks = zeros(size(leng));
LFR_T = zeros(size(leng));
GFR_peaks = zeros(size(leng));
GFR_T = zeros(size(leng));
PLD = zeros(size(leng));
GFO = zeros(size(leng));
num = 100;
figure(i)
plot(time,LF,'LineWidth',2)
hold on
plot(time,GF,'LineWidth',2)
plot(time,GFR,'LineWidth',2)
plot(time,LFR,'LineWidth',2)
scatter(time(GFL_T),GFL_peaks,'LineWidth',4)

for l = 1:leng
  if(GFL_T(l)~= 0 && GFL_T(l)+num<=length(time))
pos2 = GFL_T(l)-num+find(GF(GFL_T(l)-num:GFL_T(l))>=0.1);     %Determines >=0.1N GF
pos1 = GFL_T(l)-num+find(LF(GFL_T(l)-num:GFL_T(l))>=0.1);     %Determines >=0.1N LF
LFRsub = LFR(GFL_T(l)-num:GFL_T(l));
GFRsub = GFR(GFL_T(l)-num:GFL_T(l));
[LFR_peaks(l),LFR_T(l)] = findpeaks(LFRsub,'MinPeakHeight',10,'NPeaks',1);
LFR_T(l) = GFL_T(l)-num + LFR_T(l);
[GFR_peaks(l),GFR_T(l)] = findpeaks(GFRsub,'MinPeakHeight',10,'NPeaks',1);
GFR_T(l) = GFL_T(l)-num + GFR_T(l);
PLD(l) = (pos1(1)-pos2(1))*1/60;
GFO(l) = GF(pos1(1));
  else
      PLD(l) = 0;
      GFO(l) = 0;
  end
end


scatter(time(LFR_T),LFR_peaks,'LineWidth',4)
scatter(time(GFR_T),GFR_peaks,'LineWidth',4)

legend({'LF_{GR}','GF_{GR}','GFR_{GR}','LFR_{GR}','GFL_{GR}','PLFR_{GR}','PGFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','blue','Orientation','horizontal')
ylabel('N and N/s')
xlabel('Time (seconds)');
hold off

S = strsplit(spike_files(i).name,'--_');
St = strsplit(char(S(2)),'_');

for k = 1:leng
%     'Subject ID','Weight','Texture','Instructor','Trial No.','PLFR','PGFR','PLD','GFO'
fprintf( fid1, '%s,%s,%s,%s,%s,%d,%d,%d,%d',char(St(1)),char(St(3)),char(St(4)),char(St(2)),strcat('Trial--', int2str(k)),LFR_peaks(k),GFR_peaks(k),PLD(k),GFO(k));
fprintf( fid1,'\n');
end
clearvars LF GF LFR GFR GFR_peaks LFR_peaks time GFR_T LFR_T k len j leng PLD GFO time GFL_peaks GFL_T;
end

fclose(fid1);