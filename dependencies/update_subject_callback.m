function update_subject_callback(src,event)

    main_window = src.Parent;
    counter = findall(main_window.Children,'Tag','index_counter');
    
%     disp(event)
    
    subject = string(event.NewValue.Text);
    data_directory = getappdata(main_window,'data_directory');
    
    ground_truth_table = load_subject_ground_truth_table(data_directory,subject);
    
    setappdata(main_window,'ground_truth_table',ground_truth_table);
    setappdata(main_window,'active_scan_subject',subject);
    
    counter.Value = 1;
    
    refresh_display(main_window);

end