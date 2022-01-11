function ground_truth_table = load_subject_ground_truth_table(data_directory,subject)

    ground_truth_filename = fullfile(data_directory,"ground_truths_" + string(subject) + ".mat");

    if exist(ground_truth_filename,'file') == 2
        
        tic
        load(ground_truth_filename,'ground_truth_table');
        disp("Existing ground truths loaded, load time: " + num2str(toc) + "s");

    else

        ground_truth_table = table('Size',[0 5],...
            'VariableTypes',{'string','double','cell','cell','logical'},...
            'VariableNames',{'scan_key','GT_index','v1_GT_rectangle','v2_GT_rectangle','is_valid_scan'});
        disp('New ground truth table created');

    end


end