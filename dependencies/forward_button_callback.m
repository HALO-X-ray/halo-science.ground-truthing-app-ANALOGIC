function forward_button_callback(src,~)

    main_window = src.Parent;
    counter = findall(main_window.Children,'Tag','index_counter');
    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    tdr_number = length(hxt_scan_keys);
    
    if counter.Value < tdr_number
    
        counter.Value = counter.Value + 1;
        
    end
    
    refresh_display(main_window);

end
