function v2_clear_gt_callback(src, ~)

    main_window = src.Parent;
    
    permission_to_clear = 0;
    
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    counter = findall(main_window.Children,'Tag','index_counter');
    index = counter.Value;
    GT_index = getappdata(main_window,'GT_index');
    
    current_scan_key = hxt_scan_keys(index);
    current_scan_key_exists = ismember(current_scan_key,ground_truth_table.scan_key);
    
    if current_scan_key_exists
        scan_key_rows = find(ground_truth_table.scan_key == current_scan_key);
        deletion_row = scan_key_rows(GT_index);
        value_already_populated = ~cellfun(@isempty,ground_truth_table(deletion_row,:).v2_GT_rectangle);
        
        if value_already_populated
            
            fig = uifigure();
            permission_to_clear = string(uiconfirm(fig,'Clear Current Ground Truth?','Confirm Close',...
                        'Icon','warning')) == "OK";
            close(fig);
            
        end
        
    end
    
    
    if permission_to_clear
        
        if current_scan_key_exists
           
            scan_key_rows = find(ground_truth_table.scan_key == current_scan_key);
            deletion_row = scan_key_rows(GT_index);
            ground_truth_table.v2_GT_rectangle(deletion_row,:) = {[]};          
            
        end
        
    end
    
    ground_truth_table = clear_empty_rows(ground_truth_table);
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    
    tic
    save_ground_truth_table(main_window,ground_truth_table);
    disp("V2 ground truth cleared. Elapsed time: " + toc + "s");
        
    refresh_display(main_window);
end