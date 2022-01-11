function update_gt_labels(main_window)

    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    GT_index = getappdata(main_window,'GT_index');
    counter = findall(main_window.Children,'Tag','index_counter');

    scan_key_rows = find(ground_truth_table.scan_key == hxt_scan_keys(counter.Value));
    
    try
        current_v1_GT = ground_truth_table.v1_GT_rectangle{scan_key_rows(GT_index)};
    catch
        current_v1_GT = [];
    end
    
    try
        current_v2_GT = ground_truth_table.v2_GT_rectangle{scan_key_rows(GT_index)};
    catch
        current_v2_GT = [];
    end
    
    v1_gt_exists = ~isempty(current_v1_GT);
    v2_gt_exists = ~isempty(current_v2_GT);
    
    update_v1_gt_label(main_window,v1_gt_exists,current_v1_GT);
    update_v2_gt_label(main_window,v2_gt_exists,current_v2_GT);
    

end