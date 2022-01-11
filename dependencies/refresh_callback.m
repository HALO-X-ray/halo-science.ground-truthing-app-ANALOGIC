function refresh_callback(src,~)

    main_window = src.Parent;
    counter = findall(main_window.Children,'Tag','index_counter');
    data_directory = getappdata(main_window,'data_directory');

   [~, hxt_dir, dx_dir, hxt_scan_keys, timestamps, tdr_number, ground_truth_table] = ...
    initialise_variables_from_analogic_directory(data_directory);


    setappdata(main_window,'hxt_scan_keys',hxt_scan_keys);
    setappdata(main_window,'dx_dir',dx_dir);
    setappdata(main_window,'timestamps',timestamps);
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    setappdata(main_window,'hxt_dir',hxt_dir);
    setappdata(main_window,'scan_subject',strip(split(scan_subject,',')));
        
    if counter.Value > tdr_number
        counter.Value = tdr_number;
    end
    
    refresh_display(main_window);
    
    disp('Directory refreshed');

end