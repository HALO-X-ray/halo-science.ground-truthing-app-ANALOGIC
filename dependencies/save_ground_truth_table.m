function save_ground_truth_table(main_window,ground_truth_table)

    data_dir = getappdata(main_window,'data_directory');
    scan_subject = getappdata(main_window,'active_scan_subject');
    
    filename = fullfile(data_dir,"ground_truths_" + scan_subject + ".mat");
    
    save(filename,'ground_truth_table');


end