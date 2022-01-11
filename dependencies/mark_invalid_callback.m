function mark_invalid_callback(src,~)

    main_window = src.Parent;
    index_counter = findall(main_window.Children, 'Tag', 'index_counter');
    validity_checkbox = findall(main_window.Children, 'Tag', 'validity checkbox');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    ground_truth_table = getappdata(main_window,'ground_truth_table');

    current_scan_key = hxt_scan_keys(index_counter.Value);
    current_scan_key_exists = ismember(current_scan_key,ground_truth_table.scan_key);

    if ~current_scan_key_exists
        
        ground_truth_table.scan_key(size(ground_truth_table,1) + 1) = current_scan_key;
        ground_truth_table.is_valid_scan(size(ground_truth_table,1)) = true;

    end
    
    ground_truth_table_index = ground_truth_table.scan_key == current_scan_key;
    
    ground_truth_table(ground_truth_table_index,:).is_valid_scan = ...
        repelem(validity_checkbox.Value == 0,sum(ground_truth_table_index),1);
    
    
    setappdata(main_window,'ground_truth_table',ground_truth_table); 
    
    data_dir = getappdata(main_window,'data_directory');
    tic
    save(fullfile(data_dir,"ground_truths.mat"),'ground_truth_table');
    disp("Validity change saved. Elapsed time: " + toc + "s");
    
    update_dataset_progress(main_window)
    
end