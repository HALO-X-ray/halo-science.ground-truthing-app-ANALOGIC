function ground_truth_table = clear_empty_rows(ground_truth_table)

    empty_rows = cellfun(@isempty,ground_truth_table.v1_GT_rectangle) &...
        cellfun(@isempty,ground_truth_table.v2_GT_rectangle) &...
        ground_truth_table.is_valid_scan == 1;
    ground_truth_table(empty_rows,:) = [];
    
    unique_scan_keys = unique(ground_truth_table.scan_key);
    
    for scan_key_index = 1:length(unique_scan_keys)
        
        scan_key_indices = ground_truth_table.scan_key == unique_scan_keys(scan_key_index);
        ground_truth_table.GT_index(scan_key_indices) = 1:sum(scan_key_indices);
        
    end

end