function [files2save_new] = files2Save(startDate, endDate, dir_data, dir_analysis,Xbox,fileType)
    if nargin < 6
        fileType = 1;
    end
    
    if Xbox==1
        nameString = 'Prod*.tdms';
%         datafiles = dir([dir_data,'Prod*.tdms']);
        fdate_indexes = (6:13);
        fname_indexes = (1:13);
    elseif Xbox==2
        if fileType == 1;
            nameString = 'EventData*.tdms';
%             datafiles = dir([dir_data,'EventData*.tdms']);
        else
            nameString = 'TrendData*.tdms';
        end
        fdate_indexes = (11:18);
        fname_indexes = (1:18);
    end
    
    datafiles = dir([dir_data,nameString]);
    for i=1:length(datafiles)
        fname = datafiles(i).name;
        fdate = fname(fdate_indexes);
        if strcmp(startDate,fdate)
            st_index = i;
        end
        if strcmp(endDate,fdate)
            end_index = i;
        end
    end
    files2save = datafiles(st_index:end_index);
    
%     files_exist = dir([dir_analysis,'Prod*.mat']);
    files_exist = dir([dir_analysis,nameString]);
    files2save_new = files2save;
    for i=length(files2save):-1:1
        
        for j=1:length(files_exist)
%             if strcmp(files2save(i).name(1:13),files_exist(j).name(1:13))
            if strcmp(files2save(i).name(fname_indexes),files_exist(j).name(fname_indexes))
                files2save_new(i) = [];
            end
        end
    end