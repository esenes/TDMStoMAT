function [] = saveTDM2mat(files2save,dir_data,save_dir, Xbox)
%     cd C:\MatlabFiles\XBOX\TDMS_functions
    for i=1:length(files2save)
        file_name = files2save(i).name;
        file_name = fullfile(dir_data,file_name);
        tdms_struct = TDMS_getStruct(file_name);    % reading tdms file
        field_names = fieldnames(tdms_struct) ;     % all records Breakdowns and Log
        if Xbox == 1
            save([save_dir,file_name(end-17:end-5),'.mat'],'tdms_struct','field_names')
        elseif Xbox == 2
            save([save_dir,file_name(end-23:end-5),'.mat'],'tdms_struct','field_names')
        end
        display(['File: ', file_name(end-17:end-5),' is finished'])
%         keep files2save dir_data save_dir Xbox;
    end
%     cd C:\MatlabFiles\XBOX