function ground_truth_table = load_initial_ground_truth_table(data_directory)

    data_directory_files = dir(fullfile(data_directory,"*.mat"));
    ground_truth_inds = contains(string({data_directory_files.name}),"ground_truths");

    if any(ground_truth_inds)
        
        file_ind = find(ground_truth_inds,1);
        ground_truth_filename = fullfile(data_directory_files(file_ind).folder, data_directory_files(file_ind).name);
        load(ground_truth_filename,'ground_truth_table');
        
    else

        ground_truth_table = table('Size',[0 5],...
            'VariableTypes',{'string','double','cell','cell','logical'},...
            'VariableNames',{'scan_key','GT_index','v1_GT_rectangle','v2_GT_rectangle','is_valid_scan'});
        disp('New ground truth table created');

    end
    

end