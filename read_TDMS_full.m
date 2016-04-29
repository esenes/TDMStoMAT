% read_TDMS_full.m reads the TDMS files and generates matfiles containing
% the data. 
% 
% Last modified 01.04.2016 by Eugenio Senes
% I added the filter for files too small, and setted it ar 100kb
clearvars; clc;

dir_data ='/Volumes/mkx/TD26_Dogleg/2015_Run1/ProdData/';
dir_analysis ='/Users/esenes/swap_analysis/';
save_dir = '/Volumes/mkx/TD26_Dogleg/matfiles/';
% dir_data ='Z:\2015_Run1\ProdData';
% dir_analysis ='Y:\';
% save_dir = 'Z:\matfiles';
Xbox = 1;

startDate = '20160425';
endDate = '20160425';
[files2save] = files2Save(startDate, endDate, dir_data, dir_analysis, Xbox);

% filter files too small
files2save_filtered = [];
size_thr = 1e5; %100 kb
for i = 1:length(files2save)
    if files2save(i).bytes > size_thr
        files2save_filtered = [files2save_filtered files2save(i)];
    end
end
files2save_filtered = rot90(files2save_filtered);

saveTDM2mat(files2save,dir_data,save_dir, Xbox);