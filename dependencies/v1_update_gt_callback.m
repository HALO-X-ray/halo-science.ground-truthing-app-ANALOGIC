function v1_update_gt_callback(src, ~)

    main_window = src.Parent;
    
    %image = getappdata(main_window,'v1_image');
    permission_to_write = 1;
    
    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    counter = findall(main_window.Children,'Tag','index_counter');
    index = counter.Value;
    GT_index = getappdata(main_window,'GT_index');

    v1_axis = findall(main_window.Children,'Tag','v1_axis');
    ground_truth = drawrectangle(v1_axis);

    updated_ground_truth_position = ground_truth.Position;
    delete(ground_truth)

    current_scan_key = hxt_scan_keys(index);
    current_scan_key_exists = ismember(current_scan_key,ground_truth_table.scan_key);
    
    if current_scan_key_exists
        scan_key_rows = find(ground_truth_table.scan_key == current_scan_key);
        scan_key_row = scan_key_rows(GT_index);
        value_already_populated = ~cellfun(@isempty,ground_truth_table(scan_key_row,:).v1_GT_rectangle);
        
        if value_already_populated
            
            fig = uifigure();
            permission_to_write = string(uiconfirm(fig,'Overwrite Previous Ground Truth','Confirm Close',...
                        'Icon','warning')) == "OK";
            close(fig);
            
        end
        
    end
    
    
    if any(updated_ground_truth_position == 0)
        permission_to_write = 0;
    end
    
    
    if permission_to_write
        
        if current_scan_key_exists
           
            scan_key_rows = find(ground_truth_table.scan_key == current_scan_key);
            scan_key_row = scan_key_rows(GT_index);
%             ground_truth_table.v1_GT_rectangle(scan_key_row,:) = {ground_truth.Position};
            
            ground_truth_table.v1_GT_rectangle(scan_key_row,:) = {updated_ground_truth_position};
        else
            
            ground_truth_table.scan_key(size(ground_truth_table,1) + 1) = current_scan_key;
            
%             ground_truth_table.v1_GT_rectangle(size(ground_truth_table,1),:) = {ground_truth.Position};            
            
            ground_truth_table.v1_GT_rectangle(size(ground_truth_table,1),:) = {updated_ground_truth_position};  
            ground_truth_table.is_valid_scan(size(ground_truth_table,1),:) = 1;

        end
        
    end
    
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    update_previous_v1_gt_label(main_window, 1, ground_truth_table.v1_GT_rectangle(size(ground_truth_table,1),:));
        
    tic
    save_ground_truth_table(main_window,ground_truth_table);
    disp("V1 ground truth saved. Elapsed time: " + toc + "s");
    
    refresh_display(main_window);
    
end