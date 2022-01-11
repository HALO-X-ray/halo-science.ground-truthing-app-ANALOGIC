function v2_add_gt_callback(src, ~)

    main_window = src.Parent;

    permission_to_write = 1;
    
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    counter = findall(main_window.Children,'Tag','index_counter');
    index = counter.Value;
    ground_truth_number = size(ground_truth_table,1) + 1;
    
    v2_axis = findall(main_window.Children,'Tag','v2_axis');
    ground_truth = drawrectangle(v2_axis);
    ground_truth_position = ground_truth.Position;
    delete(ground_truth);

    current_scan_key = hxt_scan_keys(index);
    current_scan_key_exists = ismember(current_scan_key,ground_truth_table.scan_key);
    
    if current_scan_key_exists
        scan_key_rows = ground_truth_table.scan_key == current_scan_key;
        scan_key_indices = ground_truth_table.GT_index(scan_key_rows);
        new_GT_index = length(scan_key_indices) + 1;
        scan_is_valid = all(ground_truth_table.is_valid_scan(scan_key_rows));
    else
        new_GT_index = 1;
        scan_is_valid = 1;
        
    end
    
    
    if any(ground_truth_position == 0)
        permission_to_write = 0;
    end
    
    if permission_to_write
        
        ground_truth_table.scan_key(ground_truth_number) = current_scan_key;
        ground_truth_table.v2_GT_rectangle(ground_truth_number,:) = {ground_truth_position};  
        ground_truth_table.GT_index(ground_truth_number) = new_GT_index;
        ground_truth_table.is_valid_scan(ground_truth_number,:) = scan_is_valid;
        
    end
    
    setappdata(main_window,'ground_truth_table',ground_truth_table);
        
    tic
    save_ground_truth_table(main_window,ground_truth_table);
    disp("V2 ground truth saved. Elapsed time: " + toc + "s");
    
    refresh_display(main_window);

end