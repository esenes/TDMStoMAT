%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pulse counting with beam:
%
% counts the number of pulses with beam which are overcoming the beam 
% current treshold 
%
% REV. 1. by Theodoros Argyropoulos
%
% Last modified 07.09.2016 by Eugenio Senes
% - added report generation part
% - minor changes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc; clearvars;
[dirpath,~,~]=fileparts(mfilename('fullpath')); %include folder to path
addpath(genpath(dirpath))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% User input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dir_data = '/Users/esenes/swap_log_files/';
dir_report = '/Users/esenes/swap_out_pulse_counting/';

startDate = '20160603';
endDate = '20160603';

startTime = '16:00:00';
endTime = '16:54:00';
%name for report file
runName = 'Unloaded_10_2';
%%%%%%%%%%%%%%%%%%%%%%% End of user input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
[filesList] = Log_files2Analyse(dir_data,startDate,startTime,endDate,endTime);
[logFile_struct,tdms_struct] = loadSaveLogTDMSFiles(dir_data,filesList,startDate,startTime,endDate,endTime);
toc

%% Pulse counter
N_pulses = 0;
N_pulses_tot = 0;
beamThreshold = -1; %in Amperes

BPM1_peak = logFile_struct.BPM1_peak;
TimeStamp = logFile_struct.TimeStamp;
for i=1:length(BPM1_peak)
    N_pulses_tot = N_pulses_tot + 50;
    if BPM1_peak(i) < beamThreshold
        N_pulses = N_pulses + 50;
    end
end
display(['Total Number of pulses : ',num2str(N_pulses_tot)])
display(['Number of pulses with beam: ',num2str(N_pulses)])
display(['Number of pulses without beam: ',num2str(N_pulses_tot-N_pulses)])

%% Report file
fpn = [dir_report 'pulse_count_' runName '.log'];
logID = fopen(fpn, 'w+' ); 
msg = ['Pulse counting routine' '\n' ...
'Created: ' datestr(datetime('now')) '\n \n' ...
'Start: ' startDate ' ' startTime '\n' ...
'End:   ' endDate ' ' endTime '\n' ...
'\n'...
'Total number of pulses: ' num2str(N_pulses_tot) '\n' ...
'pulses with beam:       ' num2str(N_pulses) '\n' ...
'pulses without beam:    ' num2str(N_pulses_tot-N_pulses) '\n' ...
'\n'];
fprintf(logID,msg);
fclose(logID);