function [v1_gts_exist, v1_gt, v2_gts_exist,  v2_gt] = check_for_existing_gts(main_window)

    v1_gt = {}; v2_gt = {};
    v1_gts_exist = 0; v2_gts_exist = 0;

    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    
    counter = findall(main_window.Children,'Tag','index_counter');
    scan_key_index = counter.Value;
    
    current_scan_key = hxt_scan_keys(scan_key_index);
    

    gt_exists = ismember(current_scan_key,ground_truth_table.scan_key);
    scan_key_index = ground_truth_table.scan_key == current_scan_key;
    
    
    if gt_exists
    
        v1_gts_exist = any(~cellfun(@isempty,ground_truth_table(scan_key_index,:).v1_GT_rectangle));
        v2_gts_exist = any(~cellfun(@isempty,ground_truth_table(scan_key_index,:).v2_GT_rectangle));
    
    end
    
    if v1_gts_exist
        
       v1_gt = ground_truth_table(ground_truth_table.scan_key == current_scan_key,:).v1_GT_rectangle;    
       
    end
    
    if v2_gts_exist
        
       v2_gt = ground_truth_table(ground_truth_table.scan_key == current_scan_key,:).v2_GT_rectangle;    
       
    end
    
%     update_previous_v1_gt_label(main_window, v1_gt_exists, v1_gt);
%     update_previous_v2_gt_label(main_window, v2_gt_exists, v2_gt);
    
    
end