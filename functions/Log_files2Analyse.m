function [filesList] = Log_files2Analyse(dir_data,startDate,startTime,endDate,endTime)
    % create the Dates
    a = datenum(startDate,'yyyymmdd');
    b = datenum(endDate,'yyyymmdd');
    Dates = {};
    for i=a:b
        i_str = datestr(i,'yyyymmdd');
        Dates = [Dates;{i_str}];
    end

    % find the log files saved for these days (Dates)
    nameString = 'log*.tdms';
    fdate_indexes = (5:12);
    datafiles = dir([dir_data,nameString]);
    filesList = [];

    for i=1:length(datafiles)
        fname = datafiles(i).name;
        fdate = fname(fdate_indexes);

        if find(strcmp(Dates,fdate))
            filesList = [filesList;fname];
        end
    end

    %second iteration of the filesList now for StartTime and EndTime considerations
    startHour = startTime(1:2);
    endHour = endTime(1:2);
    fhour_indexes = (14:15);
    fdate_indexes = (5:12);
    N_iter = size(filesList,1);
    filesListKeep = ones(N_iter,1);
    for i=1:N_iter
        file_name = filesList(i,:);
        file_hour = file_name(fhour_indexes);
        file_date = file_name(fdate_indexes);
        if strcmp(Dates(1),file_date) && str2double(file_hour)+8<str2double(startHour)
            filesListKeep(i)=0;
        end
        if strcmp(Dates(end),file_date) && str2double(file_hour)>str2double(endHour)
            filesListKeep(i)=0;
        end    
    end
    filesList(filesListKeep==0,:)=[];