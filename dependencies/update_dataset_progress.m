function update_dataset_progress(main_window)

    progress_axis = findall(main_window.Children,'Tag','prog_bar_axis');
    progress_label = findall(main_window.Children,'Tag','prog_bar_label');
    invalid_counter = findall(main_window.Children,'Tag','invalid counter');
    cla(progress_axis);
    
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    
    if ismember("is_valid_scan",ground_truth_table.Properties.VariableNames)
        
        invalid_number = length(unique(ground_truth_table.scan_key(ground_truth_table.is_valid_scan == 0)));
        
    else
        
        invalid_number = 0;
        
    end
    
    invalid_rows = ground_truth_table.is_valid_scan == 0;
    completed_rows = ~(cellfun(@isempty,ground_truth_table.v1_GT_rectangle) | cellfun(@isempty,ground_truth_table.v2_GT_rectangle));
    completed_scan_keys = string(ground_truth_table.scan_key(completed_rows | invalid_rows));
    
    proportion = sum(ismember(hxt_scan_keys,completed_scan_keys))/length(unique(hxt_scan_keys));

    text(progress_axis,50,2.5,100*proportion + "%"); hold(progress_axis,'on');
    patch(progress_axis,100*proportion * [0 1 1 0 0],[0 0 5 5 0],[0.2 0.7 0.2],'FaceAlpha',0.5,'EdgeAlpha',0.4);
    
    progress_label.Text = "Dataset Progress: " + sum(ismember(hxt_scan_keys,completed_scan_keys)) + ...
    " / " + length(unique(hxt_scan_keys)); 
    invalid_counter.Text = "Scans marked invalid: " + invalid_number + "/" + length(unique(hxt_scan_keys));

end