%Data analysis for DoD written by Ashwin RajKumar
clc
clear all
close all
%Variables involved in the study GFO, PLFR, and PLD
cd('R:\raghavanlab\raghavanlabspace\OPEN STUDIES\Raghavan_CO-I\DOD_MS\Data\Data (Filtered)\106\Training\asdf');      %Enter the command prompt of the folder.
list=dir();        
spike_files=dir('*.txt');               %Collects all the file names in a single variable with *.txt file type
for i = 1:length(spike_files)
     D = strcat('R:\raghavanlab\raghavanlabspace\OPEN STUDIES\Raghavan_CO-I\DOD_MS\Data\Data (Filtered)\106\Training\asdf');
    C = strcat(D,'\',spike_files(i).name);
    fid = fopen(C, 'rb');
    %# Get file size.
fseek(fid, 0, 'eof');
fileSize = ftell(fid);
frewind(fid);
%# Read the whole file.
data = fread(fid, fileSize, 'uint8');
%# Count number of line-feeds and increase by one.
numLines(i,1) = sum(data == 10) + 1;
fclose(fid);
end
                                        %Verifying the number of datapoints in a text file 
numlmax = max(numLines);
numlmean = ceil(mean(numLines));
numlobject = min(numLines);
if(numlmean-numlobject>=500)            %provides warning if the mean number is very high compaed to minimum number
    disp('WARNING: delete files with inconsistent number of data points.');   
end
                    %Variable declaration
LF = zeros(i,numlobject);
GF = zeros(i,numlobject);
LFR = zeros(i,numlobject);
GFR = zeros(i,numlobject);
time = 0:1/60:(length(LF)-1)/60;

for i=1:length(spike_files)
         D = strcat('R:\raghavanlab\raghavanlabspace\OPEN STUDIES\Raghavan_CO-I\DOD_MS\Data\Data (Filtered)\106\Training\asdf');
    C = strcat(D,'\',spike_files(i).name);
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
LF(i,:) = cell2mat(raw(1:numlobject, 1));
GF(i,:) = cell2mat(raw(1:numlobject, 2));
minGF = min(GF(i,:));
GF(i,:) = GF(i,:) -minGF;
for j = 2:numlobject
    LFR(i,j) = (LF(i,j) - LF(i,j-1))/((time(1,j) - time(1,j-1)));
    if(LFR(i,j)<0)
        LFR(i,j) = 0;
    end
    GFR(i,j) = (GF(i,j) - GF(i,j-1))/((time(1,j) - time(1,j-1)));
     if(GFR(i,j)<0)
        GFR(i,j) = 0;
     end
end
GFR(i,:) = smooth(GFR(i,:));
LFR(i,:) = smooth(LFR(i,:));
[GFR_peaks,GFR_T] = findpeaks(GFR(i,:),'MinPeakHeight',10,'MinPeakDistance',50);
[LFR_peaks,LFR_T] = findpeaks(LFR(i,:),'MinPeakHeight',10,'MinPeakDistance',50);
PLFR_whole(i,1:length(LFR_peaks)) = LFR_peaks; 
PGFR_whole(i,1:length(GFR_peaks)) = GFR_peaks;
PLFR_time(i,1:length(LFR_T)) = LFR_T;
PGFR_time(i,1:length(GFR_T)) = GFR_T;

figure(i)
plot(LF(i,:),'LineWidth',2)
hold on
plot(GF(i,:),'LineWidth',2)
plot(GFR(i,:),'LineWidth',2)
plot(LFR(i,:),'LineWidth',2)
scatter(LFR_T,LFR_peaks,'LineWidth',4)
scatter(GFR_T,GFR_peaks,'LineWidth',4)
legend({'GF_{GR}','LF_{GR}','GFR_{GR}','LFR_{GR}','PLFR_{GR}','PGFR_{GR}'},'Location','northwest','FontSize',11,'TextColor','blue','Orientation','vertical')
ylabel('N and N/s')
xlabel('Time (seconds)');
hold off
end
%%

%%
PLD = zeros(size(PGFR_time));
GFO = zeros(size(PGFR_time));
num = 20;
for k = 1:4
    for l = 1:9
        if(PGFR_time(k,l)~= 0 && PGFR_time(k,l)+num<=numlobject && PLFR_time(k,l)~=
0 && PLFR_time(k,l)+num<=numlobject && PGFR_time(k,l)-num>=1 && PLFR_time(k,l)-num>=1)
pos2 = PGFR_time(k,l)-num+find(GF(k,PGFR_time(k,l)-num:PGFR_time(k,l)+num)>=0.1);     %Determines >=0.1N GF
pos1 = PLFR_time(k,l)-num+find(LF(k,PLFR_time(k,l)-num:PLFR_time(k,l)+num)>=0.1);     %Determines >=0.1N LF
PLD(k,l) = (pos1(1)-pos2(1))*1/60;
GFO(k,l) = GF(k,pos1(1));
        end
    end
end

%% Writing data in a CSV file
%S = {'Weight','Texture','PLFR','PGFR','PLD','GFO','\n'}
fid = fopen('asdf.txt','w');
fprintf( fid, '%s,%s,%s,%s,%s,%s,%s\n','S.No','Weight','Texture','PLFR','PGFR','PLD','GFO');
for i=1:length(spike_files)
C = strsplit(spike_files(i).name,'_');
Q = strsplit(char(C(7)),'.');
% fprintf( fid, '%s,%s,%s,%s,%s,%s,%s\n','S.No','Weight','Texture','PLFR','PGFR','PLD','GFO');
fprintf(fid,'%d,%s,%s',i,char(C(6)),char(Q(1)));
fprintf(fid,',%2i,%2i,%2i,%2i\n',PLFR_whole(i,1),PGFR_whole(i,1),PLD(i,1),GFO(i,1));
end
fclose(fid);
% csvwrite('asdf.txt',{string(C(6)),string(Q(1))});
