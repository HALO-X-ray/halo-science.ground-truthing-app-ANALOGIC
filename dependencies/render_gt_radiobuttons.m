function render_gt_radiobuttons(main_window)

    bg = refresh_radiobutton_group(main_window);

    ground_truth_table = getappdata(main_window,'ground_truth_table');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    counter = findall(main_window.Children,'Tag','index_counter');
    index = counter.Value;
    
    current_scan_key = hxt_scan_keys(index);

    current_scan_key_exists = ismember(current_scan_key,ground_truth_table.scan_key);

    if ~current_scan_key_exists
        return
    end
    
    ground_truth_number = sum(ground_truth_table.scan_key == current_scan_key);
    
    for radiobutton_index = 1:ground_truth_number
       
        uiradiobutton(bg,...
            'Position',nonnormalised_size(main_window, [0.015 0.47 - (0.028*radiobutton_index) 0.07 0.02]),...
            'Text',string(radiobutton_index));
       
    end

end