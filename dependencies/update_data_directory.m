function update_data_directory(main_window, new_directory)

    counter = findall(main_window.Children,'Tag','index_counter');
    counter.Value = 1;
    
    data_directory = new_directory;
    
    data_dir_split = split(data_directory,"\");
    scan_subject = string(data_dir_split{end});

    [~, hxt_dir, image_dir, hxt_scan_keys, timestamps, tdr_number, ground_truth_table] = ...
    initialise_variables_from_analogic_directory(data_directory);

    setappdata(main_window,'data_directory',data_directory);
    setappdata(main_window,'scan_keys_master',hxt_scan_keys);
    setappdata(main_window,'hxt_scan_keys',hxt_scan_keys);
    setappdata(main_window,'hxt_dir',hxt_dir);
    setappdata(main_window,'dx_dir',image_dir);
    setappdata(main_window,'timestamps',timestamps);
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    setappdata(main_window,'scan_subject',strip(split(scan_subject,',')));
    
    counter.Limits = [1 tdr_number];
    
    scan_subjects = getappdata(main_window,'scan_subject');
    
    setappdata(main_window,'active_scan_subject',scan_subjects(1));
    
    init_scan_subject_label(main_window);
    
    refresh_display(main_window);
    
%     update_scan_subject_label(main_window);
%     update_scan_key_label(main_window);
%     update_timestamp_label(main_window);
%     update_axes_images(main_window);
%     update_index_counter_limits(main_window,tdr_number);
%     
%     render_existing_ground_truths(main_window)
%     update_dataset_progress(main_window);
    
    

    disp("Directory changed to: " + new_directory);
    disp("Loading....");
    figure(main_window);
    disp("Loaded");

end