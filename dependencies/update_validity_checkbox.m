function update_validity_checkbox(main_window)

    index_counter = findall(main_window.Children, 'Tag', 'index_counter');
    validity_checkbox = findall(main_window.Children, 'Tag', 'validity checkbox');
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    
    current_scan_key = hxt_scan_keys(index_counter.Value);
    
    if ismember(current_scan_key, ground_truth_table.scan_key)
        
        gt_row = current_scan_key == ground_truth_table.scan_key;
        validity_checkbox.Value = all(ground_truth_table(gt_row,:).is_valid_scan == 0);
    
    else
        
        validity_checkbox.Value = 0;
        
    end

end 