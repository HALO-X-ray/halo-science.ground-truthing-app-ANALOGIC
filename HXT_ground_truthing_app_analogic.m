%% HXT-GT Software
clear variables; close all; clc
% addpath(fullfile("G:\Shared drives\Software\MAT - MATLAB\m files\git repos\halo-science.ground-truthing-app","dependencies"));
addpath(cd,"dependencies");
[~,~] = loadHaloPlugin('');
warning('off','MATLAB:table:RowsAddedExistingVars');
warning('off','images:dicomread:badNumberOfFrames');

try
    initial_data_directory = uigetdir("G:\Shared drives\Data_Analogic\ConneCT Live Targeted Data Collection");
catch
    initial_data_directory = uigetdir("D:\Shared drives\Data_Analogic\ConneCT Live Targeted Data Collection");
end

[tdr_dir, hxt_dir, dx_dir, hxt_scan_keys, timestamps, tdr_number, ground_truth_table] = ...
    initialise_variables_from_analogic_directory(initial_data_directory);

%%

main_window = init_main(tdr_number, initial_data_directory, hxt_scan_keys, hxt_dir, timestamps, dx_dir, ground_truth_table);


%% 


function main_window = init_main(tdr_number, data_directory, hxt_scan_keys, hxt_dir, timestamps, dx_dir, ground_truth_table)
%%
    main_window = uifigure();
    main_window.Position = get(0, 'Screensize') - [0,0,0,30];
    try
    main_window.Icon = "G:\Shared drives\Software\MAT - MATLAB\m files\git repos\halo-science.ground-truthing-app\dependencies\halo+symbol.png";
    catch
    main_window.Icon = "D:\Shared drives\Software\MAT - MATLAB\m files\git repos\halo-science.ground-truthing-app\dependencies\halo+symbol.png";        
    end
    main_window.Name = "HALO X-Ray Technologies Ground Truthing Application";
    %     main_window.WindowState = 'maximized';
    data_dir_split = split(data_directory,"\");
    scan_subject = string(data_dir_split{end});
    
    setappdata(main_window,'data_directory',data_directory);
    setappdata(main_window,'scan_keys_master',hxt_scan_keys);
    setappdata(main_window,'hxt_dir',hxt_dir);
    setappdata(main_window,'hxt_scan_keys',hxt_scan_keys);
    setappdata(main_window,'dx_dir',dx_dir);
    setappdata(main_window,'timestamps',timestamps);
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    setappdata(main_window,'scan_subject',strip(split(scan_subject,',')));
    
    scan_subjects = getappdata(main_window,'scan_subject');
    
    setappdata(main_window,'active_scan_subject',scan_subjects(1));
    
    initialise_ui_components(main_window, tdr_number);
    
    
end


function initialise_ui_components(main_window, tdr_number)

    v1_axis = uiaxes('Parent',main_window,'Position',nonnormalised_size(main_window,[0.2 0.15 0.35 0.5]),...
        'Xlim',[0 580],'Ylim',[0 617],'Tag','v1_axis');
    v2_axis = uiaxes(main_window,'Position',nonnormalised_size(main_window,[0.6 0.15 0.35 0.5]),...
        'Xlim',[0 580],'Ylim',[0 617],'Tag','v2_axis');
    progress_bar_axis = uiaxes(main_window,'Position',nonnormalised_size(main_window,[0.7 0.9 0.25 0.03]),...
        'Xlim',[0 100],'Ylim',[0 5],'Tag','prog_bar_axis');
    progress_bar_axis.XTick = [];
    progress_bar_axis.YTick = [];
    progress_bar_axis.YColor = [1 1 1];
    progress_bar_axis.XColor = [1 1 1];
    
    disableDefaultInteractivity(v1_axis);
    disableDefaultInteractivity(v2_axis); 
    disableDefaultInteractivity(progress_bar_axis); 
    
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.025 0.89 0.3 0.04]),'Text','Scan Key: ','Tag','scan_key_label');
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.025 0.80 0.3 0.04]),'Text','Scan Timestamp: ','Tag','scan_timestamp');

    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.025 0.86 0.3 0.04]),'Text',"Current v1 ground truth: ",...
        'Tag','current_v1_gt_label');
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.025 0.83 0.3 0.04]),'Text',"Current v2 ground truth: ",...
        'Tag','current_v2_gt_label');
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.8 0.87 0.3 0.04]),'Text',"Dataset Progress",...
        'Tag','prog_bar_label');
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.8 0.85 0.3 0.04]),'Text',"Scans marked invalid: ",...
        'Tag','invalid counter');   
    
    init_scan_subject_label(main_window);
    
    
    
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.33 0.87 0.02 0.04]),'Text','>',...
        'ButtonPushedFcn',@forward_button_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.27 0.87 0.02 0.04]),'Text','<',...
        'ButtonPushedFcn',@backward_button_callback);
    
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.18 0.6 0.05 0.03]),'Text','Add GT',...
        'ButtonPushedFcn',@v1_add_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.57 0.6 0.05 0.03]),'Text','Add GT',...
        'ButtonPushedFcn',@v2_add_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.18 0.56 0.05 0.03]),'Text','Update GT',...
        'ButtonPushedFcn',@v1_update_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.57 0.56 0.05 0.03]),'Text','Update GT',...
        'ButtonPushedFcn',@v2_update_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.18 0.52 0.05 0.03]),'Text','Clear GT',...
        'ButtonPushedFcn',@v1_clear_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.57 0.52 0.05 0.03]),'Text','Clear GT',...
        'ButtonPushedFcn',@v2_clear_gt_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.37 0.875 0.05 0.03]),'Text','Refresh',...
        'ButtonPushedFcn',@refresh_callback);
    uibutton(main_window,'Position',nonnormalised_size(main_window, [0.42 0.945 0.08 0.03]),'Text','Update directory',...
        'ButtonPushedFcn',@update_directory_button_callback);
    
    uicheckbox(main_window,'Position',nonnormalised_size(main_window,[0.27 0.815 0.15 0.05]),'Text','Show incomplete ground truths only',...
        'ValueChangedFcn',@toggle_incomplete_only);
    uicheckbox(main_window,'Position',nonnormalised_size(main_window,[0.27 0.78 0.15 0.05]),'Text','Mark scan invalid',...
        'ValueChangedFcn',@mark_invalid_callback, 'Tag', 'validity checkbox');
    
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.03 0.94 0.1 0.04]),'Text',"Active Directory: ",...
        'Tag','current_directory_label');
    uieditfield(main_window,'text','Position',nonnormalised_size(main_window, [0.11 0.94 0.3 0.04]),...
        'Value', getappdata(main_window,'data_directory'), 'Tag', 'directory_field',...
        'ValueChangedFcn',@update_directory_field_callback);

    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.52 0.94 0.1 0.04]),'Text',"Directory Not Found",...
        'Tag','wrong directory label','FontColor',[0.8 0.15 0.5],'Visible','off'); 
  
    uilabel(main_window,'Position',nonnormalised_size(main_window, [0.45,0.8 0.1 0.04]),'Text',"All ground truths complete",...
        'Tag','ground truths complete label','FontColor',[0.8 0.15 0.5],'Visible','off'); 
    
    uieditfield(main_window,'numeric','Position',nonnormalised_size(main_window, [0.3 0.87 0.02 0.04]),...
        'Value',1,'Limits',[1 tdr_number], 'Tag', 'index_counter',...
        'CreateFcn',@update_counter_callback,'ValueChangedFcn',@update_counter_callback);
    
    uibuttongroup(main_window,'Position',nonnormalised_size(main_window, [0.025 0.16 0.09 0.5]),...
        'Tag','current gt radiobutton',...
        'Visible','on',...
        'scrollable','on',...
        'Title','Selected Ground Truth',...
        'SelectionChangedFcn',@update_rendered_GT);
    
    
    refresh_display(main_window);
%     update_dataset_progress(main_window);
    
    
end

