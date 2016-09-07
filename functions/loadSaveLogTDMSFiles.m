function [logFile_struct,tdms_struct] = loadSaveLogTDMSFiles(dir_data,filesList,startDate,startTime,endDate,endTime)
    t1 = [startDate,' ',startTime,':000'];
    t1 = datenum(t1,'yyyymmdd HH:MM:SS:FFF');
    t2 = [endDate,' ',endTime,':000'];
    t2 = datenum(t2,'yyyymmdd HH:MM:SS:FFF');

    N_iter = size(filesList,1);
    TimeStamp = [];
    Event_Type = [];
    BPM1_peak = [];
    IP_before_PC_Pressure = [];
    IP_after_PC_Pressure = [];
    Circ_WG_Gallery_Pressure = [];
    Circ_WG_CTF2_Pressure = [];
    IP_before_hybrid_Pressure = [];
    Loadside_win_Pressure = [];
    Beam_axis_IPs_Pressure = [];
    Manifold_IPs_Pressure = [];
    c_0260A_Structure_Out = [];
    c_0260_Structure_In = [];
    c_0260B_WG_linac = [];
    c_0160_WG_CTF2_to_linac_ = [];
    Left_PC_Temperature = [];
    Right_PC_Temperature = [];
    Structure_Input_Temperature = [];
    Structure_Temperature = [];
    Structure_Output_Temperature = [];
    N_pulses = 0;
    for i=1:N_iter
        file_name = filesList(i,:);
        Date = file_name(5:12);
        file_name = fullfile(dir_data,file_name)
        tdms_struct = TDMS_getStruct(file_name);    % reading tdms file
        field_names = fieldnames(tdms_struct);     % all records Breakdowns and Log
        for j=2:length(field_names)
            nameSplit = strsplit(tdms_struct.(field_names{j}).name,'_');
            Time = strcat(nameSplit(2),nameSplit(3),nameSplit(4),nameSplit(5));
%             timeStamp = tdms_struct.(field_names{j}).Props.Timestamp;
%             timeStamp = datenum(timeStamp,'dd-mmm-yyyy HH:MM:SS:FFF');
            timeStamp = strcat(Date,Time);
            timeStamp = datenum(timeStamp,'yyyymmddHHMMSSFFF');
            if timeStamp>=t1 && timeStamp<=t2
                N_pulses = N_pulses + tdms_struct.(field_names{j}).Props.Pulse_Delta;
                if isfield(tdms_struct.(field_names{j}),'BPM1_peak')
                    TimeStamp = [TimeStamp;tdms_struct.(field_names{j}).Props.Timestamp];
                    Event_Type = [Event_Type;tdms_struct.(field_names{j}).Props.Event_Type(1)];
                    BPM1_peak = [BPM1_peak;tdms_struct.(field_names{j}).BPM1_peak.data'];
                    IP_before_PC_Pressure = [IP_before_PC_Pressure;tdms_struct.(field_names{j}).IP_before_PC_Pressure.data'];
                    IP_after_PC_Pressure = [IP_after_PC_Pressure;tdms_struct.(field_names{j}).IP_after_PC_Pressure.data'];
                    Circ_WG_Gallery_Pressure = [Circ_WG_Gallery_Pressure;tdms_struct.(field_names{j}).Circ_WG_Gallery_Pressure.data'];
                    Circ_WG_CTF2_Pressure = [Circ_WG_CTF2_Pressure;tdms_struct.(field_names{j}).Circ_WG_CTF2_Pressure.data'];
                    IP_before_hybrid_Pressure = [IP_before_hybrid_Pressure;tdms_struct.(field_names{j}).IP_before_hybrid_Pressure.data'];
                    Loadside_win_Pressure = [Loadside_win_Pressure;tdms_struct.(field_names{j}).Loadside_win_Pressure.data'];
                    Beam_axis_IPs_Pressure = [Beam_axis_IPs_Pressure;tdms_struct.(field_names{j}).Beam_axis_IPs_Pressure.data'];
                    Manifold_IPs_Pressure = [Manifold_IPs_Pressure;tdms_struct.(field_names{j}).Manifold_IPs_Pressure.data'];
                    c_0260A_Structure_Out = [c_0260A_Structure_Out;tdms_struct.(field_names{j}).c_0260A_Structure_Out.data'];
                    c_0260_Structure_In = [c_0260_Structure_In;tdms_struct.(field_names{j}).c_0260_Structure_In.data'];
                    c_0260B_WG_linac = [c_0260B_WG_linac;tdms_struct.(field_names{j}).c_0260B_WG_linac.data'];
                    c_0160_WG_CTF2_to_linac_ = [c_0160_WG_CTF2_to_linac_;tdms_struct.(field_names{j}).c_0160_WG_CTF2_to_linac_.data'];
                    Left_PC_Temperature = [Left_PC_Temperature;tdms_struct.(field_names{j}).Left_PC_Temperature.data'];
                    Right_PC_Temperature = [Right_PC_Temperature;tdms_struct.(field_names{j}).Right_PC_Temperature.data'];
                    Structure_Input_Temperature = [Structure_Input_Temperature;tdms_struct.(field_names{j}).Structure_Input_Temperature.data'];
                    Structure_Temperature = [Structure_Temperature;tdms_struct.(field_names{j}).Structure_Temperature.data'];
                    Structure_Output_Temperature = [Structure_Output_Temperature;tdms_struct.(field_names{j}).Structure_Output_Temperature.data'];            
                end
            end
        end
        
    end
    logFile_struct.('TimeStamp') = TimeStamp;
    logFile_struct.('Event_Type') = Event_Type;
    logFile_struct.('BPM1_peak') = BPM1_peak;
    logFile_struct.('IP_before_PC_Pressure') = IP_before_PC_Pressure;
    logFile_struct.('IP_after_PC_Pressure') = IP_after_PC_Pressure;
    logFile_struct.('Circ_WG_Gallery_Pressure') = Circ_WG_Gallery_Pressure;
    logFile_struct.('Circ_WG_CTF2_Pressure') = Circ_WG_CTF2_Pressure;
    logFile_struct.('IP_before_hybrid_Pressure') = IP_before_hybrid_Pressure;
    logFile_struct.('Loadside_win_Pressure') = Loadside_win_Pressure;
    logFile_struct.('Beam_axis_IPs_Pressure') = Beam_axis_IPs_Pressure;
    logFile_struct.('Manifold_IPs_Pressure') = Manifold_IPs_Pressure;
    logFile_struct.('c_0260A_Structure_Out') = c_0260A_Structure_Out;
    logFile_struct.('c_0260_Structure_In') = c_0260_Structure_In;
    logFile_struct.('c_0260B_WG_linac') = c_0260B_WG_linac;
    logFile_struct.('c_0160_WG_CTF2_to_linac') = c_0160_WG_CTF2_to_linac_;
    logFile_struct.('Left_PC_Temperature') = Left_PC_Temperature;
    logFile_struct.('Right_PC_Temperature') = Right_PC_Temperature;
    logFile_struct.('Structure_Input_Temperature') = Structure_Input_Temperature;
    logFile_struct.('Structure_Temperature') = Structure_Temperature;
    logFile_struct.('Structure_Output_Temperature') = Structure_Output_Temperature;
    logFile_struct.('N_pulses') = N_pulses;


    