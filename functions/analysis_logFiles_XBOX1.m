%%
tic
dir_data = 'G:\Experiments\CTF3\DATA\mkx\TD26_Dogleg\2015_Run1\PXI\';
dir_analysis = 'C:\MatlabFiles\XBOX\XBOX_analysis_data\Xbox1\';
save_dir = '\\cern.ch\dfs\Experiments\CTF3\DATA\mkx\TD26_Dogleg\matfiles\';

startDate = '20160427';
endDate = '20160429';

startTime = '17:00:00';
endTime = '12:00:00';

[filesList] = Log_files2Analyse(dir_data,startDate,startTime,endDate,endTime);
% filesList = filesList(2:end,:)
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