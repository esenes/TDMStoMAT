%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read_TDMS_full.m reads the TDMS files and generates matfiles containing
% the data. 
% 
% Last modified 01.04.2016 by Eugenio Senes
% - added file size filter, to sort out files too small
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars; clc;
%include folder to path
[dirpath,~,~]=fileparts(mfilename('fullpath'));
addpath(genpath(dirpath))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% User input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dir_data ='/Volumes/mkx/TD26_Dogleg/2015_Run1/ProdData/';
dir_analysis ='/Users/esenes/swap_analysis/';
save_dir = '/Volumes/mkx/TD26_Dogleg/matfiles/';

startDate = '20160720';
endDate = '20160721';
%%%%%%%%%%%%%%%%%%%%%%% End of user input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%
Xbox = 1;
size_thr = 1e5; %100 kb
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



[files2save] = files2Save(startDate, endDate, dir_data, dir_analysis, Xbox);

% filter files too small
files2save_filtered = [];
for i = 1:length(files2save)
    if files2save(i).bytes > size_thr
        files2save_filtered = [files2save_filtered files2save(i)];
    end
end
files2save_filtered = rot90(files2save_filtered);

saveTDM2mat(f2s_f,dir_data,save_dir, Xbox);