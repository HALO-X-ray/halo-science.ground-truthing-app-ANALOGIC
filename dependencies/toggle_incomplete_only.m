function toggle_incomplete_only(src,~)

    main_window = src.Parent;
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    scan_key_master_list = getappdata(main_window,'scan_keys_master');
    counter = findall(main_window.Children,'Tag','index_counter');
    
    switch src.Value
        case 1
            incomplete_gt_rows = ...
                cellfun(@isempty,ground_truth_table.v1_GT_rectangle) | ...
                cellfun(@isempty,ground_truth_table.v2_GT_rectangle);
            complete_gt_scan_keys = ground_truth_table.scan_key(~incomplete_gt_rows);
            incomplete_scan_key_master_list = scan_key_master_list(~ismember(scan_key_master_list,complete_gt_scan_keys));
            
            if size(incomplete_scan_key_master_list,1) > 0
                
               setappdata(main_window,'hxt_scan_keys',incomplete_scan_key_master_list);
               counter.Value = 1;
               refresh_display(main_window);
                
            else
                
                error_label = findall(main_window.Children,'Tag','ground truths complete label');
                src.Value = 0;
                error_label.Visible = 'on';
                pause(1.2);
                error_label.Visible = 'off';
                
            end
            
            
        case 0
            setappdata(main_window,'hxt_scan_keys',scan_key_master_list);
            counter.Value = 1;
            refresh_display(main_window);
            
    end


end